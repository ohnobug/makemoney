from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from .base_response import BaseResponse


class UploadFileRequest(BaseModel):
    filename: str
    filetype: str  # 如 "image/jpeg", "video/mp4" 等


class UploadFileData(BaseModel):
    url: str
    key: str


class UploadFileResponse(BaseResponse):
    data: UploadFileData


# 评论列表响应模型 - 支持分页
