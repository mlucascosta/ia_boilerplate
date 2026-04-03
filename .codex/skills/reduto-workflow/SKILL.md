---
name: reduto-workflow
description: "Minimal Codex adapter for this repository."
---

# Codex adapter

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

If an active plan exists, use it as the local execution guide and keep `STATE.md` as the global header only.

## Max read budget

Before acting, read only the first-read set and the smallest additional area context needed for correctness.
Do not scan the whole repository.
Do not load unrelated docs.

## Path selection

- Trivial: one local change, default `VERIFY=V0`
- Focused: bounded multi-file change, default `VERIFY=V1`
- Full: structural or cross-cutting change, default `VERIFY=V2`

Escalate path if correctness is at risk.

## Output contract

- Return only the minimal diff or patch.
- Add a targeted note only when required for correctness.
- Add the exact next step only when the task remains open.
- Prefer flags and manifests over prose. Do not restate plan flags in natural language.
- No workflow recap.
- No file dumps.
- No context replay.

## Verification contract

- Use `V0` for trivial work, `V1` for focused work, and `V2` for full work.
- Escalate verification when risk exceeds the default path.
- Keep verification explicit and minimal.

## Artifact update rules

- Keep `.planning/` current for phased or risky work.
- Use `docs/ai/DECISION_RULES.md` before touching roadmap, ADRs, or governance docs.
- Preserve documented architecture and avoid undeclared platform shifts.
- Treat chat history as temporary memory only.

## Hard prohibitions

- Inventing a Codex-only workflow.
- Full file pastes.
- Context replay.
- Hidden structural drift.