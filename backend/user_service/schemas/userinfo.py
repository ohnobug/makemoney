import datetime
from .base_response import BaseResponse
from pydantic import BaseModel, Field

class UserInfoRequestIn(BaseModel):
    pass

class UserInfo(BaseModel):
    phone_number: str = Field(...)
    username: str = Field(...)
    avatar_url: str = Field(...)
    create_time: datetime = Field(...)
    update_time: datetime = Field(...)
    id: int = Field(...)
    class Config:
        orm_mode = True

class UserInfoRequestOut(BaseResponse):
    data: UserInfo = Field(...)
