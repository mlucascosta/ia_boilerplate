# Governance Skills

These skills extend the repository agent contract with architectural audit behavior.

## Skill: Clean Architecture Audit

### Objective

Detect violations of dependency direction and boundary leakage.

### Hard Rules

- Domain must not import infrastructure frameworks or runtime delivery frameworks.
- Application must not depend on presentation.
- Infrastructure must not become the owner of domain rules.
- Adapters must depend inward, not the inverse.

### Heuristics

- Infrastructure files with business-heavy branching may indicate domain leakage.
- Controller-heavy orchestration may indicate use-case drift.

### Evidence

- imports
- concrete dependencies
- code placement
- repository structure

### Typical output

- `fail` if a hard dependency violation is direct
- `warning` if evidence suggests boundary erosion

---

## Skill: DDD Integrity Review

### Objective

Detect anemic models, mutable value objects, and broken ubiquitous language.

### Hard Rules

- Value Objects must be immutable.
- Value Objects must validate state on creation.
- Controllers and repositories must not host core domain invariants.

### Heuristics

- entities with only getters/setters and no behavior
- weak domain naming
- mutable aggregate internals exposed directly

---

## Skill: SOLID Review

### Objective

Review SRP, OCP, LSP, ISP, and DIP pragmatically.

### Hard Rules

- domain/application must not instantiate infrastructure services directly
- subtype methods must not break essential base contracts with `NotImplementedException` or equivalent misuse

### Heuristics

- too many constructor dependencies
- excessive branching by type/state in domain logic
- oversized interfaces
- test setup indicating excessive coupling

---

## Skill: TDD and Test Quality Review

### Objective

Check whether behavior changes are properly covered and whether unit tests remain isolated.

### Hard Rules

- unit tests must not depend on real IO

### Heuristics

- Behavior changes without corresponding test modifications may indicate incomplete coverage; flag for review.
- overly interaction-based tests
- excessive mocks
- generic test names
- tests validating implementation instead of behavior

---

## Skill: Controller Clean Review

### Objective

Keep controllers/adapters thin and delivery-oriented.

### Hard Rules

- controller must not own domain rules
- controller must not directly own persistence logic when a use case boundary is expected

### Heuristics

- too much orchestration in controller actions
- mapping logic too complex for the delivery layer

---

## Skill: MVVM Headless Review

### Objective

Ensure presentation state is not tightly coupled to concrete UI elements.

### Hard Rules

- viewmodels must not couple directly to concrete view artifacts
- viewmodels must not host domain invariants

### Heuristics

- direct widget manipulation
- local formatting complexity is acceptable if it remains presentation-only

---

## Skill: Integration Test Realism Review

### Objective

Detect fake integration tests that do not reflect real infrastructure behavior.

### Hard Rules

- integration tests for relational persistence must not rely on fake providers that erase real behavior differences

### Heuristics

- no failure-path testing
- no transaction rollback checks
- shared state between tests

---

## Skill: E2E Minimalism Review

### Objective

Keep E2E proportional and focused on critical journeys.

### Heuristics

- too many E2E tests for local logic
- validating domain details through UI that belong in unit/integration layers
- long suite duration without clear value

---

## Skill: Full Audit Aggregator

### Objective

Aggregate applicable findings into a standardized report.

### Rules

- deduplicate same-evidence findings
- prioritize direct evidence over style concerns
- use `.agents/governance/REVIEW_OUTPUT_TEMPLATE.md`
- treat score as auxiliary only
