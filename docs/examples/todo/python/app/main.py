"""Application composition root — wires implementations to abstractions."""

from fastapi import FastAPI

from app.repositories.in_memory_todo_repo import InMemoryTodoRepo
from app.routes.todos import create_router
from app.services.todo_service import TodoService

app = FastAPI(title="Todo API")

repository = InMemoryTodoRepo()
service = TodoService(repository)

app.include_router(create_router(service))
