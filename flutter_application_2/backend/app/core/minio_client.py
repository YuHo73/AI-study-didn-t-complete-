from minio import Minio
from app.core.config import (
    MINIO_ENDPOINT,
    MINIO_ACCESS_KEY,
    MINIO_SECRET_KEY,
    MINIO_SECURE,
    MINIO_BUCKET_NAME
)
import logging

# 配置日志
logger = logging.getLogger(__name__)

# 创建MinIO客户端
minio_client = Minio(
    MINIO_ENDPOINT,
    access_key=MINIO_ACCESS_KEY,
    secret_key=MINIO_SECRET_KEY,
    secure=MINIO_SECURE
)

# 创建bucket（如果不存在）
def ensure_bucket_exists(bucket_name=MINIO_BUCKET_NAME):
    """
    确保MinIO中存在指定的bucket
    """
    try:
        if not minio_client.bucket_exists(bucket_name):
            minio_client.make_bucket(bucket_name)
            logger.info(f"Created bucket {bucket_name}")
        return True
    except Exception as e:
        logger.error(f"Failed to create bucket {bucket_name}: {str(e)}")
        return False 