from fastapi import Depends,Query,Request
from fastapi import APIRouter, HTTPException
from sqlalchemy import delete, select

from db.models import VigaUsers
from db.database import get_db
from middlewares.token_auth import token_auth_middleware
from schemas.userinfo import UserInfo, UserInfoRequestOut
from sqlalchemy.ext.asyncio import AsyncSession




# 创建一个 APIRouter 实例
router = APIRouter(prefix="/api/users")
router.middleware("http")(token_auth_middleware)
# 获取用户信息
@router.post("/userinfo", response_model=UserInfoRequestOut)
async def userinfo(request: Request, db: AsyncSession = Depends(get_db)):
    user_info = request.state.user
    select_query = select(VigaUsers).where(VigaUsers.id == user_info.user_id)
    user_record = await db.execute(select_query)
    db_user = user_record.scalar_one_or_none()
    if not db_user:
        raise HTTPException(status_code=404, detail="用户不存在")
    return UserInfoRequestOut(
        code=200,
        message="success",
        data=UserInfo(**db_user.__dict__)
    )