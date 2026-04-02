<?php

declare(strict_types=1);

namespace App\Infrastructure;

use App\Domain\Todo;
use App\Domain\TodoRepositoryInterface;

/**
 * In-memory implementation of {@see TodoRepositoryInterface} (SRP).
 *
 * Stores todos in a plain array. Suitable for development and testing;
 * replace with a database-backed repository for production.
 */
final class InMemoryTodoRepository implements TodoRepositoryInterface
{
    /** @var array<string, Todo> */
    private array $store = [];

    /**
     * {@inheritDoc}
     */
    public function save(string $title, string $description = ''): Todo
    {
        $id = bin2hex(random_bytes(16));

        $todo = new Todo(
            id: $id,
            title: $title,
            description: $description,
            done: false,
            createdAt: (new \DateTimeImmutable('now', new \DateTimeZone('UTC')))->format('c'),
        );

        $this->store[$id] = $todo;

        return $todo;
    }

    /**
     * {@inheritDoc}
     */
    public function findAll(): array
    {
        return array_values($this->store);
    }

    /**
     * {@inheritDoc}
     */
    public function markDone(string $id): ?Todo
    {
        if (!isset($this->store[$id])) {
            return null;
        }

        $this->store[$id]->done = true;

        return $this->store[$id];
    }
}
