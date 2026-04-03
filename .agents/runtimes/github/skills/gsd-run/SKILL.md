---
name: gsd-run
description: Execute work — full phase, quick task, or trivial inline fix
---

<objective>
Three execution modes:

Default (phase number): Execute all plans with wave-based parallelization.
--quick (or task description): Quick task with GSD guarantees. Add --research or --full for extras.
--fast (trivial): Inline edit, no planning, no subagents.

Routing:
1. --fast → fast workflow
2. --quick or task description → quick workflow
3. --review → review workflow
4. --workspace new|list|remove → workspace workflows
5. --milestone audit|complete → milestone workflows
6. --forensics → forensics workflow
7. Phase number → execute-phase workflow

execute-phase flags: --wave N, --gaps-only, --interactive
quick flags: --research, --full, --discuss
ops flags: --review [phase], --workspace new|list|remove, --milestone audit|complete, --forensics "<issue>"
</objective>

<context>
{{GSD_ARGS}}
</context>

<process>
Parse arguments to determine mode and execute the matched workflow end-to-end.
</process>

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
</execution_context>
