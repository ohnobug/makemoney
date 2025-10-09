from fastapi import APIRouter, HTTPException
import boto3
from botocore.exceptions import ClientError
from datetime import datetime

from schemas.upload_file import UploadFileRequest, UploadFileResponse
from middlewares.token_auth import token_auth_middleware
from config import R2_ACCESS_KEY, R2_SECRET_KEY, R2_BUCKET, R2_ACCOUNT_ID


router = APIRouter(prefix="/api/art")
router.middleware("http")(token_auth_middleware)

# 创建 S3 兼容客户端
s3_client = boto3.client(
    "s3",
    endpoint_url=f"https://{R2_ACCOUNT_ID}.r2.cloudflarestorage.com",
    aws_access_key_id=R2_ACCESS_KEY,
    aws_secret_access_key=R2_SECRET_KEY,
)


@router.post("/upload-url")
def get_presigned_url(request: UploadFileRequest):
    """
    生成 R2 临时上传 URL
    """
    try:
        # 可选：对文件类型做白名单校验
        allowed_types = ["image/jpeg", "image/png", "video/mp4", "application/pdf"]
        if request.filetype not in allowed_types:
            raise HTTPException(status_code=400, detail="File type not allowed")

        # 生成唯一文件名（避免覆盖）
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        key = f"public/{timestamp}_{request.filename}"

        # 生成预签名 URL（有效期 5 分钟）
        presigned_url = s3_client.generate_presigned_url(
            "put_object",
            Params={
                "Bucket": R2_BUCKET,
                "Key": key,
                "ContentType": request.filetype,
                # 可选：设置元数据、ACL 等
            },
            ExpiresIn=480,  # 8 分钟
            HttpMethod="PUT",
        )

        return UploadFileResponse(url=presigned_url, key=key)

    except ClientError as e:
        print(f"R2 Client Error: {e}")
        raise HTTPException(status_code=500, detail="Failed to generate upload URL")
    except Exception as e:
        print(f"Unexpected error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")
