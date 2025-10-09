# reward_api/database.py

from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base
from config import DATABASE_URL  # 从您的配置文件中导入数据库连接字符串

print("Initializing database engine...")

# 1. 创建异步数据库引擎
#    - echo=True: 打印执行的SQL语句，便于调试，生产环境建议设为 False。
#    - future=True: 启用 SQLAlchemy 2.0 风格的API。
#    - pool_recycle: 连接池回收时间（秒），防止因数据库超时而断开连接。
engine: AsyncEngine = create_async_engine(
    DATABASE_URL,
    echo=False, # 在生产中建议关闭
    future=True,
    pool_size=20, # 根据您的预期并发量调整
    max_overflow=50,
    pool_recycle=1800
)

# 2. 创建异步数据库会话工厂
#    这个工厂函数将用于创建新的数据库会话。
AsyncSessionLocal: sessionmaker = sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False  # 防止在提交后 ORM 对象过期
)

# 3. 创建所有ORM模型的基类
#    我们所有的模型类都将继承自这个 Base。
Base = declarative_base()


# 4. 依赖注入函数，为API路由提供数据库会话
async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """
    一个异步生成器，用于为 FastAPI 依赖注入系统提供数据库会话。
    它能确保每个请求都使用独立的会话，并在请求结束后自动关闭。
    """
    async with AsyncSessionLocal() as db:
        try:
            yield db
            await db.commit() # 如果路由中没有异常，则提交事务
        except Exception:
            await db.rollback() # 如果发生异常，则回滚
            raise
        finally:
            await db.close()


# 5. (可选) 一个用于初始化数据库表的工具函数
#    通常只在项目启动时或测试前运行一次。
async def create_db_and_tables():
    """
    异步地连接到数据库并创建所有继承自 Base 的表。
    """
    async with engine.begin() as conn:
        print("Creating database tables...")
        await conn.run_sync(Base.metadata.create_all)
    print("Database tables created successfully.")