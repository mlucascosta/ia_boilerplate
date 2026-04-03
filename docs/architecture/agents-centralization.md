# Technical Architecture Specification

## Centralized Agent Operating Model for `ia_boilerplate`

## 1. Executive Summary

This document defines the target architecture for evolving `ia_boilerplate` into a fully centralized, repository-level AI workflow system where all agent behavior, skills, runtime adapters, prompts, and operational rules are managed from a single source of truth: `.agents/`.

The current repository already establishes a cross-runtime workflow model for multiple AI runtimes, including Claude, Codex, and Copilot. It also already emphasizes repository artifacts as durable operational memory instead of relying on transient chat context. However, parts of the current design are still distributed across runtime-specific locations such as `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.codex/skills/...`, `.claude/agents/...`, and `.codex/agents/...`.

The objective of this redesign is to replace that distributed model with a centralized architecture that is:

* runtime-agnostic at its core
* skill-first rather than command-first
* compatible with Claude, Codex, Copilot, and future runtimes
* aligned with GSD-style operating patterns
* technically enforceable
* easier to maintain
* less prone to drift
* explicitly grounded in TDD, SOLID, layered testing, Git Flow, and hybrid Agile + PMBOK governance

This is not a cosmetic reorganization. It is a structural operating model change.

---

## 2. Background and Context

The repository already presents itself as a cross-AI workflow bootstrap focused on repository-level execution rules, planning artifacts, workflow discipline, and adapter-based runtime compatibility.

That current model has several strengths:

* a canonical workflow contract
* a canonical artifact contract
* planning and execution artifacts under `.planning/`
* runtime support for multiple AI tools
* strong emphasis on documentation as operational memory
* an explicit quality bar
* explicit concern with predictable delivery

At the same time, the current structure still reflects a partially distributed runtime architecture. The workflow intent is centralized, but some of the executable policy remains duplicated across runtime surfaces.

This conversation introduced a stronger goal:

1. move all runtime intelligence into `.agents/`
2. remove semantic duplication between `.claude`, `.codex`, and `.github`
3. treat runtime-specific directories as thin compatibility shells only
4. use the `get-shit-done` project as a conceptual base for skills and agent orchestration
5. avoid over-reliance on many runtime-specific commands
6. preserve and strengthen engineering discipline:

   * TDD by default
   * tests first, implementation second
   * unit, integration, and E2E testing proportional to risk
   * SOLID-oriented design
   * hybrid Agile + PMBOK delivery
   * Git Flow with `develop` as the base branch for feature work

The result is a centralized, repository-native operating system for AI-assisted software delivery.

---

## 3. Problem Statement

The current architecture has four major structural weaknesses.

### 3.1 Semantic duplication across runtimes

Equivalent logic exists in multiple places with only format-level differences. This increases maintenance cost and creates drift risk.

For example, an agent may exist in both Claude-specific and Codex-specific directories, even though the actual responsibilities and instructions are largely the same.

### 3.2 Runtime-first organization

The system is still too organized around where a runtime expects files, rather than around what the repository itself needs as the real workflow contract.

This makes the repository behave as if Claude, Codex, or Copilot were the primary owners of the workflow, when in reality the repository should own the workflow and runtimes should merely consume it.

### 3.3 Weak normalization of agent and skill behavior

There is no single canonical place where agent skills, operational contracts, and runtime mapping are fully governed together.

### 3.4 GSD inspiration is present but not fully internalized

The repository already aligns conceptually with GSD on durable state, phases, artifact-driven execution, and strong operational constraints, but does not yet fully adopt a clean skill-based internal architecture.

---

## 4. Architectural Goal

The target architecture is defined by one central rule:

**All normative behavior for agents, skills, prompts, adapter semantics, and workflow contracts must live exclusively in `.agents/`.**

All runtime-specific surfaces outside `.agents/` must be treated as:

* generated
* minimal
* disposable
* non-normative
* compatibility-only

This means the repository itself becomes the owner of the AI workflow system, and runtimes simply become consumers of generated or minimal compatibility surfaces.

---

## 5. Design Principles

### 5.1 Single Source of Truth

All meaningful agent behavior must be stored in one place only: `.agents/`.

### 5.2 Runtime Compatibility, Not Runtime Ownership

Claude, Codex, Copilot, and similar runtimes may require certain files for discovery, but they must not become the canonical owners of the workflow.

### 5.3 Skills First

The repository should be organized around reusable capabilities such as discuss, plan, execute, verify, review, and documentation, rather than around a command tree tied to a specific runtime.

### 5.4 Agents as Reusable Building Blocks

Specialized agents should be defined once and reused by multiple runtime environments.

### 5.5 Zero Semantic Duplication

Different wrappers may exist for technical compatibility, but policy or behavior must not be duplicated.

### 5.6 Engineering Discipline Is Mandatory

This is not only a prompt architecture. It is an engineering operating model. TDD, SOLID, layered testing, Git Flow, and hybrid governance are not optional recommendations; they are mandatory system defaults.

### 5.7 GSD-Inspired, Not GSD-Copied

The system should adopt the strongest ideas from GSD without inheriting unnecessary command sprawl or runtime-specific complexity.

---

## 6. Target Repository Structure

The recommended target structure is:

```text
.agents/
├── AGENTS.md
├── manifest.json
├── adapters/
│   ├── claude.md
│   ├── codex.md
│   ├── copilot.md
│   └── gsd.md
├── skills/
│   ├── workflow-core/
│   │   └── SKILL.md
│   ├── discuss-phase/
│   │   └── SKILL.md
│   ├── plan-phase/
│   │   └── SKILL.md
│   ├── execute-phase/
│   │   └── SKILL.md
│   ├── verify-phase/
│   │   └── SKILL.md
│   ├── quick-task/
│   │   └── SKILL.md
│   ├── docs-update/
│   │   └── SKILL.md
│   └── review/
│       └── SKILL.md
├── agents/
│   ├── advisor-researcher.md
│   ├── planner.md
│   ├── executor.md
│   ├── verifier.md
│   ├── doc-writer.md
│   └── doc-verifier.md
├── prompts/
│   ├── system/
│   ├── templates/
│   └── fragments/
├── schemas/
│   ├── agent.schema.json
│   ├── skill.schema.json
│   └── manifest.schema.json
└── scripts/
    ├── sync-runtime-adapters.sh
    ├── generate-runtime-shims.sh
    └── validate-agents.sh
```

This structure separates concerns clearly:

* policy lives in `AGENTS.md`
* inventory and orchestration metadata live in `manifest.json`
* runtime-specific differences live in `adapters/`
* reusable capabilities live in `skills/`
* reusable subagents live in `agents/`
* reusable fragments live in `prompts/`
* schemas live in `schemas/`
* automation lives in `scripts/`

---

## 7. Core Components

## 7.1 `.agents/AGENTS.md`

This becomes the canonical system contract.

It must define:

* source-of-truth policy
* read budget
* path selection behavior
* output contract
* verification levels
* artifact update rules
* engineering defaults
* branching model
* hard prohibitions

It replaces the role of the current top-level `AGENTS.md` as the real normative source.

A typical high-level structure would include:

```md
# Repository Agent Contract

## Source of truth
Follow this file first, then the canonical workflow docs.

## Read budget
Read only the minimum required artifacts and code context.

## Path selection
Choose Trivial, Focused, or Full based on scope and risk.

## Engineering defaults
- TDD by default
- Tests first
- SOLID design
- Layered validation proportional to risk

## Git strategy
- Git Flow is mandatory
- `develop` is the base for feature work

## Verification
Use V0, V1, V2, or V3 proportional to risk.

## Hard prohibitions
- no full repository scan without reason
- no runtime-specific workflow invention
- no implementation-first as the default for behavior changes
```

---

## 7.2 `.agents/manifest.json`

This is the machine-readable map of the operating system.

It should declare:

* architecture version
* supported runtimes
* skills inventory
* agents inventory
* generated wrapper targets
* validation expectations

Example:

```json
{
  "version": "2.0.0-agent-core",
  "sourceOfTruth": ".agents",
  "supportedRuntimes": ["claude", "codex", "copilot"],
  "skills": [
    "workflow-core",
    "discuss-phase",
    "plan-phase",
    "execute-phase",
    "verify-phase",
    "quick-task",
    "docs-update",
    "review"
  ],
  "agents": [
    "advisor-researcher",
    "planner",
    "executor",
    "verifier",
    "doc-writer",
    "doc-verifier"
  ],
  "generatedTargets": [
    ".claude/CLAUDE.md",
    ".codex/skills/project-workflow/SKILL.md",
    ".github/copilot-instructions.md"
  ]
}
```

---

## 7.3 `.agents/adapters/`

These files capture only real runtime-specific differences.

They must never restate the full workflow or become shadow sources of truth.

### `claude.md`

Use only for details genuinely specific to Claude runtime consumption.

### `codex.md`

Use only for Codex skill expectations, format nuances, and runtime notes.

### `copilot.md`

Use only for repository instruction behavior relevant to Copilot.

### `gsd.md`

Use for documenting how GSD concepts are incorporated into this repository architecture.

---

## 7.4 `.agents/skills/`

This is the functional heart of the system.

Skills define reusable capabilities, not runtime entrypoints.

### `workflow-core`

The foundational skill. It defines the universal model.

### `discuss-phase`

Captures user intent, implementation preferences, gray areas, and pre-planning decisions.

### `plan-phase`

Creates bounded implementation plans, test strategy, and verification expectations.

### `execute-phase`

Performs implementation in constrained slices with explicit validation behavior.

### `verify-phase`

Checks completion, quality, and evidence.

### `quick-task`

Provides a reduced-overhead path for small tasks without collapsing discipline.

### `docs-update`

Handles documentation updates that reflect durable changes.

### `review`

Provides review, audit, and cross-check behavior.

---

## 7.5 `.agents/agents/`

These are reusable specialized subagents.

Each agent should have one responsibility and must be runtime-neutral.

Examples:

### `advisor-researcher.md`

Researches a single uncertainty and returns structured comparisons.

### `planner.md`

Turns a bounded request into an implementation-ready plan.

### `executor.md`

Applies a focused implementation slice within a bounded scope.

### `verifier.md`

Checks outcomes, evidence, and behavioral correctness.

### `doc-writer.md`

Updates persistent documentation.

### `doc-verifier.md`

Checks documentation integrity and alignment.

---

## 7.6 `.agents/prompts/`

This directory contains reusable text fragments, templates, and structured system prompt components.

Examples:

* a verification levels fragment
* a minimal-diff fragment
* a telegraphic state update fragment
* a conditional recommendations fragment
* a Git Flow constraints fragment

The benefit is consistency and easier maintenance.

---

## 7.7 `.agents/scripts/`

These scripts enforce centralization.

### `generate-runtime-shims.sh`

Generates runtime wrappers for Claude, Codex, Copilot, or any additional supported runtime.

### `sync-runtime-adapters.sh`

Ensures the runtime shells match the central architecture.

### `validate-agents.sh`

Validates:

* manifest integrity
* skill presence
* agent presence
* wrapper minimality
* no semantic duplication outside `.agents/`

---

## 8. Runtime Strategy

## 8.1 General Rule

Runtime-specific directories must not be trusted as source-of-truth locations.

They may exist physically, but only as minimal compatibility layers.

## 8.2 Claude

A generated minimal wrapper might look like:

```md
# Runtime shim for Claude

Follow `.agents/AGENTS.md`.

Runtime-specific notes:
- See `.agents/adapters/claude.md`
- Shared skills live in `.agents/skills/`
- Shared agents live in `.agents/agents/`
```

## 8.3 Codex

A generated minimal Codex skill might look like:

```md
---
name: project-workflow
description: Minimal Codex shim that delegates to .agents
---

Follow `.agents/AGENTS.md`.
Runtime specifics: `.agents/adapters/codex.md`
Primary shared skill: `.agents/skills/workflow-core/SKILL.md`
```

## 8.4 Copilot

A minimal wrapper might look like:

```md
# Runtime shim for Copilot

Follow `.agents/AGENTS.md`.
Runtime-specific notes: `.agents/adapters/copilot.md`
Do not treat this file as a source of truth.
```

---

## 9. Should Runtime Directories Be Deleted?

The answer is: not blindly.

If a runtime depends on those files for discovery, fully deleting them can break native usability.

So the recommended approach is:

* remove their intelligence
* keep them minimal
* preferably generate them
* treat them as disposable compatibility shells

This preserves runtime support without allowing those directories to become a second source of truth.

---

## 10. GSD Integration Strategy

The repository should absorb GSD conceptually, not mechanically.

## 10.1 What to adopt

The following GSD ideas should be internalized:

* durable state in repository artifacts
* phased work
* discuss → plan → execute → verify loops
* bounded plans
* subagent specialization
* fresh-context execution
* strong verification
* artifact-driven continuity

## 10.2 What not to clone directly

The repository should avoid unnecessary inheritance of:

* very large command surfaces
* runtime-coupled command trees
* complexity not required by the repository's own scope

## 10.3 Resulting model

The repository becomes **GSD-inspired** in operating model, but retains its own identity and simpler runtime surface.

---

## 11. Engineering Quality Model

This architecture must explicitly preserve and strengthen engineering discipline.

That includes:

* TDD
* test-first implementation
* SOLID-oriented design
* layered test coverage
* hybrid Agile + PMBOK governance
* Git Flow

These are not optional project preferences. They become mandatory architectural defaults.

---

## 12. TDD as a Mandatory Default

For any behavioral change, the default sequence must be:

1. define expected behavior
2. write the test first
3. run the test and confirm failure
4. implement the minimum solution
5. refactor while preserving green state
6. validate across the required layers

Implementation-first followed by "coverage later" is not the default path.

### Example

Bad default:

```text
Implement service -> add tests later
```

Required default:

```text
Write failing unit test -> implement service -> refactor -> run integration/E2E if required
```

---

## 13. Layered Testing Model

The system must preserve a layered testing strategy proportional to change risk.

## 13.1 Unit tests

Used for isolated rules, services, validators, pure functions, mappers, and domain behavior.

Example:

* validating a pricing calculation service
* verifying a permission evaluator
* checking slug normalization logic

## 13.2 Integration tests

Used for interactions between modules or infrastructure boundaries.

Example:

* repository + database
* service + queue adapter
* API handler + persistence
* application service + external gateway abstraction

## 13.3 E2E tests

Used for full functional flows or user-critical behaviors.

Example:

* user login flow
* checkout flow
* tenant onboarding flow
* agent execution lifecycle with real planning artifact interactions

## 13.4 Risk proportionality

Not every change requires all three layers, but all changes must be verified proportionally.

### Example matrix

A local pure-function fix:

* unit only may be sufficient

A service that reads and writes persistence:

* unit + integration

A critical authentication change:

* unit + integration + E2E

---

## 14. SOLID as a Structural Contract

All implementation must be guided by SOLID-oriented architecture.

This means:

* clear responsibility boundaries
* separation between domain and infrastructure
* low coupling
* high cohesion
* extensions through composition or abstraction rather than uncontrolled modification
* no large procedural accumulation in handlers or services
* no infrastructure leakage into core rules

### Example

Bad structure:

```ts
class UserController {
  async createUser(req, res) {
    // validate input
    // hash password
    // write to DB
    // send email
    // create audit log
    // generate token
  }
}
```

Better structure:

```ts
class CreateUserController {
  constructor(private readonly createUserUseCase: CreateUserUseCase) {}

  async handle(req, res) {
    const result = await this.createUserUseCase.execute(req.body);
    return res.status(201).json(result);
  }
}
```

```ts
class CreateUserUseCase {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly passwordHasher: PasswordHasher,
    private readonly emailSender: EmailSender,
    private readonly auditLogger: AuditLogger
  ) {}

  async execute(input: CreateUserInput): Promise<CreateUserOutput> {
    // domain-driven orchestration
  }
}
```

---

## 15. Hybrid Agile + PMBOK Governance

The system must preserve a hybrid delivery model.

## 15.1 Agile side

Agile governs:

* incremental slices
* short feedback loops
* adaptive planning
* iterative execution
* feature-focused delivery

## 15.2 PMBOK side

PMBOK-style governance governs:

* scope control
* risk tracking
* dependency visibility
* milestone orientation
* documentation and traceability
* execution discipline at project level

## 15.3 Separation rule

Governance artifacts and execution artifacts must remain distinct.

Examples:

Governance-oriented artifacts:

* roadmap
* milestone definitions
* architectural decisions
* scope boundaries
* risk tracking

Execution-oriented artifacts:

* active state
* plan files
* summaries
* verification evidence

The centralized agent system must respect this distinction.

---

## 16. Git Flow Is Mandatory

Git Flow must be formally enforced.

The repository already conceptually references Git Flow, but the new architecture must operationalize it clearly.

## 16.1 Main branches

### `main`

Stable, production-grade, or releasable state.

No everyday feature work should be developed directly on `main`.

### `develop`

Default integration branch for ongoing development.

All feature work must branch from `develop`.

## 16.2 Supporting branches

### `feature/*`

Used for bounded new work, improvements, or refactors.

Rules:

* branch from `develop`
* merge back into `develop`

Examples:

* `feature/agents-centralization`
* `feature/test-first-execute-phase`
* `feature/gitflow-validation`

### `release/*`

Used for stabilization before publishing.

Rules:

* branch from `develop`
* used for final adjustments, versioning, release preparation
* merged into `main`
* merged back into `develop`

Example:

* `release/v2.0.0`

### `hotfix/*`

Used for urgent production corrections.

Rules:

* branch from `main`
* merged into `main`
* merged back into `develop`

Example:

* `hotfix/runtime-wrapper-regression`

## 16.3 Core branching rule

All normal feature development must begin from `develop`.

That rule should be enforced by documentation, review, and automation where possible.

---

## 17. Verification Levels

The verification model should be formalized as follows.

### `V0`

Reasoning-only. Allowed only for truly trivial, non-behavioral, local changes.

### `V1`

Targeted validation. Usually unit-level or one bounded check.

### `V2`

Multi-check validation. Typically unit + integration, or equivalent.

### `V3`

Full behavioral validation. Used when risk warrants unit + integration + E2E.

### Example

A text-only typo fix in docs:

* `V0`

A helper function logic fix:

* `V1`

A persistence-related feature change:

* `V2`

An authentication or billing flow change:

* `V3`

---

## 18. Skill Design Contract

Every skill should follow a standard structure.

Example:

```md
---
name: plan-phase
description: Creates an atomic implementation plan for a bounded phase or slice.
---

# Purpose
Create a bounded, implementation-ready plan using the repository workflow.

# Use when
- Work is broader than trivial
- A feature or slice needs explicit planning
- Correctness depends on artifact updates

# Read first
- .agents/AGENTS.md
- docs/ai/WORKFLOW_SHORT.md
- docs/ai/ARTIFACTS.md
- relevant active planning artifact

# Engineering defaults
- Start from tests
- Define required test layers
- Respect SOLID boundaries
- Preserve Git Flow expectations

# Output
- Minimal plan artifact
- Explicit verification level
- Clear implementation boundary
- Test-first execution sequence

# Prohibitions
- No full repository scan
- No hidden structural drift
- No implementation-first default for behavior changes
```

---

## 19. Agent Design Contract

Every agent should define:

* role
* purpose
* scope
* inputs
* outputs
* tool strategy
* limitations
* anti-patterns

Agents must remain runtime-neutral.

### Example: `advisor-researcher.md`

```md
# Role
Research one gray-area technical decision and return a structured comparison.

# Inputs
- target decision area
- project context
- constraints
- calibration level

# Output
- comparison table
- concise rationale

# Anti-patterns
- no broad unfocused research
- no direct user-facing synthesis if this is a subagent
- no inflated option lists
```

---

## 20. Runtime Wrappers Must Remain Minimal

A runtime wrapper must never become a second workflow definition.

A wrapper is allowed to say:

* where the source of truth is
* where runtime-specific notes live
* how that runtime should reach the central contract

A wrapper is not allowed to:

* redefine testing policy
* redefine architecture rules
* redefine branching strategy
* redefine verification semantics

---

## 21. Migration Strategy

The migration should happen in controlled phases.

## Phase 1 — Introduce `.agents/`

Create the new structure without removing existing runtime surfaces yet.

## Phase 2 — Move canonical policy

Move the normative system contract into `.agents/AGENTS.md`.

## Phase 3 — Consolidate runtime adapters

Reduce existing runtime files into thin wrappers and move real differences into `.agents/adapters/`.

## Phase 4 — Consolidate agents

Unify duplicated agents under `.agents/agents/`.

## Phase 5 — Extract skills

Reorganize workflow behavior into reusable skill modules.

## Phase 6 — Generate wrappers

Automate runtime shim generation.

## Phase 7 — Validate and lock down

Add CI checks to prevent semantic drift and wrapper bloat.

---

## 22. CI and Validation

The CI pipeline should validate:

* manifest integrity
* skill existence
* agent existence
* runtime wrapper generation
* no manual drift in generated files

A minimal sequence could be:

```bash
bash .agents/scripts/validate-agents.sh
bash .agents/scripts/generate-runtime-shims.sh
git diff --exit-code
```

If the generated shims differ from committed ones, CI should fail.

---

## 23. Documentation Strategy

This architecture should be documented in at least three repository docs.

### 1. `docs/architecture/agents-centralization.md`

The main architecture document.

### 2. `docs/architecture/agents-migration-plan.md`

A file-by-file migration plan.

### 3. `docs/architecture/runtime-shims-spec.md`

A formal specification of generated runtime wrappers.

Optional additions:

* `docs/architecture/testing-governance.md`
* `docs/architecture/gitflow-policy.md`

---

## 24. Risks and Mitigations

### Risk: runtime discovery breakage

If runtime directories are fully removed, some tools may stop loading instructions.

Mitigation:

* keep generated minimal wrappers

### Risk: accidental re-duplication

Adapters may start growing again.

Mitigation:

* make wrapper minimality a CI-validated rule

### Risk: over-copying GSD

The system may become unnecessarily large or command-heavy.

Mitigation:

* adopt capability patterns, not command sprawl

### Risk: weak enforcement of TDD and Git Flow

These may remain "documented" but not operationalized.

Mitigation:

* encode them in central contract and review/verification behavior

---

## 25. End State

When complete, the repository should behave like this:

* `.agents/` is the only normative location
* runtime shells are compatibility-only
* agent and skill definitions exist once
* testing strategy is encoded into workflow behavior
* TDD is the default
* SOLID is mandatory
* layered tests are proportional to risk
* Agile + PMBOK governance remains explicit
* Git Flow is enforced with `develop` as the normal base for feature work
* GSD principles are internalized in a repository-native architecture

---

## 26. Master Rule

The final governing rule of the entire architecture is:

**All meaningful agent behavior, workflow policy, engineering defaults, skill contracts, adapter semantics, and operational constraints must live exclusively inside `.agents/`. Any file outside `.agents/` that exists for runtime compatibility is derived, minimal, disposable, and non-normative.**

---

## 27. Implementation Checklist

### Structure

* Create `.agents/`
* Add `manifest.json`
* Add `adapters/`
* Add `skills/`
* Add `agents/`
* Add `prompts/`
* Add `scripts/`

### Centralization

* Move canonical policy to `.agents/AGENTS.md`
* Move runtime-specific differences into `.agents/adapters/`
* Consolidate duplicated agents
* Extract reusable skills

### Engineering defaults

* Encode TDD policy
* Encode layered test requirements
* Encode SOLID rules
* Encode hybrid Agile + PMBOK guidance
* Encode Git Flow rules

### Compatibility

* Generate Claude shim
* Generate Codex shim
* Generate Copilot shim

### Validation

* Validate manifest
* Validate skills
* Validate agents
* Validate wrappers
* Prevent drift in CI

### Documentation

* Update README
* Document architecture
* Document migration plan
* Document runtime shim specification

---

## 28. Final Example: End-to-End Feature Flow

Suppose a developer wants to add a new authentication refresh-token flow.

The expected path under this architecture would be:

1. Update `develop`
2. Create `feature/auth-refresh-token` from `develop`
3. Use central `.agents/` contract
4. Trigger `plan-phase`
5. Plan defines:

   * failing unit tests for token refresh logic
   * integration tests for persistence/session behavior
   * E2E tests for login → refresh flow if risk warrants
   * SOLID decomposition into controller/use case/repository abstractions
6. `execute-phase` begins with tests, not implementation
7. Code is implemented minimally to pass tests
8. Refactor preserves green state
9. `verify-phase` checks:

   * tests were added first
   * unit/integration/E2E coverage is proportional
   * feature branch is correct
   * no architectural drift
10. PR is opened into `develop`
11. Release work later branches from `develop` into `release/*`
12. Stable release merges into `main`

That is the intended operating model.
