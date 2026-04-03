---
name: gsd-capture
description: Zero-friction idea capture — note, todo, or backlog item
---

<objective>
Capture ideas without breaking flow.

Default (text): Save timestamped note. No questions.
list: Show all notes.
todo <text>: Add to .planning/todos.md.
backlog <text>: Park with 999.x numbering in ROADMAP.md backlog.
seed <text>: Save forward-looking idea with trigger conditions.

Inline — no subagents.
</objective>

<context>
{{GSD_ARGS}}
</context>

<process>
Parse first token: list / todo / backlog / seed / default(note).
Route:
- `seed` → plant-seed workflow
- otherwise → note workflow or inline write
</process>

<execution_context>
@.agents/workflows/note.md
@.agents/workflows/plant-seed.md
</execution_context>
