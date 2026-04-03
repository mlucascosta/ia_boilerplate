# Copilot adapter

Follow `AGENTS.md`.

## Source of truth

1. `docs/ai/WORKFLOW_SHORT.md`
2. `docs/ai/WORKFLOW.md` only if ambiguous
3. `docs/ai/ARTIFACTS.md`

## First read

- `docs/ai/WORKFLOW_SHORT.md`
- one active artifact: `.planning/STATE.md` or the active plan
- area files selected through `docs/ai/CONTEXT_MAP.md`
- files explicitly requested by the user

## Max read budget

Before acting, read only the first-read set and the smallest additional area context needed for correctness.
Do not scan the whole repository.
Do not load unrelated docs.

## Path selection

- Trivial: local change, default `VERIFY=V0`
- Focused: bounded multi-file change, default `VERIFY=V1`
- Full: structural or cross-cutting change, default `VERIFY=V2`

Escalate path if risk or uncertainty increases.

## Output contract

- Return only the minimal diff or patch.
- Keep notes short and only when needed for correctness.
- Keep changes explicit and verifiable.
- No workflow recap.
- No file dumps.
- No context replay.

## Verification contract

- Use `V0` for trivial work, `V1` for focused work, and `V2` for full work.
- Escalate verification when risk exceeds the default path.
- Keep verification explicit and minimal.

## Artifact update rules

- For non-trivial work, update `STATE.md` when the next step or focus changes.
- Update a plan only when the implementation path changes.
- Update durable docs only when durable knowledge changes.
- Use `docs/ai/DECISION_RULES.md` before touching roadmap, ADRs, or governance docs.

## Hard prohibitions

- Forcing feedback loops.
- Using GSD commands or skills unless the user explicitly asks.
- Mandatory `ask_user` follow-ups after every deliverable.
- Speculative autonomy.
- Entire file dumps.
