from sqlalchemy import Column, Integer, DateTime, func
from db.database import Base
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# SQLAlchemy 模型
class VigaLike(Base):
    __tablename__ = "viga_like"
    __table_args__ = {'comment': '点赞表'}

    id = Column(Integer, primary_key=True, autoincrement=True, comment='Primary Key')
    create_time = Column(DateTime, server_default=func.now(), comment='Create Time')
    author_id = Column(Integer, nullable=False, comment='作者id')
    user_id = Column(Integer, nullable=True, comment='点赞者id')
    art_id = Column(Integer, nullable=True, comment='作品id')

    def __repr__(self):
        return f"<VigaLike(id={self.id}, author_id={self.author_id}, user_id={self.user_id}, art_id={self.art_id})>"

# Pydantic 模型
class LikeBase(BaseModel):
    author_id: int
    user_id: Optional[int] = None
    art_id: Optional[int] = None

class LikeCreate(LikeBase):
    pass

class LikeUpdate(LikeBase):
    pass

class LikeInDBBase(LikeBase):
    id: int
    create_time: datetime

    class Config:
        orm_mode = True

class Like(LikeInDBBase):
    pass

class LikeInDB(LikeInDBBase):
    pass