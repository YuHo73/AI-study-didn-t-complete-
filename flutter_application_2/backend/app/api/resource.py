from fastapi import APIRouter, UploadFile, File
from minio import Minio

router = APIRouter(prefix="/resource", tags=["Resource"])

# MinIO 客户端初始化（实际应放到配置文件）
minio_client = Minio(
    "localhost:9000",
    access_key="minioadmin",
    secret_key="minioadmin",
    secure=False
)

@router.post("/upload")
async def upload_resource(file: UploadFile = File(...)):
    """
    上传资源到对象存储
    """
    content = await file.read()
    minio_client.put_object(
        "your-bucket",
        file.filename,
        data=content,
        length=len(content),
        content_type=file.content_type
    )
    return {"filename": file.filename, "url": f"/minio/your-bucket/{file.filename}"}
