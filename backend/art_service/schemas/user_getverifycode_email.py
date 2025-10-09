'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
from pydantic import BaseModel, Field
from .base_response import BaseResponse

# class UserResetPasswordRequestIn(BaseModel):
#     phone_number: str
#     verify_code: str
#     new_password: str = Field()

# class UserResetPasswordRequestOut(BaseResponse):
#     pass


class UserGetVerifyCodeRequest(BaseModel):
    email: str

class UserGetVerifyEmailCodeRequestOut(BaseModel):
    email: str
    message: str = "验证码已发送"
