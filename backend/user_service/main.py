"""
description:
@author chenchangfu
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
"""

import uvicorn
from fastapi import Depends, FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.concurrency import asynccontextmanager
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from routers import users, users_api
import db.database as database
from dependencies.request_auth import request_auth
from dependencies.header_user_parser import header_user_parser

from routers import internal_api


@asynccontextmanager
async def lifespan(app: FastAPI):
    # 启动阶段 (在 yield 之前)
    print("Application startup...")

    # 这会确保在应用接受任何请求之前，数据库和表就已经创建好了
    await database.create_db_and_tables()
    print("Database and tables created.")

    yield
    print("Application shutdown...")
    # 释放数据库 Engine 和连接池
    if database.engine:
        await database.engine.dispose()
    print("Database engine disposed")


# 优化 FastAPI 配置，增强文档显示效果
app = FastAPI(
    title="用户服务 API",
    description="""
    ## 接口分组
    
    - **公开接口**: `/api/user/*` - 无需认证
    - **用户接口**: `/api/user/*` - 需要 JWT 认证  
    - **内部接口**: `/internal_api/user/*` - 需要 X-User-Info 头部
    """,
    version="1.0.0",
    lifespan=lifespan,
    # 配置安全方案，这样文档会显示认证按钮
    openapi_security=[{"Bearer": []}],
    # 配置安全方案定义和标签
    openapi_extra={
        "components": {
            "securitySchemes": {
                "Bearer": {
                    "type": "http",
                    "scheme": "bearer",
                    "bearerFormat": "JWT",
                    "description": """
                    JWT Bearer Token 认证。
                    
                    请在下方输入您的 JWT Token (不包含 'Bearer '前缀)。
                    
                    💡 **测试示例 Token (开发环境):**
                    ```
                    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMjMsInVzZXJuYW1lIjoiZGV2X3VzZXIifQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6y
                    ```
                    """,
                }
            }
        },
        "tags": [
            {"name": "用户认证", "description": "用户登录、注册等相关接口"},
            {"name": "用户信息", "description": "获取和操作用户信息的接口"},
            {"name": "内部接口", "description": "内部服务调用的接口"},
        ],
    },
)


class UnicornException(Exception):
    def __init__(self, message: str, code: int = 400):
        self.code = code
        self.message = message


@app.exception_handler(UnicornException)
async def unicorn_exception_handler(request: Request, exc: UnicornException):
    return JSONResponse(
        status_code=400,
        content={"code": exc.code, "message": exc.message},
    )


@app.exception_handler(HTTPException)
async def custom_http_exception_handler(request: Request, exc: HTTPException):
    """
    自定义 HTTPException 处理器。
     khusus 针对 401 Unauthorized 错误返回统一的 JSON 格式响应。
    """
    print(
        f"Caught HTTPException with status code: {exc.status_code} and detail: {exc.detail}"
    )

    if exc.detail == "Not authenticated":
        return JSONResponse(
            status_code=exc.status_code,
            content={"code": 401, "message": "用户尚未登录"},
        )

    return JSONResponse(
        status_code=exc.status_code,
        content={"code": exc.status_code, "message": exc.detail},
    )


app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://turcar.net.cn",
        "https://learn.turcar.net.cn",
        "http://localhost:5173",
        "http://127.0.0.1:5173",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 挂载子应用
app.include_router(users.router, prefix="/api/user")
# 需要登陆接口的路由
app.include_router(
    users_api.router,
    prefix="/api/user",
    dependencies=[Depends(request_auth)],
    tags=["用户信息"],
)

# 3. 内部接口 (internal_api.router)
app.include_router(
    internal_api.router,
    prefix="/internal_api/user",
    dependencies=[Depends(header_user_parser)],
    tags=["内部接口"],
)


if __name__ == "__main__":
    # 使用 uvicorn.run() 来启动应用
    uvicorn.run(
        "main:app",  # app 字符串，格式为 "module_name:app_instance_name"
        host="0.0.0.0",  # 监听所有网络接口
        port=8000,  # 监听 8000 端口
        reload=True,  # 开启热重载，代码变动时自动重启服务（仅限开发）
    )
