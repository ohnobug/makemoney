# schemas/base_response.py
from pydantic import BaseModel, Field, ConfigDict
from typing import TypeVar, Generic, Optional

T = TypeVar('T')

class BaseResponse(BaseModel, Generic[T]):
    """
    标准API响应模型
    """
    code: int = Field(200, description="业务状态码, 200 表示成功")
    message: str = Field("success", description="响应消息")
    
    data: Optional[T] = Field(None, description="响应数据")

    model_config = ConfigDict(from_attributes=True)