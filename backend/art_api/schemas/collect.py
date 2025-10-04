from pydantic import BaseModel
from .base_response import BaseResponse
from typing import List

class CollectResponse(BaseResponse):
    data: str