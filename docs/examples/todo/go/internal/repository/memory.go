// Package repository provides concrete data-access implementations.
package repository

import (
	"fmt"
	"sync"
	"time"

	"todo-go/internal/domain"

	"github.com/google/uuid"
)

// Memory is an in-memory implementation of domain.TodoRepository.
// It is safe for concurrent use.
type Memory struct {
	mu    sync.RWMutex
	store map[string]*domain.Todo
}

// NewMemory creates an empty in-memory repository.
func NewMemory() *Memory {
	return &Memory{store: make(map[string]*domain.Todo)}
}

// Save persists a new todo in memory.
func (r *Memory) Save(title, description string) (*domain.Todo, error) {
	todo := &domain.Todo{
		ID:          uuid.New().String(),
		Title:       title,
		Description: description,
		Done:        false,
		CreatedAt:   time.Now().UTC(),
	}

	r.mu.Lock()
	r.store[todo.ID] = todo
	r.mu.Unlock()

	return todo, nil
}

// FindAll returns all stored todos.
func (r *Memory) FindAll() ([]*domain.Todo, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()

	todos := make([]*domain.Todo, 0, len(r.store))
	for _, t := range r.store {
		todos = append(todos, t)
	}
	return todos, nil
}

// MarkDone sets done=true for the given ID.
// Returns a non-nil error when the todo is not found.
func (r *Memory) MarkDone(id string) (*domain.Todo, error) {
	r.mu.Lock()
	defer r.mu.Unlock()

	todo, ok := r.store[id]
	if !ok {
		return nil, fmt.Errorf("todo %s not found", id)
	}
	todo.Done = true
	return todo, nil
}
