---
name: gsd:settings
description: Configure GSD workflow toggles, model profile, and cost controls
argument-hint: "[--profile quality|balanced|budget|inherit] [--show]"
allowed-tools:
  - Read
  - Write
  - Bash
  - AskUserQuestion
---

<objective>
Configure GSD behavior interactively or via flags.

**Default (no args):** Interactive multi-question configuration.
- Model profile (quality / balanced / budget / inherit)
- Workflow agent toggles (research, plan_check, verifier, nyquist)
- Git branching strategy
- Confirmation display with quick command references

**`--profile <name>`:** Switch model profile immediately without interaction.
- `quality` — Opus for planning, Sonnet for execution (highest quality, highest cost)
- `balanced` — Opus for planning only, Sonnet elsewhere (default)
- `budget` — Sonnet for code writes, Haiku for research/verification (~50% cost reduction)
- `inherit` — All agents use the session model (**required for non-Anthropic providers**: OpenRouter, Ollama, local models)

**`--show`:** Display current configuration without changing anything.

**Cost guidance:**
- Solo developers / MVPs: start with `budget`
- Non-Anthropic providers (OpenRouter, local): always use `inherit`
- Critical architecture work: use `quality` or `balanced`
</objective>

<execution_context>
@.agents/workflows/settings.md
</execution_context>

<context>
Arguments: $ARGUMENTS
</context>

<process>
Parse $ARGUMENTS:
- `--show` → read .planning/config.json and display current settings, done
- `--profile <name>` → validate profile name, update model_profile in .planning/config.json, confirm
- No args → follow settings workflow end-to-end (interactive)

The interactive workflow handles:
1. Config file creation with defaults if missing
2. Current config reading
3. Interactive settings presentation with pre-selection
4. Answer parsing and config merging
5. File writing
6. Confirmation display
</process>
