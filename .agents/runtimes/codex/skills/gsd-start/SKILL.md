---
name: "gsd-start"
description: "Initialize a new project or milestone — context gathering → research → requirements → roadmap"
metadata:
  short-description: "Initialize a new project or milestone — context gathering → research → requirements → roadmap"
---

<codex_skill_adapter>
## A. Skill Invocation
- Invoked by mentioning `$gsd-SLUG`.
- Treat all user text after `$gsd-SLUG` as `{{GSD_ARGS}}`.

## B. AskUserQuestion → request_user_input Mapping
- `header` → `header`, `question` → `question`
- Options `"Label" — desc` → `{label: "Label", description: "desc"}`
- Generate `id` from header: lowercase, replace spaces with underscores
- Batched: `AskUserQuestion([q1, q2])` → single `request_user_input` with multiple entries
- Execute mode fallback: plain-text numbered list, pick reasonable default

## C. Task() → spawn_agent Mapping
- `Task(subagent_type="X", prompt="Y")` → `spawn_agent(agent_type="X", message="Y")`
- `Task(model="...")` → omit
- Parallel fan-out: spawn multiple → collect IDs → `wait(ids)` → `close_agent(id)`
- Look for `CHECKPOINT`, `PLAN COMPLETE`, `SUMMARY` markers in output
</codex_skill_adapter>

<objective>
Initialize a new project or milestone — context gathering → research → requirements → roadmap.

**Default:** questioning → research (optional) → requirements → roadmap.
**`--milestone "Name"`:** New milestone on existing project.
**`--map [area]`:** Brownfield codebase mapping before planning.
**`--auto`:** Skip interactive questions.
After: run `$gsd-plan 1` to begin execution.
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
{{GSD_ARGS}}
Routing:
- `--milestone` → new-milestone flow
- `--map` → map-codebase workflow
- otherwise → new-project flow
</context>

<process>
If `--milestone` flag present: update ROADMAP.md with new milestone, update STATE.md.
If `--map` flag present: run brownfield codebase mapping before project planning.
Otherwise: execute new-project workflow end-to-end.
</process>
