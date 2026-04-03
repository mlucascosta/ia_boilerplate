# Workflow Artifact Contract

This file defines the repository artifacts that any AI runtime should understand and maintain.

## Directory Contract

```text
.planning/
  STATE.md
  ROADMAP.md
  VISION.md
  PROJECT.md
  RISK_REGISTER.md
  research/
  epics/
  adrs/
  plans/
  summaries/
  verification/
docs/
  adoption/
  architecture/
  infrastructure/
  integrations/
  environments/
  glossary/
  features/
  modules/
  runbooks/
  solutions/
  ai/
    ARTIFACTS.md
    WORKFLOW.md
    WORKFLOW_SHORT.md
    PROJECT_METHOD.md
    DECISION_RULES.md
    CONTEXT_MAP.md
    RECIPES.md
```

Not every directory must exist immediately. Create only what the current work needs.

## Context Budget

Hard limits per artifact to enforce continuous compression:

| Artifact | Max size |
| --- | --- |
| `STATE.md` | 120 words |
| `ROADMAP.md` | 12 bullets |
| Each atomic `PLAN` | 180 words |
| Each `SUMMARY` | 120 words |
| Each `VERIFICATION` | 8 bullets |

If an artifact exceeds its budget, compress or rotate content to `summaries/` before continuing.

No prompt should request "analyze the entire repository". Scope reads explicitly.

## Artifact Classification

### Governance artifacts
Use these for durable direction and control:
- `VISION.md`
- `PROJECT.md`
- `ROADMAP.md`
- architecture documentation
- ADRs (`.planning/adrs/`)
- `RISK_REGISTER.md`

### Execution artifacts
Use these for active delivery:
- `STATE.md`
- plans
- summaries
- verification notes
- handoffs

### Rule
Do not mix roadmap-level decisions with slice execution notes.
Do not use summaries as long-term canonical architecture records.

## Artifact Meanings

### `.planning/VISION.md`

Use for durable product direction:

1. Purpose of the project.
2. Target users and value proposition.
3. High-level boundaries.
4. Key constraints and premises.

This is a governance artifact. Update only when direction changes.

### `.planning/PROJECT.md`

Use for project-level identity and requirements:

1. What the project is.
2. Core value proposition.
3. Validated and pending requirements.

This file is managed by the GSD workflow. Treat it as a governance artifact.

### `.planning/STATE.md`

Use for active workflow state (telegraphic, ≤120 words):

1. Current objective.
2. Current task.
3. In-scope files.
4. Locked decisions.
5. Main risk or blocker.
6. Immediate next action.

History is prohibited. Rotate past context to `summaries/`.
If STATE exceeds 120 words during execution, compress immediately.

### `.planning/ROADMAP.md`

Use when work is phased:

1. Phase list.
2. Goal of each phase.
3. Dependencies.
4. Status markers.

### `.planning/research/`

Use for temporary but useful implementation research:

1. Library comparisons.
2. Architecture investigation.
3. Existing codebase mapping.
4. External system constraints.

### `.planning/epics/`

Use when a macro-phase from `ROADMAP.md` needs its own grouped breakdown.

Each epic is a markdown file describing:

1. Goal of the epic.
2. List of atomic plans it contains (by reference to `../plans/`).
3. Dependencies between plans.
4. Acceptance criteria for the epic as a whole.

Epics sit between `ROADMAP.md` and `plans/`. They do not replace either.

### `.planning/adrs/`

Use for Architecture Decision Records:

1. Structural technical decisions.
2. Dependency or integration strategy changes.
3. Persistence, queue, or security pattern choices.
4. Decisions that need durable reasoning and traceability.

Each ADR is a short markdown file. Use `docs/ai/DECISION_RULES.md` to know when to create one.

### `.planning/RISK_REGISTER.md`

Use for tracking project risks:

1. Risk description.
2. Impact and probability.
3. Mitigation strategy.
4. Trigger conditions.
5. Owner.

This is a governance artifact. Review periodically.

### `.planning/plans/`

Use for atomic executable plans.

Suggested naming:

1. `01-<slug>-PLAN.md`
2. `02-<slug>-PLAN.md`

Each plan should include:

1. Objective.
2. Scope.
3. Expected files.
4. Constraints.
5. Documentation strategy, explicitly covering the in-code documentation standard to be preserved or introduced.
6. Verification steps.
7. Done criteria.

### `.planning/summaries/`

Use for execution summaries that help future sessions understand what changed.

### `.planning/verification/`

Use for validation notes, UAT outcomes, documentation conformance evidence, architecture conformance evidence, or unresolved gaps for non-trivial work.

## Documentation Contract

### `docs/adoption/`

Scenario-based onboarding guides for introducing the workflow in new, legacy, or in-flight projects.

### `docs/architecture/`

Durable structure, boundaries, ADRs, major system flows.

### `docs/infrastructure/`

Deployment, hosting, environments, secrets handling boundaries, scheduled jobs, operational topology.

### `docs/integrations/`

External systems, contracts, auth methods, failure modes, retry behavior.

### `docs/environments/`

Local, staging, production differences and setup notes.

### `docs/glossary/`

Shared domain language and business terms.

### `docs/features/` and `docs/modules/`

Feature-specific and module-specific behavior, contracts, and maintenance notes.

### `docs/runbooks/`

Operational procedures: incident handling, maintenance, deployment, recovery, smoke checks.

### `docs/solutions/`

Reusable learnings and patterns from non-trivial implementation or debugging work.

## Minimal Templates

### `STATE.md`

```md
# State
Objective: <one line>
Now: <current task>
Files: <in-scope files>
Locked: <key decisions>
Risk: <main risk or blocker>
Next: <immediate next action>
```

History is prohibited inside `STATE.md`. Rotate past context to `summaries/`.

### `ROADMAP.md`

```md
# Roadmap

## Milestone: <name>

| Phase | Goal | Dependency | Status |
| --- | --- | --- | --- |
| 01 | <goal> | — | Planned |
```

### `VISION.md`

```md
# Vision

## Purpose

## Target Users

## Value Proposition

## Boundaries

## Key Constraints
```

### `PROJECT.md`

```md
# <Project Name>

## What This Is

## Core Value

## Requirements

### Validated

### Active

### Out of Scope
```

### `RISK_REGISTER.md`

```md
# Risk Register

| Risk | Impact | Probability | Mitigation | Trigger | Owner |
|---|---|---:|---|---|---|
```

### Epic template

```md
# Epic: <name>

## Goal

## Plans

## Dependencies

## Acceptance Criteria
```

### ADR template

```md
# ADR-001: <title>

## Status

## Context

## Decision

## Consequences
```

### Atomic plan template

```md
# Plan: <name>
SCOPE=trivial|focused|full
DOC=full|min
ARCH=solid|none
VERIFY=V0|V1|V2
FILES=<comma-separated paths>
OUT=<explicit exclusions>

## Objective

## Expected Changes

## Constraints

## Verification

## Done Criteria
```

Flags at the top let agents parse the task in ~10 lines instead of ~200.

### Execution summary template

```md
# Summary: <name>

## What Changed

## Validation

## Risks Or Follow-ups
```

### Verification template

```md
# Verification: <name>

## Scope

## Documentation Evidence

## Architecture Evidence

## Checks Run

## Outcome

## Remaining Risks
```

## Runtime Rule

Any agent can use its own native commands, prompts, skills, or slash-command system, but repository artifacts must stay compatible with this contract.