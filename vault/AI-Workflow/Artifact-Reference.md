---
tags: [ai-workflow, artifacts, planning]
---

# Artifact Reference

All planning and delivery work is driven by repository artifacts — not chat history.

## Artifact Hierarchy

```
.planning/
  STATE.md          ← Global session header (≤120 words, telegraphic)
  ROADMAP.md        ← Phased work, milestone definitions
  plans/
    PLAN.md         ← Active execution plan for current phase
  verification/
    VERIFICATION.md ← Evidence that phase goal was achieved
  summaries/
    *.md            ← Archived session handoffs (≤180 words each)
```

## STATE.md Rules

- Maximum 120 words
- Telegraphic format — no prose
- Rotate stale context to `summaries/` first
- Must contain: current phase, next step, blockers (if any)

## PLAN.md Rules

- One plan per phase
- Tasks are atomic and verifiable
- Done criteria are explicit before execution starts
- When an active plan exists: it is the hot execution artifact, STATE.md is the global header

## VERIFICATION.md Rules

- Written after phase completion
- Maps done criteria from the plan to evidence
- Required for V2/V3 verification paths

## Summary Rules (summaries/)

- Maximum 180 words per summary
- Must include: what changed, what was learned, next step
- Archive format: `YYYY-MM-DD-phase-name.md`

## When to Update Artifacts

| Trigger | Update |
|---|---|
| Next step or focus changes | STATE.md |
| Implementation path changes | PLAN.md |
| Phase complete | VERIFICATION.md |
| Context > 12 turns | Write summary → compress STATE |
| Durable knowledge changes | Governance docs (use DECISION_RULES.md) |
