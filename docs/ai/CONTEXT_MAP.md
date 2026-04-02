# Context Map

Use this file to minimize unnecessary context loading.

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
- broad architecture docs
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

### Structural change
Read:
- `.planning/STATE.md`
- `docs/ai/WORKFLOW.md`
- `docs/ai/PROJECT_METHOD.md`
- relevant architecture docs
- related ADRs
- affected module docs

### Documentation change
Read:
- `.planning/STATE.md`
- target documentation file
- one closest canonical reference

Avoid:
- implementation files unless the doc depends on them

### Handoff or resume
Read:
- `.planning/STATE.md`
- latest relevant summary
- active plan
- only the files in current scope

## Loading rule
Never ask the model to analyze the entire repository unless the task is explicitly repository-wide and planning artifacts were updated first.
