'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
from .base_response import BaseResponse
from pydantic import BaseModel, Field

class UserLoginRequestIn(BaseModel):
    name: str = Field(..., example="")
    password: str = Field(..., example="")
    
class UserLoginToken(BaseModel):
    token: str = Field(...)

class UserLoginRequestOut(BaseResponse):
    data: UserLoginToken = Field(...)