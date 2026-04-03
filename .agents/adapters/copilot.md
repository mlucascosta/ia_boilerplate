---
type: adapter
runtime: copilot
source_of_truth: .agents/AGENTS.md
canonical_contract: .agents/AGENTS.md
---

# GitHub Copilot Runtime Adapter

Maps GSD workflow primitives to Copilot syntax while deferring behavior to `.agents/AGENTS.md`.

## Skill Invocation
Skills live in `.github/skills/gsd-<name>/SKILL.md`.
Invoked via GitHub Copilot agent in the IDE or GitHub.com.

## Subagent Spawning
Copilot does not support subagent spawning natively.
For multi-step workflows, orchestrate inline using sequential tool calls.

## @-Reference Paths
Same as Claude and Codex: `@.agents/workflows/<name>.md`.

## Context Budget
Copilot has a smaller context window. Prefer compact workflows.
Load only the specific workflow file — do not preload all references.

## No Interactive Prompts
Copilot does not support interactive input during execution.
Use argument parsing from the skill invocation instead.
