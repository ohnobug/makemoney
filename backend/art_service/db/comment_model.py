from sqlalchemy import Column, Integer, String, Text, DateTime, func
from db.database import Base
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# SQLAlchemy ORM 模型
class VigaComment(Base):
    __tablename__ = "viga_comment"
    __table_args__ = {'comment': '评论表'}

    id = Column(Integer, primary_key=True, autoincrement=True, comment='Primary Key')
    create_time = Column(DateTime, server_default=func.now(), comment='Create Time')
    user_id = Column(Integer, nullable=True, comment='评论者id')
    art_id = Column(Integer, nullable=True, comment='作品id')
    message = Column(String(255), nullable=True, comment='评论信息')
    file_url = Column(Text, nullable=True, comment='多个逗号隔开')

    def __repr__(self):
        return f"<VigaComment(id={self.id}, user_id={self.user_id}, art_id={self.art_id})>"