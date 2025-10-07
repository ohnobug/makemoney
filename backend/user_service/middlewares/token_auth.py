import json
from fastapi import Request, status
from fastapi.responses import JSONResponse
import redis.asyncio as redis
from utils.redis import get_redis_connection
from config import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES
from jose import JWTError, jwt
from pydantic import BaseModel



class DecodeTokenUserData(BaseModel):
    user_id: int
    username: str
    avatar_url: str

def get_user_info_from_token(token: str):
    """
    从 JWT Token 字符串中解码出 payload。
    主要用于不需要强制验证（即不抛出 HTTP 异常）的场景。
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        # 如果解码失败，可以选择返回 None 或抛出自定义异常
        return None

# --- 定义在 /api 路径下，但不需要登录鉴权的公开API路由 ---

async def token_auth_middleware(request: Request, call_next):

    # 从请求头获取 token
    auth_header = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        return JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content={"code": 401, "message": "未提供认证信息"},
            headers={"WWW-Authenticate": "Bearer"},
        )

    token = auth_header.split(" ")[1]
    user_info = get_user_info_from_token(token)
    if not user_info:
        return JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content={"code": 401, "message": "凭证无效或已过期"},
            headers={"WWW-Authenticate": "Bearer"},
        )
    try:
        
        # (可选) 将用户信息附加到请求 state，方便路由函数直接使用
        request.state.user = DecodeTokenUserData(**user_info)

    except Exception as e:
        # 处理 Redis 连接异常等问题
        return JSONResponse(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            content={"code": 500, "message": f"服务器内部错误: {e}"},
        )

    # 验证通过，继续处理请求
    response = await call_next(request)
    return response

