---
name: gsd-help
description: Show available GSD commands and usage guide
---

<objective>
Display the GSD command reference. Output ONLY the reference below — no additions.
</objective>

<process>
Output the following reference directly:

---

# GSD Command Reference

11 commands. Compact surface, full workflow.

## Core Loop

| Command | Purpose |
|---------|---------|
| `$gsd-start` | Initialize project or new milestone |
| `$gsd-plan [phase]` | Plan a phase (research → plan → verify) |
| `$gsd-run [phase]` | Execute work (phase, quick task, or trivial fix) |
| `$gsd-verify [phase]` | Validate built features via UAT |
| `$gsd-ship [phase]` | Push branch, create PR, prepare for merge |

## Support

| Command | Purpose |
|---------|---------|
| `$gsd-debug [issue]` | Systematic debugging with subagent isolation |
| `$gsd-session` | Resume, pause, check progress, or get next step |
| `$gsd-capture <text>` | Capture note, todo, or backlog item |
| `$gsd-settings` | Configure model profile and workflow toggles |
| `$gsd-update` | Refresh runtime bundle and changelog |
| `$gsd-help` | Show this reference |

---

## Typical Flow

```
$gsd-start                    # new project → PROJECT.md + ROADMAP.md
$gsd-plan 1                   # plan phase 1 → PLAN.md
$gsd-run 1                    # execute phase 1
$gsd-verify 1                 # UAT validation
$gsd-ship 1                   # create PR
$gsd-session next             # advance to phase 2
```

---

## Cost Profiles

| Profile | Use When | Cost Impact |
|---------|----------|-------------|
| `quality` | Critical architecture | Highest |
| `balanced` | Normal development (default) | Medium |
| `budget` | Solo dev, MVPs, high-volume | ~50% lower |
| `inherit` | OpenRouter, Ollama, local models | Zero Anthropic cost |

Set profile: `$gsd-settings --profile budget`

---

## Key Flags

| Command | Flag | Effect |
|---------|------|--------|
| `$gsd-start` | `--milestone 'v1.1'` | New milestone |
| `$gsd-start` | `--map [area]` | Brownfield codebase mapping before planning |
| `$gsd-plan` | `--discuss` | Clarify assumptions first |
| `$gsd-plan` | `--ui` | Generate UI design contract before planning |
| `$gsd-plan` | `add-phase "desc"` | Append future roadmap phase |
| `$gsd-plan` | `insert-phase N "desc"` | Insert urgent future phase |
| `$gsd-plan` | `remove-phase N` | Remove future phase safely |
| `$gsd-plan` | `--gaps` | Fix plans from verification gaps |
| `$gsd-run` | `--quick <task>` | Quick task with GSD guarantees |
| `$gsd-run` | `--fast <task>` | Trivial inline edit |
| `$gsd-run` | `--review [phase]` | Cross-AI review before ship |
| `$gsd-run` | `--workspace new|list|remove` | Multi-workspace operations |
| `$gsd-run` | `--milestone audit|complete` | Milestone operations |
| `$gsd-run` | `--interactive` | Sequential, no subagents |
| `$gsd-verify` | `--audit` | Cross-phase UAT gap scan |
| `$gsd-verify` | `--validate [phase]` | Validation debt audit for completed work |
| `$gsd-verify` | `--health [--repair]` | Planning directory diagnostics |
| `$gsd-session` | `pause` | Save context handoff |
| `$gsd-session` | `report` | Token usage summary |
| `$gsd-capture` | `todo <text>` | Add to active queue |
| `$gsd-capture` | `backlog <text>` | Park for future milestone |
| `$gsd-capture` | `seed <text>` | Save idea with later trigger |
| `$gsd-settings` | `--profile budget` | Cut costs ~50% |
| `$gsd-settings` | `--profile inherit` | Required for non-Anthropic |
</process>
