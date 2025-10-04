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

# 创建一个 APIRouter 实例
router = APIRouter(prefix="/api/art")
router.middleware("http")(redis_auth_middleware)

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
        art_items = [ArtItem(art) for art in arts]
        
        data = ArtListData(
            list=art_items,
            total=total,
            page=page,
            page_size=page_size
        )
        return ArtListResponse(
          data=data
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"获取艺术作品列表失败: {str(e)}")