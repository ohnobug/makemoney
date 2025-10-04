import hashlib
# 导入 JWT 和时间处理所需模块
from datetime import datetime, timedelta, timezone

from passlib.context import CryptContext
from jose import JWTError, jwt
from fastapi import HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy import select, update

# 从您的配置中导入 JWT 相关设置
from jiaoyisuo.backend.art_api.schemas.art_list import UserGetVerifyCodePurposeEnum
from config import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES

import db as database
from db.art_model import VigaUsers, VigaVerifyCodes
import random
from fastapi import HTTPException

# Passlib 上下文，用于安全的密码哈希（推荐使用）
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# OAuth2 配置，用于 FastAPI 的自动文档和依赖注入
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    """
    依赖函数：从请求头中的 Bearer Token 解码并验证用户信息。
    如果验证失败，则抛出 401 Unauthorized 异常。
    """
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        # 解码 JWT
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        # 从 payload 中获取用户 ID (标准做法是存在 'sub' 字段)
        user_id: str = payload.get("sub")
        if user_id is None:
            raise credentials_exception
    except JWTError:
        # 如果解码失败（例如签名不匹配、过期等），抛出异常
        raise credentials_exception
    
    # 从数据库中查找用户
    query = select(VigaUsers).where(VigaUsers.id == int(user_id))
    user = await database.fetch_one(query)
    if user is None:
        raise credentials_exception
    return user


def create_access_token(data: dict, expires_delta: timedelta | None = None):
    """
    辅助函数：创建一个包含过期时间的 JWT Access Token。
    """
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        # 如果未提供过期时间，则使用默认值
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    
    # 将过期时间 'exp' 添加到 payload 中
    to_encode.update({"exp": expire})
    # 使用密钥和算法对 payload进行编码（签名）
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def get_token(userInfo: VigaUsers):
    """
    为指定用户生成一个 JWT Token。
    """
    # 设置 Token 的过期时间
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    # 创建 Token，将用户 ID 作为 'sub' (subject) 传入
    access_token = create_access_token(
        data={
            "user_id": str(userInfo.id), 
            "phone_number": str(userInfo.phone_number)
        },
        expires_delta=access_token_expires
    )
    return access_token


def get_userInfo_from_token(token: str):
    """
    从 JWT Token 字符串中解码出 payload。
    主要用于不需要强制验证（即不抛出 HTTP 异常）的场景。
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        # 如果解码失败，可以选择返回 None 或抛出自定义异常
        return None


def password_hash(password: str):
    """
    【注意】这是一个简单的 SHA256 哈希，不带盐。
    为了更高的安全性，强烈建议使用 pwd_context.hash(password) 来代替。
    """
    m = hashlib.sha256()
    m.update(password.encode('utf-8'))
    return m.hexdigest()


def generate_numeric_code_randint():
    """
    生成一个6位的纯数字验证码。
    """
    # 生成一个介于 100000 和 999999 之间的随机整数
    code = random.randint(100000, 999999)
    return code


def p(stri: str):
    """
    调试打印专用函数。
    """
    print("\n" * 2)
    print("❤️" * 30)
    print(stri)
    print("❤️" * 30)
    print("\n" * 2)


async def check_verify_code(db, phone_number: str, code: str, purpose: UserGetVerifyCodePurposeEnum):
    """
    检查手机验证码是否正确、有效且未被使用。
    """
    # 从数据库中查找匹配的、未使用的验证码
    select_stmt = select(
        VigaVerifyCodes
    ).where(
        VigaVerifyCodes.phone_number == phone_number,
        VigaVerifyCodes.purpose == purpose,
        VigaVerifyCodes.is_used == False,
        VigaVerifyCodes.code == code
    ).order_by(
        VigaVerifyCodes.id.desc()
    ).limit(1)
    lastVerifyCode = (await db.execute(select_stmt)).scalar_one_or_none()

    if lastVerifyCode is None:
        raise HTTPException(status_code=429, detail="验证码错误或无效")

    # 检查验证码是否在十分钟有效期内
    if lastVerifyCode.created_at < datetime.now() - timedelta(minutes=10):
        raise HTTPException(status_code=429, detail="验证码已过期")

    # 将验证码标记为已使用
    update_stmt = update(VigaVerifyCodes).where(
        VigaVerifyCodes.id == lastVerifyCode.id
    ).values(
        used_at=datetime.now(),
        is_used=True
    )

    await db.execute(update_stmt)
    await db.commit()