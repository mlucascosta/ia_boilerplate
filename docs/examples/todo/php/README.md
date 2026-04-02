# Todo API — PHP / Slim

Demonstrates the IA Boilerplate workflow applied to a PHP REST API.

## Architecture (SOLID)

```
src/
├── Domain/
│   ├── Todo.php                # Entity
│   └── TodoRepositoryInterface.php  # Interface (DIP)
├── Infrastructure/
│   └── InMemoryTodoRepository.php   # Concrete implementation (SRP)
├── Application/
│   └── TodoService.php         # Business logic (SRP, OCP)
└── Http/
    └── TodoController.php      # HTTP layer (ISP)
public/
└── index.php                   # Composition root
```

## Documentation Standard

PHPDoc on all classes, methods, and properties.

## Verification

```bash
composer require slim/slim slim/psr7
php -S localhost:3000 -t public &
curl -s -X POST http://localhost:3000/todos -H 'Content-Type: application/json' -d '{"title":"Buy milk"}'
curl -s http://localhost:3000/todos
kill %1
```
