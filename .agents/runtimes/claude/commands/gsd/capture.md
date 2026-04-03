---
name: gsd:capture
description: Zero-friction idea capture — note, todo, backlog item, or seed
argument-hint: "<text> | list | todo <text> | backlog <text> | seed <text>"
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
---
<objective>
Capture ideas and tasks without breaking flow.

**Default (text only):** Save a timestamped note. No questions, no formatting.

**`list`:** Show all notes from project and global scopes.

**`todo <text>`:** Capture as a structured todo item in `.planning/todos.md`.
Promotes to the active work queue.

**`backlog <text>`:** Park an idea in the backlog (999.x numbering) for future milestone review.
Low-friction deferral — doesn't pollute active roadmap.

**`seed <text>`:** Save a forward-looking idea with trigger conditions for later surfacing.

Runs inline — no Task, no AskUserQuestion, no Bash.
</objective>

<execution_context>
@.agents/workflows/note.md
@.agents/workflows/plant-seed.md
</execution_context>

<context>
$ARGUMENTS
</context>

<process>
Parse first token of $ARGUMENTS:
- `list` → show all notes
- `todo` → capture rest of args as structured todo item in .planning/todos.md
- `backlog` → assign 999.x phase number, append to .planning/ROADMAP.md backlog section
- `seed` → route to plant-seed workflow
- anything else (default) → capture as timestamped note via note workflow

For note and todo captures: one Write call, one confirmation line. Done.
</process>
