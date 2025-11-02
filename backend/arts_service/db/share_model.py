from sqlalchemy import Column, Integer, DateTime, func
from db.database import Base

# SQLAlchemy ORM 模型
class VigaShare(Base):
    __tablename__ = "viga_share"
    __table_args__ = {'comment': '分享表'} 

    id = Column(Integer, primary_key=True, autoincrement=True, comment='Primary Key')
    create_time = Column(DateTime, server_default=func.now(), comment='Create Time')
    user_id = Column(Integer, nullable=True, comment='分享id')
    art_id = Column(Integer, nullable=True, comment='作品id')
    author_id = Column(Integer, nullable=True, comment='作者id')

    def __repr__(self):
        return f"<VigaShare(id={self.id}, user_id={self.user_id}, art_id={self.art_id}, author_id={self.author_id})>"