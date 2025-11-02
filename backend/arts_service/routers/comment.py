from fastapi import APIRouter, HTTPException, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.orm import joinedload
from typing import List
from db.database import get_db
from db.comment_model import VigaComment
from db.user_model import VigaUsers  # 导入用户模型
from schemas.comment import (
    CommentCreate,
    CommentUpdate,
    CommentItem,
    CommentResponse,
    CommentListResponse,
)

# 创建一个 APIRouter 实例
router = APIRouter()


@router.post("/comments", response_model=CommentResponse, summary="创建评论")
async def create_comment(comment: CommentCreate, db: AsyncSession = Depends(get_db)):
    """
    创建新的评论

    Args:
        comment: 评论信息
        db: 数据库会话

    Returns:
        CommentResponse: 评论创建结果
    """
    try:
        # 创建新的评论实例
        db_comment = VigaComment(**comment.model_dump())
        db.add(db_comment)
        await db.commit()
        await db.refresh(db_comment)

        # 构造返回数据
        comment_item = CommentItem(
            id=db_comment.id,
            user_id=db_comment.user_id,
            art_id=db_comment.art_id,
            message=db_comment.message,
            file_url=db_comment.file_url,
            create_time=db_comment.create_time,
        )

        return CommentResponse(code=200, message="评论创建成功", data=comment_item)

    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"创建评论失败: {str(e)}")


@router.get(
    "/comments/list", response_model=CommentListResponse, summary="分页获取评论列表"
)
async def get_comments(
    art_id: int = Query(..., description="艺术作品ID"),
    page: int = Query(1, ge=1, description="页码，默认为1"),
    page_size: int = Query(10, ge=1, le=100, description="每页数量，默认为10，最大100"),
    db: AsyncSession = Depends(get_db),
):
    """
    根据艺术作品ID分页获取评论列表，并关联用户名称信息

    Args:
        art_id: 艺术作品ID
        page: 页码
        page_size: 每页数量
        db: 数据库会话

    Returns:
        CommentListResponse: 评论列表响应
    """
    try:
        # 计算偏移量
        offset = (page - 1) * page_size

        # 查询总数
        count_query = select(VigaComment).where(VigaComment.art_id == art_id)
        count_result = await db.execute(count_query)
        total = len(count_result.scalars().all())

        # 查询当前页的数据，并关联用户表获取用户名
        stmt = (
            select(VigaComment, VigaUsers.username)
            .join(VigaUsers, VigaComment.user_id == VigaUsers.id, isouter=True)
            .where(VigaComment.art_id == art_id)
            .offset(offset)
            .limit(page_size)
        )

        result = await db.execute(stmt)
        comments_with_users = result.all()

        # 构造返回数据
        comment_items = []
        for comment, username in comments_with_users:
            comment_item = CommentItem(
                id=comment.id,
                user_id=comment.user_id,
                art_id=comment.art_id,
                message=comment.message,
                file_url=comment.file_url,
                create_time=comment.create_time,
                # 真正从用户表获取用户名
                user_name=username if username else "匿名用户",
            )
            comment_items.append(comment_item)

        return CommentListResponse(
            code=200,
            message="获取成功",
            data=comment_items,
            total=total,
            page=page,
            page_size=page_size,
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"获取评论列表失败: {str(e)}")


@router.get(
    "/comments/{comment_id}", response_model=CommentResponse, summary="获取评论详情"
)
async def get_comment(comment_id: int, db: AsyncSession = Depends(get_db)):
    """
    根据ID获取评论详情

    Args:
        comment_id: 评论ID
        db: 数据库会话

    Returns:
        CommentResponse: 评论详情
    """
    try:
        # 查询评论，并关联用户表获取用户名
        stmt = (
            select(VigaComment, VigaUsers.username)
            .join(VigaUsers, VigaComment.user_id == VigaUsers.id, isouter=True)
            .where(VigaComment.id == comment_id)
        )

        result = await db.execute(stmt)
        comment_with_user = result.one_or_none()

        if not comment_with_user:
            raise HTTPException(status_code=404, detail="评论不存在")

        comment, username = comment_with_user

        # 构造返回数据
        comment_item = CommentItem(
            id=comment.id,
            user_id=comment.user_id,
            art_id=comment.art_id,
            message=comment.message,
            file_url=comment.file_url,
            create_time=comment.create_time,
            # 真正从用户表获取用户名
            user_name=username if username else "匿名用户",
        )

        return CommentResponse(code=200, message="获取成功", data=comment_item)

    except HTTPException as he:
        raise he
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"获取评论失败: {str(e)}")


@router.put(
    "/comments/{comment_id}", response_model=CommentResponse, summary="更新评论"
)
async def update_comment(
    comment_id: int, comment_update: CommentUpdate, db: AsyncSession = Depends(get_db)
):
    """
    更新评论信息

    Args:
        comment_id: 评论ID
        comment_update: 更新的评论信息
        db: 数据库会话

    Returns:
        CommentResponse: 更新后的评论信息
    """
    try:
        # 查询评论，并关联用户表获取用户名
        stmt = (
            select(VigaComment, VigaUsers.username)
            .join(VigaUsers, VigaComment.user_id == VigaUsers.id, isouter=True)
            .where(VigaComment.id == comment_id)
        )

        result = await db.execute(stmt)
        comment_with_user = result.one_or_none()

        if not comment_with_user:
            raise HTTPException(status_code=404, detail="评论不存在")

        db_comment, username = comment_with_user

        # 更新评论字段
        update_data = comment_update.model_dump(exclude_unset=True)
        for field, value in update_data.items():
            setattr(db_comment, field, value)

        await db.commit()
        await db.refresh(db_comment)

        # 构造返回数据
        comment_item = CommentItem(
            id=db_comment.id,
            user_id=db_comment.user_id,
            art_id=db_comment.art_id,
            message=db_comment.message,
            file_url=db_comment.file_url,
            create_time=db_comment.create_time,
            # 真正从用户表获取用户名
            user_name=username if username else "匿名用户",
        )

        return CommentResponse(code=200, message="评论更新成功", data=comment_item)

    except HTTPException as he:
        raise he
    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"更新评论失败: {str(e)}")


@router.delete(
    "/comments/{comment_id}", response_model=CommentResponse, summary="删除评论"
)
async def delete_comment(comment_id: int, db: AsyncSession = Depends(get_db)):
    """
    删除评论

    Args:
        comment_id: 评论ID
        db: 数据库会话

    Returns:
        CommentResponse: 删除结果
    """
    try:
        # 查询评论
        stmt = select(VigaComment).where(VigaComment.id == comment_id)
        result = await db.execute(stmt)
        comment = result.scalar_one_or_none()

        if not comment:
            raise HTTPException(status_code=404, detail="评论不存在")

        # 删除评论
        await db.delete(comment)
        await db.commit()

        return CommentResponse(code=200, message="评论删除成功", data=None)

    except HTTPException as he:
        raise he
    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"删除评论失败: {str(e)}")
