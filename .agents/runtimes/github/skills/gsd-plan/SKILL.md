---
name: gsd-plan
description: Plan a phase — optional discussion → research → plan → verify
---

<objective>
Create an executable PLAN.md for a roadmap phase.

Default flow: Research (if needed) → Plan → Verify → Done

Flags:
- `--discuss` — Clarify assumptions before planning
- `--ui` — Generate UI design contract before planning
- `--auto` — Skip questions, use recommended defaults
- `--skip-research` — Go straight to planning
- `--gaps` — Gap closure mode from VERIFICATION.md
- `--prd <file>` — Parse PRD into CONTEXT.md
- `add-phase "desc"` — Append future phase to roadmap
- `insert-phase N "desc"` — Insert future phase after N
- `remove-phase N` — Remove future phase safely

After: run gsd-run <phase> to execute.
</objective>

<context>
Phase: {{GSD_ARGS}} (auto-detects next unplanned if omitted)
</context>

<process>
Route by intent:
- `add-phase` → add-phase workflow
- `insert-phase` → insert-phase workflow
- `remove-phase` → remove-phase workflow
- `--ui` → ui-phase workflow
- `--gaps` → plan-milestone-gaps workflow
- `--discuss` → discuss-phase workflow first, then plan-phase
- otherwise → execute plan-phase workflow end-to-end
</process>

<execution_context>
@.agents/workflows/plan-phase.md
@.agents/workflows/discuss-phase.md
@.agents/workflows/ui-phase.md
@.agents/workflows/add-phase.md
@.agents/workflows/insert-phase.md
@.agents/workflows/remove-phase.md
@.agents/workflows/plan-milestone-gaps.md
</execution_context>
