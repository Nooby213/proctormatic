from django.utils import timezone
from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from exams.models import Exam
from datetime import date, datetime
from .models import Taker

class TakerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Taker
        fields = ['name', 'email', 'exam']

    def create(self, validated_data):
        exam = validated_data.get('exam')
        exam_info = Exam.objects.get(id=exam.id)

        if exam_info.entry_time > timezone.now().time():
            raise serializers.ValidationError({'message': '입장 가능 시간이 아닙니다. 입장은 시험 시작 30분 전부터 가능합니다.'})
        if exam_info.end_time < timezone.now().time():
            raise serializers.ValidationError({'message': '종료된 시험입니다.'})

        return super().create(validated_data)

class UpdateTakerSerializer(serializers.ModelSerializer):
    birth = serializers.CharField(
        error_messages={
            'invalid': "날짜 형식이 올바르지 않습니다. YYYYMMDD 형식이어야 합니다."
        }
    )

    class Meta:
        model = Taker
        fields = ['birth', 'id_photo', 'verification_rate']

    def validate_birth(self, value):
        if not value.isdigit() or len(value) != 8:
            raise serializers.ValidationError("날짜 형식이 올바르지 않습니다. YYYYMMDD 형식이어야 합니다.")

        try:
            birth = datetime.strptime(value, '%Y%m%d')
            if birth.date() > date.today():
                raise serializers.ValidationError('생년월일은 오늘 날짜 이전이어야 합니다.')
        except ValueError:
            raise serializers.ValidationError("날짜 형식이 올바르지 않습니다. YYYYMMDD 형식이어야 합니다.")

        return birth

class TakerTokenSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_access_token(cls, taker):
        token = super().get_token(taker)
        token['token_type'] = 'access'
        token['role'] = "taker"

        exam = Exam.objects.get(id=taker.exam.id)
        current_time = timezone.now()
        exam_end_datetime = timezone.datetime.combine(exam.date, exam.end_time)
        exam_end_datetime_utc = exam_end_datetime.astimezone(timezone.utc)

        if current_time >= exam_end_datetime:
            raise serializers.ValidationError("시험이 종료되었습니다. 토큰을 발급할 수 없습니다.")

        token['exp'] = int(exam_end_datetime_utc.astimezone(timezone.utc).timestamp())

        return token