'''
description:  
@author chenchangfu 
Copyright (c) 2019, AUTHOR. All rights reserved.
AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
'''
# services/__init__.py
API_VERSION = "1.0"
AUTHOR = "kent"

# # services/__init__.py
from .email import generate_verification_code , send_verification_email

__all__ = ["generate_verification_code",'send_verification_email']  # 声明可公开访问的内容