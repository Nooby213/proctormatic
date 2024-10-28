import re
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework import status
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
from django.contrib.auth import get_user_model, authenticate
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from django_redis import get_redis_connection
from .utils import generate_verification_code, send_verification_email, save_verification_code_to_redis
from .serializers import CustomTokenObtainPairSerializer, UserSerializer, UserInfoSerializer, EditMarketingSerializer, \
    FindEmailRequestSerializer, FindEmailResponseSerializer

User = get_user_model()


@swagger_auto_schema(
    method='get',
    operation_summary="이메일 중복체크",
    manual_parameters=[
        openapi.Parameter('email', openapi.IN_QUERY, type=openapi.TYPE_STRING),
    ],
    responses={
        200: openapi.Response('이메일 중복체크 결과입니다.', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'isAlreadyExists': openapi.Schema(type=openapi.TYPE_BOOLEAN),
            }
        )),
        400: openapi.Response('잘못된 이메일 형식 또는 이메일 미제공', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    }
)
@swagger_auto_schema(
    method='post',
    operation_summary="이메일 인증번호 발송",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'email': openapi.Schema(type=openapi.TYPE_STRING),
        }
    ),
    responses={
        200: openapi.Response('인증번호를 발송했습니다.', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        400: openapi.Response('잘못된 이메일 형식 또는 이메일 미제공', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    }
)
@swagger_auto_schema(
    method='put',
    operation_summary="이메일 인증",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'email': openapi.Schema(type=openapi.TYPE_STRING),
            'code': openapi.Schema(type=openapi.TYPE_STRING),
        }
    ),
    responses={
        200: openapi.Response('이메일 인증이 완료되었습니다.', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        400: openapi.Response('잘못된 인증번호 또는 만료된 인증번호', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    }
)
@api_view(['GET', 'POST', 'PUT'])
@permission_classes([AllowAny])
def handle_email_verification(request):
    if request.method == 'GET':
        email = request.query_params.get('email')

        if not is_valid_email(email):
            return Response({'message': '이메일 형식을 확인해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

        if email:
            email_exists = User.objects.filter(email=email).exists()
            return Response({'isAlreadyExists': email_exists}, status=status.HTTP_200_OK)
        else:
            return Response({'message': '이메일을 입력해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'POST':
        email = request.data.get('email')
        if email:
            if not is_valid_email(email):
                return Response({'message': '이메일 형식을 확인해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

            code = generate_verification_code()
            send_verification_email(email, code)
            save_verification_code_to_redis(email, code)

            return Response({'message': '인증번호를 발송했습니다.'}, status=status.HTTP_200_OK)
        else:
            return Response({'message': '이메일을 입력해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'PUT':
        email = request.data.get('email')
        code = request.data.get('code')

        if not email:
            return Response({'message': '이메일을 입력해주세요.'}, status=status.HTTP_400_BAD_REQUEST)
        if not code:
            return Response({'message': '인증번호를 입력해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

        redis_conn = get_redis_connection('default')
        stored_code = redis_conn.get(f'verification_code:{email}')

        if stored_code is None:
            return Response({'message': '인증번호가 만료되었습니다.'}, status=status.HTTP_400_BAD_REQUEST)

        if stored_code.decode('utf-8') == code:
            return Response({'message': '이메일 인증이 완료되었습니다.'}, status=status.HTTP_200_OK)
        else:
            return Response({'message': '잘못된 인증번호입니다.'}, status=status.HTTP_400_BAD_REQUEST)


@swagger_auto_schema(
    method='get',
    operation_summary="회원정보 조회",
    manual_parameters=[
        openapi.Parameter('Authorization', openapi.IN_HEADER, type=openapi.TYPE_STRING)
    ],
    responses={
        200: openapi.Response('회원정보 조회 결과입니다.', schema=UserSerializer()),
        401: openapi.Response('인증 실패', schema=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        403: openapi.Response('권한이 없습니다.', schema=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    },
)
@swagger_auto_schema(
    method='post',
    operation_summary="회원가입",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'name': openapi.Schema(type=openapi.TYPE_STRING),
            'email': openapi.Schema(type=openapi.TYPE_STRING),
            'password': openapi.Schema(type=openapi.TYPE_STRING),
            'birth': openapi.Schema(type=openapi.TYPE_STRING, format=openapi.FORMAT_DATE),
            'policy': openapi.Schema(type=openapi.TYPE_BOOLEAN),
            'marketing': openapi.Schema(type=openapi.TYPE_BOOLEAN),
        }
    ),
    responses={
        201: openapi.Response('회원가입이 완료되었습니다.', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        400: openapi.Response('잘못된 요청입니다.', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    }
)
@swagger_auto_schema(
    method='put',
    operation_summary="마케팅 활용 및 광고 수신 여부 수정",
    manual_parameters=[
        openapi.Parameter('Authorization', openapi.IN_HEADER, type=openapi.TYPE_STRING)
    ],
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'marketing': openapi.Schema(type=openapi.TYPE_BOOLEAN)
        }
    ),
    responses={
        200: openapi.Response('마케팅 활용 및 광고 수신 여부가 수정되었습니다.', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        400: openapi.Response('잘못된 인증번호 또는 만료된 인증번호', openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    }
)
@api_view(['GET', 'POST', 'PUT'])
@permission_classes([AllowAny])
def handle_user(request):
    if request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "회원가입이 완료되었습니다."}, status=status.HTTP_201_CREATED)
        return Response({"message": "잘못된 요청입니다."}, status=status.HTTP_400_BAD_REQUEST)
    else:
        if not request.user.is_authenticated:
            return Response({'message': '권한이 없습니다.'}, status=status.HTTP_403_FORBIDDEN)

        user_id = request.auth['id']
        user = User.objects.get(pk=user_id)

        if request.method == 'GET':
            if not user.is_active:
                return Response({'message': '권한이 없습니다.'}, status=status.HTTP_403_FORBIDDEN)

            serializer = UserInfoSerializer(user)
            return Response(serializer.data, status=status.HTTP_200_OK)

        elif request.method == 'PUT':

            serializer = EditMarketingSerializer(data=request.data)
            if serializer.is_valid():
                user.marketing = serializer.data.get('marketing')
                user.save()
                return Response({'message': '마케팅 활용 및 광고 수신 여부가 수정되었습니다.'}, status=status.HTTP_200_OK)


@swagger_auto_schema(
    method='post',
    operation_summary="로그인",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'email': openapi.Schema(type=openapi.TYPE_STRING),
            'password': openapi.Schema(type=openapi.TYPE_STRING),
        }
    ),
    responses={
        200: openapi.Response('로그인이 완료되었습니다.', schema=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'access': openapi.Schema(type=openapi.TYPE_STRING),
                'refresh': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        400: openapi.Response('잘못된 요청입니다.', schema=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    },
)
@swagger_auto_schema(
    method='patch',
    operation_summary="accessToken 재발급",
    request_body=openapi.Schema(
        type=openapi.TYPE_OBJECT,
        properties={
            'refresh': openapi.Schema(type=openapi.TYPE_STRING),
        },
    ),
    responses={
        200: openapi.Response('토큰이 재발급되었습니다.', schema=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'access': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
        400: openapi.Response('잘못된 요청입니다.', schema=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'message': openapi.Schema(type=openapi.TYPE_STRING),
            }
        )),
    },
)
@api_view(['POST', 'PATCH'])
@permission_classes([AllowAny])
def handle_token(request):
    if request.method == 'POST':
        email = request.data.get('email')
        password = request.data.get('password')

        if not email:
            return Response({'message': '이메일을 입력해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

        if not password:
            return Response({'message': '비밀번호를 입력해주세요.'}, status=status.HTTP_400_BAD_REQUEST)

        user = User.objects.filter(email=email).first()
        if user is None:
            return Response({'message': '입력한 이메일은 등록되어 있지 않습니다.'}, status=status.HTTP_400_BAD_REQUEST)

        user = authenticate(email=email, password=password)
        if user is None:
            return Response({'message': '비밀번호가 일치하지 않습니다. 확인 후 다시 시도해 주세요.'}, status=status.HTTP_400_BAD_REQUEST)

        serializer = CustomTokenObtainPairSerializer()
        serializer.user = user
        token_data = serializer.validate({})
        return Response(token_data, status=status.HTTP_200_OK)

    elif request.method == 'PATCH':
        refresh_token = request.data.get('refresh')

        if not refresh_token:
            return Response({'message': 'refresh token이 입력되지 않았습니다.'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            refresh = RefreshToken(refresh_token)
            new_access_token = str(refresh.access_token)
            return Response({'access': new_access_token}, status=status.HTTP_200_OK)

        except TokenError as e:
            if isinstance(e, InvalidToken):
                return Response({'message': '유효하지 않은 토큰입니다.'}, status=status.HTTP_400_BAD_REQUEST)
            return Response({'message': '토큰이 만료되었습니다. 다시 로그인 해주세요.'}, status=status.HTTP_401_UNAUTHORIZED)

@swagger_auto_schema(
    method='post',
    operation_summary="이메일 찾기",
    request_body=FindEmailRequestSerializer,
    responses={
        200: openapi.Response('이메일 검색 결과입니다.', schema=FindEmailResponseSerializer),
        400: openapi.Response('잘못된 형식', schema=FindEmailRequestSerializer),
    }
)
@api_view(['POST'])
@permission_classes([AllowAny])
def find_email(request):
    request_serializer = FindEmailRequestSerializer(data=request.data)
    if request_serializer.is_valid():
        name = request_serializer.data.get('name')
        birth = request_serializer.data.get('birth')
        user_list = User.objects.filter(name=name, birth=birth, is_active=1).order_by('-created_at')

        response_serializer = FindEmailResponseSerializer(user_list, many=True)
        return Response({
            'emailList': response_serializer.data,
            'size': len(response_serializer.data)
        }, status=status.HTTP_200_OK)
    else:
        return Response(request_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


def is_valid_email(email):
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'

    if re.match(email_regex, email):
        return True
    return False