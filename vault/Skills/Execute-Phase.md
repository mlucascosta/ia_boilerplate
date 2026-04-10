---
tags: [skills, execute-phase, workflow]
---

# Execute Phase

The execute-phase skill implements a planned slice of work with TDD-first delivery and proportional verification.

## When to Use

- A `PLAN.md` exists and is approved
- Tasks are clearly bounded and atomic
- Done criteria are defined

## Execution Loop

```
For each task in PLAN.md:
  1. Write the test (it must fail)
  2. Implement the minimum code to pass
  3. Refactor under SOLID constraints
  4. Commit atomically: rtk git commit -m "feat: ..."
  5. Mark task complete in plan
```

## Deviation Handling

If a task deviates from the plan:
- Stop and surface the deviation explicitly
- Note impact on other tasks
- Update PLAN.md before continuing if scope changes

## Verification

| Path | Required |
|---|---|
| Trivial | V0 — reasoning only |
| Focused | V1 — targeted test run |
| Full | V2 — multi-check evidence |
| High risk | V3 — unit + integration + E2E |

Run tests via RTK (always):

```sh
rtk cargo test     # or rtk pytest, rtk go test, rtk vitest run
```

## Completion

When all tasks are done:
1. Update `.planning/STATE.md` with outcome
2. Write `.planning/verification/VERIFICATION.md`
3. Archive session to `.planning/summaries/` if session is closing

## File Reference

Skill definition: `.agents/skills/execute-phase/SKILL.md`
