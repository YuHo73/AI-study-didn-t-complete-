from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any

class LessonPlanGenRequest(BaseModel):
    """
    教案自动生成请求模型
    """
    topic: str = Field(..., description="教学主题")
    grade: str = Field(..., description="年级")
    subject: str = Field(..., description="学科")
    duration_minutes: int = Field(..., description="课程时长（分钟）")
    model: str = Field(..., description="AI模型名称")

class ContentConvertRequest(BaseModel):
    """
    多模态内容转换请求模型
    """
    type: str = Field(..., description="转换类型（text2img/img2text/speech2text/text2speech）")
    content: Optional[str] = Field(None, description="文本内容或描述")
    file_url: Optional[str] = Field(None, description="待转换文件的URL")
    model: Optional[str] = Field(None, description="AI模型名称")

class ChatMessage(BaseModel):
    """
    聊天消息模型
    """
    role: str = Field(..., description="消息角色 (user/assistant/system)")
    content: str = Field(..., description="消息内容")

class ChatRequest(BaseModel):
    """
    文本对话请求模型
    """
    messages: List[ChatMessage] = Field(..., description="对话历史消息")
    model: Optional[str] = Field(None, description="AI模型名称")
    temperature: Optional[float] = Field(0.7, description="采样温度")
    max_tokens: Optional[int] = Field(None, description="最大生成的token数量")

class ImageRecognitionRequest(BaseModel):
    """
    图像识别请求模型
    """
    file_url: str = Field(..., description="图像文件URL")
    model: Optional[str] = Field(None, description="AI模型名称")
    analyze_type: Optional[str] = Field("general", description="分析类型(general/ocr/objects)")

class ImageGenerationRequest(BaseModel):
    """
    图像生成请求模型
    """
    prompt: str = Field(..., description="图像描述")
    model: Optional[str] = Field(None, description="AI模型名称")
    size: Optional[str] = Field("512x512", description="图像尺寸")
    n: Optional[int] = Field(1, description="生成图像数量")
    style: Optional[str] = Field(None, description="图像风格") 