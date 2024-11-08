import os
import logging
import boto3
import ffmpeg
from botocore.config import Config
from django.conf import settings
from celery import shared_task
import tempfile

from takers.models import Taker

# 임시 디렉토리 설정 및 생성
TEMP_DIR = tempfile.gettempdir()
os.makedirs(TEMP_DIR, exist_ok=True)

# AWS 설정
config = Config(
    retries=dict(
        max_attempts=5,
        mode='adaptive'
    ),
    connect_timeout=5,
    read_timeout=10
)


def get_s3_client():
    try:
        return boto3.client('s3',
                            aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                            aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
                            region_name=settings.AWS_S3_REGION_NAME,
                            config=config
                            )
    except Exception as e:
        logging.error(f"Failed to create S3 client: {str(e)}")
        raise


def clean_temp_files(file_paths):
    for file_path in file_paths:
        try:
            if os.path.exists(file_path):
                os.remove(file_path)
        except Exception as e:
            logging.error(f"Error cleaning up file {file_path}: {str(e)}")


@shared_task
def merge_videos_task(taker_id, exam_id):
    temp_files = []

    try:
        s3_client = get_s3_client()
        folder_path = f"{exam_id}/{taker_id}"
        concat_file_path = os.path.join(TEMP_DIR, 'concat.txt')
        merged_output_path = os.path.join(TEMP_DIR, 'merged.mp4')

        logging.info(f"Searching for videos in path: {folder_path}")

        response = s3_client.list_objects_v2(
            Bucket=settings.AWS_STORAGE_BUCKET_NAME,
            Prefix=folder_path + "/"
        )

        if 'Contents' not in response:
            return "No video files found"

        video_files = [
            obj['Key'] for obj in response.get('Contents', [])
            if obj['Key'].startswith(f"{folder_path}/webcam_") and obj['Key'].endswith(('.mp4', '.mov', '.avi'))
        ]
        video_files.sort()

        if not video_files:
            return "No valid video files to merge"

        processed_videos = []
        previous_end_time = None

        for video_file in video_files:
            try:
                filename = os.path.basename(video_file)
                filename_without_ext = os.path.splitext(filename)[0]
                start_time, end_time = map(int, filename_without_ext.split('_')[1:3])

                if previous_end_time is not None and start_time > previous_end_time:
                    gap_duration = start_time - previous_end_time
                    black_video_path = os.path.join(TEMP_DIR, f'black_{previous_end_time}_{start_time}.mp4')

                    stream = ffmpeg.input('color=c=black:s=1280x720:d={}'.format(gap_duration),
                                          f='lavfi')
                    audio = ffmpeg.input('anullsrc=r=44100:cl=stereo:d={}'.format(gap_duration),
                                         f='lavfi')

                    stream = ffmpeg.output(stream, audio,
                                           black_video_path,
                                           vcodec='libx264',
                                           acodec='aac',
                                           pix_fmt='yuv420p')

                    ffmpeg.run(stream, overwrite_output=True)

                    processed_videos.append(black_video_path)
                    temp_files.append(black_video_path)

                local_video_path = os.path.join(TEMP_DIR, filename)
                output_resized_path = os.path.join(TEMP_DIR, f"resized_{filename}")

                s3_client.download_file(
                    Bucket=settings.AWS_STORAGE_BUCKET_NAME,
                    Key=video_file,
                    Filename=local_video_path
                )
                temp_files.append(local_video_path)

                stream = ffmpeg.input(local_video_path)
                stream = ffmpeg.output(stream,
                                       output_resized_path,
                                       vcodec='libx264',
                                       acodec='aac',
                                       preset='medium',
                                       crf=23,
                                       video_bitrate='2000k',
                                       audio_bitrate='192k',
                                       s='1280x720',
                                       pix_fmt='yuv420p')

                ffmpeg.run(stream, overwrite_output=True)

                processed_videos.append(output_resized_path)
                temp_files.append(output_resized_path)
                previous_end_time = end_time

                os.remove(local_video_path)
                temp_files.remove(local_video_path)

            except Exception as e:
                logging.error(f"Error processing video {video_file}: {str(e)}")
                continue

        if not processed_videos:
            return "Failed to process any videos"

        with open(concat_file_path, 'w', encoding='utf-8') as f:
            for video_path in processed_videos:
                video_path = video_path.replace('\\', '/')
                f.write(f"file '{video_path}'\n")
        temp_files.append(concat_file_path)

        try:
            stream = ffmpeg.input(concat_file_path, format='concat', safe=0)
            stream = ffmpeg.output(stream,
                                   merged_output_path,
                                   vcodec='libx264',
                                   acodec='aac',
                                   preset='medium',
                                   crf=23,
                                   pix_fmt='yuv420p')

            ffmpeg.run(stream, overwrite_output=True)
            temp_files.append(merged_output_path)

            s3_client.upload_file(
                Filename=merged_output_path,
                Bucket=settings.AWS_STORAGE_BUCKET_NAME,
                Key=f"{folder_path}/merged.mp4"
            )

            return f'Successfully merged {len(video_files)} videos with black screens for gaps'

        except Exception as e:
            logging.error(f"Error during final video merging: {str(e)}")
            raise

    except Exception as e:
        logging.error(f"Unexpected error in merge_videos_task: {str(e)}")
        return f"Error: {str(e)}"

    finally:
        try:
            merged_video_url = f"https://{settings.AWS_STORAGE_BUCKET_NAME}.s3.{settings.AWS_S3_REGION_NAME}.amazonaws.com/{folder_path}/merged.mp4"

            taker = Taker.objects.get(id=taker_id)
            taker.stored_state = 'done'
            taker.web_cam = merged_video_url
            taker.save()
            logging.info(f"Successfully updated Taker {taker_id} stored_state to 'done'.")
        except Taker.DoesNotExist:
            logging.error(f"Taker with id {taker_id} does not exist.")

        clean_temp_files(temp_files)