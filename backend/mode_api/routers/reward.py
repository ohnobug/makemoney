# mode_api/routers/reward.py

import math
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from schemas import reward_config_schema, latest_summary_with_config_out_schema
from db import models
from db.database import get_db
from sqlalchemy.orm import selectinload

router = APIRouter(
    prefix="/api/reward",
    tags=["Reward System - Artwork Configs"]
)

@router.post(
    "/configs", 
    response_model=reward_config_schema.ArtworkConfigResponseOut, 
    status_code=status.HTTP_201_CREATED,
    summary="创建公排配置并初始化层级"
)
async def create_artwork_config_with_layers(
    config_in: reward_config_schema.ArtworkConfigCreateIn,
    db: AsyncSession = Depends(get_db)
):
    """
    创建一个新的艺术品公排配置，并为其自动生成初始的30个层级概况记录。

    - **原子操作**: 配置的创建和30个层级记录的创建将在一个数据库事务中完成。
      如果任何一步失败，所有操作都将回滚。
    - **幂等性检查**: 如果传入的 `art_id` 已经存在，将返回 `409 Conflict` 错误。
    """
    # 检查 art_id 是否已存在
    query = select(models.RewardArtRewardConfig).where(models.RewardArtRewardConfig.art_id == config_in.art_id)
    result = await db.execute(query)
    existing_config = result.scalars().first()

    if existing_config:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Artwork config with art_id '{config_in.art_id}' already exists."
        )

    # 创建新的配置对象
    new_config = models.RewardArtRewardConfig(**config_in.model_dump())
    db.add(new_config)

    # 批量创建30条关联的层级记录
    print(f"Creating 30 initial layer summaries for art_id={config_in.art_id}...")
    layers_to_create = []
    i = 1
    maximum_capacity = 20000000000
    while True:
        if i <= config_in.exit_layer:
            relative_layer = i
        else:
            relative_layer = 0

        # 每个作品最多两百亿容量
        current_capacity = config_in.multiple**(i-1)
        if current_capacity > maximum_capacity:
            break

        layer = models.RewardLayerSummary(
            art_id=config_in.art_id,
            relative_layer=relative_layer,
            layer_capacity=math.floor(current_capacity),
            actual_user_count=0,
            calculated_user_count=current_capacity
        )
        layers_to_create.append(layer)
        i = i + 1

    db.add_all(layers_to_create)

    # 刷新以获取数据库自动生成的 id 和 created_at 等字段
    await db.flush()
    await db.refresh(new_config)

    return reward_config_schema.ArtworkConfigResponseOut(data=new_config)


@router.post(
    "/summaries/latest",
    response_model=latest_summary_with_config_out_schema.LatestSummaryWithConfigResponseOut,
    summary="查询指定艺术品的最新层级概况"
)
async def get_latest_layer_summary(
    config_in: latest_summary_with_config_out_schema.LatestSummaryWithConfigIn,
    db: AsyncSession = Depends(get_db)
):
    """
    根据艺术品ID (`art_id`)，查询其相对层级 (`relative_layer`) 最大的那一条概况记录。

    这等同于执行以下 SQL 查询:
    ```sql
    SELECT * FROM reward_layer_summary 
    WHERE art_id = :art_id 
    ORDER BY relative_layer DESC 
    LIMIT 1;
    ```
    如果找不到对应 `art_id` 的记录，将返回 404 Not Found 错误。
    """

    # 构建 SQLAlchemy 查询语句
    query = select(models.RewardLayerSummary) \
        .where(models.RewardLayerSummary.art_id == config_in.art_id)

    result = await db.execute(query)
    latest_summary = result.scalars()

    if not latest_summary:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"No layer summary found for art_id '{config_in.art_id}'."
        )

    query = select(models.RewardArtRewardConfig) \
        .where(models.RewardArtRewardConfig.art_id == config_in.art_id)

    result = await db.execute(query)
    art_reward_config = result.scalars().first()

    if not art_reward_config:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"No art reward config found for art_id '{config_in.art_id}'."
        )

    # 构建并返回新的响应数据结构
    response_data = latest_summary_with_config_out_schema.LatestSummaryWithConfigOut(
        config=art_reward_config,
        summary=latest_summary
    )

    return latest_summary_with_config_out_schema.LatestSummaryWithConfigResponseOut(data=response_data)
