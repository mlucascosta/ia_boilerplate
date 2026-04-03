---
name: gsd:start
description: Initialize a new project or milestone — context gathering → research → requirements → roadmap
argument-hint: "[--milestone 'v1.1 Name'] [--map [area]] [--auto]"
allowed-tools:
  - Read
  - Bash
  - Write
  - Task
  - AskUserQuestion
---
<objective>
Start a project or milestone cycle.

**Default (no flags):** Initialize a new project through unified flow:
questioning → research (optional) → requirements → roadmap.

Creates:
- `.planning/PROJECT.md` — project context
- `.planning/config.json` — workflow preferences (budget profile, inherit for non-Anthropic)
- `.planning/REQUIREMENTS.md` — scoped requirements
- `.planning/ROADMAP.md` — phase structure
- `.planning/STATE.md` — project memory

**`--milestone 'Name'`:** Start a new milestone cycle on an existing project.
Updates PROJECT.md with new milestone scope, routes to requirements gathering.

**`--map [area]`:** Brownfield codebase mapping before planning.
Maps existing stack, structure, conventions, tests, or concerns.

**`--auto`:** Skip interactive questions. Runs research → requirements → roadmap
without further interaction. Pass idea via @ reference.

After this command: run `/gsd:plan 1` to begin execution.
</objective>

<execution_context>
@.agents/workflows/new-project.md
@.agents/workflows/new-milestone.md
@.agents/workflows/map-codebase.md
@.agents/references/questioning.md
@.agents/templates/project.md
@.agents/templates/requirements.md
</execution_context>

<context>
$ARGUMENTS

**Routing:**
- No flags or `--auto` → run new-project workflow
- `--milestone` → run new-milestone workflow: update PROJECT.md, gather new milestone requirements, update ROADMAP.md
- `--map` → run map-codebase workflow before planning
</context>

<process>
If `--milestone` flag present:
  - Read .planning/PROJECT.md and .planning/ROADMAP.md for current state
  - Ask milestone name if not provided in flag value
  - Add new milestone section to ROADMAP.md
  - Update STATE.md with new milestone objective
  - Commit and confirm next step: `/gsd:plan <first phase of new milestone>`

If `--map` flag present:
  - Run map-codebase workflow for requested area or auto-detect broad brownfield needs
  - Write codebase orientation artifacts before the first plan

Otherwise:
  Execute the new-project workflow end-to-end.
  Preserve all workflow gates (validation, approvals, commits, routing).
</process>
