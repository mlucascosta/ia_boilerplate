# Workflow Artifact Contract

This file defines the repository artifacts that any AI runtime should understand and maintain.

## Directory Contract

```text
.planning/
  STATE.md
  ROADMAP.md
  research/
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
```

Not every directory must exist immediately. Create only what the current work needs.

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

## Objective

## Active Work

## Locked Decisions

## Open Questions

## Blockers

## Next Step
```

### Atomic plan template

```md
# Plan: <name>

## Objective

## Scope

## Expected Changes

## Constraints

## Documentation Strategy

## Verification

## Done Criteria
```

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