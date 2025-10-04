from sqlalchemy import Column, Integer, String, TIMESTAMP, Boolean, func, MetaData
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from config import DATABASE_URL

engine: AsyncEngine = create_async_engine(
    DATABASE_URL,
    echo=True,
    future=True,
    pool_size=70,
    pool_recycle=1800,
    max_overflow=100
)

AsyncSessionLocal: sessionmaker = sessionmaker(
    engine,
    class_=AsyncSession,
    expire_on_commit=False
)

async def get_db():
    async with AsyncSessionLocal() as db:
        try:
            yield db
        except Exception:
            await db.rollback()
            raise
        finally:
            await db.close()

metadata = MetaData()
Base = declarative_base(metadata=metadata)

async def create_db_and_tables():
    """
    异步地连接到数据库并创建所有表。
    """
    async with engine.begin() as conn:
        # a. 使用 await conn.run_sync() 来运行同步的 create_all 方法
        #    这是 SQLAlchemy 提供的、在异步环境中运行同步代码的正确方式。
        await conn.run_sync(Base.metadata.create_all)
    print("Database tables created successfully.")

