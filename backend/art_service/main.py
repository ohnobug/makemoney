import uvicorn
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.concurrency import asynccontextmanager
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from backend.art_service.middlewares.header_user_parser import (
    header_user_parser_middleware,
)
from backend.art_service.middlewares.token_auth import token_auth_middleware
import db.art_model
import db.database as database
from routers import art, comment, upload, arts


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


app = FastAPI(title="FastAPI新接口", lifespan=lifespan)

# 创建需要登陆子应用
api_app = FastAPI()
# 创建内部调用子应用
internal_app = FastAPI()

# 为子应用添加中间件
api_app.middleware("http")(token_auth_middleware)
internal_app.middleware("http")(header_user_parser_middleware)


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

# 用户路由
app.include_router(art.router)
app.mount("/api/arts", api_app)
# app.mount("/internal_api/users", internal_app)

# 在子应用中包含路由
api_app.include_router(arts.router)
api_app.include_router(comment.router)
api_app.include_router(upload.router)
# internal_app.include_router(internal_api.router)


if __name__ == "__main__":
    # 使用 uvicorn.run() 来启动应用
    uvicorn.run(
        "main:app",  # app 字符串，格式为 "module_name:app_instance_name"
        host="0.0.0.0",  # 监听所有网络接口
        port=8001,  # 监听 8000 端口
        reload=True,  # 开启热重载，代码变动时自动重启服务（仅限开发）
    )
