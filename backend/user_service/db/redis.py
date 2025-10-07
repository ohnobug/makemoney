'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
from redis.asyncio import Redis
from config import REDIS_URL
from contextlib import asynccontextmanager



@asynccontextmanager
async def get_redis():
    redis = Redis.from_url(REDIS_URL)
    try:
        yield redis  # 返回 Redis 客户端
    finally:
        await redis.close()  # 使用完毕后关闭连接