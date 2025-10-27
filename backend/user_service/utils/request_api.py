import json
import httpx
from typing import Dict, Any, Optional
from fastapi import Request

async def request_internal_api(
    request: Request,
    method: str,
    url: str,
    data: Optional[Dict[Any, Any]] = None,
    params: Optional[Dict[Any, Any]] = None,
    headers: Optional[Dict[str, str]] = None
) -> httpx.Response:
    """
    封装的内部接口请求函数，在请求头中带上用户信息
    
    Args:
        request: FastAPI请求对象，用于获取用户信息
        method: HTTP方法 (GET, POST, PUT, DELETE等)
        url: 请求的URL
        data: 请求体数据 (用于POST, PUT等)
        params: 查询参数 (用于GET等)
        headers: 额外的请求头
        
    Returns:
        httpx.Response: HTTP响应对象
    """
    # 获取用户信息
    user_info = getattr(request.state, 'user', None)
    
    # 构造请求头
    request_headers = headers.copy() if headers else {}
    
    # 如果有用户信息，将其转换为JSON字符串并添加到请求头
    if user_info:
        # 将Pydantic模型转换为字典
        if hasattr(user_info, 'dict'):
            user_info_dict = user_info.dict()
        else:
            user_info_dict = user_info
            
        # 将用户信息转换为JSON字符串并添加到请求头
        request_headers['X-User-Info'] = json.dumps(user_info_dict, ensure_ascii=False)
    
    # 创建异步HTTP客户端
    async with httpx.AsyncClient() as client:
        # 根据方法类型发送请求
        if method.upper() == 'GET':
            response = await client.get(url, params=params, headers=request_headers)
        elif method.upper() == 'POST':
            response = await client.post(url, json=data, params=params, headers=request_headers)
        elif method.upper() == 'PUT':
            response = await client.put(url, json=data, params=params, headers=request_headers)
        elif method.upper() == 'DELETE':
            response = await client.delete(url, params=params, headers=request_headers)
        else:
            raise ValueError(f"Unsupported HTTP method: {method}")
            
        return response

# 使用示例的辅助函数
async def get_internal_api(request: Request, url: str, params: Optional[Dict[Any, Any]] = None, headers: Optional[Dict[str, str]] = None) -> httpx.Response:
    """封装的GET请求"""
    return await request_internal_api(request, "GET", url, params=params, headers=headers)

async def post_internal_api(request: Request, url: str, data: Optional[Dict[Any, Any]] = None, params: Optional[Dict[Any, Any]] = None, headers: Optional[Dict[str, str]] = None) -> httpx.Response:
    """封装的POST请求"""
    return await request_internal_api(request, "POST", url, data=data, params=params, headers=headers)

async def put_internal_api(request: Request, url: str, data: Optional[Dict[Any, Any]] = None, params: Optional[Dict[Any, Any]] = None, headers: Optional[Dict[str, str]] = None) -> httpx.Response:
    """封装的PUT请求"""
    return await request_internal_api(request, "PUT", url, data=data, params=params, headers=headers)

async def delete_internal_api(request: Request, url: str, params: Optional[Dict[Any, Any]] = None, headers: Optional[Dict[str, str]] = None) -> httpx.Response:
    """封装的DELETE请求"""
    return await request_internal_api(request, "DELETE", url, params=params, headers=headers)