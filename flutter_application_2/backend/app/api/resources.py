from fastapi import APIRouter, Depends, UploadFile, File, Form, Query, HTTPException
from fastapi.responses import StreamingResponse
from typing import List, Optional
from datetime import datetime

from app.services.resource_service import ResourceService
from app.models.resource import Resource

# 初始化路由
router = APIRouter()

# 模拟用户认证，实际项目中应该使用真实的认证系统
def get_current_user_id():
    """
    模拟当前用户ID，实际项目中通过token获取
    """
    return "test_user_id"

@router.post("/upload", response_model=Resource)
async def upload_resource(
    file: UploadFile = File(...),
    description: Optional[str] = Form(None),
    tags: Optional[str] = Form(None),
    folder: str = Form(""),  # 可选的文件夹路径
    user_id: str = Depends(get_current_user_id)
):
    """
    上传资源文件
    """
    # 处理标签
    tag_list = tags.split(",") if tags else []
    tag_list = [tag.strip() for tag in tag_list if tag.strip()]
    
    # 调用服务上传资源
    resource = await ResourceService.upload_resource(
        file=file,
        uploader_id=user_id,
        description=description,
        tags=tag_list,
        folder=folder
    )
    
    return resource

@router.get("/list", response_model=List[Resource])
async def list_resources(
    uploader_id: Optional[str] = None,
    type: Optional[str] = None,
    tag: Optional[str] = None,
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=500),
    user_id: str = Depends(get_current_user_id)
):
    """
    获取资源列表，支持筛选和分页
    """
    # 调用服务获取资源列表
    resources = ResourceService.get_resources(
        uploader_id=uploader_id,
        resource_type=type,
        tag=tag,
        skip=skip,
        limit=limit
    )
    
    return resources

@router.get("/{resource_id}", response_model=Resource)
async def get_resource(
    resource_id: str,
    user_id: str = Depends(get_current_user_id)
):
    """
    获取资源详情
    """
    return ResourceService.get_resource(resource_id)

@router.get("/download/{resource_id}")
async def download_resource(
    resource_id: str,
    user_id: str = Depends(get_current_user_id)
):
    """
    下载资源
    """
    # 首先获取资源信息
    resource = ResourceService.get_resource(resource_id)
    
    # 获取资源流
    response = ResourceService.download_resource(resource_id)
    
    # 创建流式响应
    return StreamingResponse(
        response,
        media_type=response.headers.get('content-type', 'application/octet-stream'),
        headers={"Content-Disposition": f'attachment; filename="{resource.name}"'}
    )

@router.delete("/{resource_id}")
async def delete_resource(
    resource_id: str,
    user_id: str = Depends(get_current_user_id)
):
    """
    删除资源
    """
    return ResourceService.delete_resource(resource_id, user_id) 