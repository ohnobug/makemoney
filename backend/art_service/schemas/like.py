from pydantic import BaseModel, Field
from .base_response import BaseResponse
from typing import List

class LikeResponse(BaseResponse):
    data: str


