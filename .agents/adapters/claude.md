---
type: adapter
runtime: claude
source_of_truth: .agents/AGENTS.md
canonical_contract: .agents/AGENTS.md
---

# Claude Code Runtime Adapter

Maps GSD workflow primitives to Claude Code syntax while deferring behavior to `.agents/AGENTS.md`.

## Skill Invocation
Skills live in `.claude/commands/gsd/`. Invoked as `/gsd:<name>` in Claude Code.
Arguments available as `$ARGUMENTS` inside the skill file.

## Subagent Spawning
```
Task(
  prompt="<prompt>",
  subagent_type="gsd-<agent-name>",
  model="<resolved-model>",
  description="<short description>"
)
```

## Model Resolution
```bash
node ".agents/bin/gsd-tools.cjs" resolve-model gsd-planner --raw
```

## State Init
```bash
INIT=$(node ".agents/bin/gsd-tools.cjs" state load)
if [[ "$INIT" == @file:* ]]; then INIT=$(cat "${INIT#@file:}"); fi
```

## @-Reference Paths
Workflow files referenced as: `@.agents/workflows/<name>.md`
Template files: `@.agents/templates/<name>.md`
Reference files: `@.agents/references/<name>.md`

## Interactive Input
Use `AskUserQuestion` tool with `header`, `question`, optional `options` array.

## Context Budget
Orchestrators: ~15% of context. Each spawned agent: 100% fresh context.
Agents self-load context via `<files_to_read>` blocks in their prompt.
