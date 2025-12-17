from pydantic import BaseModel, Field
from typing import Optional

class User(BaseModel):
    """
    用户模型
    """
    id: str = Field(..., description="用户唯一ID")
    username: str = Field(..., description="用户名")
    password: str = Field(..., description="密码（加密存储）")
    email: Optional[str] = Field(None, description="邮箱")
    role: str = Field(..., description="角色（teacher/student/admin）")
    avatar_url: Optional[str] = Field(None, description="头像URL")
    created_at: Optional[str] = Field(None, description="注册时间") 