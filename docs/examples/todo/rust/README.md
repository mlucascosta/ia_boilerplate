# Todo API — Rust / Actix-web

Demonstrates the IA Boilerplate workflow applied to a Rust REST API.

## Architecture (SOLID)

```
src/
├── domain.rs       # Entity + repository trait (DIP)
├── repository.rs   # In-memory implementation (SRP)
├── service.rs      # Business logic (SRP, OCP)
├── handler.rs      # HTTP handlers (ISP)
└── main.rs         # Composition root
```

## Documentation Standard

`///` rustdoc comments on all public items.

## Verification

```bash
cargo run &
curl -s -X POST http://localhost:3000/todos -H 'Content-Type: application/json' -d '{"title":"Buy milk"}'
curl -s http://localhost:3000/todos
kill %1
```
