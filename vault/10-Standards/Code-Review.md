---
tags: [standards, code-review]
---

# Code Review Standards

## Before Requesting Review

Every PR author must verify:

- [ ] All tests pass: `rtk cargo test` / `rtk pytest` / `rtk go test`
- [ ] Linter is clean: `rtk lint` / `rtk cargo clippy` / `rtk ruff check`
- [ ] Types are valid: `rtk tsc` (TypeScript projects)
- [ ] No hardcoded secrets
- [ ] Branch follows Git Flow (`feature/*`, `fix/*`, `release/*`, `hotfix/*`)
- [ ] Commit messages follow Conventional Commits

## Review Dimensions

### 1. Correctness
Does the code do what the requirement says — for all inputs, including edge cases?

### 2. Test Coverage
Is the changed behavior tested? Are the tests meaningful?

### 3. Security
- Input validated at system boundaries
- Parameterized queries (no SQL injection)
- Output sanitized (no XSS)
- Auth checks in place
- No sensitive data logged

### 4. Design (SOLID)
- Single responsibility per module
- Narrow interfaces, dependency injection
- Closed for modification, open for extension

### 5. Readability
- Names describe intent
- No surprising side effects
- Functions are short and focused

## Review Verdicts

| Verdict | Meaning |
|---|---|
| **APPROVE** | Ready to merge |
| **COMMENT** | Merge allowed, items to address in follow-up |
| **REQUEST CHANGES** | Do not merge until issues are fixed |

## PR Size Guidelines

- Target PRs under 400 lines changed
- Large PRs must be split unless structurally impossible
- Each PR delivers one atomic, logically complete change
