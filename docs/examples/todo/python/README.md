# Todo API — Python / FastAPI

Demonstrates the IA Boilerplate workflow applied to a Python REST API.

## Workflow Artifacts

Same planning structure as all other stacks — the workflow is language-agnostic.

| Artifact | Purpose |
|---|---|
| `.planning/STATE.md` | Current objective and next step |
| `.planning/plans/todo-api-PLAN.md` | Atomic plan |
| `.planning/verification/todo-api-VERIFICATION.md` | Test results |

## Architecture (SOLID)

```
app/
├── repositories/
│   ├── todo_repository.py      # Abstract base (DIP)
│   └── in_memory_todo_repo.py  # Concrete implementation (SRP)
├── services/
│   └── todo_service.py         # Business logic (SRP, OCP)
├── routes/
│   └── todos.py                # HTTP layer (ISP)
└── main.py                     # Composition root
```

## Documentation Standard

Google-style docstrings on all public classes and methods.

## Verification

```bash
pip install fastapi uvicorn
uvicorn app.main:app --port 3000 &
curl -s -X POST http://localhost:3000/todos -H 'Content-Type: application/json' -d '{"title":"Buy milk"}'
curl -s http://localhost:3000/todos
kill %1
```
