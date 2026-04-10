---
tags: [standards, tdd, testing]
---

# TDD Standards

Test-Driven Development is the **default delivery mode** for all behavioral changes.

## The Rules

1. **Write the test first** — before any production code
2. **Run the test** — it must fail (proves the test is real)
3. **Write the minimum code** to make it pass
4. **Refactor** under green — keep SOLID constraints
5. **Cover by risk** — unit + integration + E2E where justified

## Coverage by Delivery Risk

| Risk Level | Required Coverage |
|---|---|
| Trivial (copy, label, config) | V0 — reasoning only, no tests required |
| Focused (bug, single endpoint) | V1 — unit tests for changed behavior |
| Full (feature, auth, billing, infra) | V2 — unit + integration |
| User-facing or system-critical | V3 — unit + integration + E2E evidence |

## Anti-Patterns

- ❌ Implement first, add tests later
- ❌ Tests that only assert `true`
- ❌ Mocking everything with no real behavior tested
- ❌ Skipping tests for "simple" changes
- ❌ Testing implementation details instead of behavior

## Test Naming Convention

Tests must describe observable behavior, not method names:

```
✓ it should return 404 when the user does not exist
✓ it should reject the payment when the card is expired
✗ test_get_user
✗ test_payment_method
```

## Running Tests via RTK

Always prefix test runners with `rtk`:

```sh
rtk cargo test          # Rust — failures only (-90% tokens)
rtk pytest              # Python — failures only (-90%)
rtk go test             # Go — NDJSON, failures only (-90%)
rtk vitest run          # Vitest — failures only
rtk playwright test     # E2E — failures only
rtk rspec               # Ruby — compact JSON output
```
