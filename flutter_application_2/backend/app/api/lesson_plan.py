from fastapi import APIRouter, HTTPException
from app.models.lesson_plan import LessonPlan

router = APIRouter(prefix="/lesson", tags=["LessonPlan"])

# 假数据存储
LESSON_PLANS = {}

@router.post("/", response_model=LessonPlan)
def create_lesson_plan(lesson: LessonPlan):
    """创建教案"""
    LESSON_PLANS[lesson.id] = lesson
    return lesson

@router.get("/{lesson_id}", response_model=LessonPlan)
def get_lesson_plan(lesson_id: str):
    """获取教案详情"""
    lesson = LESSON_PLANS.get(lesson_id)
    if not lesson:
        raise HTTPException(status_code=404, detail="教案不存在")
    return lesson
