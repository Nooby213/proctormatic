import pandas as pd
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans

# 데이터 로드 (파일 경로를 수정해 주세요)
data = pd.read_csv('data.csv')

# 실제 CSV 파일의 컬럼 이름으로 수정
# 예: 'feature1', 'feature2'라는 컬럼이 있다면 다음과 같이 수정
x = data[['feature1', 'feature2']]

# K-Means 모델 학습
kmeans = KMeans(n_clusters=3, random_state=42)
kmeans.fit(x)

# 클러스터 레이블 추가
data['cluster'] = kmeans.labels_

# 클러스터 도식화
plt.scatter(data['feature1'], data['feature2'], c=data['cluster'], cmap='viridis')
plt.xlabel('feature1')
plt.ylabel('feature2')
plt.title('K-Means Clustering Visualization')
plt.show()
