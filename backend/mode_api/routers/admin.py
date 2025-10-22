from fastapi import APIRouter, Depends
from fastapi.responses import HTMLResponse
from db.database import get_db
from sqlalchemy.ext.asyncio import AsyncSession

# 创建一个 APIRouter 实例
router = APIRouter(prefix="/api/reward_admin")

# 获取手机验证码列表(测试用)
@router.get("/msgs", response_class=HTMLResponse, summary="获取验证码列表")
async def get_verify_code_list(db: AsyncSession = Depends(get_db)):
    return "hello"
