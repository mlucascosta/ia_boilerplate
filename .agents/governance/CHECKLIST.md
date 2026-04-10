# Governance Checklist

Use this checklist during PR audit and architectural review.

## Boundaries

- [ ] Domain does not import infrastructure or delivery frameworks.
- [ ] Application does not depend on presentation.
- [ ] Infrastructure depends inward.
- [ ] No alternate normative layer was introduced outside `.agents/`.

## DDD

- [ ] Value Objects are immutable and validated on creation.
- [ ] Controllers and repositories do not hold core domain invariants.
- [ ] Entities expose behavior where the model requires it.
- [ ] Ubiquitous language remains coherent.

## SOLID

- [ ] High-level code depends on abstractions, not infrastructure concretes.
- [ ] Constructor dependency count does not suggest obvious responsibility overload.
- [ ] Oversized interfaces were reviewed for cohesion.
- [ ] Type/state branching in domain logic was evaluated.

## Tests

- [ ] Behavioral changes appear covered by tests.
- [ ] Unit tests do not use real IO.
- [ ] Test design focuses on behavior, not internals.
- [ ] Integration tests are realistic where infrastructure behavior matters.
- [ ] E2E remains proportional to system risk.

## Delivery Layer

- [ ] Controllers remain thin.
- [ ] ViewModels do not couple to concrete UI elements.
- [ ] Presentation formatting remains presentation-only.

## Governance

- [ ] Findings are evidence-based.
- [ ] No `fail` was emitted without direct evidence.
- [ ] Merge impact classification is proportional.
- [ ] Score is treated as auxiliary.

## RTK

- [ ] Shell guidance respects mandatory RTK usage.
- [ ] No raw command is recommended when RTK equivalent exists.
