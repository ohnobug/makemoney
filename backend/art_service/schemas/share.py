from pydantic import BaseModel
from .base_response import BaseResponse
from typing import List

class ShareResponse(BaseResponse):
    data: str