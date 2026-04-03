---
type: adapter
runtime: codex
source_of_truth: .agents/AGENTS.md
canonical_contract: .agents/AGENTS.md
---

# Codex Runtime Adapter

Maps GSD workflow primitives to Codex syntax while deferring behavior to `.agents/AGENTS.md`.

## Skill Invocation
Skills live in `.codex/skills/gsd-<name>/SKILL.md`. Invoked as `$gsd-<name>`.
Arguments available as `{{GSD_ARGS}}` inside the skill file.

## Subagent Spawning
```
spawn_agent(agent_type="gsd-<agent-name>", message="<prompt>")
```
Parallel fan-out: spawn multiple → collect IDs → `wait(ids)` → `close_agent(id)`.
Look for `CHECKPOINT`, `PLAN COMPLETE`, `SUMMARY` markers in output.

## Model Resolution
Codex uses per-role config via `.codex/agents/*.toml`. Omit model parameter inline.

## State Init
```bash
node ".agents/bin/gsd-tools.cjs" state load
```

## @-Reference Paths
Same as Claude: `@.agents/workflows/<name>.md`, `@.agents/templates/<name>.md`.

## Interactive Input
Translate `AskUserQuestion` to `request_user_input`:
- `header` → `header`
- `question` → `question`  
- Options `"Label" — desc` → `{label: "Label", description: "desc"}`
- Generate `id` from header: lowercase, underscores
- Execute mode fallback: plain-text numbered list, pick reasonable default
