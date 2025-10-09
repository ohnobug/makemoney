
from .base_response import BaseResponse
from pydantic import BaseModel, Field

class UserRegisterRequestEmailIn(BaseModel):
    email: str = Field(...)
    password: str = Field(...)
    confirm_password:str =Field(...)
    verify_code: str = Field(...)

class UserRegisterRequestEmailOut(BaseResponse):
    pass
