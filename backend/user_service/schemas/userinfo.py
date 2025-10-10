import datetime
from .base_response import BaseResponse
from pydantic import BaseModel, Field,ConfigDict,field_serializer

class UserInfoRequestIn(BaseModel):
    pass

class UserInfo(BaseModel):
    phone_number: str = Field(...)
    username: str = Field(...)
    avatar_url: str = Field(...)
    create_time: datetime.datetime = Field(...)
    update_time: datetime.datetime = Field(...)
    id: int = Field(...)

    model_config = ConfigDict(
        from_attributes=True,  # ✅ 替代 orm_mode
        json_encoders={
            datetime.datetime: lambda v: v.isoformat()  # 全局时间序列化
        }
    )
    
    # 可选：单独字段序列化
    # @field_serializer('create_time', 'update_time')
    # def serialize_dates(self, value: datetime.datetime) -> str:
    #     return value.isoformat()

class UserInfoRequestOut(BaseResponse):
    data: UserInfo = Field(..., description="用户数据")
