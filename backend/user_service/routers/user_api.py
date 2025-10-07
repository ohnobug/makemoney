from fastapi import Depends,Query,Request
from fastapi import APIRouter, HTTPException
from sqlalchemy import delete, select

from middlewares.token_auth import token_auth_middleware
from schemas.userinfo import UserInfoRequestOut



# 创建一个 APIRouter 实例
router = APIRouter(prefix="/api/users")
router.middleware("http")(token_auth_middleware)
# 获取用户信息
@router.post("/userinfo", response_model=UserInfoRequestOut)
async def userinfo(request: Request):
    user_info = request.state.user
 
    return UserInfoRequestOut(
        code=200,
        message="success",
        data=user_info
    )