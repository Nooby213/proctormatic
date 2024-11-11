import { useEffect } from "react";
import * as faceapi from "face-api.js";

// Face API 모델 호출
const useFaceApiModels = () => {
  useEffect(() => {
    const loadModels = async () => {
      try {
        await faceapi.nets.tinyFaceDetector.loadFromUri("/models");
        await faceapi.nets.faceLandmark68Net.loadFromUri("/models");
        await faceapi.nets.faceRecognitionNet.loadFromUri("/models");
      } catch (err) {
        console.error("모델 로딩에 실패했습니다:", err);
      }
    };
    loadModels();
  }, []);
};

export default useFaceApiModels;
