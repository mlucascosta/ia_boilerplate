# Example: Adding a New Feature (End-to-End Flow)

This example shows a complete cycle using the IA Boilerplate workflow — from objective definition to session handoff — applied to a concrete task: **adding a user notification endpoint to a Node.js API**.

Use this as a reference when starting any non-trivial task.

---

## Stage 1 — Define objective in STATE.md

```md
# State

## Objective
Add POST /notifications endpoint that creates a user notification record and emits a queue event.

## Active Work
- Discovery: reading existing route and service patterns.

## Locked Decisions
1. Use existing express router pattern in src/routes/.
2. Emit to queue via the established JobQueue service.

## Open Questions
1. Should failed queue emissions retry automatically or surface an error to the caller?

## Blockers
None.

## Next Step
Write atomic plan: 01-notifications-endpoint-PLAN.md
```

---

## Stage 2 — Write atomic plan in .planning/plans/

```md
# Plan: notifications-endpoint

## Objective
Add POST /notifications endpoint that creates a record and emits a queue event.

## Scope
- src/routes/notifications.ts (new)
- src/services/NotificationService.ts (new)
- src/routes/index.ts (register new router)

## Constraints
- Follow existing route + service pattern (see src/routes/users.ts).
- Complete TSDoc on all exported functions and classes.
- Do not introduce new npm dependencies.

## Documentation Strategy
TSDoc on router handler and service methods. Inline comment on queue emission failure path.

## Verification
- [ ] POST /notifications returns 201 with created record.
- [ ] Queue receives the notification event (unit test with mock).
- [ ] No TypeScript errors: npx tsc --noEmit.

## Done Criteria
All verification checkboxes pass. No lint errors. TSDoc present on all exports.
```

---

## Stage 3 — Execute (minimal diff)

Only the 3 files in the plan scope are touched. No speculative refactors.

Reference file paths in prompts instead of pasting content:

> "Implement the plan in `.planning/plans/01-notifications-endpoint-PLAN.md`. Follow the pattern in `src/routes/users.ts`. Return only diffs for the 3 expected files."

---

## Stage 4 — Verify

```bash
npx tsc --noEmit          # 0 errors
npx jest notifications    # tests pass
curl -X POST http://localhost:3000/notifications -d '{"userId":1,"message":"hello"}'
# → 201 {"id": 42, "userId": 1, "message": "hello"}
```

Log results in `.planning/verification/01-notifications-VERIFICATION.md`.

---

## Stage 5 — Handoff summary (max 180 words)

```md
# Handoff: 2026-04-02

**Objective:** Add POST /notifications endpoint with queue emission.
**Current Slice:** 01-notifications-endpoint-PLAN.md — complete.
**Changed Files:**
- src/routes/notifications.ts (new)
- src/services/NotificationService.ts (new)
- src/routes/index.ts (router registration)

**Checks Run:**
- npx tsc --noEmit → pass
- npx jest notifications → 4/4 pass
- manual curl → 201 OK

**Open Risks:**
- Queue retry behavior on emission failure is not yet decided (open question from STATE.md).
- No integration test against real queue — only mock.

**Next Action:** Resolve retry policy question, then add integration test.
```

Update `.planning/STATE.md` with the next action above.

---

## Key takeaways from this example

1. Objective was explicit before any code was written.
2. Plan bounded scope to 3 files — no drift.
3. Prompts referenced file paths, not pasted content.
4. Verification was explicit before the slice was closed.
5. Handoff is under 180 words and self-contained for the next session or agent.
