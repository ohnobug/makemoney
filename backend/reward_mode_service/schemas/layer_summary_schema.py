# mode_api/schemas/layer_summary_schema.py

from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field, ConfigDict

from .reward_config_schema import ArtworkConfigOut
from .base_response import BaseResponse

class LayerSummaryOut(BaseModel):
    """用于API响应的层级概况数据模型。"""
    id: int
    art_id: int
    relative_layer: int
    layer_capacity: int = Field(..., description="绝对层数 (即层级容量)")
    actual_user_count: int
    calculated_user_count: int
    updated_at: datetime

    model_config = ConfigDict(from_attributes=True)

class LayerSummaryResponseOut(BaseResponse):
    """用于获取单个层级概况的完整API响应结构。"""
    data: Optional[LayerSummaryOut] = None


