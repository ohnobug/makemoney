from fastapi import Request, status, HTTPException
from config import SECRET_KEY, ALGORITHM
from jose import JWTError, jwt
from pydantic import BaseModel

# 导入安全模块
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from typing import Annotated
from fastapi import Depends


class DecodeTokenUserData(BaseModel):
    user_id: int
    username: str
    avatar_url: str


def get_user_info_from_token(token: str):
    """
    从 JWT Token 字符串中解码出 payload。
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        return None


# 默认我的token调试
EXAMPLE_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsInVzZXJuYW1lIjoiTm9uZSIsImF2YXRhcl91cmwiOiJOb25lIiwiZXhwIjoxNzYyODQwNzY2fQ.MyfEp47dTzIAm1YiNGbD0vPqCKcqqGy-lse6ewmHaC4"

oauth2_scheme = HTTPBearer(
    auto_error=False,
    description=f"""
    **JWT Bearer Token 认证**
    
    请在下方输入您的 JWT Token (不包含 'Bearer '前缀)。
    
    ### 💡 快速测试示例 Token (开发环境):
    ```
    {EXAMPLE_TOKEN}
    ```
    
    ### 使用方法:
    1. 复制上面的示例 Token
    2. 点击右上角的 **"Authorize"** 按钮
    3. 在弹出的对话框中粘贴 Token
    4. 点击 **"Authorize"** 完成认证
    
    ### 认证成功后:
    - 需要认证的接口会自动在请求头中添加 Authorization
    - 您可以测试所有需要认证的 API 接口
    """,
)


def get_current_user(
    request: Request,
    token_data: Annotated[HTTPAuthorizationCredentials, Depends(oauth2_scheme)],
) -> DecodeTokenUserData:
    """
    认证依赖项。
    使用 Depends(oauth2_scheme) 自动解析 Authorization 头部。
    """

    # 1. 检查是否提供了认证信息

    # 暂时屏蔽所有人默认一个token调试
    # if token_data is None:
    #     # 抛出异常，会被主应用的 custom_http_exception_handler 捕获
    #     raise HTTPException(
    #         status_code=status.HTTP_401_UNAUTHORIZED,
    #         detail="Not authenticated",  # 使用 "Not authenticated" 触发您的自定义 401 逻辑
    #         headers={"WWW-Authenticate": "Bearer"},
    #     )

    # token = token_data.credentials

    token = EXAMPLE_TOKEN
    user_info = get_user_info_from_token(token)

    # 2. 检查凭证是否有效
    if not user_info:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="凭证无效或已过期",
            headers={"WWW-Authenticate": "Bearer"},
        )

    try:
        # 3. 验证并返回用户模型
        user = DecodeTokenUserData(**user_info)

        request.state.user = user

        return user

    except Exception as e:
        # 4. 处理内部错误
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"服务器内部错误: {e}",
        )
