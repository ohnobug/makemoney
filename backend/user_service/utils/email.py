import random
from aiosmtplib import SMTP
from app.config import settings

async def send_verification_email(email: str, code: str):
    message = f"""\
Subject: 您的验证码
To: {email}
From: {settings.EMAIL_FROM}

您的验证码是: {code}
该验证码将在5分钟后失效。
"""
    
    async with SMTP(
        hostname=settings.SMTP_SERVER,
        port=settings.SMTP_PORT,
        username=settings.SMTP_USERNAME,
        password=settings.SMTP_PASSWORD,
        use_tls=True,
    ) as smtp:
        await smtp.send_message(message)

def generate_verification_code() -> str:
    return str(random.randint(100000, 999999))