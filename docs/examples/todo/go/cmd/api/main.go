// Command api is the composition root for the Todo API server.
package main

import (
	"log"

	"todo-go/internal/handler"
	"todo-go/internal/repository"
	"todo-go/internal/service"

	"github.com/gin-gonic/gin"
)

func main() {
	repo := repository.NewMemory()
	svc := service.NewTodo(repo)
	h := handler.NewTodo(svc)

	r := gin.Default()
	h.Register(r)

	log.Println("Todo API listening on :3000")
	if err := r.Run(":3000"); err != nil {
		log.Fatal(err)
	}
}
