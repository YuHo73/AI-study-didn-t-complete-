import os
import uuid
import time
from typing import List, Optional
from fastapi import UploadFile, HTTPException
from app.core.minio_client import minio_client
from app.core.config import (
    MINIO_BUCKET_NAME, 
    ALLOWED_FILE_TYPES,
    MAX_FILE_SIZE,
    get_resource_type
)
from app.models.resource import Resource

# 模拟数据库存储，实际项目应使用数据库
resources_db = {}

class ResourceService:
    @staticmethod
    async def upload_resource(
        file: UploadFile,
        uploader_id: str,
        description: Optional[str] = None,
        tags: Optional[List[str]] = None,
        folder: str = ""
    ) -> Resource:
        """
        上传资源到MinIO并记录元数据
        """
        # 检查文件扩展名
        file_extension = file.filename.rsplit(".", 1)[-1].lower() if "." in file.filename else ""
        if file_extension not in ALLOWED_FILE_TYPES:
            raise HTTPException(
                status_code=400,
                detail=f"不支持的文件类型: {file_extension}。允许的类型: {', '.join(ALLOWED_FILE_TYPES)}"
            )
        
        # 生成唯一ID和文件名
        resource_id = str(uuid.uuid4())
        timestamp = int(time.time())
        safe_filename = f"{timestamp}_{resource_id}.{file_extension}"
        
        # 构造对象路径
        object_path = safe_filename
        if folder:
            object_path = f"{folder.rstrip('/')}/{safe_filename}"
        
        # 读取文件内容
        content = await file.read()
        
        # 检查文件大小
        if len(content) > MAX_FILE_SIZE:
            raise HTTPException(
                status_code=400,
                detail=f"文件过大。最大允许大小: {MAX_FILE_SIZE / 1024 / 1024}MB"
            )
        
        try:
            # 上传到MinIO
            minio_client.put_object(
                MINIO_BUCKET_NAME,
                object_path,
                data=file.file,  # 重置文件指针
                length=len(content),
                content_type=file.content_type
            )
            
            # 生成URL
            url = f"/api/resource/download/{resource_id}"
            
            # 创建资源记录
            resource = Resource(
                id=resource_id,
                name=file.filename,
                url=url,
                type=get_resource_type(file.filename),
                uploader_id=uploader_id,
                tags=tags or [],
                size=len(content),
                created_at=time.strftime("%Y-%m-%d %H:%M:%S"),
                description=description
            )
            
            # 存储资源记录
            resources_db[resource_id] = {
                **resource.dict(),
                "minio_path": object_path  # 存储MinIO中的路径，方便下载
            }
            
            return resource
            
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"上传文件失败: {str(e)}")
    
    @staticmethod
    def get_resource(resource_id: str) -> Resource:
        """
        获取资源详情
        """
        if resource_id not in resources_db:
            raise HTTPException(status_code=404, detail="资源不存在")
        
        return Resource(**{k: v for k, v in resources_db[resource_id].items() if k != "minio_path"})
    
    @staticmethod
    def get_resources(
        uploader_id: Optional[str] = None,
        resource_type: Optional[str] = None,
        tag: Optional[str] = None,
        skip: int = 0,
        limit: int = 100
    ) -> List[Resource]:
        """
        获取资源列表，支持筛选和分页
        """
        resources = list(resources_db.values())
        
        # 应用筛选
        if uploader_id:
            resources = [r for r in resources if r["uploader_id"] == uploader_id]
        
        if resource_type:
            resources = [r for r in resources if r["type"] == resource_type]
            
        if tag:
            resources = [r for r in resources if tag in r["tags"]]
        
        # 应用分页
        resources = resources[skip:skip+limit]
        
        return [Resource(**{k: v for k, v in r.items() if k != "minio_path"}) for r in resources]
    
    @staticmethod
    def download_resource(resource_id: str):
        """
        获取资源下载流
        """
        if resource_id not in resources_db:
            raise HTTPException(status_code=404, detail="资源不存在")
        
        try:
            object_path = resources_db[resource_id]["minio_path"]
            response = minio_client.get_object(MINIO_BUCKET_NAME, object_path)
            return response
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"下载文件失败: {str(e)}")
    
    @staticmethod
    def delete_resource(resource_id: str, user_id: str):
        """
        删除资源
        """
        if resource_id not in resources_db:
            raise HTTPException(status_code=404, detail="资源不存在")
        
        # 检查权限
        if resources_db[resource_id]["uploader_id"] != user_id:
            raise HTTPException(status_code=403, detail="没有权限删除此资源")
        
        try:
            object_path = resources_db[resource_id]["minio_path"]
            minio_client.remove_object(MINIO_BUCKET_NAME, object_path)
            del resources_db[resource_id]
            return {"message": "资源已删除"}
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"删除文件失败: {str(e)}") 