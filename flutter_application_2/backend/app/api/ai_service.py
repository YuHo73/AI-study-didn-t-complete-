from fastapi import APIRouter, Body
from pydantic import BaseModel
import httpx

router = APIRouter(prefix="/ai", tags=["AIService"])

class LessonPlanGenRequest(BaseModel):
    topic: str
    grade: str
    subject: str
    duration_minutes: int
    model: str

@router.post("/generate/lesson-plan")
async def generate_lesson_plan(req: LessonPlanGenRequest):
    """
    调用外部AI API生成教案
    """
    # 这里用伪代码，实际应根据你的AI API文档实现
    async with httpx.AsyncClient() as client:
        # 假设你的AI服务是 http://ai.example.com/generate
        resp = await client.post("http://ai.example.com/generate", json=req.dict())
        return resp.json()
