from pydantic import BaseModel, Field
from typing import List, Optional

class Resource(BaseModel):
    """
    教学资源模型
    """
    id: str = Field(..., description="资源唯一ID")
    name: str = Field(..., description="资源名称")
    url: str = Field(..., description="MinIO文件URL")
    type: str = Field(..., description="资源类型（image/audio/video/doc/other）")
    uploader_id: str = Field(..., description="上传者ID")
    tags: List[str] = Field(default_factory=list, description="标签列表")
    size: Optional[int] = Field(None, description="文件大小（字节）")
    created_at: Optional[str] = Field(None, description="上传时间")
    description: Optional[str] = Field(None, description="资源描述") 