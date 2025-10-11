"""
description:
@author chenchangfu
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
"""

from fastapi import Depends, Query, Request
from fastapi import APIRouter, HTTPException
from sqlalchemy import delete, select
from db.database import get_db
from sqlalchemy.ext.asyncio import AsyncSession


from schemas.userinfo import (
    UserInfoRequestOut,
    UserInfoListRequestIn,
    UserInfoListRequestOut,
)
from services.user_service import get_users_by_ids


# 创建一个 APIRouter 实例
router = APIRouter(prefix="/internal_api/users")


# 获取用户信息
@router.post("/userinfo", response_model=UserInfoRequestOut)
async def userinfo(request: Request):
    user_info = request.state.user
    if not user_info:
        raise HTTPException(status_code=401, detail="token解析错误")
    return UserInfoRequestOut(code=200, message="success", data=user_info)


@router.post("/get_user_list", response_model=UserInfoListRequestOut)
async def get_user_list(
    request: UserInfoListRequestIn, db: AsyncSession = Depends(get_db)
):
    # 业务逻辑：根据IDs查询用户#
    users = await get_users_by_ids(db=db, user_ids=request.ids)
    return UserInfoListRequestOut.create_response(
        users=users, total_count=len(users)  # 如果是精确查询，总数等于返回数
    )
