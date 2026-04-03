# Legacy Project Adoption

Use this playbook when the workflow is being introduced into an existing codebase with undocumented behavior, uneven architecture, or missing tests.

## Goal

Add planning discipline and repository memory without forcing a rewrite of the system.

## Steps

1. Start with one bounded area, not the whole codebase.
2. Write `.planning/STATE.md` around the current problem, the affected module, and the next action.
3. Capture only the durable facts needed to work safely: architecture notes, integration constraints, and major risks.
4. Build a baseline roadmap that focuses on adoption slices such as mapping, guardrails, and one production-relevant change.
5. Create plans around real delivery work so the artifacts reflect actual pressure points instead of theoretical cleanup.
6. Document missing tests, ownership gaps, and unstable boundaries in `.planning/RISK_REGISTER.md` rather than hiding them in chat.
7. Prefer verification that matches current reality: smoke checks, narrow tests, or manual evidence when full automation does not exist yet.

## Minimum Viable Baseline

- current objective in `.planning/STATE.md`
- risk register entries for major unknowns
- one roadmap milestone for adoption
- one plan tied to a real feature, bug, or refactor

## Common Failure Modes

- Trying to backfill every missing doc before doing any delivery work.
- Creating a roadmap that mirrors the entire legacy system.
- Pretending the codebase has quality guarantees it does not actually have.