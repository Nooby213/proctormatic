import fs from "fs";
import path from "path";
import * as faceapi from "face-api.js";
import { createObjectCsvWriter } from "csv-writer";
import { fileURLToPath } from "url"; // __dirname 대체용
import { Canvas, Image, ImageData } from "canvas"; // canvas 라이브러리 추가

// Node 환경에서 face-api.js가 canvas를 사용하도록 설정
faceapi.env.monkeyPatch({ Canvas, Image, ImageData });

// __dirname 설정 (ES 모듈에서 __dirname 대체)
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 모델 로드
const loadModels = async () => {
  const modelPath = path.join(__dirname, "../public/models");
  await faceapi.nets.ssdMobilenetv1.loadFromDisk(modelPath);
  await faceapi.nets.faceLandmark68Net.loadFromDisk(modelPath);
  await faceapi.nets.faceRecognitionNet.loadFromDisk(modelPath);
};

// 유사도 측정 함수
const computeSimilarity = async (img1Path, img2Path) => {
  try {
    const img1 = await canvasLoadImage(img1Path);
    const img2 = await canvasLoadImage(img2Path);
    const img1Desc = await faceapi.computeFaceDescriptor(img1);
    const img2Desc = await faceapi.computeFaceDescriptor(img2);
    const similarity = faceapi.euclideanDistance(img1Desc, img2Desc);
    return similarity;
  } catch (error) {
    console.error("유사도 계산 중 오류 발생:", error);
    return null; // 오류 발생 시 null 반환
  }
};

// canvas 라이브러리로 이미지 로드
const canvasLoadImage = async (imgPath) => {
  const buffer = fs.readFileSync(imgPath);
  const img = new Image();
  img.src = buffer;
  return img;
};

// 현재 시간 추가하여 파일명 생성
const getCurrentTimestamp = () => {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, "0");
  const day = String(now.getDate()).padStart(2, "0");
  const hours = String(now.getHours()).padStart(2, "0");
  const minutes = String(now.getMinutes()).padStart(2, "0");
  const seconds = String(now.getSeconds()).padStart(2, "0");
  return `${year}${month}${day}_${hours}${minutes}${seconds}`;
};

// CSV 저장 설정
const csvWriter = createObjectCsvWriter({
  path: `similarity_results_${getCurrentTimestamp()}.csv`, // 파일명에 현재 시간 추가
  header: [
    { id: "person", title: "Person" },
    { id: "image1", title: "Image1" },
    { id: "image2", title: "Image2" },
    { id: "similarity", title: "Similarity" },
  ],
});

const main = async () => {
  await loadModels();
  const datasetFolder = path.join(__dirname, "../public/images");

  const results = [];

  // 모든 이미지 파일을 읽어오는 함수
  const getAllImages = (baseFolder) => {
    const categories = fs.readdirSync(baseFolder);

    const images = [];
    for (const category of categories) {
      const categoryPath = path.join(baseFolder, category);

      // 사람별 하위 폴더 확인
      if (fs.lstatSync(categoryPath).isDirectory()) {
        const personFolders = fs.readdirSync(categoryPath);

        for (const personFolder of personFolders) {
          const personPath = path.join(categoryPath, personFolder);

          if (fs.lstatSync(personPath).isDirectory()) {
            const personImages = fs
              .readdirSync(personPath)
              .filter((file) => file.endsWith(".jpg"))
              .map((file) => path.join(personPath, file));

            images.push({
              personFolder: `${category}/${personFolder}`,
              images: personImages,
            });
          }
        }
      }
    }
    return images;
  };

  // 모든 이미지를 가져오기
  const allImages = getAllImages(datasetFolder);

  // 각 사람의 이미지 폴더 내에서 유사도 계산
  for (const { personFolder, images } of allImages) {
    for (let i = 0; i < images.length; i++) {
      for (let j = i + 1; j < images.length; j++) {
        const similarity = await computeSimilarity(images[i], images[j]);

        // 유사도가 null이 아닌 경우에만 저장
        if (similarity !== null) {
          results.push({
            person: personFolder,
            image1: path.basename(images[i]),
            image2: path.basename(images[j]),
            similarity: similarity.toFixed(2),
          });
          console.log(
            `유사도 계산 완료: ${personFolder} - ${path.basename(
              images[i]
            )} vs ${path.basename(images[j])} = ${similarity}`
          );
        }
      }
    }
  }

  // CSV 파일로 저장
  await csvWriter.writeRecords(results);
  console.log("CSV 파일 생성 완료");
};

main().catch(console.error);
