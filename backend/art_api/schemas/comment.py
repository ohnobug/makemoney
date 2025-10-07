from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from .base_response import BaseResponse

# 评论基础模型
class CommentBase(BaseModel):
    user_id: Optional[int] = None
    art_id: Optional[int] = None
    message: Optional[str] = None
    file_url: Optional[str] = None

# 创建评论请求模型
class CommentCreate(CommentBase):
    user_id: int
    art_id: int
    message: str

# 更新评论请求模型
class CommentUpdate(BaseModel):
    message: Optional[str] = None
    file_url: Optional[str] = None

# 评论数据库基础模型
class CommentInDBBase(CommentBase):
    id: int
    create_time: datetime

    class Config:
        orm_mode = True

# 评论项模型（用于列表展示）- 新增用户名称字段
class CommentItem(CommentInDBBase):
    user_name: Optional[str] = None  # 新增用户名称字段

# 单个评论响应模型
class CommentResponse(BaseResponse):
    data: Optional[CommentItem] = None

# 评论列表响应模型 - 支持分页
class CommentListResponse(BaseResponse):
    data: Optional[List[CommentItem]] = None
    total: Optional[int] = None
    page: Optional[int] = None
    page_size: Optional[int] = None