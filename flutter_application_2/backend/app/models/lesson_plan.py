from pydantic import BaseModel, Field
from typing import List, Optional

class LessonSection(BaseModel):
    """
    教学环节模型
    """
    title: str = Field(..., description="环节标题")
    content: str = Field(..., description="环节内容")
    duration_minutes: int = Field(..., description="时长（分钟）")
    activity_type: Optional[str] = Field(None, description="活动类型")
    resources: Optional[List[str]] = Field(default_factory=list, description="相关资源ID列表")

class LessonPlan(BaseModel):
    """
    教案模型
    """
    id: str = Field(..., description="教案唯一ID")
    title: str = Field(..., description="教案标题")
    subject: str = Field(..., description="学科")
    grade: str = Field(..., description="年级")
    duration_minutes: int = Field(..., description="总时长")
    sections: List[LessonSection] = Field(..., description="教学环节列表")
    objectives: Optional[str] = Field(None, description="教学目标")
    materials: Optional[str] = Field(None, description="教学材料")
    assessment: Optional[str] = Field(None, description="评估方式")
    notes: Optional[str] = Field(None, description="教学笔记")
    is_favorite: bool = Field(default=False, description="是否收藏")
    author_id: Optional[str] = Field(None, description="创建者ID")
    created_at: Optional[str] = Field(None, description="创建时间")
    updated_at: Optional[str] = Field(None, description="更新时间")
