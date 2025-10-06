
import redis.asyncio as redis
import os
import asyncio
from typing import Optional

# --- 1. 初始化 Redis 连接 ---

# 从环境变量获取 Redis 配置，如果获取不到则使用默认值
# 这与您 docker-compose.yml 中的配置相对应
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))

# 创建一个异步 Redis 连接池
# decode_responses=True 会将从 Redis 获取的二进制数据自动解码为 utf-8 字符串，方便处理
redis_pool = redis.ConnectionPool(host=REDIS_HOST, port=REDIS_PORT, db=0, decode_responses=True)

def get_redis_connection() -> redis.Redis:
    """
    从连接池获取一个 Redis 连接实例。
    在您的应用中，可以像 get_db 一样通过依赖注入来使用它。
    """
    return redis.Redis(connection_pool=redis_pool)

# --- 2. 封装增删改查函数 ---

async def set_data(redis_conn: redis.Redis, key: str, value: str, expire_seconds: Optional[int] = None):
    """
    向 Redis 中设置一个键值对 (新增或修改)。

    :param redis_conn: Redis 连接实例
    :param key: 键
    :param value: 值
    :param expire_seconds: (可选) 过期时间（秒）
    """
    print(f"Setting data: key='{key}', value='{value}'")
    await redis_conn.set(key, value, ex=expire_seconds)
    print("Set complete.")

async def get_data(redis_conn: redis.Redis, key: str) -> Optional[str]:
    """
    从 Redis 中获取一个键的值 (查询)。

    :param redis_conn: Redis 连接实例
    :param key: 键
    :return: 键对应的值，如果键不存在则返回 None
    """
    print(f"Getting data for key: '{key}'")
    value = await redis_conn.get(key)
    print(f"Retrieved value: '{value}'")
    return value

async def delete_data(redis_conn: redis.Redis, key: str) -> int:
    """
    从 Redis 中删除一个键 (删除)。

    :param redis_conn: Redis 连接实例
    :param key: 要删除的键
    :return: 成功删除的键的数量 (通常是 1 或 0)
    """
    print(f"Deleting data for key: '{key}'")
    num_deleted = await redis_conn.delete(key)
    print(f"Number of keys deleted: {num_deleted}")
    return num_deleted