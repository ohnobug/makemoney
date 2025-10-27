from pydantic import BaseModel, Optional,datetime
from .base_response import BaseResponse
from typing import List
from db.tag_model import VideoTag

# Pydantic 模型
class TagBase(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    cover_image_url: Optional[str] = None
    use_count: Optional[int] = None
    is_hot: Optional[int] = None
    status: Optional[int] = None

class TagCreate(TagBase):
    name: str

class TagUpdate(TagBase):
    pass

class TagInDBBase(TagBase):
    id: int
    create_time: datetime
    update_time: datetime

    class Config:
        orm_mode = True

class TagItem(BaseModel):
    id: int
    name: str
    description: Optional[str] = None
    cover_image_url: Optional[str] = None
    use_count: int
    is_hot: int
    status: int

    class Config:
        orm_mode = True

class TagInDB(TagInDBBase):
    pass