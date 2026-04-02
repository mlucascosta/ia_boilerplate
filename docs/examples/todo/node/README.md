# Todo API — Node.js / Express

Demonstrates the IA Boilerplate workflow applied to a Node.js REST API.

## Workflow Artifacts

| Artifact | Purpose |
|---|---|
| `.planning/STATE.md` | Current objective and next step |
| `.planning/plans/todo-api-PLAN.md` | Atomic plan with scope, constraints, done criteria |
| `.planning/verification/todo-api-VERIFICATION.md` | Test results log |

## Architecture (SOLID)

```
src/
├── repositories/TodoRepository.js    # Interface (DIP)
├── repositories/InMemoryTodoRepo.js  # Concrete implementation (SRP)
├── services/TodoService.js           # Business logic (SRP, OCP)
├── routes/todos.js                   # HTTP layer (ISP)
└── app.js                            # Composition root
```

## Code

See the source files in this directory. Every exported function and class has complete JSDoc.

## Verification

```bash
node src/app.js &
curl -s -X POST http://localhost:3000/todos -H 'Content-Type: application/json' -d '{"title":"Buy milk"}'
curl -s http://localhost:3000/todos
kill %1
```

## Handoff

```md
**Objective:** Todo CRUD API with repository pattern.
**Changed Files:** src/repositories/, src/services/, src/routes/, src/app.js
**Checks Run:** manual curl — 201 on POST, 200 on GET with created record.
**Next Action:** Add persistence layer replacing InMemoryTodoRepo.
```
