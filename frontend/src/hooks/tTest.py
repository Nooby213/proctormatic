import pandas as pd
from scipy import stats

# CSV 파일 불러오기 (파일 경로와 인코딩을 수정해 주세요)
data = pd.read_csv('data.csv', encoding='latin1')

# 같은 사람 비교한 데이터와 다른 사람 비교한 데이터 분리
same_person_similarity = data[data['Person1'] == data['Person2']]['Similarity'].dropna()
different_person_similarity = data[data['Person1'] != data['Person2']]['Similarity'].dropna()

# t-검정 수행 (독립표본 t-검정)
t_stat, p_value = stats.ttest_ind(same_person_similarity, different_person_similarity)

# 결과 출력
print(f"t-통계량: {t_stat}")
print(f"p-값: {p_value}")

# p-값을 통해 유의미한 차이가 있는지 확인
if p_value < 0.01:
    print("같은 사람과 다른 사람 간에 유의미한 차이가 있음")
else:
    print("같은 사람과 다른 사람 간에 유의미한 차이가 없음")
