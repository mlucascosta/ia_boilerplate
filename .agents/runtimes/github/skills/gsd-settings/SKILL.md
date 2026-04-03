---
name: "gsd-settings"
description: "Configure GSD workflow toggles, model profile, and cost controls"
metadata:
  short-description: "Configure GSD workflow toggles, model profile, and cost controls"
---

<objective>
Configure GSD behavior.

Default: Interactive multi-question configuration (model profile, agent toggles, git branching).
--profile <name>: Switch profile immediately — quality | balanced | budget | inherit.
--show: Display current config without changes.

Cost guidance:
- Solo/MVP: budget (~50% cost reduction)
- Non-Anthropic providers (OpenRouter, Ollama, local): inherit (required)
- Critical architecture: quality or balanced
</objective>

<execution_context>
@.agents/workflows/settings.md
</execution_context>

<context>
{{GSD_ARGS}}
</context>

<process>
Parse arguments:
- --show → read .planning/config.json, display current settings
- --profile <name> → validate, update model_profile in config.json, confirm
- No args → execute settings workflow interactively
</process>
