from pydantic import BaseModel, Field
from typing import Optional

from schemas.base_response import BaseResponse


class ArtCreateRequest(BaseModel):
    """创建艺术作品请求"""

    name: str = Field(..., description="作品名称", min_length=1, max_length=255)
    url: str = Field(..., description="原资源URL", min_length=1, max_length=255)
    ipfs_url: Optional[str] = Field(None, description="IPFS链接", max_length=255)
    tag: Optional[str] = Field(
        None, description="标签，多个标签用逗号分隔", max_length=255
    )


class ArtCreateData(BaseModel):
    """创建艺术作品返回数据"""

    id: int = Field(..., description="作品ID")
    name: str = Field(..., description="作品名称")
    url: str = Field(..., description="原资源URL")
    user_id: int = Field(..., description="用户ID")
    ipfs_url: Optional[str] = Field(None, description="IPFS链接")
    tag: Optional[str] = Field(None, description="标签")
    create_time: str = Field(..., description="创建时间")


class ArtCreateResponse(BaseResponse):
    data: ArtCreateData


# 待审核艺术作品相关模型
class ArtTempCreateRequest(BaseModel):
    """创建待审核艺术作品请求"""

    name: str = Field(..., description="作品名称", min_length=1, max_length=255)
    url: str = Field(..., description="原资源URL", min_length=1, max_length=255)


class ArtTempCreateData(BaseModel):
    """创建待审核艺术作品返回数据"""

    id: int = Field(..., description="作品ID")
    name: str = Field(..., description="作品名称")
    url: str = Field(..., description="原资源URL")
    user_id: int = Field(..., description="用户ID")
    status: int = Field(..., description="审核状态 0 待审核，1 审核成功，2审核失败")
    create_time: str = Field(..., description="创建时间")


class ArtTempCreateResponse(BaseResponse):
    data: ArtTempCreateData
