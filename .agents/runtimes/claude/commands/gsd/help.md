---
name: gsd:help
description: Show available GSD commands and usage guide
---
<objective>
Display the GSD command reference.

Output ONLY the reference content below. Do NOT add:
- Project-specific analysis
- Git status or file context
- Next-step suggestions
- Any commentary beyond the reference
</objective>

<process>
Output the following reference directly:

---

# GSD Command Reference

11 commands. Compact surface, full workflow.

## Core Loop

```
/gsd:start          Initialize project or new milestone
/gsd:plan [phase]   Plan a phase (research → plan → verify)
/gsd:run [phase]    Execute work (phase, quick task, or trivial fix)
/gsd:verify [phase] Validate built features via UAT
/gsd:ship [phase]   Push branch, create PR, prepare for merge
```

## Support

```
/gsd:debug [issue]  Systematic debugging with subagent isolation
/gsd:session        Resume, pause, check progress, or get next step
/gsd:capture <text> Capture note, todo, or backlog item
/gsd:settings       Configure model profile and workflow toggles
/gsd:update         Refresh runtime bundle and changelog
/gsd:help           Show this reference
```

---

## Typical Flow

```
/gsd:start                    # new project → PROJECT.md + ROADMAP.md
/gsd:plan 1                   # plan phase 1 → PLAN.md
/gsd:run 1                    # execute phase 1
/gsd:verify 1                 # UAT validation
/gsd:ship 1                   # create PR
/gsd:session next             # advance to phase 2
```

---

## Key Flags

| Command | Flag | Effect |
|---------|------|--------|
| `/gsd:start` | `--milestone 'v1.1'` | New milestone on existing project |
| `/gsd:start` | `--map [area]` | Brownfield codebase mapping before planning |
| `/gsd:start` | `--auto` | Skip all questions |
| `/gsd:plan` | `--discuss` | Clarify assumptions before planning |
| `/gsd:plan` | `--ui` | Generate UI design contract before planning |
| `/gsd:plan` | `add-phase "desc"` | Append future roadmap phase |
| `/gsd:plan` | `insert-phase N "desc"` | Insert urgent future phase |
| `/gsd:plan` | `remove-phase N` | Remove future phase safely |
| `/gsd:plan` | `--gaps` | Create fix plans from verification gaps |
| `/gsd:run` | `--quick <task>` | Quick task with GSD guarantees |
| `/gsd:run` | `--fast <task>` | Trivial inline edit, no planning |
| `/gsd:run` | `--review [phase]` | Cross-AI review before ship |
| `/gsd:run` | `--workspace new|list|remove` | Multi-workspace operations |
| `/gsd:run` | `--milestone audit|complete` | Milestone operations |
| `/gsd:run` | `--interactive` | Sequential execution, no subagents |
| `/gsd:verify` | `--audit` | Cross-phase UAT gap scan |
| `/gsd:verify` | `--validate [phase]` | Validation debt audit for completed work |
| `/gsd:verify` | `--health [--repair]` | Planning directory diagnostics |
| `/gsd:session` | `pause` | Save context handoff |
| `/gsd:session` | `status` | Show progress |
| `/gsd:session` | `report` | Token usage + outcomes summary |
| `/gsd:capture` | `todo <text>` | Add to active todo queue |
| `/gsd:capture` | `backlog <text>` | Park for future milestone |
| `/gsd:capture` | `seed <text>` | Save idea with later trigger |
| `/gsd:settings` | `--profile budget` | Cut costs ~50% |
| `/gsd:settings` | `--profile inherit` | Required for non-Anthropic providers |

---

## Cost Profiles

| Profile | Use When | Cost |
|---------|----------|------|
| `quality` | Critical architecture decisions | Highest |
| `balanced` | Normal development (default) | Medium |
| `budget` | Solo dev, MVPs, high-volume work | ~50% lower |
| `inherit` | OpenRouter, Ollama, local models | Zero Anthropic cost |

Set profile: `/gsd:settings --profile budget`

---

## Execution Paths

| Situation | Command |
|-----------|---------|
| New project | `/gsd:start` |
| Existing repo / brownfield map | `/gsd:start --map` |
| Plan next phase | `/gsd:plan` |
| Add or reshape future phases | `/gsd:plan add-phase|insert-phase|remove-phase` |
| Execute phase | `/gsd:run <N>` |
| Quick task | `/gsd:run --quick "description"` |
| Trivial fix | `/gsd:run --fast "description"` |
| Cross-AI review | `/gsd:run --review` |
| Debug issue | `/gsd:debug "description"` |
| Validate work | `/gsd:verify <N>` |
| Create PR | `/gsd:ship <N>` |
| Capture idea | `/gsd:capture <text>` |
| Configure | `/gsd:settings` |
</process>
