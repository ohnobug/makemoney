import json
from fastapi import Request, status
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from .request_auth import DecodeTokenUserData


def header_user_parser(request: Request):
    """
    中间件用于解析请求头中的用户信息并注入到 request.state.user 中
    """
    # 从请求头获取用户信息
    user_info_header = request.headers.get("X-User-Info")
    if user_info_header:
        try:
            # 解析 JSON 字符串
            user_info_dict = json.loads(user_info_header)
            # 将用户信息注入到 request.state.user
            request.state.user = DecodeTokenUserData(**user_info_dict)
        except Exception:
            # 如果解析失败或其他异常，返回错误响应
            return JSONResponse(
                status_code=status.HTTP_400_BAD_REQUEST,
                content={"code": 400, "message": "用户信息格式错误"},
            )
