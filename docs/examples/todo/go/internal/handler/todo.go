// Package handler provides HTTP handlers for the todo API.
package handler

import (
	"net/http"

	"todo-go/internal/service"

	"github.com/gin-gonic/gin"
)

// createRequest is the expected JSON body for POST /todos.
type createRequest struct {
	Title       string `json:"title"`
	Description string `json:"description"`
}

// Todo groups the HTTP handlers and holds a reference to the service layer.
type Todo struct {
	svc *service.Todo
}

// NewTodo creates a handler with the given service.
func NewTodo(svc *service.Todo) *Todo {
	return &Todo{svc: svc}
}

// Register mounts all todo routes on the given Gin engine.
func (h *Todo) Register(r *gin.Engine) {
	g := r.Group("/todos")
	g.POST("/", h.create)
	g.GET("/", h.list)
	g.PATCH("/:id/done", h.complete)
}

// create handles POST /todos.
func (h *Todo) create(c *gin.Context) {
	var body createRequest
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	todo, err := h.svc.Create(body.Title, body.Description)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, todo)
}

// list handles GET /todos.
func (h *Todo) list(c *gin.Context) {
	todos, err := h.svc.ListAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, todos)
}

// complete handles PATCH /todos/:id/done.
func (h *Todo) complete(c *gin.Context) {
	todo, err := h.svc.Complete(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, todo)
}
