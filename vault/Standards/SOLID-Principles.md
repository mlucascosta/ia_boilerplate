---
tags: [standards, solid, architecture]
---

# SOLID Principles

SOLID is a mandatory constraint on all implementation work. Refactor under SOLID before considering a task done.

## S — Single Responsibility

A class or module must have **one reason to change**.

```
✓ UserRepository — only handles user persistence
✓ AuthService — only handles authentication logic
✗ UserController — handles auth, validation, DB, and email
```

## O — Open/Closed

Open for extension, **closed for modification**.

Add behavior via new code (subclassing, composition, strategy) — not by modifying existing stable code.

## L — Liskov Substitution

Subtypes must be substitutable for their base types without changing program correctness.

If `class B extends A`, replacing `A` with `B` must not break callers of `A`.

## I — Interface Segregation

Prefer **small, role-specific interfaces** over large general ones.

Clients must not depend on methods they don't use.

```
✓ Readable, Writable, Closeable (separate)
✗ FileHandler with read, write, close, encrypt, compress (single fat interface)
```

## D — Dependency Inversion

High-level modules must not depend on low-level modules. Both depend on **abstractions**.

Inject dependencies — don't instantiate them inside business logic.

```
✓ class OrderService(repo: OrderRepository)  ← interface
✗ class OrderService() { this.repo = new PostgresRepo() }
```

## Checklist Before Marking Work Done

- [ ] Each class/module has one reason to change
- [ ] New behavior is added without modifying stable code
- [ ] Interfaces are narrow and role-specific
- [ ] Dependencies are injected, not created internally
- [ ] Tests cover behavior, not implementation details
