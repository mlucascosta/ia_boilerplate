---
name: workflow-core
description: Canonical repository workflow contract for all runtimes.
---

# Purpose

Load the shared operating contract from `.agents/AGENTS.md` and route work through the canonical repository workflow.

# Read First

- `.agents/AGENTS.md`
- `docs/ai/WORKFLOW_SHORT.md`
- `docs/ai/ARTIFACTS.md`

# Use When

- Any runtime needs the canonical repository rules
- A task needs path selection, verification level, or artifact guidance

# Output

- Minimal diff or patch
- Explicit verification evidence only when needed

# Prohibitions

- No runtime-specific rule invention
- No duplicate policy outside `.agents/`
