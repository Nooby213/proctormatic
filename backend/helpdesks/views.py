from django.contrib.auth import get_user_model
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import AllowAny
from django.core.paginator import Paginator

from .models import Notification, Question, Faq, Answer
from .serializers import NotificationCreateSerializer, NotificationListSerializer, NotificationObjectSerializer, \
    FaqCreateSerializer, FaqListSerializer, FaqSerializer, QuestionSerializer, QuestionEditSerializer, \
    QuestionCreateSerializer, QuestionListSerializer, AnswerSerializer
from .swagger_schemas import notification_schama, check_notification_schema, question_schema, question_detail_schema, \
    faq_schema, faq_detail_schema, answer_schema, answer_admin_schema

User = get_user_model()


@notification_schama
@api_view(['GET', 'POST'])
@permission_classes([AllowAny])
def notification(request):
    if request.method == 'POST':
        serializer = NotificationCreateSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': '공지사항이 등록되었습니다.'}, status=status.HTTP_201_CREATED)
    elif request.method == 'GET':
        notifications = Notification.objects.all()
        page = request.GET.get('page', 1)
        size = request.GET.get('size', 10)
        if int(page) <= 0:
            return Response({'message': '잘못된 페이지 요청입니다.'}, status=status.HTTP_400_BAD_REQUEST)
        if int(size) <= 0:
            return Response({'message': '잘못된 사이즈 요청입니다.'}, status=status.HTTP_400_BAD_REQUEST)
        paginator = Paginator(notifications, size)
        page_obj = paginator.get_page(page)
        serializer = NotificationListSerializer(page_obj, many=True)
        data = {
            "notificationList": serializer.data,
            "prev": page_obj.has_previous(),
            "next": page_obj.has_next(),
            "totalPage": paginator.num_pages,
        }
        return Response(data, status=status.HTTP_200_OK)


@check_notification_schema
@api_view(['GET', 'DELETE'])
@permission_classes([AllowAny])
def check_notification(request, notification_id):
    try:
        notification = Notification.objects.get(pk=notification_id)
    except:
        return Response({'message': '공지 사항이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = NotificationObjectSerializer(notification)
        return Response(serializer.data, status=status.HTTP_200_OK)
    elif request.method == 'DELETE':
        notification.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


@question_schema
@api_view(['POST', 'GET'])
def question(request):
    user = find_user_by_token(request)

    if request.method == 'POST':
        serializer = QuestionCreateSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=user)
            return Response({'message': '등록이 완료되었습니다.'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'message': '제목은 100자를 넘길 수 없습니다.'}, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'GET':
        questions = Question.objects.filter(user_id=user.id)
        page = request.GET.get('page', 1)
        size = request.GET.get('size', 10)
        if int(page) <= 0:
            return Response({'message': '잘못된 페이지 요청입니다.'}, status=status.HTTP_400_BAD_REQUEST)
        if int(size) <= 0:
            return Response({'message': '잘못된 사이즈 요청입니다.'}, status=status.HTTP_400_BAD_REQUEST)
        paginator = Paginator(questions, size)
        page_obj = paginator.get_page(page)
        serializer = QuestionListSerializer(page_obj, many=True)
        data = {
            "questionList": serializer.data,
            "prev": page_obj.has_previous(),
            "next": page_obj.has_next(),
            "totalPage": paginator.num_pages,
        }
        return Response(data, status=status.HTTP_200_OK)


@question_detail_schema
@api_view(['GET', 'PUT', 'DELETE'])
def question_detail(request, question_id):
    user_id = request.auth['user_id']

    try:
        question = Question.objects.get(pk=question_id, user_id=user_id)
    except:
        return Response({'message': '질문이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = QuestionSerializer(question)
        return Response(serializer.data, status=status.HTTP_200_OK)

    elif request.method == 'PUT':
        serializer = QuestionEditSerializer(question, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': '질문이 수정되었습니다.'}, status=status.HTTP_200_OK)
        return Response({'message': '잘못된 요청입니다.'}, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        question.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


@answer_schema
@api_view(['POST'])
def create_answer(request, question_id):
    user_id = request.auth['user_id']
    user = User.objects.get(pk=user_id)

    question = Question.objects.filter(pk=question_id, user_id=user_id).first()
    if question is None:
        return Response({'message': '질문이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'POST':
        serializer = AnswerSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(question=question, author=user.name)
            return Response({'message': '답변이 등록되었습니다.'}, status=status.HTTP_201_CREATED)


@answer_admin_schema
@api_view(['POST'])
@permission_classes([AllowAny])
def create_answer_admin(request, question_id):
    question = Question.objects.filter(pk=question_id).first()
    if question is None:
        return Response({'message': '질문이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'POST':
        serializer = AnswerSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(question=question, author='admin')
            return Response({'message': '답변이 등록되었습니다.'}, status=status.HTTP_201_CREATED)


@answer_admin_schema
@api_view(['PUT'])
@permission_classes([AllowAny])
def update_answer_admin(request, question_id, answer_id):
    question = Question.objects.filter(pk=question_id).first()
    if question is None:
        return Response({'message': '질문이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)
    answer = Answer.objects.filter(pk=answer_id).first()
    if answer is None:
        return Response({'message': '답변이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = AnswerSerializer(answer, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': '답변이 수정되었습니다.'}, status=status.HTTP_200_OK)


@faq_schema
@api_view(['GET', 'POST'])
@permission_classes([AllowAny])
def faq(request):
    if request.method == 'GET':
        faq_list = Faq.objects.all()
        serializer = FaqListSerializer(faq_list, many=True)
        return Response({'faqList': serializer.data}, status=status.HTTP_200_OK)

    elif request.method == 'POST':
        serializer = FaqCreateSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': '자주 묻는 질문이 등록되었습니다.'}, status=status.HTTP_201_CREATED)


@faq_detail_schema
@api_view(['GET', 'DELETE'])
@permission_classes([AllowAny])
def faq_detail(request, faq_id):
    try:
        faq = Faq.objects.get(id=faq_id)
    except:
        return Response({'message': '자주 묻는 질문이 존재하지 않습니다.'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = FaqSerializer(faq)
        return Response(serializer.data, status=status.HTTP_200_OK)
    elif request.method == 'DELETE':
        faq.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


def find_user_by_token(request):
    user_id = request.auth['user_id']
    user = User.objects.get(pk=user_id)

    if not user.is_active:
        return Response({'message': '권한이 없습니다.'}, status=status.HTTP_403_FORBIDDEN)
    return user