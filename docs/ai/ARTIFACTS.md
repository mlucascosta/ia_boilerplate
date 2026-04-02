# Workflow Artifact Contract

This file defines the repository artifacts that any AI runtime should understand and maintain.

## Directory Contract

```text
.planning/
  STATE.md
  ROADMAP.md
  research/
  epics/
  plans/
  summaries/
  verification/
docs/
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

## Artifact Meanings

### `.planning/STATE.md`

Use for active workflow state:

1. Current objective.
2. Active phase or task.
3. Locked decisions.
4. Open questions.
5. Blockers.
6. Next recommended action.

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