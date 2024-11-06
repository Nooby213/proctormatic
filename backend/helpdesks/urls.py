from django.urls import path
from . import views

urlpatterns = [
    path('notification/', views.notification),
    path('notification/<int:notification_id>/', views.check_notification, name='check_notification'),
    path('question/', views.question, name='question'),
    path('question/<int:question_id>/', views.question_detail),
    path('question/<int:question_id>/answer/', views.answer),
    path('question/<int:question_id>/answer/admin/', views.answer_admin),
    path('faq/', views.faq),
    path('faq/<int:faq_id>/', views.faq_detail),
]