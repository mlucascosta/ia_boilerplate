# Workflow — Pocket Card

Mandatory first read. Consult `WORKFLOW.md` only when ambiguity requires it.

## Paths

| Path | When | Steps |
| --- | --- | --- |
| **Trivial** | ≤1 file, local, low-risk | confirm locality → edit → smallest validation |
| **Focused** | 2–3 files or needs validation | read → clarify → short plan → implement → validate → update docs if needed |
| **Full** | >3 files, auth, billing, infra, migration, cross-cutting | map → docs → brainstorm → plan → quality gates → execute → verify → capture |

Pick the **lightest** path that preserves correctness. Escalate if missing context.

## Delivery model

Hybrid: governance (stable direction) + adaptive execution (daily delivery).
- Governance artifacts: VISION, ROADMAP, architecture docs, ADRs, RISK_REGISTER.
- Execution artifacts: STATE, plans, summaries, verification, handoffs.
- Humans own judgment and approval. AI accelerates execution.
- See `PROJECT_METHOD.md` for full rationale. `DECISION_RULES.md` for when to update what.

## Verification

| Level | Scope |
| --- | --- |
| V0 | Reasoning only |
| V1 | One targeted check |
| V2 | Multi-check + evidence |

## Context rules

- Read at most: 1 workflow file + 1 active artifact + cited files.
- Use `docs/ai/CONTEXT_MAP.md` for area-specific file lists.
- Output: diff/patch only. No recap, no file dumps.
- STATE.md ≤120 words. No history inside it.
- Summaries ≤120 words. Plans ≤180 words.

## Session reset

Reset if: >12 turns, >3 scope changes, or >2 failed attempts.
→ write SUMMARY → compress STATE → restart from STATE + PLAN.

## Large scopes

Never execute broad requests in one pass.
→ `STATE.md → ROADMAP.md → epics → atomic plans → execute one slice → summary → next slice`

## Task manifest (top of every plan)

```
SCOPE=trivial|focused|full  DOC=full|min  ARCH=solid|none
VERIFY=V0|V1|V2  FILES=<paths>  OUT=<exclusions>
```

## Prohibited

- Pasting entire files (excerpts OK).
- Re-reading everything when scope can be explicit.
- Combining unrelated tasks in one prompt.
- Skipping handoff summaries at session boundaries.

## Definition of Done

A slice is done only when: scoped change implemented + validation done + summarized + STATE updated + no hidden structural decisions.
