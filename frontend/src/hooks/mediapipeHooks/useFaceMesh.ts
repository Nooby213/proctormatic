import { useEffect, useRef, useState } from "react";
import * as face_mesh from "@mediapipe/face_mesh";
import { Camera } from "@mediapipe/camera_utils";
import axiosInstance from "@/utils/axios";

const useFaceMesh = (
  videoRef: React.RefObject<HTMLVideoElement>,
  faceCanvasRef: React.RefObject<HTMLCanvasElement>,
  recordStartTime: Date,
  onResults: (results: any) => void
) => {
  const [noFaceStartTime, setNoFaceStartTime] = useState<Date | null>(null);
  const [noFaceEndTime, setNoFaceEndTime] = useState<Date | null>(null);
  const noFaceStartTimeRef = useRef<Date | null>(null);

  const fetchPostAbnormal = (
    detectedTime: Date,
    endTime: Date,
    type: string
  ) => {
    const detectedMilliseconds =
      detectedTime.getTime() - recordStartTime.getTime();
    const endMilliseconds = endTime.getTime() - recordStartTime.getTime();

    const formatElapsedTime = (milliseconds: number) => {
      const seconds = Math.floor(milliseconds / 1000) % 60;
      const minutes = Math.floor(milliseconds / (1000 * 60)) % 60;
      const hours = Math.floor(milliseconds / (1000 * 60 * 60));
      return `${String(hours).padStart(2, "0")}:${String(minutes).padStart(
        2,
        "0"
      )}:${String(seconds).padStart(2, "0")}`;
    };

    const detectedTimeFormatted = formatElapsedTime(detectedMilliseconds);
    const endTimeFormatted = formatElapsedTime(endMilliseconds);

    axiosInstance
      .post("/taker/abnormal/", {
        type: type,
        detected_time: detectedTimeFormatted,
        end_time: endTimeFormatted,
      })
      .then((response) => {
        console.log("이상행동 등록 성공: ", response.data);
      })
      .catch((error) => {
        console.error("이상행동 등록 실패: ", error);
      });
  };

  useEffect(() => {
    if (!videoRef.current) return;

    const faceMesh = new face_mesh.FaceMesh({
      locateFile: (file) =>
        `https://cdn.jsdelivr.net/npm/@mediapipe/face_mesh/${file}`,
    });

    faceMesh.setOptions({
      maxNumFaces: 2,
      refineLandmarks: true,
      minDetectionConfidence: 0.5,
      minTrackingConfidence: 0.5,
    });

    faceMesh.onResults((results) => {
      const canvas = faceCanvasRef.current;
      if (!canvas) return;

      const ctx = canvas.getContext("2d");
      const video = videoRef.current;

      if (!ctx || !video) return;

      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

      if (
        !results.multiFaceLandmarks ||
        results.multiFaceLandmarks.length === 0
      ) {
        if (noFaceStartTimeRef.current === null) {
          noFaceStartTimeRef.current = new Date();
          setNoFaceStartTime(noFaceStartTimeRef.current);
        }
        return;
      }

      if (noFaceStartTimeRef.current !== null) {
        const currentEndTime = new Date();
        setNoFaceEndTime(currentEndTime);

        fetchPostAbnormal(
          noFaceStartTimeRef.current,
          currentEndTime,
          "absence"
        );

        noFaceStartTimeRef.current = null;
      }

      if (results.multiFaceLandmarks.length > 1) {
        const currentTime = new Date();
        fetchPostAbnormal(currentTime, currentTime, "overcrowded");
      }

      onResults(results);
    });

    const camera = new Camera(videoRef.current, {
      onFrame: async () => {
        if (videoRef.current) {
          await faceMesh.send({ image: videoRef.current });
        }
      },
      width: 800,
      height: 600,
    });

    camera.start();
  }, [videoRef, onResults]);

  return { noFaceStartTime, noFaceEndTime };
};

export default useFaceMesh;
