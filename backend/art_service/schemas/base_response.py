from pydantic import BaseModel, Field


# 响应基类
class BaseResponse(BaseModel):
    code: int = Field(default=200)
    message: str = Field(default="Success")
