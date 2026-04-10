# Context Map

Use this file to minimize unnecessary context loading.

## Context temperatures

### Hot

Load by default:

- `docs/ai/WORKFLOW_SHORT.md`
- one active artifact: `STATE.md` or the active plan
- files in the current slice

### Warm

Load only when needed for the current task type:

- `docs/ai/CONTEXT_MAP.md`
- `docs/ai/DECISION_RULES.md`
- one recipe or closest canonical reference

### Cold

Load only when the task explicitly requires broader context:

- `ROADMAP.md`
- ADRs
- research artifacts
- broad architecture or module docs
- older summaries beyond the last 2 relevant ones

## Always read first

- `.planning/STATE.md`
- the active plan in `.planning/plans/`
- the specific files requested by the task

## Read only when needed

- `docs/ai/WORKFLOW.md`
- `docs/ai/ARTIFACTS.md`
- `docs/ai/PROJECT_METHOD.md`
- `docs/ai/DECISION_RULES.md`
- `docs/architecture/*`
- `docs/modules/*`

## Architecture audit context

Load when doing code review, audits, or architecture analysis:

- `.agents/governance/RULES.md` — behavior rules for the auditor
- `.agents/governance/CHECKLIST.md` — per-category checklist
- `.agents/governance/ANTI_PATTERNS.md` — known anti-patterns table
- `.agents/governance/REVIEW_OUTPUT_TEMPLATE.md` — finding/report format
- `docs/architecture/ARCHITECTURE.md` — layer contract and intentional exceptions

Invoke `.agents/skills/review/` when a full audit is requested.

## Avoid by default

- unrelated modules
- old summaries unless the task explicitly depends on them
- full repository scans
- entire generated files when diffs or small excerpts are enough

## Task-oriented loading

### Local bugfix

Read:

- `.planning/STATE.md`
- active plan if present
- failing module files
- relevant test file

Avoid:

- roadmap
- ADRs unless the bug touches a structural decision
- broad architecture docs
- research artifacts
- unrelated summaries

### Local feature

Read:

- `.planning/STATE.md`
- active plan
- target module docs
- affected implementation files

Read later only if needed:

- architecture docs
- ADRs
- roadmap

Avoid:

- research artifacts
- old summaries unrelated to the current slice

### Structural change

Read:

- `.planning/STATE.md`
- active plan if present
- `docs/ai/WORKFLOW.md`
- `docs/ai/PROJECT_METHOD.md`
- relevant architecture docs
- related ADRs
- affected module docs

Avoid:

- unrelated module docs
- old summaries beyond the last 2 relevant checkpoints

### Documentation change

Read:

- `.planning/STATE.md`
- target documentation file
- one closest canonical reference

Avoid:

- implementation files unless the doc depends on them
- roadmap unless the documentation change is governance-level
- research artifacts unless they are the source of truth

### Handoff or resume

Read:

- `.planning/STATE.md`
- active plan
- latest 2 relevant summaries
- only the files in current scope

Avoid:

- roadmap unless priorities changed
- research artifacts unless the slice depends on them
- broad docs outside the current area

## Resume packet

For resumptions, build the packet in this order:

- current objective from `STATE.md`
- active plan
- latest 2 relevant summaries
- files in focus
- current risk or blocker

Do not reopen roadmap, ADRs, or broad docs unless the resume packet proves they are needed.

## Loading rule

Never ask the model to analyze the entire repository unless the task is explicitly repository-wide and planning artifacts were updated first.
