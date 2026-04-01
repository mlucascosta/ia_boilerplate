# CollabPix Workflow Bootstrap

## What This Is

This repository is a bootstrap and compatibility layer for a shared AI workflow that works consistently across Copilot, Codex, and Claude. It stores the canonical workflow, artifact contract, and runtime adapters needed so different AI runtimes can operate against the same repository rules.

## Core Value

Keep cross-AI execution predictable by making repository artifacts and workflow rules the single source of truth.

## Requirements

### Validated

- ✓ Cross-AI workflow contract exists in repository docs — bootstrap
- ✓ Runtime adapters for Copilot, Codex, and Claude exist locally — bootstrap

### Active

- [ ] Local GSD runtime support remains usable without conflicting with repository-specific rules
- [ ] Planning artifacts stay compatible with the shared contract in `docs/ai/ARTIFACTS.md`
- [ ] Future repository work can start from ready-to-use planning, summary, and verification templates

### Out of Scope

- Full product roadmap definition — this repository is currently workflow infrastructure only
- Runtime-specific divergence from the canonical workflow — prevented by design

## Context

- The repository intentionally combines Pster-style explicit workflow control with GSD-style artifact-driven execution.
- `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md` are the canonical references.
- `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, and `.codex/skills/reduto-workflow/SKILL.md` are adapters to that contract.

## Constraints

- **Workflow**: Repository docs are the source of truth — runtime helpers must not override them
- **Compatibility**: Artifacts must remain usable by Copilot, Codex, and Claude — avoid runtime-exclusive formats in canonical files
- **Validation**: Non-trivial work should keep explicit planning and verification — avoid opaque automation-only paths

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Canonical workflow lives in repository docs | Prevent vendor lock-in and drift between AI runtimes | ✓ Good |
| Native GSD install is local to this repo | Allow runtime commands without changing the cross-AI contract | ✓ Good |
| `.planning/` includes starter templates | Reduce friction for the first real execution cycle | ✓ Good |

## Evolution

This document evolves when the repository workflow, artifact contract, or runtime integrations change.

If this repository is reused as a boilerplate, run `./scripts/bootstrap-template.sh` first so local runtime paths and project-facing metadata are rewritten for the new project.

After meaningful workflow updates:
1. Reflect any newly validated repository capabilities in `Validated`.
2. Move stale or rejected workflow ideas to `Out of Scope`.
3. Update constraints when a runtime integration changes operational limits.
4. Record durable decisions that affect future AI behavior in this repo.

---
*Last updated: 2026-04-01 after GSD local bootstrap*