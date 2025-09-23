import pytest
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from .database import Base, engine, AsyncSessionLocal, create_db_and_tables, VigaUsers, TurChatSessions, TurChatHistory, VigaVerifyCodes

@pytest.fixture
def async_session():
    """
    创建一个异步数据库会话的fixture。
    """
    return AsyncSessionLocal()

@pytest.mark.asyncio
async def test_create_db_and_tables():
    """
    测试 create_db_and_tables 函数是否能够正确创建数据库表。
    """
    await create_db_and_tables()
    async with engine.connect() as conn:
        tables = await conn.run_sync(lambda sync_conn: sync_conn.get_table_names())
    assert "tur_users" in tables
    assert "tur_chat_sessions" in tables
    assert "tur_chat_history" in tables
    assert "tur_verify_codes" in tables

@pytest.mark.asyncio
async def test_get_db(async_session):
    """
    测试 get_db 函数是否能够正确返回一个异步数据库会话。
    """
    async with async_session() as db:
        assert isinstance(db, AsyncSession)

@pytest.mark.asyncio
async def test_tur_users_model(async_session):
    """
    测试 VigaUsers 模型的基本功能，包括插入和查询数据。
    """
    user = VigaUsers(
        phone_number="1234567890",
        password_hash="hashed_password"
    )
    async with async_session() as db:
        db.add(user)
        await db.commit()
        result = await db.execute(select(VigaUsers).where(VigaUsers.phone_number == "1234567890"))
        fetched_user = result.scalars().first()
        assert fetched_user.phone_number == "1234567890"
        assert fetched_user.password_hash == "hashed_password"

@pytest.mark.asyncio
async def test_tur_chat_sessions_model(async_session):
    """
    测试 TurChatSessions 模型的基本功能，包括插入和查询数据。
    """
    session = TurChatSessions(
        user_id=1,
        title="Test Session"
    )
    async with async_session() as db:
        db.add(session)
        await db.commit()
        result = await db.execute(select(TurChatSessions).where(TurChatSessions.title == "Test Session"))
        fetched_session = result.scalars().first()
        assert fetched_session.user_id == 1
        assert fetched_session.title == "Test Session"

@pytest.mark.asyncio
async def test_tur_chat_history_model(async_session):
    """
    测试 TurChatHistory 模型的基本功能，包括插入和查询数据。
    """
    history = TurChatHistory(
        user_id=1,
        chat_session_id=1,
        sender="user",
        text="Hello, world!"
    )
    async with async_session() as db:
        db.add(history)
        await db.commit()
        result = await db.execute(select(TurChatHistory).where(TurChatHistory.text == "Hello, world!"))
        fetched_history = result.scalars().first()
        assert fetched_history.user_id == 1
        assert fetched_history.chat_session_id == 1
        assert fetched_history.sender == "user"
        assert fetched_history.text == "Hello, world!"

@pytest.mark.asyncio
async def test_tur_verify_codes_model(async_session):
    """
    测试 VigaVerifyCodes 模型的基本功能，包括插入和查询数据。
    """
    code = VigaVerifyCodes(
        phone_number="1234567890",
        code="123456",
        purpose="verification"
    )
    async with async_session() as db:
        db.add(code)
        await db.commit()
        result = await db.execute(select(VigaVerifyCodes).where(VigaVerifyCodes.phone_number == "1234567890"))
        fetched_code = result.scalars().first()
        assert fetched_code.phone_number == "1234567890"
        assert fetched_code.code == "123456"
        assert fetched_code.purpose == "verification"
        assert fetched_code.is_used is False
