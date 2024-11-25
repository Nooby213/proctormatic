import jwt
from django.conf import settings
from rest_framework.authentication import BaseAuthentication
from rest_framework.exceptions import AuthenticationFailed
from django.contrib.auth import get_user_model


User = get_user_model()

class CustomAuthentication(BaseAuthentication):
    def authenticate(self, request):
        # 회원가입, 비밀번호 재설정 인증번호 전송 기능은 auth가 필요없음
        if (request.path.endswith('/users/') or request.path.endswith('/users/password/')) and request.method == 'POST':
            return None

        auth_header = request.headers.get('Authorization')
        if auth_header is None or not auth_header.startswith('Bearer '):
            raise AuthenticationFailed('권한이 없습니다.')

        token = auth_header.split(' ')[1]

        try:
            decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
            user_id = decoded_token.get('user_id')
            role = decoded_token.get('role')

            if user_id is None or role != 'host':
                raise AuthenticationFailed('권한이 없습니다.')

            user = User.objects.get(pk=user_id)

            if not user.is_active:
                raise AuthenticationFailed('권한이 없습니다.')

            return (user, None)

        except jwt.ExpiredSignatureError:
            raise AuthenticationFailed('토큰이 만료되었습니다.')
        except jwt.DecodeError:
            raise AuthenticationFailed('유효하지 않은 토큰입니다.')
        except User.DoesNotExist:
            raise AuthenticationFailed('유저를 찾을 수 없습니다.')