"""In-memory implementation of TodoRepository (Single Responsibility Principle)."""

import uuid
from datetime import datetime, timezone
from typing import Optional

from app.repositories.todo_repository import TodoRepository


class InMemoryTodoRepo(TodoRepository):
    """Stores todos in a plain dict. Suitable for development and testing."""

    def __init__(self) -> None:
        """Initialise empty in-memory store."""
        self._store: dict[str, dict] = {}

    def save(self, title: str, description: str = "") -> dict:
        """Persist a new todo in memory.

        Args:
            title: Required todo title.
            description: Optional description.

        Returns:
            Created todo dict with generated id and timestamp.
        """
        todo_id = str(uuid.uuid4())
        todo = {
            "id": todo_id,
            "title": title,
            "description": description,
            "done": False,
            "created_at": datetime.now(timezone.utc).isoformat(),
        }
        self._store[todo_id] = todo
        return todo

    def find_all(self) -> list[dict]:
        """Return all todos from memory.

        Returns:
            List of todo dicts.
        """
        return list(self._store.values())

    def mark_done(self, todo_id: str) -> Optional[dict]:
        """Mark a stored todo as done.

        Args:
            todo_id: Unique todo identifier.

        Returns:
            Updated todo dict, or None if not found.
        """
        todo = self._store.get(todo_id)
        if todo is None:
            return None
        todo["done"] = True
        return todo
