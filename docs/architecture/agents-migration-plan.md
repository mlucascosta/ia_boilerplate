# Agent Centralization Migration Plan
## File-by-File Technical Migration Strategy

## 1. Purpose

This document provides the operational migration and stabilization plan for the repository's centralized `.agents/` architecture.

It is implementation-facing and answers:

* what remains canonical
* what stays as compatibility surface
* what must be generated or synchronized
* what must be validated continuously
* what the safe commit sequence looks like from the current release v2 baseline

---

## 2. Migration Objective

The migration objective at this stage is not to introduce `.agents/` from scratch.

It is to stabilize and enforce the already-implemented release v2 model by:

* preserving `.agents/` as the only normative source
* eliminating contradictory documentation or wrapper semantics
* preserving runtime compatibility for Claude, Codex, and Copilot
* keeping engineering defaults centralized
* enforcing parity between docs, manifest, adapters, and materialized runtime surfaces

---

## 3. Migration Constraints

The stabilization work must preserve:

* repository workflow identity
* planning and artifact-driven continuity
* runtime compatibility for Claude, Codex, and Copilot
* documentation-first orientation
* Git Flow
* engineering discipline

The stabilization work must not:

* invent a parallel target architecture
* break runtime discovery without replacement
* create a second source of truth
* regress testing or governance policy
* weaken architectural constraints already encoded in `.agents/`

---

## 4. Baseline Assumption

This plan assumes the release v2 baseline already exists.

That means the following is already true:

* `.agents/` is the canonical source of truth
* `.agents/manifest.json` enumerates supported runtimes, skills, agents, generated targets, and required scripts
* `.agents/runtimes/{claude,codex,github}/` owns runtime-managed wrapper content
* repository-root compatibility entrypoints remain in place for discovery

The remaining work is therefore normalization and enforcement, not greenfield centralization.

---

## 5. Current-to-Target Mapping

## 5.1 Canonical instruction sources

### Current release v2 state
* `.agents/AGENTS.md` is canonical
* `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` are compatibility entrypoints
* `.codex/skills/boilerplate-workflow/SKILL.md` is the Codex compatibility entrypoint

### Target stabilization state
* keep `.agents/AGENTS.md` canonical
* keep compatibility entrypoints thin and aligned
* keep runtime-specific nuances in `.agents/adapters/`

---

## 5.2 Agent definitions

### Current release v2 state
* canonical agent definitions live in `.agents/agents/`
* materialized runtime copies may exist under `.claude/`, `.codex/`, and `.github/`

### Target stabilization state
* `.agents/agents/` remains the only normative agent source
* runtime-owned copies are generated or synchronized artifacts only

---

## 5.3 Runtime-specific command and skill entrypoints

### Current release v2 state
* Claude command surfaces are sourced from `.agents/runtimes/claude/` and materialized into `.claude/commands/`
* Codex skills are sourced from `.agents/runtimes/codex/` and materialized into `.codex/skills/`
* GitHub Copilot wrapper content is sourced from `.agents/runtimes/github/` and materialized into `.github/`

### Target stabilization state
* keep runtime-owned wrapper content under `.agents/runtimes/`
* validate that materialized runtime directories contain no normative drift

---

## 5.4 Shared workflow surface

### Current release v2 state
* reusable capabilities live in `.agents/skills/`
* workflow definitions live in `.agents/workflows/`
* reusable references and templates live in `.agents/references/` and `.agents/templates/`

### Target stabilization state
* maintain these directories as the only shared behavioral surface across runtimes

---

## 6. Stabilization Phases

## Phase 1 — Audit Parity Against Release v2

### Goal
Verify docs, manifest, adapters, runtime entrypoints, and generated targets all describe the same architecture.

### Actions
* compare architecture docs against `.agents/manifest.json`
* compare docs against `.agents/AGENTS.md`
* compare runtime target descriptions against actual generated targets
* remove references to superseded paths or naming models

### Output
Documentation and manifest describe the same runtime model.

### Suggested commit
`docs(architecture): align centralization docs with release v2 runtime model`

---

## Phase 2 — Normalize Runtime EntryPoints

### Goal
Keep compatibility entrypoints thin and consistent.

### Actions
* verify `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` point back to `.agents/AGENTS.md`
* verify `.codex/skills/boilerplate-workflow/SKILL.md` remains the Codex entrypoint
* ensure no entrypoint grows into a shadow contract

### Output
Repository-root and runtime-facing entrypoints remain compatibility-only.

### Suggested commit
`refactor(adapters): normalize root and runtime entrypoints`

---

## Phase 3 — Validate Runtime-Owned Wrapper Content

### Goal
Ensure `.agents/runtimes/` remains the owner of runtime-managed content.

### Actions
* audit `.agents/runtimes/claude/`, `.agents/runtimes/codex/`, and `.agents/runtimes/github/`
* confirm each materialized runtime directory is sourced from the correct runtime-owned content
* remove any manual edits in materialized runtime surfaces that are not reflected centrally

### Output
Runtime-owned wrapper content is centralized where intended.

### Suggested commit
`refactor(runtime): align materialized wrappers with .agents/runtimes ownership`

---

## Phase 4 — Lock Agent and Skill Inventory

### Goal
Treat the manifest as the authoritative inventory and prevent drift.

### Actions
* validate every declared skill exists
* validate every declared agent exists
* remove stale doc references to non-existent names
* preserve repository-specific naming such as `boilerplate-workflow` and the `gsd-*` agent namespace

### Output
Inventory, docs, and runtime references agree.

### Suggested commit
`refactor(manifest): lock inventory and naming to implemented surfaces`

---

## Phase 5 — Harden Validation and CI

### Goal
Make wrapper minimality and runtime parity enforceable.

### Actions
* keep `validate-agents.sh`, `generate-runtime-shims.sh`, and `sync-runtime-adapters.sh` as required scripts
* validate generated targets listed in the manifest
* fail if materialized wrappers diverge from centralized sources
* fail if docs describe unsupported targets as normative

### Output
Centralization becomes enforceable, not just documented.

### Suggested commit
`ci(agents): enforce manifest parity and wrapper minimality`

---

## Phase 6 — Document the End State Clearly

### Goal
Keep architecture docs aligned with implemented reality.

### Actions
* document `.agents/runtimes/` as the owner of runtime-managed wrapper content
* document root entrypoints as thin compatibility adapters
* document actual generated targets from the manifest
* separate current implemented state from optional future evolution

### Output
Architecture docs guide contributors toward the current system instead of a parallel one.

### Suggested commit
`docs(architecture): describe implemented release v2 centralization model`

---

## 7. File-by-File Stabilization Table

| Current Path | Role in release v2 | Target rule | Notes |
|---|---|---|---|
| `AGENTS.md` | root compatibility adapter | keep thin, non-normative | points back to `.agents/AGENTS.md` |
| `CLAUDE.md` | root Claude adapter | keep thin, non-normative | runtime specifics belong in `.agents/adapters/claude.md` |
| `.github/copilot-instructions.md` | root Copilot adapter | keep thin, non-normative | runtime specifics belong in `.agents/adapters/copilot.md` |
| `.codex/skills/boilerplate-workflow/SKILL.md` | root Codex entrypoint | keep thin, non-normative | preserve repository-specific skill naming |
| `.agents/AGENTS.md` | canonical contract | authoritative | all normative behavior lives here or in canonical `.agents/` surfaces |
| `.agents/manifest.json` | authoritative inventory | authoritative | generated targets and required scripts must match reality |
| `.agents/runtimes/claude/*` | source for Claude-managed content | authoritative for Claude-owned wrappers | materializes into `.claude/` |
| `.agents/runtimes/codex/*` | source for Codex-managed content | authoritative for Codex-owned wrappers | materializes into `.codex/` |
| `.agents/runtimes/github/*` | source for Copilot/GitHub-owned content | authoritative for GitHub-owned wrappers | materializes into `.github/` |
| `.claude/*`, `.codex/*`, `.github/*` | materialized compatibility surfaces | generated or synchronized only | no independent semantics |

---

## 8. Compatibility Surface Strategy

The remaining runtime directories are not “legacy” in the sense of “ready for deletion.”

They are compatibility surfaces required by runtime discovery.

Recommended treatment:

### Keep physically, control semantically
Use when runtime discovery depends on those files.

### Regenerate or synchronize from centralized ownership
Root and runtime-owned surfaces may remain, but they must be regenerated or synchronized from `.agents/`.

### Never keep them as normative
Even if they physically remain, they must not carry real workflow semantics.

---

## 9. Engineering Defaults to Preserve During Stabilization

The stabilization work must preserve the following defaults in the central contract.

### TDD
Behavioral changes start from tests.

### Tests-first implementation
Tests are written before production classes, functions, handlers, or modules.

### Layered testing
Use unit, integration, and E2E tests proportionally to risk.

### SOLID
Preserve low coupling, high cohesion, and clear boundaries.

### Hybrid Agile + PMBOK
Separate governance artifacts from execution artifacts.

### Git Flow
Use `develop` as the default base for feature branches.

---

## 10. Suggested Commit Sequence

A safe sequence from the current release v2 baseline is:

1. `docs(architecture): align centralization docs with release v2 runtime model`
2. `refactor(adapters): normalize root and runtime entrypoints`
3. `refactor(runtime): align materialized wrappers with .agents/runtimes ownership`
4. `refactor(manifest): lock inventory and naming to implemented surfaces`
5. `ci(agents): enforce manifest parity and wrapper minimality`
6. `docs(architecture): describe implemented release v2 centralization model`

---

## 11. Example Stabilization Slice

Suppose the repository currently has:

* `.agents/agents/gsd-advisor-researcher.md`
* materialized runtime copies under `.claude/` or `.codex/`
* docs that refer to a non-existent neutralized name such as `advisor-researcher.md`

The stabilization flow should be:

1. treat `.agents/agents/gsd-advisor-researcher.md` as canonical
2. remove stale doc references to the non-existent neutralized name
3. verify any runtime-owned copies are generated or synchronized artifacts only
4. validate the manifest and runtime surfaces still point to the canonical `gsd-*` name

This process should be repeated for each doc or wrapper that drifts from the implemented inventory.

---

## 12. Validation Gates After Each Phase

Each stabilization phase should pass three questions:

### Structural
Does the central source exist and is it correctly organized?

### Semantic
Did the change preserve `.agents/` as the only normative source?

### Compatibility
Can supported runtimes still discover the repository behavior?

No phase should proceed without all three.

---

## 13. Risk Management

### Risk: documenting a parallel architecture
Mitigation:
* always compare docs against `.agents/manifest.json` and `.agents/AGENTS.md`

### Risk: breaking runtime discovery
Mitigation:
* do not remove compatibility entrypoints unless the runtime no longer depends on them

### Risk: partial centralization
Mitigation:
* fail CI if normative behavior remains outside `.agents/`

### Risk: weak engineering contract
Mitigation:
* explicitly preserve TDD, layered tests, SOLID, Git Flow, and governance rules in `.agents/AGENTS.md` and related skills

### Risk: overcomplication
Mitigation:
* centralize only what carries semantics
* keep wrappers minimal
* preserve the current runtime-owned split under `.agents/runtimes/` instead of inventing a second model

---

## 14. Completion Criteria

The stabilization work is complete when all of the following are true:

* `.agents/` remains the only normative source
* root and runtime-owned wrappers are minimal
* inventory in docs matches the manifest
* generated targets in docs match actual generated targets
* CI enforces wrapper minimality and no drift
* engineering defaults remain centrally encoded
* documentation matches the implemented release v2 architecture

---

## 15. Final Rule

> A stabilization step is not complete unless it preserves `.agents/` as the sole normative source and removes any contradictory description of the runtime model from docs, wrappers, or generated surfaces.
