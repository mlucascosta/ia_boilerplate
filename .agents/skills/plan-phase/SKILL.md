---
name: plan-phase
description: Produce an executable plan for a bounded slice or phase.
---

# Purpose

Create a plan that an executor can implement without reinterpretation.

# Read First

- `.agents/AGENTS.md`
- `.agents/workflows/plan-phase.md`

# Use When

- Work is broader than trivial
- Tests, scope, or verification need explicit sequencing

# Output

- Bounded plan with test-first execution path

# Prohibitions

- No implementation before planning when the work is non-trivial
