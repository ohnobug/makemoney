import random
from aiosmtplib import SMTP
# from app.config import settings
import os
from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession
from redis.asyncio import Redis
from config import REDIS_URL,SMTP_SERVER,SMTP_PORT,SMTP_USERNAME,SMTP_PASSWORD
from email.message import EmailMessage
from db.redis import get_redis
from fastapi import HTTPException, status

redis = Redis.from_url(REDIS_URL)

async def send_verification_email(email: str, code: str):

   # 创建邮件对象
    message = EmailMessage()
    message["From"] =SMTP_USERNAME 
    message["To"] = email
    message["Subject"] = "验证码通知"
    
    # 设置UTF-8编码的内容
    message.set_content(f"您的验证码是：{code}", charset="utf-8")
    print("邮箱配置：",SMTP_SERVER,SMTP_PORT,SMTP_USERNAME,SMTP_PASSWORD)
    
    async with SMTP(
        hostname = SMTP_SERVER,
        port = SMTP_PORT,
        username = SMTP_USERNAME,
        password = SMTP_PASSWORD,
        validate_certs=False,
        use_tls = True,
    ) as smtp:
        print('sendmail:',message)
        # await smtp.sendmail(
        #     sender=SMTP_USERNAME,
        #     recipients=[email],
        #     message=message)  # 简单格式message)
        await smtp.send_message(message)

def generate_verification_code() -> str:
    return str(random.randint(100000, 999999))


# async def verify_email_flow(
#     email: str,
#     db: AsyncSession = Depends(get_db)
# ):


async def check_verify_code_email (email,code,redis_):

    async with redis_ as redis:  # 获取 Redis 客户端
        # await redis.setex(f"verify:{email}", 300, code)
      redis_code = await redis.get(f"verify:{email}")
      
      if not redis_code:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="验证码已过期或不存在"
        )
      
      if isinstance(redis_code, bytes):
        redis_code = redis_code.decode("utf-8")
      print("redis_code:",f"verify:{email}:",redis_code,code,str(code).strip() == str(redis_code).strip())

      if str(code).strip() == str(redis_code).strip():
        # return True
         print("验证码正确")
      else:
          raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="验证码错误"
          )
      

