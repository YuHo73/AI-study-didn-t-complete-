import os
from typing import Optional
from dotenv import load_dotenv

load_dotenv()  # 加载.env文件

# 基础配置
API_VERSION = "v1"
PROJECT_NAME = "多模态教学资源系统"

# MinIO配置
MINIO_ENDPOINT = os.getenv("MINIO_ENDPOINT", "10.0.113.17:9000") 
MINIO_ACCESS_KEY = os.getenv("MINIO_ACCESS_KEY", "YuHo")
MINIO_SECRET_KEY = os.getenv("MINIO_SECRET_KEY", "7happyyyh")
MINIO_SECURE = False  # 是否使用HTTPS
MINIO_BUCKET_NAME = os.getenv("MINIO_BUCKET_NAME", "teaching-resources")

# 资源类型映射
RESOURCE_TYPE_MAPPING = {
    "pdf": "document",
    "doc": "document",
    "docx": "document",
    "ppt": "presentation",
    "pptx": "presentation",
    "xls": "spreadsheet",
    "xlsx": "spreadsheet",
    "jpg": "image",
    "jpeg": "image",
    "png": "image",
    "gif": "image",
    "mp3": "audio",
    "wav": "audio",
    "mp4": "video",
    "mov": "video",
    "txt": "text",
}

# AI服务配置 - 通用配置（旧版配置，保留向后兼容性）
AI_SERVICE_URL = os.getenv("AI_SERVICE_URL", "")  # AI服务URL
AI_SERVICE_KEY = os.getenv("AI_SERVICE_KEY", "")  # AI服务密钥（如有）

# 文本对话 API 配置
# 【需要填写】请在.env中设置TEXT_CHAT_API_URL和TEXT_CHAT_API_KEY
TEXT_CHAT_API_URL = os.getenv("TEXT_CHAT_API_URL", "")
TEXT_CHAT_API_KEY = os.getenv("TEXT_CHAT_API_KEY", "")

# 教案生成 API 配置
# 【需要填写】请在.env中设置LESSON_PLAN_API_URL和LESSON_PLAN_API_KEY
LESSON_PLAN_API_URL = os.getenv("LESSON_PLAN_API_URL", "")
LESSON_PLAN_API_KEY = os.getenv("LESSON_PLAN_API_KEY", "")

# 多模态内容转换 API 配置
# 【需要填写】请在.env中设置CONTENT_CONVERT_API_URL和CONTENT_CONVERT_API_KEY
CONTENT_CONVERT_API_URL = os.getenv("CONTENT_CONVERT_API_URL", "")
CONTENT_CONVERT_API_KEY = os.getenv("CONTENT_CONVERT_API_KEY", "")

# 图像识别 API 配置
# 【需要填写】请在.env中设置IMAGE_RECOGNITION_API_URL和IMAGE_RECOGNITION_API_KEY
IMAGE_RECOGNITION_API_URL = os.getenv("IMAGE_RECOGNITION_API_URL", "")
IMAGE_RECOGNITION_API_KEY = os.getenv("IMAGE_RECOGNITION_API_KEY", "")

# 图像生成 API 配置
# 【需要填写】请在.env中设置IMAGE_GENERATION_API_URL和IMAGE_GENERATION_API_KEY
IMAGE_GENERATION_API_URL = os.getenv("IMAGE_GENERATION_API_URL", "")
IMAGE_GENERATION_API_KEY = os.getenv("IMAGE_GENERATION_API_KEY", "")

# 允许的文件类型集合（扩展名）
ALLOWED_FILE_TYPES = set(RESOURCE_TYPE_MAPPING.keys())

# 最大文件大小（字节）
MAX_FILE_SIZE = 100 * 1024 * 1024  # 100 MB

# 获取文件类型
def get_resource_type(filename: str) -> Optional[str]:
    """根据文件名获取资源类型"""
    ext = filename.rsplit(".", 1)[-1].lower() if "." in filename else ""
    return RESOURCE_TYPE_MAPPING.get(ext, "other")
