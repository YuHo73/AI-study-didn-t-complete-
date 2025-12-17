from fastapi import APIRouter

from app.api.resources import router as resources_router
from app.api.ai import router as ai_router

# 创建主API路由
api_router = APIRouter()

# 注册所有子路由
api_router.include_router(resources_router, prefix="/resource", tags=["资源管理"])
api_router.include_router(ai_router, prefix="/ai", tags=["AI服务"]) 