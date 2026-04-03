# Agent Centralization Migration Plan
## File-by-File Technical Migration Strategy

## 1. Purpose

This document provides the operational migration plan for moving the repository from a distributed runtime-specific instruction model to a centralized `.agents/` architecture.

It is intended to be implementation-facing.

This document answers:

- what moves
- what gets reduced
- what becomes generated
- what must be preserved
- what the ideal commit sequence looks like

---

## 2. Migration Objective

The migration aims to achieve the following:

- centralize all meaningful agent behavior in `.agents/`
- eliminate semantic duplication across runtime directories
- preserve runtime compatibility
- preserve engineering quality defaults
- preserve cross-runtime workflow support
- encode TDD, layered tests, SOLID, Agile + PMBOK, and Git Flow centrally

---

## 3. Migration Constraints

The migration must preserve the following repository properties:

- current repository workflow identity
- planning and artifact-driven continuity
- runtime compatibility for Claude, Codex, and Copilot
- documentation-first orientation
- Git Flow
- engineering discipline

The migration must not:

- break runtime discovery without replacement
- create a second source of truth
- regress test policy
- weaken architectural constraints

---

## 4. Current-to-Target Mapping

## 4.1 Canonical instruction sources

### Current
- `AGENTS.md`
- `CLAUDE.md`
- `.github/copilot-instructions.md`
- `.codex/skills/...`

### Target
- `.agents/AGENTS.md`
- `.agents/adapters/claude.md`
- `.agents/adapters/codex.md`
- `.agents/adapters/copilot.md`

Wrappers remain, but only as compatibility surfaces.

---

## 4.2 Agent definitions

### Current
- `.claude/agents/...`
- `.codex/agents/...`

### Target
- `.agents/agents/...`

A single canonical copy per agent.

---

## 4.3 Runtime-specific command or skill entrypoints

### Current
- `.codex/skills/...`
- `.claude/commands/...`

### Target
- `.agents/skills/...`
- generated runtime-facing shells as needed

---

## 4.4 Shared prompt fragments

### Current
- embedded in multiple agent or adapter files

### Target
- `.agents/prompts/templates/`
- `.agents/prompts/fragments/`

---

## 5. Migration Phases

## Phase 1 — Introduce `.agents/`

### Goal
Create the new structure without breaking existing behavior.

### Actions
- create `.agents/`
- create `.agents/AGENTS.md`
- create `.agents/manifest.json`
- create `adapters/`, `skills/`, `agents/`, `prompts/`, `schemas/`, and `scripts/`

### Output
A visible central architecture scaffold exists.

### Suggested commit
`chore(agents): introduce centralized .agents architecture scaffold`

---

## Phase 2 — Move Canonical Policy

### Goal
Move normative behavior into `.agents/AGENTS.md`.

### Actions
- inspect current `AGENTS.md`
- move all normative policy into `.agents/AGENTS.md`
- preserve:
  - read budget
  - workflow references
  - path selection
  - output rules
  - verification model
- add centrally:
  - TDD by default
  - tests-first rule
  - SOLID expectations
  - layered testing requirements
  - Git Flow rules
  - Agile + PMBOK distinction

### Output
`.agents/AGENTS.md` becomes the central contract.

### Suggested commit
`refactor(agents): move normative workflow policy into .agents/AGENTS.md`

---

## Phase 3 — Extract Runtime Semantics

### Goal
Reduce runtime files to minimal compatibility surfaces.

### Actions
- inspect `CLAUDE.md`
- inspect `.github/copilot-instructions.md`
- inspect `.codex/skills/...`
- extract genuine runtime-only nuances
- move those nuances into:
  - `.agents/adapters/claude.md`
  - `.agents/adapters/codex.md`
  - `.agents/adapters/copilot.md`

### Output
Runtime differences exist, but no longer own the workflow.

### Suggested commit
`refactor(adapters): centralize runtime-specific semantics under .agents/adapters`

---

## Phase 4 — Consolidate Duplicated Agents

### Goal
Move duplicated agent definitions into one location.

### Actions
- compare `.claude/agents/*` against `.codex/agents/*`
- identify canonical behavior
- create runtime-neutral agent files in `.agents/agents/`
- remove semantic duplication from runtime-specific copies

### Output
Each agent has one canonical source.

### Suggested commit
`refactor(agents): consolidate duplicated runtime agent definitions`

---

## Phase 5 — Extract Shared Skills

### Goal
Reorganize workflow behavior into reusable capability modules.

### Actions
- define:
  - `workflow-core`
  - `discuss-phase`
  - `plan-phase`
  - `execute-phase`
  - `verify-phase`
  - `quick-task`
  - `docs-update`
  - `review`
- move relevant operational instructions into those skills
- make them runtime-neutral
- encode test-first and Git Flow expectations in relevant skills

### Output
The architecture becomes skills-first.

### Suggested commit
`feat(skills): introduce centralized workflow skills under .agents/skills`

---

## Phase 6 — Introduce Shared Prompt Fragments

### Goal
Reduce instruction repetition across skills and agents.

### Actions
- extract repeated text into prompt fragments
- create reusable templates
- normalize phrasing for:
  - test-first
  - verification levels
  - Git Flow
  - artifact update rules
  - minimal diff behavior

### Output
Centralized prompt fragments improve consistency.

### Suggested commit
`refactor(prompts): introduce reusable fragments for central workflow behavior`

---

## Phase 7 — Implement Runtime Shim Generation

### Goal
Make runtime-facing files derived artifacts.

### Actions
- create `generate-runtime-shims.sh`
- create `sync-runtime-adapters.sh`
- generate:
  - `.claude/CLAUDE.md`
  - `.codex/skills/project-workflow/SKILL.md`
  - `.github/copilot-instructions.md`
- ensure wrappers are minimal and point back to `.agents/`

### Output
Runtime shells become compatibility-only.

### Suggested commit
`build(runtime): generate runtime shims from centralized .agents architecture`

---

## Phase 8 — Add Validation

### Goal
Prevent architectural regression.

### Actions
- create `validate-agents.sh`
- validate:
  - manifest integrity
  - declared skills exist
  - declared agents exist
  - generated wrappers match checked-in versions
  - wrappers remain minimal
  - no semantic duplication outside `.agents/`

### Output
Centralization becomes enforceable.

### Suggested commit
`ci(agents): validate centralized agent architecture and generated wrappers`

---

## Phase 9 — Update Documentation

### Goal
Reflect the new architecture publicly.

### Actions
- update README
- add architecture docs
- describe `.agents/` as source of truth
- describe runtime wrappers as compatibility-only
- document engineering defaults
- document Git Flow and testing model

### Output
Documentation matches reality.

### Suggested commit
`docs(architecture): document centralized .agents operating model`

---

## 6. File-by-File Migration Table

| Current Path | Target Action | Target Path | Notes |
|---|---|---|---|
| `AGENTS.md` | Move semantics | `.agents/AGENTS.md` | Top-level may remain as thin pointer if needed |
| `CLAUDE.md` | Reduce to wrapper | generated or minimal `CLAUDE.md` | Real Claude semantics go to `.agents/adapters/claude.md` |
| `.github/copilot-instructions.md` | Reduce to wrapper | generated shim | Real Copilot semantics go to `.agents/adapters/copilot.md` |
| `.codex/skills/*/SKILL.md` | Reduce to wrapper | generated Codex skill shim | Real semantics move to `.agents/skills/workflow-core/SKILL.md` |
| `.claude/agents/*` | Consolidate | `.agents/agents/*` | Runtime-neutral canonical files |
| `.codex/agents/*` | Consolidate | `.agents/agents/*` | Runtime-neutral canonical files |
| embedded repeated text | Extract | `.agents/prompts/fragments/*` | Improves consistency |
| runtime-generation logic | Add | `.agents/scripts/*` | Supports compatibility without duplication |

---

## 7. Legacy Surface Strategy

Not all legacy runtime directories need to be physically deleted immediately.

Recommended treatment:

### Keep physically, reduce semantically
Use when runtime discovery depends on those files.

### Remove only after generator is proven
Delete only once runtime compatibility is validated.

### Never keep them as normative
Even if they physically remain, they must not carry real workflow semantics.

---

## 8. Engineering Defaults to Encode During Migration

The migration must explicitly add the following defaults to the central contract.

## 8.1 TDD
Behavioral changes start from tests.

## 8.2 Tests-first implementation
Tests are written before production classes, functions, handlers, or modules.

## 8.3 Layered testing
Use unit, integration, and E2E tests proportionally to risk.

## 8.4 SOLID
Preserve low coupling, high cohesion, and clear boundaries.

## 8.5 Hybrid Agile + PMBOK
Separate governance artifacts from execution artifacts.

## 8.6 Git Flow
Use `develop` as the default base for feature branches.

---

## 9. Suggested Commit Sequence

A safe sequence is:

1. `chore(agents): introduce centralized .agents architecture scaffold`
2. `refactor(agents): move normative workflow policy into .agents/AGENTS.md`
3. `refactor(adapters): centralize runtime-specific semantics under .agents/adapters`
4. `refactor(agents): consolidate duplicated runtime agent definitions`
5. `feat(skills): introduce centralized workflow skills under .agents/skills`
6. `refactor(prompts): introduce reusable fragments for central workflow behavior`
7. `build(runtime): generate runtime shims from centralized .agents architecture`
8. `ci(agents): validate centralized agent architecture and generated wrappers`
9. `docs(architecture): document centralized .agents operating model`

---

## 10. Example Migration Slice

Suppose the repository currently has:

- `.claude/agents/gsd-advisor-researcher.md`
- `.codex/agents/gsd-advisor-researcher.md`

The migration flow should be:

1. compare both files
2. identify common semantic body
3. create `.agents/agents/advisor-researcher.md`
4. reduce runtime-specific copies to:
   - generated versions
   - or remove them if runtime shim generation handles discovery
5. validate output behavior remains equivalent

This process should be repeated for each duplicated agent.

---

## 11. Validation Gates After Each Phase

Each migration phase should pass three questions:

### Structural
Does the central source exist and is it correctly organized?

### Semantic
Was real behavior moved to `.agents/`, not just copied?

### Compatibility
Can supported runtimes still discover the repository behavior?

No phase should proceed without all three.

---

## 12. Risk Management

### Risk: breaking runtime discovery
Mitigation:
- do not delete wrappers before generated replacements exist

### Risk: partial centralization
Mitigation:
- fail CI if normative behavior remains outside `.agents/`

### Risk: weak engineering contract
Mitigation:
- explicitly encode TDD, layered tests, SOLID, Git Flow, and governance rules in `.agents/AGENTS.md` and related skills

### Risk: overcomplication
Mitigation:
- centralize only what carries semantics
- keep wrappers minimal
- prefer capability-based skills over sprawling command trees

---

## 13. Completion Criteria

The migration is complete when all of the following are true:

- `.agents/` is the only normative source
- runtime wrappers are minimal
- duplicated agents are eliminated
- skills are centralized
- manifest exists and is validated
- CI enforces wrapper minimality and no drift
- engineering defaults are centrally encoded
- documentation matches the implemented architecture

---

## 14. Final Rule

> A migration step is not considered complete unless it both moves semantics into `.agents/` and removes semantic ownership from the legacy runtime surfaces.
