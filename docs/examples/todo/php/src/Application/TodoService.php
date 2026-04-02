<?php

declare(strict_types=1);

namespace App\Application;

use App\Domain\Todo;
use App\Domain\TodoRepositoryInterface;

/**
 * Business-logic layer for todo operations (SRP + DIP).
 *
 * Owns all validation and domain rules. Depends on the
 * {@see TodoRepositoryInterface} abstraction.
 */
final class TodoService
{
    /**
     * @param TodoRepositoryInterface $repository Concrete repository.
     */
    public function __construct(
        private readonly TodoRepositoryInterface $repository,
    ) {
    }

    /**
     * Create a new todo after validating inputs.
     *
     * @param string $title       Required, max 200 characters.
     * @param string $description Optional description.
     *
     * @return Todo Created entity.
     *
     * @throws \InvalidArgumentException When title is empty or too long.
     */
    public function create(string $title, string $description = ''): Todo
    {
        $title = trim($title);

        if ($title === '') {
            throw new \InvalidArgumentException('Title is required');
        }

        if (mb_strlen($title) > 200) {
            throw new \InvalidArgumentException('Title must not exceed 200 characters');
        }

        return $this->repository->save($title, $description);
    }

    /**
     * List all todos, newest first.
     *
     * @return Todo[]
     */
    public function listAll(): array
    {
        $todos = $this->repository->findAll();

        usort($todos, static fn (Todo $a, Todo $b): int => $b->createdAt <=> $a->createdAt);

        return $todos;
    }

    /**
     * Mark an existing todo as done.
     *
     * @param string $id Unique identifier.
     *
     * @return Todo Updated entity.
     *
     * @throws \RuntimeException When the todo is not found.
     */
    public function complete(string $id): Todo
    {
        $todo = $this->repository->markDone($id);

        if ($todo === null) {
            throw new \RuntimeException('Todo not found');
        }

        return $todo;
    }
}
