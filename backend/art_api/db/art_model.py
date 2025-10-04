from sqlalchemy import Column, Integer, String, DateTime, func
from db.database import Base
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# SQLAlchemy 模型
class VigaArt(Base):
    __tablename__ = "viga_art"
    __table_args__ = {'comment': '作品表'}

    id = Column(Integer, primary_key=True, autoincrement=True, comment='Primary Key')
    name = Column(String(255), nullable=True, comment='作品名称')
    url = Column(String(255), nullable=True, comment = '原资源url')
    user_id = Column(Integer, nullable=True)
    ipfs_url = Column(String(255), nullable=True, comment='作品链接')
    tag = Column(String(255), nullable=True, comment='标签,多个表')
    sort = Column(Integer, nullable=True, server_default='0', comment='排序，越大越靠前')
    status = Column(Integer, nullable=True, server_default='1', comment='状态，1正常，0禁用')
    create_time = Column(DateTime, server_default=func.now(), comment='Create Time')
    update_time = Column(DateTime, server_default=func.now(), onupdate=func.now(), comment='更新时间')

    def __repr__(self):
        return f"<VigaArt(id={self.id}, name='{self.name}', user_id={self.user_id})>"

# Pydantic 模型
class ArtBase(BaseModel):
    name: Optional[str] = None
    url: Optional[str] = None
    user_id: Optional[int] = None
    ipfs_url: Optional[str] = None
    tag: Optional[str] = None
    sort: Optional[int] = None
    status: Optional[int] = None

class ArtCreate(ArtBase):
    name: str
    url: str
    user_id: int

class ArtUpdate(ArtBase):
    pass

class ArtInDBBase(ArtBase):
    id: int
    create_time: datetime
    update_time: datetime

    class Config:
        orm_mode = True

class ArtItem(BaseModel):
    id: int
    ipfs_url: Optional[str] = None
    tag: Optional[str] = None
    name: Optional[str] = None
    user_id: Optional[int] = None
    class Config:
        orm_mode = True

class ArtInDB(ArtInDBBase):
    pass