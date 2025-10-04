from pydantic import BaseModel, Field
from .base_response import BaseResponse
from typing import List
from db.art_model import ArtItem



class ArtListData(BaseModel):
    list: List[ArtItem]
    total: int
    page: int
    page_size: int

class ArtListResponse(BaseResponse):
    data: ArtListData


