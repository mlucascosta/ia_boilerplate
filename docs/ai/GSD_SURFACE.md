# Compact GSD Surface

Canonical command surface for this repository: keep the user-facing workflow compact while retaining useful GSD capabilities.

## Goal

Use a small command set that is easy to remember.
Absorb upstream `get-shit-done` capabilities behind flags and routing instead of exposing 40+ standalone skills.

## Public Surface

11 commands. One workflow.

| Command | Primary job | Also absorbs |
| --- | --- | --- |
| `start` | Initialize project or milestone | brownfield mapping, milestone creation |
| `plan` | Clarify and produce executable plan | discuss, assumptions, UI planning, phase surgery, gap planning |
| `run` | Execute work | quick, fast, review, workspaces, milestone ops, forensics |
| `verify` | Validate delivered behavior | UAT, audits, health checks, validation debt |
| `ship` | Turn validated work into PR and merge prep | PR branch prep, review handoff |
| `debug` | Investigate and fix issues | diagnosis loop, checkpoints |
| `session` | Resume and navigate current work | pause, status, next, report |
| `capture` | Save lightweight inputs | notes, todos, backlog, seeds |
| `settings` | Configure profiles and toggles | profile switching, runtime behavior |
| `help` | Show the compact surface | flags, routing, typical flows |
| `update` | Refresh runtime bundle | changelog and upgrade flow |

## Design Rules

- Prefer capability-by-flag over new commands.
- Add a new command only when the user mental model clearly improves.
- Keep the default path obvious: `start -> plan -> run -> verify -> ship`.
- Route specialist workflows through the nearest parent command.
- Make brownfield, review, milestone, workspace, and backlog flows discoverable from `help`.
