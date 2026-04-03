# Workflow — Pocket Card

Mandatory first read. Consult `WORKFLOW.md` only when ambiguity requires it.

## Paths

| Path | When | Steps |
| --- | --- | --- |
| **Trivial** | ≤1 file, local, low-risk | confirm → edit → smallest validation |
| **Focused** | 2–3 files or needs validation | read → clarify → plan → implement → validate |
| **Full** | >3 files, auth, billing, infra, migration | map → docs → plan → gates → execute → verify → capture |

Pick the **lightest** path that preserves correctness. Escalate if missing context.

## Delivery model

Hybrid: governance (VISION, ROADMAP, ADRs, RISK_REGISTER) + execution (STATE, plans, summaries, verification).
Humans own judgment/approval. AI accelerates execution. See `PROJECT_METHOD.md` + `DECISION_RULES.md`.

## Verification

V0 = reasoning only (Trivial) · V1 = one check (Focused) · V2 = multi-check + evidence (Full).

## Context & output rules

- Read: pocket card + 1 active artifact + `CONTEXT_MAP.md` area files + cited files.
- If an active plan exists, treat it as the hot execution artifact; keep `STATE.md` as the global header only.
- Prefer flags and manifests over prose. If plan flags already express scope, files, exclusions, and verification, do not restate them.
- Output: diff/patch only. No recap, no file dumps.
- STATE ≤120 words, no history. Compress immediately if exceeded.
- Summaries ≤120 words. Plans ≤180 words. ROADMAP ≤12 bullets.

## Session reset

>12 turns, >3 scope changes, or >2 failed attempts → SUMMARY → compress STATE → restart from STATE + PLAN.

## Large scopes

Never execute in one pass → `STATE → ROADMAP → epics → atomic plans → one slice → summary → next`

## Task flags (top of every plan)

`SCOPE=trivial|focused|full  DOC=full|min  ARCH=solid|none  VERIFY=V0|V1|V2  FILES=<paths>  OUT=<exclusions>`

## Definition of Done

Scoped change implemented + validation done + summarized + STATE updated + no hidden structural decisions.
