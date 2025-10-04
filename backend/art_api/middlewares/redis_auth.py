import json
from fastapi import Request, status
from fastapi.responses import JSONResponse
import redis.asyncio as redis
from ..redis.redsi import get_redis_connection

# --- 定义在 /api 路径下，但不需要登录鉴权的公开API路由 ---
# 这些是需要鉴权的 /api 组中的例外
PUBLIC_API_PATHS = [
    "/api/user/login",
    "/api/user/register",
    "/api/user/get_verify_code",
    "/api/user/reset_password",
]

async def redis_auth_middleware(request: Request, call_next):
    """
    基于 Redis Token 的认证中间件

    1. 检查请求路径是否以 /api 开头。如果不是，则直接放行。
    2. 如果以 /api 开头，再检查路径是否在公开API列表 PUBLIC_API_PATHS 中。如果是，也直接放行。
    3. 对于其他所有 /api 路径，执行 Token 验证。
    """
    # 如果请求路径不是以 /api 开头，或者在公开API列表中，则直接放行
    if not request.url.path.startswith("/api") or request.url.path in PUBLIC_API_PATHS:
        response = await call_next(request)
        return response

    # --- 以下是针对需要鉴权的 /api 路由的逻辑 ---

    # 从请求头获取 token
    auth_header = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        return JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content={"code": 401, "message": "未提供认证信息"},
            headers={"WWW-Authenticate": "Bearer"},
        )

    token = auth_header.split(" ")[1]

    # 连接 Redis 并验证 token
    redis_conn: redis.Redis = get_redis_connection()
    try:
        user_info_json = await redis_conn.get(token)
        
        if not user_info_json:
            return JSONResponse(
                status_code=status.HTTP_401_UNAUTHORIZED,
                content={"code": 401, "message": "凭证无效或已过期"},
                headers={"WWW-Authenticate": "Bearer"},
            )
        
        # (可选) 将用户信息附加到请求 state，方便路由函数直接使用
        request.state.user = json.loads(user_info_json)

    except Exception as e:
        # 处理 Redis 连接异常等问题
        return JSONResponse(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            content={"code": 500, "message": f"服务器内部错误: {e}"},
        )
    finally:
        # 确保 Redis 连接被关闭
        await redis_conn.close()

    # 验证通过，继续处理请求
    response = await call_next(request)
    return response