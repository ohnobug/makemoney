from sqlalchemy import Column, Integer, String, DateTime, func
from db.database import Base
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# SQLAlchemy 模型
class VigaArtTemp(Base):
    __tablename__ = "viga_art_temp"
    __table_args__ = {'comment': '作品审核表'}

    id = Column(Integer, primary_key=True, autoincrement=True, comment='Primary Key')
    create_time = Column(DateTime, server_default=func.now(), comment='Create Time')
    name = Column(String(255), nullable=True, comment='作品名称', index=True)
    update_time = Column(DateTime, server_default=func.now(), onupdate=func.now(), comment='更新时间')
    status = Column(Integer, default=0, comment='审核状态 0 待审核，1 审核成功，2审核失败')
    url = Column(String(255), nullable=True, comment='资源url')
    user_id = Column(Integer, nullable=True)
    review_msg = Column(String(255), nullable=True, comment='审核信息')

# Pydantic 模型
class ArtTempBase(BaseModel):
    name: Optional[str] = None
    url: Optional[str] = None
    user_id: Optional[int] = None
    review_msg: Optional[str] = None

class ArtTempCreate(ArtTempBase):
    pass

class ArtTempUpdate(ArtTempBase):
    status: Optional[int] = None
    review_msg: Optional[str] = None

class ArtTempInDBBase(ArtTempBase):
    id: int
    create_time: datetime
    update_time: datetime
    status: int

    class Config:
        orm_mode = True

class ArtTemp(ArtTempInDBBase):
    pass

class ArtTempInDB(ArtTempInDBBase):
    pass