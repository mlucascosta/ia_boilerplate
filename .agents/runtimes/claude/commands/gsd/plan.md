---
name: gsd:plan
description: Plan a phase — optional discussion → research → plan → verify
argument-hint: "[phase] [--auto] [--discuss] [--ui] [--skip-research] [--gaps] [--prd <file>] | add-phase <desc> | insert-phase N <desc> | remove-phase N"
agent: gsd-planner
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Task
  - WebFetch
  - mcp__context7__*
---
<objective>
Create an executable PLAN.md for a roadmap phase.

**Default flow:** Research (if needed) → Plan → Verify → Done

**Flags:**
- `--discuss` — Lightweight discussion phase before planning. Surfaces assumptions, clarifies gray areas, captures decisions in CONTEXT.md. Use when the task has ambiguity worth resolving upfront.
- `--ui` — Generate UI design contract before planning a frontend-heavy phase.
- `--auto` — Skip all interactive questions. Claude picks recommended defaults.
- `--skip-research` — Skip research, go straight to planning.
- `--gaps` — Gap closure mode: reads VERIFICATION.md, creates fix plans, skips research.
- `--prd <file>` — Parse a PRD/acceptance criteria file into CONTEXT.md instead of questioning. Skips discuss phase.
- `add-phase <desc>` — Append a future phase to ROADMAP.md.
- `insert-phase N <desc>` — Insert an urgent future phase after N.
- `remove-phase N` — Remove a future phase safely.

Flags are composable: `/gsd:plan 3 --discuss --auto` discusses then auto-plans.

**After this command:** Run `/gsd:run <phase>` to execute.
</objective>

<execution_context>
@.agents/workflows/plan-phase.md
@.agents/workflows/discuss-phase.md
@.agents/workflows/ui-phase.md
@.agents/workflows/add-phase.md
@.agents/workflows/insert-phase.md
@.agents/workflows/remove-phase.md
@.agents/workflows/plan-milestone-gaps.md
@.agents/references/ui-brand.md
</execution_context>

<context>
Phase number: $ARGUMENTS (optional — auto-detects next unplanned phase if omitted)

Normalize phase input before any directory lookups.
</context>

<process>
If command is `add-phase`, `insert-phase`, or `remove-phase`:
  - Route to the matching roadmap surgery workflow

If `--ui` flag present:
  - Run ui-phase workflow before executable planning

If `--gaps` flag present:
  - Route to plan-milestone-gaps workflow

If `--discuss` flag present:
  - Run discuss-phase workflow first to gather CONTEXT.md
  - Then proceed to plan-phase workflow using CONTEXT.md as input

Otherwise:
  Execute the plan-phase workflow end-to-end.
  Preserve all workflow gates (validation, research, planning, verification loop, routing).
</process>
