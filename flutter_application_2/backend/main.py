import logging
from fastapi import FastAPI, Request, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import uvicorn
import os

from app.api import api_router
from app.core.config import API_VERSION, PROJECT_NAME
from app.core.minio_client import ensure_bucket_exists

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger(__name__)

# 创建FastAPI应用
app = FastAPI(
    title=PROJECT_NAME,
    description="多模态教学资源系统API",
    version=API_VERSION,
)

# 配置跨域中间件
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 实际生产环境应限定允许的源
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 全局异常处理
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"全局异常: {exc}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"message": f"服务器内部错误: {str(exc)}"},
    )

# 注册API路由
app.include_router(api_router, prefix=f"/api/{API_VERSION}")

# 应用启动事件
@app.on_event("startup")
async def startup_event():
    """应用启动时执行的操作"""
    logger.info("应用正在启动...")
    
    # 确保MinIO bucket存在
    ensure_bucket_exists()
    
    logger.info("应用启动完成")

@app.on_event("shutdown")
async def shutdown_event():
    """应用关闭时执行的操作"""
    logger.info("应用正在关闭...")
    # 执行清理操作，如关闭连接等
    logger.info("应用已关闭")

# 健康检查接口
@app.get("/health")
async def health_check():
    """健康检查接口"""
    return {"status": "healthy", "version": API_VERSION}

# 根路由
@app.get("/")
async def root():
    """API根路由"""
    return {
        "message": f"欢迎使用{PROJECT_NAME} API",
        "version": API_VERSION,
        "docs_url": "/docs",
    }

# 直接运行该文件时的入口
if __name__ == "__main__":
    # 从环境变量获取端口，如果不存在则使用默认值8000
    port = int(os.getenv("PORT", "8000"))
    # 启动服务器
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=True) 