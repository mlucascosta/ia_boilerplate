<?php

declare(strict_types=1);

namespace App\Domain;

/**
 * Data-access contract for todos (Dependency Inversion Principle).
 *
 * Higher-level code depends on this interface, not on a concrete store.
 */
interface TodoRepositoryInterface
{
    /**
     * Persist a new todo and return it with a generated ID.
     *
     * @param string $title       Required title.
     * @param string $description Optional description.
     *
     * @return Todo Created entity.
     */
    public function save(string $title, string $description = ''): Todo;

    /**
     * Retrieve all todos.
     *
     * @return Todo[] List of entities; empty array when none exist.
     */
    public function findAll(): array;

    /**
     * Mark an existing todo as done.
     *
     * @param string $id Unique identifier.
     *
     * @return Todo|null Updated entity or null if not found.
     */
    public function markDone(string $id): ?Todo;
}
