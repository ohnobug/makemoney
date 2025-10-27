from typing import List, Optional
from pydantic import BaseModel, Field, ConfigDict

from .base_response import BaseResponse
from .layer_summary_schema import LayerSummaryOut
from .reward_config_schema import ArtworkConfigOut

class LatestSummaryWithConfigOut(BaseModel):
    """
    一个组合模型，用于同时返回最新的层级概况和其关联的艺术品配置。
    """
    config: ArtworkConfigOut
    summary: List[LayerSummaryOut]

    model_config = ConfigDict(from_attributes=True)

class LatestSummaryWithConfigIn(BaseModel):
    art_id: int


class LatestSummaryWithConfigResponseOut(BaseResponse):
    """用于获取最新层级概况及其配置的完整API响应结构。"""
    data: Optional[LatestSummaryWithConfigOut] = None
