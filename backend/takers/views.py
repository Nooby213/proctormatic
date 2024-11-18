import re
import os
import io
import ffmpeg
import tempfile
from accounts.utils import generate_verification_code, send_verification_email, save_verification_code_to_redis
from exams.models import Exam
from rest_framework.decorators import api_view, permission_classes, parser_classes, authentication_classes
from rest_framework.parsers import MultiPartParser
from rest_framework.permissions import AllowAny

from proctormatic.utils import forbidden_response, ok_with_data_response, bad_request_response, \
    too_many_requests_response, created_response, created_with_data_response, bad_request_invalid_data_response, \
    conflict_response, ok_response, not_found_response, internal_server_error
from .authentication import CustomJWTAuthentication
from .models import Taker, Logs
from .serializers import TakerSerializer, UpdateTakerSerializer, TakerTokenSerializer, AbnormalSerializer
from .swagger_schemas import add_taker_schema, check_email_schema, add_web_cam_schame, update_taker_schema, \
    add_abnormal_schema
from django_redis import get_redis_connection
from django.utils import timezone
from datetime import datetime
from django.conf import settings
import boto3
from takers.celery.tasks import merge_videos_task

@add_taker_schema
@api_view(['POST', 'PATCH'])
@authentication_classes([CustomJWTAuthentication])
@permission_classes([AllowAny])
def add_taker(request):
    if request.method == 'POST':
        serializer = TakerSerializer(data=request.data)

        if serializer.is_valid():
            exam = Exam.objects.get(id=serializer.validated_data['exam'].id)
            email = serializer.validated_data['email']

            current_time = timezone.now()
            entry_time = datetime.combine(exam.date, exam.entry_time)
            end_time = datetime.combine(exam.date, exam.end_time)

            existing_taker = Taker.objects.filter(email=email, exam_id=exam.id).first()
            if existing_taker:
                if existing_taker.check_out_state == "normal":
                    return forbidden_response('이미 퇴실한 사용자입니다.')
                access_token = TakerTokenSerializer.get_access_token(existing_taker)
                Logs.objects.create(
                    taker_id=existing_taker.id,
                    type='entry'
                )
                return ok_with_data_response({'access': str(access_token)})

            if current_time < entry_time:
                return bad_request_response('입장 가능 시간이 아닙니다. 입장은 시험 시작 30분 전부터 가능합니다.')
            if current_time > end_time:
                return bad_request_response('종료된 시험입니다.')
            if exam.total_taker >= exam.expected_taker:
                return too_many_requests_response('참가자 수를 초과했습니다.')

            taker = serializer.save()
            access_token = TakerTokenSerializer.get_access_token(taker)

            exam.total_taker += 1
            exam.save(update_fields=['total_taker'])

            Logs.objects.create(
                taker_id=taker.id,
                type='entry'
            )

            return created_with_data_response({'access': str(access_token)})
        return bad_request_invalid_data_response()

    elif request.method == 'PATCH':
        taker_id = request.auth['user_id']

        taker = Taker.objects.filter(id=taker_id).first()

        exam = Exam.objects.filter(id=taker.exam_id).first()
        exit_time = datetime.now().time()
        if exam:
            if exit_time < exam.exit_time:
                return conflict_response('퇴실 가능 시간이 아닙니다.')

        taker.check_out_state = 'normal'
        taker.save()

        merge_videos_task.delay(taker_id, taker.exam.id)

        log_entry = Logs(taker=taker, type='exit')
        log_entry.save()

        return ok_response('시험이 종료되었습니다.')


@check_email_schema
@api_view(['GET', 'POST', 'PUT'])
@permission_classes([AllowAny])
def check_email(request):
    if request.method == 'GET':
        email = request.query_params.get('email')
        exam_id = request.query_params.get("id")

        if not email or not exam_id:
            return bad_request_response('이메일과 시험 ID를 모두 입력해야 합니다.')

        if not is_valid_email(email):
            return bad_request_response('유효하지 않은 이메일 형식입니다.')

        if not Exam.objects.filter(id=exam_id).exists():
            return not_found_response('유효하지 않은 시험 ID입니다.')

        is_duplicate = Taker.objects.filter(email=email, exam__id=exam_id).exists()
        return ok_with_data_response({'isAlreadyExists': is_duplicate})

    elif request.method == 'POST':
        exam_id = request.data.get('id')
        email = request.data.get('email')

        if email:
            if not is_valid_email(email):
                return bad_request_response('이메일 형식을 확인해주세요.')

            if Taker.objects.filter(exam_id=exam_id, email=email).exists():
                return conflict_response('이미 존재하는 이메일입니다. 다른 이메일을 사용해주세요.')

            code = generate_verification_code()
            send_verification_email(email, code)
            save_verification_code_to_redis(email, code)

            return ok_response('인증번호를 발송했습니다.')
        else:
            return bad_request_response('이메일을 입력해주세요.')

    elif request.method == 'PUT':
        email = request.data.get('email')
        code = request.data.get('code')

        if not email:
            return bad_request_response('이메일을 입력해주세요.')
        if not code:
            return bad_request_response('인증번호를 입력해주세요.')

        redis_conn = get_redis_connection('default')
        stored_code = redis_conn.get(f'verification_code:{email}')

        if stored_code is None:
            return bad_request_response('인증번호가 만료되었습니다.')

        if stored_code.decode('utf-8') == code:
            return ok_response('이메일 인증이 완료되었습니다.')
        else:
            return bad_request_response('잘못된 인증번호입니다.')


@update_taker_schema
@api_view(['PATCH'])
@authentication_classes([CustomJWTAuthentication])
@parser_classes([MultiPartParser])
def update_taker(request):
    taker_id = request.auth['user_id']
    required_fields = ['id_photo', 'birth', 'verification_rate']

    for field in required_fields:
        if field not in request.data:
            return bad_request_invalid_data_response()

    taker = Taker.objects.filter(id=taker_id).first()

    s3_client = boto3.client('s3')

    if 'id_photo' in request.FILES:
        id_photo_file = request.FILES['id_photo']
        _, file_extension = os.path.splitext(id_photo_file.name)
        file_name = f"idPhoto{file_extension}"
        s3_path = f"{taker.exam_id}/{taker_id}/{file_name}"

        try:
            s3_client.upload_fileobj(
                id_photo_file,
                settings.AWS_STORAGE_BUCKET_NAME,
                s3_path,
                ExtraArgs={'ContentType': id_photo_file.content_type}
            )
            s3_file_url = f"{settings.MEDIA_URL}{s3_path}"

        except Exception as e:
            return internal_server_error(f'S3 업로드 실패: {str(e)}')

    else:
        return bad_request_invalid_data_response()

    update_data = {**request.data.dict(), 'id_photo': s3_file_url}

    serializer = UpdateTakerSerializer(taker, data=update_data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return ok_response('신분증이 등록되었습니다.')

    error_messages = serializer.errors.get('birth', [])
    if error_messages:
        return bad_request_response(error_messages[0])
    return bad_request_invalid_data_response()


@add_web_cam_schame
@api_view(['POST'])
@authentication_classes([CustomJWTAuthentication])
@parser_classes([MultiPartParser])
def add_web_cam(request):
    taker_id = request.auth['user_id']
    taker = Taker.objects.filter(id=taker_id).first()
    exam_id = taker.exam_id

    if 'web_cam' not in request.FILES:
        return bad_request_invalid_data_response()

    web_cam_file = request.FILES['web_cam']
    end_time = request.data.get('end_time')

    if not end_time:
        return bad_request_invalid_data_response()
    duration_seconds = get_video_duration_in_seconds(web_cam_file)
    if duration_seconds is None:
        return bad_request_response('영상 길이를 계산할 수 없습니다.')

    start_time = subtract_duration_from_end_time(end_time, duration_seconds)
    if start_time is None:
        return bad_request_response('시작 시간을 계산할 수 없습니다.')
    start_time = start_time.replace(":", "")
    end_time = end_time.replace(":", "")

    s3_client = boto3.client('s3')
    _, file_extension = os.path.splitext(web_cam_file.name)
    file_name = f'webcam_{start_time}_{end_time}{file_extension}'
    s3_path = f"{exam_id}/{taker_id}/{file_name}"
    try:
        with io.BytesIO() as byte_io:
            for chunk in web_cam_file.chunks():
                byte_io.write(chunk)

            byte_io.seek(0)  # 파일 포인터를 처음으로 이동

            # 파일 업로드
            s3_client.upload_fileobj(
                byte_io,
                settings.AWS_STORAGE_BUCKET_NAME,
                s3_path,
                ExtraArgs={'ContentType': web_cam_file.content_type}
            )

    except Exception as e:
        return internal_server_error(f'S3 업로드 실패: {str(e)}')
    return ok_response('웹캠 영상이 저장되었습니다.')


@add_abnormal_schema
@api_view(['POST'])
@authentication_classes([CustomJWTAuthentication])
def add_abnormal(request):
    taker_id = request.auth['user_id']
    taker = Taker.objects.filter(id=taker_id).first()

    data = request.data.copy()
    data['taker'] = taker.id

    serializer = AbnormalSerializer(data=data)

    if serializer.is_valid():
        serializer.save()
        return created_response('이상행동 영상이 등록되었습니다.')
    else:
        error_message = next(iter(serializer.errors.values()))[0]
        return bad_request_response(error_message)


def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    if re.match(email_regex, email):
        return True
    return False

def get_video_duration_in_seconds(web_cam_file):
    try:
        # 웹캠 파일을 임시 파일로 저장
        with tempfile.NamedTemporaryFile(delete=False, suffix=".webm") as temp_file:
            for chunk in web_cam_file.chunks():
                temp_file.write(chunk)
            temp_file.flush()
            temp_file.close()  # 파일을 명시적으로 닫아서 FFmpeg가 읽을 수 있게 함

            # FFmpeg를 사용하여 동영상 길이 추출
            probe = ffmpeg.probe(temp_file.name)
            duration = float(probe['format']['duration'])  # 초 단위로 동영상 길이 추출
            os.remove(temp_file.name)  # 임시 파일 삭제
            return duration
    except Exception as e:
        return None

from datetime import datetime, timedelta


def subtract_duration_from_end_time(end_time, duration_seconds):
    try:
        # end_time을 datetime 객체로 변환 (형식을 "%H:%M:%S"로 수정)
        end_time_obj = datetime.strptime(end_time, "%H:%M:%S")

        # duration_seconds 만큼 빼기
        new_time_obj = end_time_obj - timedelta(seconds=duration_seconds)

        # 다시 "HH:MM:SS" 형식으로 반환
        return new_time_obj.strftime("%H:%M:%S")
    except Exception as e:
        print(f"Error: {e}")
        return None