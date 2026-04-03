---
type: adapter
runtime: gsd
source_of_truth: .agents/AGENTS.md
---

# GSD Adapter Notes

GSD is used as an operational model, not as the normative source of truth.

## Canonical Rule

- Shared workflow behavior lives in `.agents/`
- Public runtime surfaces stay compact
- Capabilities may be routed through flags and orchestrators instead of exposing the full upstream command tree

## Consumption Model

- Workflows live in `.agents/workflows/`
- Templates live in `.agents/templates/`
- References live in `.agents/references/`
- Canonical subagents live in `.agents/agents/`
- Runtime shims under `.claude/`, `.codex/`, and `.github/` only adapt invocation syntax

## Scope Guard

- Keep the public command surface small
- Prefer shared skills and reusable agents over runtime-specific branching
- Do not reintroduce duplicated behavioral rules outside `.agents/`
