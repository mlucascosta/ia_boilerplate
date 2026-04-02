// Package domain defines the core Todo entity and the repository interface.
package domain

import "time"

// Todo represents a task in the system.
type Todo struct {
	ID          string    `json:"id"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Done        bool      `json:"done"`
	CreatedAt   time.Time `json:"created_at"`
}

// TodoRepository defines the data-access contract.
// Higher-level code depends on this interface, not on a concrete store (DIP).
type TodoRepository interface {
	// Save persists a new todo and returns it with a generated ID.
	Save(title, description string) (*Todo, error)

	// FindAll returns every stored todo.
	FindAll() ([]*Todo, error)

	// MarkDone sets done=true for the given ID. Returns nil if not found.
	MarkDone(id string) (*Todo, error)
}
