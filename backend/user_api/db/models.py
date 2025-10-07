
from sqlalchemy import TIMESTAMP, Boolean, Column, Integer, String, func
from db.database import Base


class VigaUsers(Base):
    __tablename__ = "viga_users"
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, index=True, nullable=False)
    email = Column(String(100), unique=True, index=True, nullable=False)
    phone_number = Column(String(20), unique=True, index=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    email =  Column(String(255), nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.now())

class VigaVerifyCodes(Base):
    __tablename__ = "viga_verify_codes"
    id = Column(Integer, primary_key=True, index=True)
    phone_number = Column(String(20), nullable=False, index=True)
    code = Column(String(10), nullable=False)
    purpose = Column(String(50), nullable=False)
    is_used = Column(Boolean, default=False)
    used_at = Column(TIMESTAMP, nullable=True)
    created_at = Column(TIMESTAMP, server_default=func.now())
