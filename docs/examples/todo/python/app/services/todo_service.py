"""Business-logic layer for todo operations (SRP + DIP)."""

from app.repositories.todo_repository import TodoRepository


class TodoService:
    """Owns all validation and domain rules for todos.

    Depends on the TodoRepository abstraction, not on a concrete store.
    """

    def __init__(self, repository: TodoRepository) -> None:
        """Initialise the service with a repository implementation.

        Args:
            repository: Concrete TodoRepository.
        """
        self._repository = repository

    def create(self, title: str, description: str = "") -> dict:
        """Create a new todo after validating inputs.

        Args:
            title: Required, max 200 characters.
            description: Optional description text.

        Returns:
            Created todo dict.

        Raises:
            ValueError: If title is empty or exceeds 200 characters.
        """
        if not title or not title.strip():
            raise ValueError("Title is required")
        if len(title) > 200:
            raise ValueError("Title must not exceed 200 characters")
        return self._repository.save(title.strip(), description)

    def list_all(self) -> list[dict]:
        """List all todos, newest first.

        Returns:
            Sorted list of todo dicts.
        """
        todos = self._repository.find_all()
        return sorted(todos, key=lambda t: t["created_at"], reverse=True)

    def complete(self, todo_id: str) -> dict:
        """Mark an existing todo as done.

        Args:
            todo_id: Unique todo identifier.

        Returns:
            Updated todo dict.

        Raises:
            ValueError: If the todo is not found.
        """
        todo = self._repository.mark_done(todo_id)
        if todo is None:
            raise ValueError("Todo not found")
        return todo
