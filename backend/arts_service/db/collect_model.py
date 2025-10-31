from sqlalchemy import Column, Integer, DateTime, func
from db.database import Base
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# SQLAlchemy 模型
class VigaCollect(Base):
    __tablename__ = "viga_collect"
    __table_args__ = {'comment': '收藏表'}

    id = Column(Integer, primary_key=True, autoincrement=True, comment='Primary Key')
    create_time = Column(DateTime, server_default=func.now(), comment='Create Time')
    user_id = Column(Integer, nullable=True, comment='收藏者id')
    art_id = Column(Integer, nullable=True, comment='作品id')
    author_id = Column(Integer, nullable=True, comment='作者id')

    def __repr__(self):
        return f"<VigaCollect(id={self.id}, user_id={self.user_id}, art_id={self.art_id}, author_id={self.author_id})>"


# Pydantic 模型
class CollectBase(BaseModel):
    user_id: Optional[int] = None
    art_id: Optional[int] = None
    author_id: Optional[int] = None


class CollectCreate(CollectBase):
    pass


class CollectUpdate(CollectBase):
    pass


class CollectInDBBase(CollectBase):
    id: int
    create_time: datetime

    class Config:
        orm_mode = True


class Collect(CollectInDBBase):
    pass


class CollectInDB(CollectInDBBase):
    pass