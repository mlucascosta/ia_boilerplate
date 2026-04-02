<?php

declare(strict_types=1);

namespace App\Domain;

/**
 * Todo entity representing a task in the system.
 */
final class Todo
{
    /**
     * @param string $id          Unique identifier (UUID v4).
     * @param string $title       Task title.
     * @param string $description Optional description.
     * @param bool   $done        Whether the task is complete.
     * @param string $createdAt   ISO-8601 creation timestamp.
     */
    public function __construct(
        public readonly string $id,
        public readonly string $title,
        public readonly string $description,
        public bool $done,
        public readonly string $createdAt,
    ) {
    }

    /**
     * Serialise the entity to an associative array.
     *
     * @return array{id: string, title: string, description: string, done: bool, created_at: string}
     */
    public function toArray(): array
    {
        return [
            'id'          => $this->id,
            'title'       => $this->title,
            'description' => $this->description,
            'done'        => $this->done,
            'created_at'  => $this->createdAt,
        ];
    }
}
