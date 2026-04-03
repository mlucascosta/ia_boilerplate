---
name: gsd:run
description: Execute work — full phase, quick task, or trivial inline fix
argument-hint: "[phase | task description] [--quick] [--fast] [--interactive] [--wave N] [--gaps-only] [--review [phase]] [--workspace new|list|remove] [--milestone audit|complete] [--forensics <issue>]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - Bash
  - Task
  - TodoWrite
  - AskUserQuestion
---
<objective>
Three execution modes in one command:

**Default (phase number provided):** Execute all plans in a phase with wave-based parallelization.
- Spawns gsd-executor subagents per plan
- Handles checkpoints, state updates, commits
- Supports `--wave N` to execute only one wave
- Supports `--gaps-only` to execute only gap closure plans
- Supports `--interactive` for inline sequential execution (no subagents, pair-programming style)

**`--quick` (or no phase, task description provided):** Quick task with GSD guarantees.
- Spawns gsd-planner (quick mode) + gsd-executor
- Updates STATE.md quick tasks table (not ROADMAP)
- Skips research, discussion, plan-checker, verifier by default
- Add `--research` to spawn research agent before planning
- Add `--full` to enable plan-checking + post-execution verification

**`--fast` (trivial one-liner):** Execute inline without subagents or PLAN.md.
- For tasks completable in under 2 minutes: typo fixes, config changes, small refactors
- No Task spawning, no planning overhead

**Operational flags:** absorb specialist workflows without creating new top-level commands.
- `--review [phase]` → cross-AI review
- `--workspace new|list|remove` → multi-workspace operations
- `--milestone audit|complete` → milestone audit / completion
- `--forensics <issue>` → post-mortem workflow diagnosis

Choose the lightest mode that preserves correctness. Escalate if missing context.
</objective>

<execution_context>
@.agents/workflows/execute-phase.md
@.agents/workflows/quick.md
@.agents/workflows/fast.md
@.agents/workflows/review.md
@.agents/workflows/new-workspace.md
@.agents/workflows/list-workspaces.md
@.agents/workflows/remove-workspace.md
@.agents/workflows/audit-milestone.md
@.agents/workflows/complete-milestone.md
@.agents/workflows/forensics.md
@.agents/references/ui-brand.md
</execution_context>

<context>
Arguments: $ARGUMENTS

**Routing logic:**
1. If `--fast` present → inline trivial execution (fast workflow)
2. If `--quick` present OR arguments are a task description (not a phase number) → quick workflow
3. If `--review` present → review workflow
4. If `--workspace` present → workspace workflow
5. If `--milestone` present → milestone workflow
6. If `--forensics` present → forensics workflow
7. If arguments contain a phase number → execute-phase workflow

**Available flags for execute-phase mode:**
- `--wave N` — Execute only Wave N
- `--gaps-only` — Execute only gap closure plans
- `--interactive` — Sequential inline execution, no subagents

**Available flags for quick mode:**
- `--research` — Spawn research agent before planning
- `--full` — Enable plan-checking + post-execution verification
- `--discuss` — Lightweight discussion before planning

Context files are resolved inside the workflow via `gsd-tools init`.
</context>

<process>
Parse $ARGUMENTS to determine mode:
- `--fast` flag → run fast workflow end-to-end
- `--quick` flag or task description (no phase number) → run quick workflow end-to-end
- `--review` → run review workflow
- `--workspace` → run matching workspace workflow
- `--milestone` → run milestone audit or completion workflow
- `--forensics` → run forensics workflow
- Phase number detected → run execute-phase workflow end-to-end

Preserve all workflow gates in whichever mode runs.
</process>
