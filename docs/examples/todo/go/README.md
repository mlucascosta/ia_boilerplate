# Todo API — Go / Gin

Demonstrates the IA Boilerplate workflow applied to a Go REST API.

## Architecture (SOLID)

```
internal/
├── domain/
│   └── todo.go            # Entity + repository interface (DIP)
├── repository/
│   └── memory.go          # In-memory implementation (SRP)
├── service/
│   └── todo.go            # Business logic (SRP, OCP)
└── handler/
    └── todo.go            # HTTP handlers (ISP)
cmd/
└── api/
    └── main.go            # Composition root
```

## Documentation Standard

Godoc comments on all exported types, functions, and methods.

## Verification

```bash
go run cmd/api/main.go &
curl -s -X POST http://localhost:3000/todos -H 'Content-Type: application/json' -d '{"title":"Buy milk"}'
curl -s http://localhost:3000/todos
kill %1
```
