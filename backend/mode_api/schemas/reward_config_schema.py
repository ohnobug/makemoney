# mode_api/schemas/reward_config_schema.py

from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel, Field, ConfigDict

from .base_response import BaseResponse


# --- 基础模型 ---
# 这个基类包含了创建和读取时都共有的字段，以遵循 DRY (Don't Repeat Yourself) 原则。
class ArtworkConfigBase(BaseModel):
    """公排配置的基础模型，包含所有核心业务字段。"""
    art_id: int = Field(..., example=1, description="艺术品ID")
    exit_layer: int = Field(..., example=6, description="出局层级")
    multiple: float = Field(
            ..., 
            gt=1,  # gt=1 表示 "greater than 1"
            example=2.0, 
            description="倍数 (必须大于1)"
        )

    reward_rate_1: float = Field(..., example=0.25000, description="升1奖励比例")
    reward_rate_2: float = Field(..., example=0.50000, description="升2奖励比例")
    reward_rate_3: float = Field(..., example=0.10000, description="升3奖励比例")
    reward_rate_4: float = Field(..., example=0.15000, description="升4奖励比例")
    reward_rate_5: float = Field(..., example=0.20000, description="升5奖励比例")
    reward_rate_6: float = Field(..., example=0.25000, description="升6奖励比例")
    reward_rate_7: float = Field(..., example=0.00000, description="升7奖励比例")
    reward_rate_8: float = Field(..., example=0.00000, description="升8奖励比例")
    reward_rate_9: float = Field(..., example=0.00000, description="升9奖励比例")
    reward_rate_10: float = Field(..., example=0.00000, description="升10奖励比例")


# --- 输入模型 (用于 API 请求) ---

class ArtworkConfigCreateIn(ArtworkConfigBase):
    """
    用于创建新配置的请求体模型 (POST /configs)。
    继承自 ArtworkConfigBase，所有字段都是必需的。
    """
    pass

# --- 输出模型 (用于 API 响应) ---
class ArtworkConfigOut(ArtworkConfigBase):
    """
    用于API响应的数据模型，比基础模型多了数据库自动生成的字段。
    """
    id: int
    created_at: datetime
    updated_at: datetime

    # model_config (Pydantic V2) 或 class Config (V1)
    # 允许 Pydantic 模型从 ORM 对象（如 SQLAlchemy 模型实例）中读取数据。
    model_config = ConfigDict(from_attributes=True)


# --- 完整的API响应包装器 ---
class ArtworkConfigResponseOut(BaseResponse):
    """用于获取单个配置的完整API响应结构。"""
    data: Optional[ArtworkConfigOut] = None


class ArtworkConfigListResponseOut(BaseResponse):
    """用于获取配置列表的完整API响应结构。"""
    data: List[ArtworkConfigOut] = Field(default_factory=list)

