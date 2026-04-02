// Package service contains business logic for todo operations.
package service

import (
	"errors"
	"sort"

	"todo-go/internal/domain"
)

// Todo owns validation and domain rules.
// It depends on the domain.TodoRepository abstraction (DIP).
type Todo struct {
	repo domain.TodoRepository
}

// NewTodo creates a Todo service backed by the given repository.
func NewTodo(repo domain.TodoRepository) *Todo {
	return &Todo{repo: repo}
}

// Create validates inputs and persists a new todo.
// Returns an error when the title is empty or exceeds 200 characters.
func (s *Todo) Create(title, description string) (*domain.Todo, error) {
	if title == "" {
		return nil, errors.New("title is required")
	}
	if len(title) > 200 {
		return nil, errors.New("title must not exceed 200 characters")
	}
	return s.repo.Save(title, description)
}

// ListAll returns every todo, newest first.
func (s *Todo) ListAll() ([]*domain.Todo, error) {
	todos, err := s.repo.FindAll()
	if err != nil {
		return nil, err
	}
	sort.Slice(todos, func(i, j int) bool {
		return todos[i].CreatedAt.After(todos[j].CreatedAt)
	})
	return todos, nil
}

// Complete marks a todo as done.
// Returns an error when the todo does not exist.
func (s *Todo) Complete(id string) (*domain.Todo, error) {
	return s.repo.MarkDone(id)
}
