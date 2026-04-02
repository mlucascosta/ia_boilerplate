"""Abstract base class for todo data access (Dependency Inversion Principle)."""

from abc import ABC, abstractmethod
from typing import Optional


class TodoRepository(ABC):
    """Repository interface for todo data operations.

    Concrete implementations provide the actual storage mechanism.
    Higher-level modules depend on this abstraction, not on a specific database.
    """

    @abstractmethod
    def save(self, title: str, description: str = "") -> dict:
        """Persist a new todo.

        Args:
            title: Required todo title.
            description: Optional description text.

        Returns:
            Dict with keys: id, title, description, done, created_at.
        """

    @abstractmethod
    def find_all(self) -> list[dict]:
        """Retrieve all todos.

        Returns:
            List of todo dicts. Empty list when none exist.
        """

    @abstractmethod
    def mark_done(self, todo_id: str) -> Optional[dict]:
        """Mark an existing todo as complete.

        Args:
            todo_id: Unique todo identifier.

        Returns:
            Updated todo dict, or None if not found.
        """
