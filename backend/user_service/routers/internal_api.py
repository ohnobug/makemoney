from fastapi import Depends,Query,Request
from fastapi import APIRouter, HTTPException
from sqlalchemy import delete, select

from middlewares.header_user_parser import header_user_parser_middleware
from middlewares.token_auth import token_auth_middleware
from schemas.userinfo import UserInfoRequestOut



# 创建一个 APIRouter 实例
router = APIRouter(prefix="/internal_api/users")
router.middleware("http")(header_user_parser_middleware)
# 获取用户信息
@router.post("/userinfo", response_model=UserInfoRequestOut)
async def userinfo(request: Request):
    user_info = request.state.user
    if not user_info:
        raise HTTPException(status_code=401, detail="token解析错误")
    return UserInfoRequestOut(
        code=200,
        message="success",
        data=user_info
    )