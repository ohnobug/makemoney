# tests/test_reward_models.py

from typing import AsyncGenerator
import pytest
from decimal import Decimal
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

# 假设您的 database.py 和 models.py 文件位于 reward_api 目录下
# 请根据您的实际项目结构调整此导入路径
from backend.mode_api.db.database import Base, engine, AsyncSessionLocal
from backend.mode_api.db.database import (
    RewardArtworkConfig,
    RewardLayerSummary,
    RewardEndorsementLog,
    RewardLog
)

# 使用 pytest 的 mark 来确保此文件中的所有测试都以异步方式运行
pytestmark = pytest.mark.asyncio


@pytest.fixture(scope="function")
async def async_session() -> AsyncGenerator[AsyncSession, None]:
    """
    Pytest Fixture: 为每个测试函数提供一个干净的数据库环境。

    - 在每个测试开始前，它会创建所有数据库表。
    - 它提供一个独立的数据库会话 (session) 给测试函数使用。
    - 在每个测试结束后，它会删除所有数据库表，以确保测试之间完全隔离。
    """
    # 建立连接并创建所有在 Base.metadata 中定义的表
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    # 创建一个新的会话并将其提供给测试函数
    async with AsyncSessionLocal() as session:
        yield session

    # 测试函数执行完毕后，清理数据库，删除所有表
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


async def test_create_db_and_tables():
    """
    测试数据库和表的创建功能。
    验证所有与奖励模块相关的表是否都已成功创建。
    """
    async with engine.begin() as conn:
        # 运行同步的 create_all 方法
        await conn.run_sync(Base.metadata.create_all)
        # 获取数据库中所有表的名称
        tables = await conn.run_sync(lambda sync_conn: sync_conn.get_table_names())
    
    # 断言：检查每个预期的表名是否存在于数据库中
    assert "reward_artwork_config" in tables
    assert "reward_layer_summary" in tables
    assert "reward_endorsement_log" in tables
    assert "reward_log" in tables

    # 清理：删除所有表
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


async def test_reward_artwork_config_model(async_session: AsyncSession):
    """
    测试 RewardArtworkConfig 模型的完整功能，包括插入和查询所有字段。
    """
    # 1. 准备测试数据
    config_data = RewardArtworkConfig(
        art_id=1,
        upgrade_after_layer=6,
        exit_layer=6,
        reward_rate_1=Decimal("0.25000"),
        reward_rate_2=Decimal("0.50000"),
        reward_rate_3=Decimal("0.10000"),
        reward_rate_4=Decimal("0.15000"),
        reward_rate_5=Decimal("0.20000"),
        reward_rate_6=Decimal("0.25000"),
        reward_rate_7=Decimal("0.00000"),
        reward_rate_8=Decimal("0.00000"),
        reward_rate_9=Decimal("0.00000"),
        reward_rate_10=Decimal("0.00000"),
        upgrade_multiplier=2
    )
    
    # 2. 插入数据
    async_session.add(config_data)
    await async_session.commit()

    # 3. 查询刚刚插入的数据
    result = await async_session.execute(
        select(RewardArtworkConfig).where(RewardArtworkConfig.art_id == 1)
    )
    fetched_config = result.scalars().first()

    # 4. 断言：验证每个字段的值是否与插入时完全一致
    assert fetched_config is not None
    assert fetched_config.art_id == 1
    assert fetched_config.upgrade_after_layer == 6
    assert fetched_config.exit_layer == 6
    assert fetched_config.reward_rate_1 == Decimal("0.25000")
    assert fetched_config.reward_rate_2 == Decimal("0.50000")
    assert fetched_config.reward_rate_3 == Decimal("0.10000")
    assert fetched_config.reward_rate_4 == Decimal("0.15000")
    assert fetched_config.reward_rate_5 == Decimal("0.20000")
    assert fetched_config.reward_rate_6 == Decimal("0.25000")
    assert fetched_config.reward_rate_7 == Decimal("0.00000")
    assert fetched_config.reward_rate_8 == Decimal("0.00000")
    assert fetched_config.reward_rate_9 == Decimal("0.00000")
    assert fetched_config.reward_rate_10 == Decimal("0.00000")
    assert fetched_config.upgrade_multiplier == 2


async def test_reward_layer_summary_model(async_session: AsyncSession):
    """
    测试 RewardLayerSummary 模型，并验证其与 RewardArtworkConfig 的外键关系。
    """
    # 1. 前置条件：必须先插入一个关联的 RewardArtworkConfig 记录
    config = RewardArtworkConfig(art_id=2, upgrade_after_layer=5, exit_layer=5, upgrade_multiplier=2)
    async_session.add(config)
    await async_session.commit()

    # 2. 准备测试数据
    summary_data = RewardLayerSummary(
        art_id=2,
        relative_layer=1,
        layer_capacity=16,
        actual_user_count=15,
        calculated_user_count=16
    )

    # 3. 插入数据
    async_session.add(summary_data)
    await async_session.commit()

    # 4. 查询数据
    result = await async_session.execute(
        select(RewardLayerSummary).where(RewardLayerSummary.art_id == 2, RewardLayerSummary.layer_capacity == 16)
    )
    fetched_summary = result.scalars().first()

    # 5. 断言
    assert fetched_summary is not None
    assert fetched_summary.art_id == 2
    assert fetched_summary.relative_layer == 1
    assert fetched_summary.layer_capacity == 16
    assert fetched_summary.actual_user_count == 15
    assert fetched_summary.calculated_user_count == 16


async def test_reward_endorsement_log_model(async_session: AsyncSession):
    """
    测试 RewardEndorsementLog 模型的基本插入和查询功能。
    """
    # 1. 准备测试数据
    log_data = RewardEndorsementLog(
        art_id=3,
        user_id=101,
        current_layer_capacity=32,
        transaction_hash="0x123abc456def789"
    )

    # 2. 插入数据
    async_session.add(log_data)
    await async_session.commit()

    # 3. 查询数据
    result = await async_session.execute(
        select(RewardEndorsementLog).where(RewardEndorsementLog.user_id == 101)
    )
    fetched_log = result.scalars().first()

    # 4. 断言
    assert fetched_log is not None
    assert fetched_log.art_id == 3
    assert fetched_log.user_id == 101
    assert fetched_log.current_layer_capacity == 32
    assert fetched_log.transaction_hash == "0x123abc456def789"


async def test_reward_log_model(async_session: AsyncSession):
    """
    测试 RewardLog 模型的基本插入和查询功能。
    """
    # 1. 准备测试数据
    log_data = RewardLog(
        user_id=202,
        upgrade_remark="2->1",
        reward_amount=Decimal("99.87654321")
    )
    
    # 2. 插入数据
    async_session.add(log_data)
    await async_session.commit()

    # 3. 查询数据
    result = await async_session.execute(
        select(RewardLog).where(RewardLog.user_id == 202)
    )
    fetched_log = result.scalars().first()

    # 4. 断言
    assert fetched_log is not None
    assert fetched_log.user_id == 202
    assert fetched_log.upgrade_remark == "2->1"
    assert fetched_log.reward_amount == Decimal("99.87654321")