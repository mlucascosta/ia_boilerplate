---
name: gsd:session
description: Manage work sessions — resume, pause, check progress, or get next step
argument-hint: "[resume | pause | status | next | report | workspace list]"
allowed-tools:
  - Read
  - Write
  - Bash
  - AskUserQuestion
  - SlashCommand
---
<objective>
Single command for all session management operations.

**`resume` (default when no args):** Restore complete project context and continue work.
- Loads STATE.md, detects checkpoints (.continue-here files)
- Detects incomplete work (PLAN without SUMMARY)
- Presents status and routes to next action

**`pause`:** Create context handoff when stopping mid-phase.
- Creates `.continue-here.md` with full work state
- Commits as WIP
- Provides resume instructions

**`status` or `progress`:** Check project progress and route to next action.
- Shows current phase, completed work, what's ahead
- Routes to execute or plan as appropriate

**`next`:** Detect current state and auto-invoke the next logical workflow step.
- No arguments needed — reads STATE.md + ROADMAP.md
- Designed for rapid multi-project flow

**`report`:** Generate session report with token usage estimates, work summary, and outcomes.

**`workspace list`:** Show available workspaces when juggling multiple sandboxes.
</objective>

<execution_context>
@.agents/workflows/resume-project.md
@.agents/workflows/pause-work.md
@.agents/workflows/progress.md
@.agents/workflows/next.md
@.agents/workflows/list-workspaces.md
</execution_context>

<context>
Arguments: $ARGUMENTS
</context>

<process>
Parse first argument (case-insensitive, default = "resume"):
- `pause` → pause-work workflow
- `status` | `progress` → progress workflow
- `next` → next workflow
- `workspace list` → list-workspaces workflow
- `report` → generate session summary: read STATE.md + recent commits + phase status, output compact report
- `resume` or no args → resume-project workflow

Execute the matched workflow end-to-end.
</process>
