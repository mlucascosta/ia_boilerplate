---
name: "gsd-session"
description: "Manage work sessions — resume, pause, check progress, or get next step"
metadata:
  short-description: "Manage work sessions — resume, pause, check progress, or get next step"
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
Session management: resume (default), pause, status/progress, next, report.

resume: Restore context from STATE.md, detect checkpoints, route to next action.
pause: Create .continue-here.md handoff, commit as WIP.
status/progress: Show progress and route to execute or plan.
next: Auto-detect state and invoke next logical workflow step.
report: Session summary with work done and outcomes.
workspaces: `workspace list` for current workspace inventory.
</objective>

<context>
{{GSD_ARGS}}
</context>

<process>
Parse first argument (default = resume):
- pause → pause-work workflow
- status/progress → progress workflow
- next → next workflow
- workspace list → list-workspaces workflow
- report → read STATE.md + recent commits, output compact summary
- resume or no args → resume-project workflow
</process>

<execution_context>
@.agents/workflows/resume-project.md
@.agents/workflows/pause-work.md
@.agents/workflows/progress.md
@.agents/workflows/next.md
@.agents/workflows/list-workspaces.md
</execution_context>
