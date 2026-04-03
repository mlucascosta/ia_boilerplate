---
name: gsd-start
description: Initialize a new project or milestone — context gathering → research → requirements → roadmap
---

<objective>
Initialize a new project or milestone — context gathering → research → requirements → roadmap.

**Default:** questioning → research (optional) → requirements → roadmap.
**`--milestone "Name"`:** New milestone on existing project.
**`--map [area]`:** Brownfield codebase mapping before planning.
**`--auto`:** Skip interactive questions.
After: run `/gsd:plan 1` to begin execution.
</objective>

<execution_context>
@.agents/workflows/new-project.md
@.agents/workflows/new-milestone.md
@.agents/workflows/map-codebase.md
</execution_context>

<process>
If `--milestone` flag present: update ROADMAP.md with new milestone, update STATE.md.
If `--map` flag present: run brownfield codebase mapping before project planning.
Otherwise: execute new-project workflow end-to-end.
</process>
