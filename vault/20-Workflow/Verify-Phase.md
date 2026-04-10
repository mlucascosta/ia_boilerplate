---
tags: [skills, verify-phase, workflow]
---

# Verify Phase

The verify-phase skill validates that a delivered phase actually achieves its goal — not just that tasks completed.

## Goal-Backward Analysis

Start from the phase goal, not the task list:
1. What was the phase supposed to deliver?
2. Does the codebase now deliver that?
3. Is there evidence (test output, build output, manual check)?

## Output: VERIFICATION.md

Location: `.planning/verification/VERIFICATION.md`

Structure:

```md
# Verification: [Phase Name]

## Goal
[Restate the phase goal]

## Done Criteria Audit
- [x] T1: unit tests pass — EVIDENCE: rtk cargo test output
- [x] T2: API returns 201 on valid input — EVIDENCE: integration test
- [ ] T3: rate limiter blocks >100 req/s — BLOCKED: not yet implemented

## Gaps
- Gap 1: [description] → Fix plan: ...

## Verdict
PASS / PARTIAL / BLOCK
```

## Verification Levels

| Level | Evidence Required |
|---|---|
| V0 | Reasoning only — no execution |
| V1 | One targeted check (test run or build) |
| V2 | Multiple checks + output evidence |
| V3 | Unit + integration + E2E all passing |

## When Gaps Are Found

- PASS with gaps → create fix tasks, continue to next phase
- BLOCK → stop, surface blocker, do not mark phase done

## File Reference

Skill definition: `.agents/skills/verify-phase/SKILL.md`
