---
tags: [ai-workflow, agent-contract, behavior]
---

# Agent Contract

How all AI agents (Claude, Copilot, Gemini, Codex) must behave in this project.

## Source of Truth Order

1. `.agents/AGENTS.md` — canonical repository contract
2. `docs/ai/WORKFLOW_SHORT.md` — pocket reference, read first every session
3. `docs/ai/WORKFLOW.md` — full reference, consult only when ambiguous
4. `docs/ai/ARTIFACTS.md` — artifact contract

## Path Selection

| Situation | Path | Default Verify |
|---|---|---|
| ≤1 file, no cross-cutting impact | **Trivial** | V0 |
| 2–3 files or requires validation | **Focused** | V1 |
| >3 files, auth, billing, infra, migration | **Full** | V2 |
| User-facing or system risk | **Full+** | V3 |

Escalate path if correctness is at risk — never guess when missing context.

## First Read Per Session

1. `docs/ai/WORKFLOW_SHORT.md`
2. One active artifact: `.planning/STATE.md` or the active plan
3. Area files from `docs/ai/CONTEXT_MAP.md`
4. Files explicitly cited in the task

## Output Contract

- Return **only** the minimal diff or patch
- No workflow recap
- No file dumps
- No context replay
- Prefer flags and manifests over prose

## RTK Requirement

All shell commands must use `rtk`. See [[RTK/RTK-Commands]].

No exceptions. The auto-rewrite hook handles transparent interception after `rtk init`.

## Verification Levels

| Level | When | What |
|---|---|---|
| V0 | Trivial | Reasoning only — no test run |
| V1 | Focused | One targeted check (e.g. unit test) |
| V2 | Full | Multi-check + evidence |
| V3 | High risk | Unit + Integration + E2E |

## State Management

- `.planning/STATE.md` ≤ 120 words, telegraphic
- Archive stale context to `.planning/summaries/`
- Treat chat history as temporary memory only

## Hard Prohibitions

- Pasting entire files
- Re-explaining the workflow
- Running raw shell commands without `rtk`
- Implementing first, adding tests later
- Treating chat history as the source of truth
