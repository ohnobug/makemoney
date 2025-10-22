'''
description:  
@author kent 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
import redis
from app.config import settings

redis_client = redis.from_url(settings.REDIS_URL)

def store_verification_code(email: str, code: str):
    redis_client.setex(f"verification:{email}", settings.VERIFICATION_CODE_EXPIRE, code)

def get_verification_code(email: str) -> str:
    return redis_client.get(f"verification:{email}")

def delete_verification_code(email: str):
    redis_client.delete(f"verification:{email}")