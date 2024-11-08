import os
from celery import Celery
from django.conf import settings

# DJANGO_SETTINGS_MODULE의 환경 변수 설정
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'proctormatic.settings')
app = Celery('proctormatic')

# namespace를 설정해준 것은 celery 구성 옵션들이 모두 앞에 CELERY_가 붙게 되는 것을 의미
app.config_from_object('django.conf:settings', namespace='CELERY')

# celery가 자동적으로 tasks를 찾는데, 우리가 설치되어 있는 앱에서 찾아줌
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


@app.task(bind=True)
def debug_task(self):
    print("Request: {0!r}".format(self.request))