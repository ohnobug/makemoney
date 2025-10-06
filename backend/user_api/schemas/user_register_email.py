'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
from .base_response import BaseResponse
from pydantic import BaseModel, Field

class UserRegisterRequestEmailIn(BaseModel):
    email: str = Field(...)
    password: str = Field(...)
    confirm_password:str =Field(...)
    verify_code: str = Field(...)

class UserRegisterRequestEmailOut(BaseResponse):
    pass
