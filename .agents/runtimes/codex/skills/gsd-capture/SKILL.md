---
name: "gsd-capture"
description: "Zero-friction idea capture — note, todo, or backlog item"
metadata:
  short-description: "Zero-friction idea capture — note, todo, or backlog item"
---

<codex_skill_adapter>
## A. Skill Invocation
- Invoked by mentioning `$gsd-SLUG`.
- Treat all user text after `$gsd-SLUG` as `{{GSD_ARGS}}`.

## B. AskUserQuestion → request_user_input Mapping
- `header` → `header`, `question` → `question`
- Execute mode fallback: plain-text numbered list, pick reasonable default

## C. Task() → spawn_agent Mapping
- `Task(subagent_type="X", prompt="Y")` → `spawn_agent(agent_type="X", message="Y")`
- `Task(model="...")` → omit
- Parallel: spawn → collect IDs → `wait(ids)` → `close_agent(id)`
</codex_skill_adapter>

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
