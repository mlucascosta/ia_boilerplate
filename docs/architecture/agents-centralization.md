# Technical Architecture - Agent Centralization in `.agents/`

## 1. Overview

This document defines the target architecture for evolving `ia_boilerplate` from a runtime-distributed model into a centralized model with a single source of truth in `.agents/`.

The goals are to:

- centralize all operational agent intelligence in `.agents/`
- eliminate duplication across Claude, Codex, Copilot, and other runtimes
- use `get-shit-done` (GSD) as a conceptual base for skills, phases, and subagents
- reduce dependence on runtime-specific command trees
- make the repository more portable, predictable, auditable, and easier to maintain

The new architecture adopts a `skills-first` and `agents-first` model instead of a `runtime-first` model.

## 2. Current State and Problem

The repository already has a solid cross-AI workflow core, but the intelligence is still fragmented across multiple runtime-oriented locations:

- `AGENTS.md`
- `CLAUDE.md`
- `.github/copilot-instructions.md`
- `.codex/skills/...`
- `.claude/agents/...`
- `.codex/agents/...`
- commands, wrappers, and runtime-specific variants

This creates the following problems:

### 2.1 Structural duplication

Equivalent agents exist in more than one runtime, with minor syntax differences instead of meaningful behavioral differences.

### 2.2 Runtime drift

A rule evolves in one place but not necessarily in the others.

### 2.3 Expensive maintenance

Each policy, verification, or output-shape change may require updates in several files.

### 2.4 Runtime-centered architecture

Behavior remains tied to Claude, Codex, or Copilot when it should be defined by the project workflow itself.

### 2.5 GSD is only partially absorbed

The repository already aligns with the spirit of GSD, but it has not yet fully internalized its model of skills, phases, subagents, and runtime-decoupled execution.

## 3. Architectural Objective

The target architecture establishes:

> `.agents/` is the only source of truth for agent behavior, skills, operational contracts, structured prompts, manifests, and compatibility mapping.

All other runtime integration points are treated as:

- minimal wrappers
- generated files
- compatibility shims
- disposable surfaces

## 4. Solution Principles

### Mandatory Core Principles

- `.agents/` is the only source of truth for agent behavior
- TDD is the mandatory default implementation pattern
- tests come before real implementation
- unit, integration, and E2E tests are required proportionally to risk
- SOLID is mandatory in the construction of classes, functions, and modules
- governance remains hybrid across Agile and PMBOK
- runtimes do not define behavior; they only consume the central contract
- runtime wrappers are minimal, derived, and non-normative

### 4.1 Single Source of Truth

Every relevant rule must exist only in `.agents/`.

### 4.2 Runtime as Compatibility Layer

Claude, Codex, Copilot, and other runtimes must not define behavior. They only consume behavior.

### 4.3 Skills over Commands

The system should be organized around reusable capabilities, not large trees of runtime-coupled commands.

### 4.4 Generated Compatibility

Whenever possible, runtime files should be generated from the central source.

### 4.5 Zero Semantic Duplication

Syntax differences are acceptable. Rule or policy differences are not.

### 4.6 GSD-Inspired, not GSD-Dependent

The repository absorbs the operational model of GSD without copying its full command structure.

## 5. Current State vs Target State

### 5.1 Current state

- `AGENTS.md` as the main adapter
- `CLAUDE.md` as the Claude adapter
- `.github/copilot-instructions.md` as the Copilot adapter
- `.codex/skills/...` as the Codex adapter
- duplicated agents in `.claude/agents` and `.codex/agents`
- GSD present as a reference, but not yet as the real modeling core

### 5.2 Target state

- `.agents/` as the absolute center
- shared, modular skills
- shared, runtime-agnostic agents
- short, non-duplicating adapters
- generated runtime wrappers
- GSD internalized as a phase, skill, and subagent execution model

## 6. Target Repository Structure

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

## 7. Role of Each Directory

### 7.1 `.agents/AGENTS.md`

The universal contract of the system.

Responsibilities:

- define base rules
- define minimum reading rules
- define path selection
- define output policy
- define verification policy
- define artifact update policy
- define prohibitions

This file replaces the semantic role of the current `AGENTS.md` as the real source of behavior, while the repository-root `AGENTS.md` remains a compatibility adapter.

### 7.2 `.agents/manifest.json`

The orchestration and metadata file for the agent architecture.

Responsibilities:

- declare system version
- list skills
- list agents
- list supported runtimes
- list generated targets
- support automatic validation
- support generation scripts

Example:

```json
{
  "version": "2.0.0",
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

### 7.3 `.agents/adapters/`

Semantic adapters per runtime.

These files exist only to capture real runtime-specific differences without repeating the full workflow.

#### `claude.md`

Should contain only:

- local discovery notes
- permission differences
- runtime-specific conventions that genuinely belong to Claude

#### `codex.md`

Should contain only:

- Codex-specific skill format expectations
- runtime behavior notes
- no full workflow duplication

#### `copilot.md`

Should contain only:

- repository instruction notes for Copilot
- environment-specific constraints and expectations

#### `gsd.md`

Should document:

- how GSD is conceptually absorbed
- which capabilities were inherited
- which parts of GSD will not be reproduced
- how this repository differs from a full GSD installation

### 7.4 `.agents/skills/`

The main reusable capability layer.

Skills must model the workflow by function, not by runtime.

#### `workflow-core`

Root skill. Defines the backbone of the system.

#### `discuss-phase`

Captures decisions, preferences, gray areas, and direction before planning.

#### `plan-phase`

Transforms context into an atomic, verifiable plan aligned to the artifact model.

#### `execute-phase`

Executes the plan with emphasis on minimal diff, proportional validation, and contract preservation.

#### `verify-phase`

Verifies implementation, done criteria, and evidence.

#### `quick-task`

Lightweight path for small tasks without losing minimum discipline.

#### `docs-update`

Documentation updates driven by verification and durable-knowledge alignment.

#### `review`

Audit, peer review, and cross-check analysis.

### 7.5 `.agents/agents/`

Specialized subagents, neutral with respect to runtime.

Examples:

#### `advisor-researcher.md`

Researches one gray area and returns a structured comparison.

#### `planner.md`

Converts scope into atomic plans.

#### `executor.md`

Performs implementation with bounded scope.

#### `verifier.md`

Validates criteria, evidence, and gaps.

#### `doc-writer.md`

Updates durable documentation.

#### `doc-verifier.md`

Validates consistency, precision, and documentation alignment.

### 7.6 `.agents/prompts/`

A library of fragments and templates.

Goals:

- avoid repeating textual blocks
- centralize output contracts
- centralize verification instructions
- centralize anti-patterns

Example fragments:

- `minimal-diff.md`
- `verification-levels.md`
- `telegraphic-state.md`
- `conditional-recommendations.md`
- `artifact-update-rules.md`

### 7.7 `.agents/schemas/`

Validation schemas.

Examples:

- `agent.schema.json`
- `skill.schema.json`
- `manifest.schema.json`

Goals:

- validate structural integrity
- support future tooling
- guarantee minimum consistency across skills and agents

### 7.8 `.agents/scripts/`

Utility scripts for synchronization and validation.

#### `sync-runtime-adapters.sh`

Synchronizes generated wrappers and adapters.

#### `generate-runtime-shims.sh`

Generates minimal files for `.claude`, `.codex`, and `.github`.

#### `validate-agents.sh`

Validates the manifest, skills, agents, and wrappers.

## 8. Policy for `.claude`, `.codex`, and `.github`

### 8.1 General rule

These directories are no longer sources of truth.

They become:

- generated
- minimal
- disposable
- compatible with runtime discovery

### 8.2 What this means in practice

No workflow intelligence should be maintained there anymore.

They may still exist physically, but only as thin shells.

### 8.3 Example for Claude

```md
# Runtime shim for Claude

Follow `.agents/AGENTS.md`.

Runtime-specific notes:
- See `.agents/adapters/claude.md`
- Shared skills live in `.agents/skills/`
- Shared agents live in `.agents/agents/`
```

### 8.4 Example for Codex

```md
---
name: project-workflow
description: Minimal Codex shim that delegates to .agents
---

Follow `.agents/AGENTS.md`.
Runtime specifics: `.agents/adapters/codex.md`
Primary shared skill: `.agents/skills/workflow-core/SKILL.md`
```

### 8.5 Example for Copilot

```md
# Runtime shim for Copilot

Follow `.agents/AGENTS.md`.
Runtime-specific notes: `.agents/adapters/copilot.md`
Do not treat this file as a source of truth.
```

## 9. Decision About Deleting Runtime Directories

### 9.1 Recommended path

Do not delete them blindly.

Instead:

- remove their intelligence
- leave only minimal wrappers
- optionally generate them by script

### 9.2 Radical path

Delete `.claude`, `.codex`, and `.github` completely.

This is only acceptable if:

- the runtime does not depend on them for discovery
- or an external bootstrap layer regenerates them in the environment

### 9.3 Formal decision

The recommended architecture does not adopt full manual removal as the default path.

The standard is:

> Keep minimal compatible surfaces, but remove any normative role from them.

## 10. GSD-Based Operational Model

### 10.1 Goal

Leverage GSD as a strong reference for phase-oriented, subagent-driven workflow.

### 10.2 What should be absorbed from GSD

- phase-oriented thinking
- discuss -> plan -> execute -> verify
- atomic tasks
- context persisted in artifacts
- reusable skills
- specialized agents
- proportional verification
- execution decoupled from chat history

### 10.3 What should not be absorbed wholesale

- command-heavy interface as the primary operating model
- strong coupling to one runtime
- the need to replicate the entire GSD command tree
- operational complexity that is unnecessary for the boilerplate scope

### 10.4 Conclusion

The repository becomes `GSD-inspired` in architecture, not `GSD-cloned` in operational surface.

## 11. Mandatory Skills

At minimum, the architecture requires the following skills:

### 11.1 `workflow-core`

Mandatory base skill.

Responsibilities:

- load the main contract
- define universal rules
- establish path and verification semantics

### 11.2 `discuss-phase`

Responsible for:

- clarifying intent
- capturing preferences
- identifying gray areas
- recording direction before planning

### 11.3 `plan-phase`

Responsible for:

- decomposing scope
- proposing executable plans
- limiting impact surface
- defining the correct verification level

### 11.4 `execute-phase`

Responsible for:

- operating on the plan
- minimizing structural drift
- respecting the output contract
- maintaining bounded execution

### 11.5 `verify-phase`

Responsible for:

- validating done criteria
- validating evidence
- identifying gaps
- preparing closure or iteration

### 11.6 `quick-task`

Responsible for:

- small tasks
- fast execution
- minimum discipline without excessive overhead

### 11.7 `docs-update`

Responsible for:

- updating durable documentation
- reflecting already-consolidated knowledge
- avoiding speculative documentation

### 11.8 `review`

Responsible for:

- reviewing changes
- validating architectural adherence
- detecting inconsistency between implementation and contract

## 12. Skill Authoring Contract

Each skill must follow a standardized structure.

Suggested template:

```md
---
name: plan-phase
description: Creates an atomic implementation plan for a bounded phase or slice.
---

# Purpose
Create a bounded, implementation-ready plan using the repository workflow.

# Use when
- Work is broader than trivial
- A phase or slice needs explicit planning
- Correctness depends on artifact updates

# Read first
- .agents/AGENTS.md
- docs/ai/WORKFLOW_SHORT.md
- docs/ai/ARTIFACTS.md
- relevant active planning artifact

# Output
- Minimal plan artifact
- Explicit verification level
- Next execution boundary

# Prohibitions
- No full repository scan
- No repeated workflow explanation
- No hidden structural decisions
```

Rules:

- a skill must not depend on runtime
- a skill must not repeat the entire workflow
- a skill must be focused on one capability
- a skill must clearly declare when to use it and when not to use it

## 13. Agent Authoring Contract

Each agent must define:

- name
- role
- scope of responsibility
- expected inputs
- expected output
- tool strategy
- limitations
- anti-patterns

Rules:

- an agent must be runtime-neutral
- an agent must not embed Claude-, Codex-, or Copilot-specific logic
- frontmatter differences must be generated, not maintained manually
- an agent must operate on a clearly bounded responsibility slice

## 14. Manifest and Governance

### 14.1 `manifest.json` is mandatory

No new skill or agent enters the system without being declared in the manifest.

### 14.2 All generation starts from the manifest

Wrappers, validation, and synchronization must use the manifest as input.

### 14.3 The manifest defines the living model

It is the official map of everything the system exposes.

## 15. Daily Operational Flow

Under the new architecture, the flow becomes:

1. the runtime loads a minimal wrapper
2. the wrapper points to `.agents/AGENTS.md`
3. the central contract defines the base policy
4. the system selects the correct skill
5. skills invoke agents when needed
6. planning and state artifacts remain the real memory
7. verification closes the loop

## 16. Commands vs Skills

### 16.1 New rule

Commands are no longer the center of the system.

### 16.2 Role of commands

Commands become only:

- shortcuts
- wrappers
- invocation conveniences

### 16.3 Example

`/gsd:plan-phase` may still exist, but its real logic should delegate to `plan-phase`.

### 16.4 Result

The repository no longer depends on a forest of commands to remain usable.

## 17. Migration Strategy

Migration should happen in phases.

### 17.1 Phase 1 - Introduce `.agents/`

Goal: create the new structure without breaking anything.

Steps:

- create `.agents/`
- move the main policy into `.agents/AGENTS.md`
- create `manifest.json`
- create `adapters`, `skills`, `agents`, `prompts`, and `scripts`

Expected result:

- `.agents/` exists and already represents the new direction

### 17.2 Phase 2 - Consolidate adapters

Goal: remove semantic duplication across `CLAUDE.md`, Copilot, and Codex.

Steps:

- extract real differences into `.agents/adapters/`
- reduce old files to minimal wrappers
- register generated targets in the manifest

Expected result:

- semantic rules are centralized

### 17.3 Phase 3 - Consolidate agents

Goal: unify duplicated subagents.

Steps:

- identify duplicated pairs across `.claude/agents` and `.codex/agents`
- create canonical versions in `.agents/agents`
- remove manual maintenance of duplicates

Expected result:

- one agent, one definition

### 17.4 Phase 4 - Extract skills

Goal: model behavior by capability.

Steps:

- create `workflow-core`
- decompose discuss, plan, execute, verify, quick, docs, and review
- move currently scattered knowledge into clear skills

Expected result:

- `skills-first` architecture

### 17.5 Phase 5 - Generate wrappers

Goal: make runtime surfaces derived artifacts.

Steps:

- implement `generate-runtime-shims.sh`
- generate `.claude`, `.codex`, and `.github`
- prevent drift through CI

Expected result:

- minimal, disposable wrappers

### 17.6 Phase 6 - Validate and clean up

Goal: complete the transition.

Steps:

- validate the manifest
- validate skills
- validate agents
- validate wrappers
- remove legacy content that is no longer needed

Expected result:

- the new architecture is stabilized

## 18. Validation Policy

Validation should have four layers.

### 18.1 Structural validation

Checks whether everything declared in the manifest exists.

### 18.2 Semantic validation

Checks that wrappers do not carry their own rules.

### 18.3 Compatibility validation

Checks whether runtimes still consume the minimal files correctly.

### 18.4 Drift validation

Fails when generated wrappers are manually changed.

## 19. CI and Automation

The pipeline should include at minimum:

- manifest validation
- skill validation
- agent validation
- wrapper generation
- diff checks against versioned files
- failure if wrappers diverge from generator output

Example checks:

- `bash .agents/scripts/validate-agents.sh`
- `bash .agents/scripts/generate-runtime-shims.sh`
- `git diff --exit-code`

## 20. Versioning Policy

The agent architecture should have its own versioning.

Suggested approach:

- boilerplate version: for example `v2.0.0`
- agent architecture version in the manifest: for example `2.0.0-agent-core`

Rules:

- skill contract changes -> bump architecture version
- generated wrapper changes -> may bump compatibility version
- relevant structural changes -> update roadmap and documentation

## 21. Risks and Mitigations

### 21.1 Risk: discovery breakage

If runtime directories are deleted completely, some environments may stop discovering instructions.

Mitigation:

- use generated minimal wrappers

### 21.2 Risk: absorbing too much of GSD

The system may become too heavy.

Mitigation:

- absorb capabilities, not the entire command tree

### 21.3 Risk: duplication returns

Adapters may grow again.

Mitigation:

- explicit minimal-wrapper policy
- CI validation

### 21.4 Risk: drift between agents and wrappers

Local changes may break alignment.

Mitigation:

- always generate wrappers
- require the manifest
- validate automatically

### 21.5 Risk: mixing contract and runtime

Project rules may leak into runtime-specific files.

Mitigation:

- every normative rule must live only in `.agents/`

## 22. Expected Result

After migration:

- `.agents/` is the only source of truth
- Claude, Codex, and Copilot remain compatible
- duplication across runtimes disappears
- skills become the real unit of behavior
- agents become reusable
- GSD concretely influences the architecture
- the repository becomes cleaner, more portable, and easier to evolve

## 23. Final Master Rule

The central rule of this architecture is:

> All relevant behavior for agents, skills, adapters, structured prompts, and operational contracts must live exclusively in `.agents/`. Any file outside `.agents/` that exists for runtime integration is derived, minimal, disposable, and non-normative.

## 24. Implementation Checklist

### Structure

- [ ] Create `.agents/`
- [ ] Create `manifest.json`
- [ ] Create `adapters/`
- [ ] Create `skills/`
- [ ] Create `agents/`
- [ ] Create `prompts/`
- [ ] Create `scripts/`

### Centralization

- [ ] Migrate the main policy into `.agents/AGENTS.md`
- [ ] Extract real differences into adapters
- [ ] Consolidate duplicated agents
- [ ] Create base skills

### Compatibility

- [ ] Generate the Claude wrapper
- [ ] Generate the Codex wrapper
- [ ] Generate the Copilot wrapper
- [ ] Register everything in the manifest

### Quality

- [ ] Validate the manifest
- [ ] Validate skills
- [ ] Validate agents
- [ ] Validate wrappers
- [ ] Add CI checks

### Documentation

- [ ] Update the README
- [ ] Update repository structure docs
- [ ] Document the minimal-wrapper policy
- [ ] Document the GSD-inspired model

## 25. Next Recommended Documents

After this document, the repository should add two complementary documents:

1. `docs/architecture/agents-migration-plan.md`
   - operational migration plan by file
   - current tree vs target tree
   - suggested commit sequence

2. `docs/architecture/runtime-shims-spec.md`
   - wrapper specification
   - minimal contracts per runtime
   - generator rules for shims

## 26. Mandatory Engineering Principles

The centralized architecture in `.agents/` must preserve and strengthen the engineering principles already adopted by the repository.

These principles are not optional, and they do not depend on runtime.

They are part of the normative system contract.

### 26.1 TDD as a mandatory default

Every behavior-changing implementation must follow `Test-Driven Development` as the primary default.

The expected sequence is:

1. write the test
2. run the test and observe failure
3. implement the minimum necessary code
4. refactor while preserving green
5. update artifacts and evidence

Formal rule:

> The default implementation flow must start with tests and only then evolve into classes, functions, services, handlers, components, or real modules.

### 26.2 Mandatory construction order

The standard execution order is:

1. define the expected behavior
2. create the corresponding tests
3. validate the initial failure
4. implement the real code
5. refactor under SOLID guidance
6. validate all required layers

Implementation first and cover later is not an acceptable default.

### 26.3 Mandatory test pyramid

The system must preserve the following test layers, always proportionally to change risk:

#### Unit tests

Used to validate isolated rules, functions, services, policies, validators, mappings, and pure logic.

#### Integration tests

Used to validate interactions between modules, databases, queues, internal APIs, coupled services, repositories, adapters, and cross-layer contracts.

#### E2E tests

Used to validate complete flows, critical journeys, and functional system behavior from the outside.

### 26.4 Proportionality rule

Not every change requires the same depth across all layers, but the system must always require verification compatible with impact.

Example rule:

- trivial local change: unit may be enough
- multi-module change: unit + integration
- critical flow, authentication, billing, orchestration, queue, persistence, permissions, or critical UX change: unit + integration + E2E

### 26.5 SOLID as an architectural contract

Every real implementation must follow SOLID principles as the architectural default.

This implies, among other things:

- well-bounded responsibilities
- clear dependency separation
- low coupling
- extensibility without excessive rewriting
- appropriate abstractions
- isolation of domain rules
- refactoring guided by readability and sustainable evolution

Formal rule:

> Classes, functions, modules, and services must be designed to preserve clear responsibility, low coupling, and high cohesion, avoiding monolithic logic, infrastructure leakage, and structural drift.

### 26.6 Agile + PMBOK in a hybrid model

Work governance remains hybrid across `Agile` and `PMBOK`.

#### Agile

Used for:

- incremental execution
- slice-based delivery
- continuous adaptation
- fast feedback
- dynamic prioritization
- focus on delivered value

#### PMBOK

Used for:

- governance
- scope control
- traceability
- risks
- dependencies
- milestones
- executive and structural documentation

### 26.7 Rule for separating governance and execution

The architecture must clearly separate:

- governance and direction artifacts
- daily execution artifacts

This means:

- hybrid PMBOK guides direction, risk, scope, and control
- Agile guides slices, short cycles, adaptation, and delivery
- the `.agents/` workflow executes daily work without losing governance alignment

### 26.8 Implications for skills and agents

All skills and agents must respect these principles.

#### `workflow-core`

Must explicitly declare:

- TDD by default
- SOLID as an architectural obligation
- risk-proportional testing
- separation between governance and execution

#### `plan-phase`

Must plan:

- which tests come first
- which test layers are required
- which classes/functions are implemented only after tests
- which risks require integration and E2E

#### `execute-phase`

Must execute:

- tests first
- implementation second
- SOLID-oriented refactoring
- explicit validation

#### `verify-phase`

Must verify:

- whether tests were created before implementation
- whether required test layers were covered
- whether architectural drift occurred
- whether the solution preserves low coupling and high cohesion

#### `review`

Must review:

- adherence to TDD
- test suite quality
- adherence to SOLID
- consistency across unit, integration, and E2E layers

### 26.9 Minimum verification levels

The verification policy may be refined as follows:

- `V0`: reasoning only, allowed only for truly trivial changes with no behavior change
- `V1`: unit test or equivalent targeted local validation
- `V2`: unit + integration tests, or equivalent combined evidence
- `V3`: unit + integration + E2E when functional risk justifies it

### 26.10 Master implementation rule

The master rule becomes:

> Every meaningful behavior change must start with tests, evolve through minimal implementation, be refactored under SOLID principles, and be validated through unit, integration, and E2E tests in proportion to risk, within a hybrid Agile execution and PMBOK governance model.

## 27. Mandatory Git Flow

The repository adopts `Git Flow` as the mandatory branching policy.

This policy is not optional and must be respected by all runtimes, agents, skills, and execution flows.

### 27.1 Main branches

#### `main`

Stable production or publishable branch.
It must not receive day-to-day feature development directly.

#### `master`

Legacy stable production or publishable branch when `main` is not used.
It follows the same contract as `main`.

#### `develop`

Primary development integration branch.
Every feature branch must start from it.

### 27.2 Supporting branches

#### `feature/*`

Used for new features, improvements, or bounded refactors.

Rules:

- always created from `develop`
- always merged back into `develop`
- never opened directly from the stable branch

Examples:

- `feature/auth-refresh-token`
- `feature/agents-centralization`
- `feature/plan-phase-skill`

#### `release/*`

Used to stabilize a version before publication.

Rules:

- created from `develop`
- limited to stabilization, documentation, versioning, and final corrections
- merged into the stable branch and then back into `develop`

Example:

- `release/v2.0.0`

#### `hotfix/*`

Used for urgent production corrections.

Rules:

- created from the stable branch
- merged into the stable branch
- always merged back into `develop`

Example:

- `hotfix/login-session-regression`

### 27.3 Master feature rule

The central rule is:

> Every feature must be created from `develop` and return to `develop` after validation and review.

### 27.4 Prohibitions

The following are not allowed:

- creating a feature directly from the stable branch
- merging a feature directly into the stable branch
- using the stable branch as the daily working branch
- skipping hotfix synchronization back into `develop`
- treating Git Flow as an optional suggestion

### 27.5 Branch detection and fallback

The workflow must determine the long-lived branches in this order:

1. detect the stable branch as `main`
2. if `main` does not exist, detect the stable branch as `master`
3. detect `develop` as the integration branch

If a stable branch exists but `develop` does not, initialize Git Flow by creating `develop` from the detected stable branch before feature work starts.

If neither a stable branch nor `develop` exists, do not guess. Ask the user to identify the intended long-lived branches, then initialize Git Flow with `develop` as the integration branch.

### 27.6 Relationship to Agile + PMBOK

Git Flow supports the hybrid model of the repository:

- Agile organizes incremental execution in features and slices
- PMBOK supports control, traceability, milestones, and releases
- Git Flow provides the integration and versioning discipline that connects both

### 27.7 Implications for `.agents/`

All skills and agents must respect Git Flow.

#### `workflow-core`

Must declare Git Flow as mandatory.

#### `plan-phase`

Must consider the correct branch strategy for execution, including stable-branch detection and missing-branch fallback.

#### `execute-phase`

Must assume implementation happens in `feature/*` branches derived from `develop`, after Git Flow has been initialized correctly.

#### `verify-phase`

Must validate whether delivery is coherent with the expected branch flow and long-lived branch selection.

#### `review`

Must review not only code but also adherence to the branching model.

### 27.8 Branch naming convention

Recommended naming:

- `feature/<slug>`
- `release/v<semver>`
- `hotfix/<slug>`

### 27.9 Summary operating flow

Normal flow:

1. detect the stable branch as `main` or `master`
2. ensure `develop` exists, creating it from the stable branch when needed
3. create `feature/*` from `develop`
4. execute implementation and validation
5. open a pull request to `develop`
6. create `release/*` after stabilization
7. publish through the stable branch
8. sync changes back into `develop` when required

## 28. Status of This Branch

This specification defines the target of `release/v2`.

It should be read as the normative architecture document for the transition, not as a claim that the full target structure has already been completed in the current tree.
