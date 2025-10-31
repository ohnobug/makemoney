from sqlalchemy import Column, Integer, String, DateTime, func, Text
from db.database import Base
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# SQLAlchemy 模型 - 视频标签表
class VideoTag(Base):
    __tablename__ = "video_tag"
    __table_args__ = {'comment': '视频标签表'}

    id = Column(Integer, primary_key=True, autoincrement=True, comment='主键ID')
    name = Column(String(50), nullable=False, unique=True, comment='标签名称', index=True)
    description = Column(Text, nullable=True, comment='标签描述')
    cover_image_url = Column(String(255), nullable=True, comment='标签封面图片URL')
    use_count = Column(Integer, nullable=False, default=0, comment='使用次数')
    is_hot = Column(Integer, nullable=False, default=0, comment='是否热门标签：0-否，1-是')
    status = Column(Integer, nullable=False, default=1, comment='状态：1-启用，0-禁用')
    create_time = Column(DateTime, server_default=func.now(), comment='创建时间')
    update_time = Column(DateTime, server_default=func.now(), onupdate=func.now(), comment='更新时间')

    def __repr__(self):
        return f"<VideoTag(id={self.id}, name='{self.name}', use_count={self.use_count})>"
