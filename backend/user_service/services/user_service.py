'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
# services/user_service.py
import logging
from typing import List
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import and_
from db.models import VigaUsers
from schemas.userinfo import UserInfo
# import 'logging'

async def get_users_by_ids(
    db: AsyncSession, 
    user_ids: List[int]
    # include_inactive: bool = False
) -> List[UserInfo]:
    """
    根据用户ID列表批量查询用户信息
    """
    if not user_ids:
        return []
    
    try:
        # 构建查询条件
        conditions = [VigaUsers.id.in_(user_ids)]
        # if not include_inactive:
        #     conditions.append(User.is_active == True)
        
        # 执行查询
        stmt = select(VigaUsers).where(and_(*conditions))
        result = await db.execute(stmt)
        users = result.scalars().all()
        
        # 转换为 Pydantic 模型
        user_info_list = []
        for user in users:
            user_info = UserInfo(
                id=user.id,
                phone_number=user.phone_number,
                username=user.username,
                avatar_url=user.avatar_url,
                email=user.email,
                created_at=user.created_at
            )
            user_info_list.append(user_info)
        
        return user_info_list
        
    except Exception as e:
        logging.error(f"查询用户列表失败: {str(e)}")
        raise