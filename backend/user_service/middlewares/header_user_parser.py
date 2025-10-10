'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
import json
from fastapi import Request
from pydantic import BaseModel
from .token_auth import DecodeTokenUserData


# async def header_user_parser_middleware (request: Request, call_next):
#     """
#     中间件用于解析请求头中的用户信息并注入到 request.state.user 中
#     """
#     # 从请求头获取用户信息
#     user_info_header = request.headers.get("X-User-Info")
#     if user_info_header:
#           try:
#               # 解析 JSON 字符串
#               user_info_dict = json.loads(user_info_header)
#               # 将用户信息注入到 request.state.user
#               request.state.user = DecodeTokenUserData(**user_info_dict)
#           except json.JSONDecodeError:
#               # 如果解析失败，继续处理请求但不注入用户信息
              
#               pass
#           except Exception:
#               # 如果其他异常，继续处理请求但不注入用户信息
#               pass
      
#           # 继续处理请求
#           response = await call_next(request)
#           return response


class HeaderUserParserMiddleware:
    def __init__(self, app):
        self.app = app

    async def __call__(self, request: Request, call_next):
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
            except (json.JSONDecodeError, Exception):
                # 如果解析失败或其他异常，继续处理请求但不注入用户信息
                pass
        
        # 继续处理请求
        response = await call_next(request)
        return response

# 创建实例的函数（如果需要）
def create_header_user_parser_middleware():
    return HeaderUserParserMiddleware