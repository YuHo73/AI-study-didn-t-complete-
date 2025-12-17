from fastapi import APIRouter
from .lesson_plan import router as lesson_router
from .ai_service import router as ai_router
from .resource import router as resource_router

router = APIRouter()
router.include_router(lesson_router)
router.include_router(ai_router)
router.include_router(resource_router)
