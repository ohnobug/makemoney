import datetime
from io import StringIO
import json
from fastapi import Depends,Query
from typing import List, Optional
from fastapi.responses import HTMLResponse
from fastapi import APIRouter, HTTPException
from sqlalchemy import delete, insert, select, update
from schemas.base_response import BaseResponse
from jiaoyisuo.backend.art_api.schemas.art_list import UserGetVerifyCodePurposeEnum, UserGetVerifyCodeRequestIn, UserGetVerifyCodeRequestOut
from sms import BAIDUSMS
from utils.utils import check_verify_code, generate_numeric_code_randint, get_token, get_userInfo_from_token, password_hash

from jiaoyisuo.backend.art_api.db.art_model import VigaUsers, VigaVerifyCodes
from db.database import get_db
from sqlalchemy.ext.asyncio import AsyncSession
from schemas.art_list import ArtListData, ArtListResponse
from middlewares.redis_auth import redis_auth_middleware
from db.art_model import ArtItem, VigaArt, ArtInDBBase
from db.like_model import VigaLike
from schemas.like import LikeResponse

# 创建一个 APIRouter 实例
router = APIRouter(prefix="/api/art")
router.middleware("http")(redis_auth_middleware)


@router.post("/like", response_model=LikeResponse, summary="点赞艺术作品")
async def like_art(
    art_id: int,
    user_id: int,
    db: AsyncSession = Depends(get_db)
):
    """
    点赞艺术作品
    
    Args:
        art_id: 艺术作品ID
        user_id: 用户ID
        db: 数据库会话
        
    Returns:
        LikeResponse: 点赞结果响应
    """
    try:
        # 检查作品是否存在
        art_query = select(VigaArt).where(VigaArt.id == art_id)
        art_result = await db.execute(art_query)
        art = art_result.scalar_one_or_none()
        
        if not art:
            raise HTTPException(status_code=404, detail="艺术作品不存在")
        
        # 检查是否已经点赞
        like_query = select(VigaLike).where(
            VigaLike.art_id == art_id,
            VigaLike.user_id == user_id
        )
        like_result = await db.execute(like_query)
        existing_like = like_result.scalar_one_or_none()
        
        if existing_like:
            # 如果已点赞，待定是否允许重复点赞
            ## todo
            print("用户已点赞该作品")
        else:
            # 如果未点赞，则添加点赞记录
            # 获取作品作者ID
            author_id = art.user_id or 0
            
            # 创建点赞记录
            new_like = VigaLike(
                author_id=author_id,
                user_id=user_id,
                art_id=art_id
            )
            db.add(new_like)
            await db.commit()
            await db.refresh(new_like)
            
            return LikeResponse(code=200, message="点赞成功")
            
    except HTTPException as he:
        raise he
    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"点赞操作失败: {str(e)}")

@router.get("/list", response_model=ArtListResponse, summary="分页获取艺术作品列表")
async def get_art_list(
    page: int = Query(1, ge=1, description="页码，默认为1"),
    page_size: int = Query(10, ge=1, le=100, description="每页数量，默认为10，最大100"),
    db: AsyncSession = Depends(get_db)
):

    """
    分页获取艺术作品列表
    """
    try:
        # 计算偏移量
        offset = (page - 1) * page_size
        
        # 查询总数
        count_query = select(VigaArt)
        total_result = await db.execute(count_query)
        total = len(total_result.scalars().all())
        
        # 查询当前页的数据
        stmt = select(VigaArt).offset(offset).limit(page_size)
        result = await db.execute(stmt)
        arts = result.scalars().all()
        
        # 转换为 Pydantic 模型
        art_items = ArtListData(
            list=[ArtItem(art) for art in arts],
            total=total,
            page=page,
            page_size=page_size
        )
        return ArtListResponse(
          data=art_items
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"获取艺术作品列表失败: {str(e)}")
