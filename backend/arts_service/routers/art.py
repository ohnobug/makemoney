from fastapi import Depends, Query
from fastapi import APIRouter, HTTPException
from sqlalchemy import select

from db.database import get_db
from sqlalchemy.ext.asyncio import AsyncSession
from schemas.art_list import ArtListData, ArtListResponse
from db.art_model import ArtItem, VigaArt

# 创建一个 APIRouter 实例  无限登陆路由
router = APIRouter()


@router.get("/list", response_model=ArtListResponse, summary="分页获取艺术作品列表")
async def get_art_list(
    page: int = Query(1, ge=1, description="页码，默认为1"),
    page_size: int = Query(10, ge=1, le=100, description="每页数量，默认为10，最大100"),
    db: AsyncSession = Depends(get_db),
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
            page_size=page_size,
        )
        return ArtListResponse(data=art_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"获取艺术作品列表失败: {str(e)}")
