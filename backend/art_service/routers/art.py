from fastapi import Depends,Query,Request
from fastapi import APIRouter, HTTPException
from sqlalchemy import delete, select

from db.database import get_db
from sqlalchemy.ext.asyncio import AsyncSession
from schemas.art_list import ArtListData, ArtListResponse
from middlewares.token_auth import token_auth_middleware
from db.art_model import ArtItem, VigaArt
from db.like_model import VigaLike
from schemas.like import LikeResponse
from db.collect_model import VigaCollect
from schemas.collect import CollectResponse
from db.share_model import VigaShare
from schemas.share import ShareResponse

# 创建一个 APIRouter 实例
router = APIRouter(prefix="/api/art")
router.middleware("http")(token_auth_middleware)


@router.post("/collect", response_model=CollectResponse, summary="收藏艺术作品")
async def collect_art(
    request: Request,
    art_id: int,
    db: AsyncSession = Depends(get_db)
):
    """
    收藏艺术作品
    
    Args:
        request: FastAPI请求对象，用于从Redis认证中间件获取用户信息
        art_id: 艺术作品ID
        db: 数据库会话
        
    Returns:
        CollectResponse: 收藏结果响应
    """
    try:
        # 从Redis认证中间件获取用户信息
        user_info = request.state.user
        user_id = user_info.get("id") if isinstance(user_info, dict) else None
        
        if not user_id:
            raise HTTPException(status_code=401, detail="无法获取用户信息")
        
        # 检查作品是否存在
        art_query = select(VigaArt).where(VigaArt.id == art_id)
        art_result = await db.execute(art_query)
        art = art_result.scalar_one_or_none()
        
        if not art:
            raise HTTPException(status_code=404, detail="艺术作品不存在")
        
        # 检查是否已经收藏
        collect_query = select(VigaCollect).where(
            VigaCollect.art_id == art_id,
            VigaCollect.user_id == user_id
        )
        collect_result = await db.execute(collect_query)
        existing_collect = collect_result.scalar_one_or_none()
        
        if existing_collect:
            # 如果已收藏，则取消收藏（删除记录）
            delete_stmt = delete(VigaCollect).where(
                VigaCollect.art_id == art_id,
                VigaCollect.user_id == user_id
            )
            await db.execute(delete_stmt)
            await db.commit()
            return CollectResponse(code=200, message="已取消收藏", data="")
        else:
            # 如果未收藏，则添加收藏记录
            # 获取作品作者ID
            author_id = art.user_id or 0
            
            # 创建收藏记录
            new_collect = VigaCollect(
                author_id=author_id,
                user_id=user_id,
                art_id=art_id
            )
            db.add(new_collect)
            await db.commit()
            await db.refresh(new_collect)
            
            return CollectResponse(code=200, message="收藏成功", data="")
            
    except HTTPException as he:
        raise he
    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"收藏操作失败: {str(e)}")

@router.post("/like", response_model=LikeResponse, summary="点赞艺术作品")
async def like_art(
    request: Request,
    art_id: int,
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

        # 从Redis认证中间件获取用户信息
        user_info = request.state.user
        user_id = user_info.get("id") if isinstance(user_info, dict) else None
        
        if not user_id:
            raise HTTPException(status_code=401, detail="无法获取用户信息")
        
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


@router.post("/share", response_model=ShareResponse, summary="分享艺术作品")
async def share_art(
    request: Request,
    art_id: int,
    db: AsyncSession = Depends(get_db)
):
    """
    分享艺术作品
    
    Args:
        request: FastAPI请求对象，用于从Redis认证中间件获取用户信息
        art_id: 艺术作品ID
        db: 数据库会话
        
    Returns:
        ShareResponse: 分享结果响应
    """
    try:
        # 从Redis认证中间件获取用户信息
        user_info = request.state.user
        user_id = user_info.get("id") if isinstance(user_info, dict) else None
        
        if not user_id:
            raise HTTPException(status_code=401, detail="无法获取用户信息")
        
        # 检查作品是否存在
        art_query = select(VigaArt).where(VigaArt.id == art_id)
        art_result = await db.execute(art_query)
        art = art_result.scalar_one_or_none()
        
        if not art:
            raise HTTPException(status_code=404, detail="艺术作品不存在")
        
        # 检查是否已经分享过（可选：允许重复分享）
        share_query = select(VigaShare).where(
            VigaShare.art_id == art_id,
            VigaShare.user_id == user_id
        )
        share_result = await db.execute(share_query)
        
        # todo 检查是否已分享过该作品
        # existing_share = share_result.scalar_one_or_none()
        
        # 可以选择是否允许重复分享，这里我们允许重复分享
        # if existing_share:
        #     return ShareResponse(code=200, message="已分享过该作品", data="")
        
        # 获取作品作者ID
        author_id = art.user_id or 0
        
        # 创建分享记录
        new_share = VigaShare(
            author_id=author_id,
            user_id=user_id,
            art_id=art_id
        )
        db.add(new_share)
        await db.commit()
        await db.refresh(new_share)
        
        return ShareResponse(code=200, message="分享成功", data="")
            
    except HTTPException as he:
        raise he
    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"分享操作失败: {str(e)}")