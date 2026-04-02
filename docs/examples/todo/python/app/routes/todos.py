"""HTTP routes for todo endpoints."""

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

from app.services.todo_service import TodoService


class CreateTodoRequest(BaseModel):
    """Request body for creating a todo.

    Attributes:
        title: Required todo title.
        description: Optional description.
    """

    title: str
    description: str = ""


def create_router(service: TodoService) -> APIRouter:
    """Build a FastAPI router wired to the given TodoService.

    Args:
        service: Injected TodoService instance.

    Returns:
        Configured APIRouter with POST, GET, and PATCH endpoints.
    """
    router = APIRouter(prefix="/todos", tags=["todos"])

    @router.post("/", status_code=201)
    def create_todo(body: CreateTodoRequest) -> dict:
        """POST /todos — create a new todo."""
        try:
            return service.create(body.title, body.description)
        except ValueError as exc:
            raise HTTPException(status_code=400, detail=str(exc))

    @router.get("/")
    def list_todos() -> list[dict]:
        """GET /todos — list all todos."""
        return service.list_all()

    @router.patch("/{todo_id}/done")
    def complete_todo(todo_id: str) -> dict:
        """PATCH /todos/{todo_id}/done — mark a todo as complete."""
        try:
            return service.complete(todo_id)
        except ValueError as exc:
            raise HTTPException(status_code=404, detail=str(exc))

    return router
