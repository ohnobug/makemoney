import datetime
from .base_response import BaseResponse
from pydantic import BaseModel, Field,ConfigDict,field_serializer,field_validator
from typing import List,Optional
class UserInfoRequestIn(BaseModel):
    pass

class UserInfo(BaseModel):
    phone_number: Optional[str] = None
    username: Optional[str] = None  # 允许为None
    avatar_url: Optional[str] = None  # 允许为None
    created_at: datetime.datetime = Field(...)
    email:Optional[str] = None 
    id: int = Field(...)
    # phone_number: str = Field(...)
    # username: str = Field(...)
    # avatar_url: str = Field(...)

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


class UserInfoListRequestIn(BaseModel):
    ids:List[int] = Field(..., description="用户ID列表", examples=[])

    @field_validator('ids')  # 装饰器：指定要验证的字段名
    def validate_ids(cls, v):  # cls: 类本身, v: 字段的值
        if not v:
            raise ValueError("用户ID列表不能为空")  # 验证1：不能为空
        if len(v) > 100:
            raise ValueError("单次查询最多支持100个用户")  # 验证2：长度限制
        return v  # 返回验证后的值


class UserInfoListRequestOut(BaseResponse):
    data: List[UserInfo] = Field(..., description="用户数据列表")
    total_count: int = Field(..., description="总用户数")
    returned_count: int = Field(..., description="返回用户数")

    # 确保正确定义 create_response 方法
    @classmethod
    def create_response(cls, users: List[UserInfo], total_count: Optional[int] = None):
        """
        创建列表响应的便捷方法
        """
        if total_count is None:
            total_count = len(users)
        
        return cls(
            code=200,
            message="success",
            data=users,
            total_count=total_count,
            returned_count=len(users)
        )
