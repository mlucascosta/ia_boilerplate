# Changelog

All notable changes to this project follow [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) conventions and [Semantic Versioning](https://semver.org/).

Format: `[version] — YYYY-MM-DD`

---

## [3.1.0] — 2026-04-09

### Added

- `.agents/governance/` — new normative subcamada de governança arquitetural, extending `.agents/` without creating a competing authority:
  - `SKILLS.md` — eight architectural audit skills: Clean Architecture, DDD integrity, SOLID, TDD/test quality, Controller clean, MVVM headless, Integration test realism, E2E minimalism, and Full Audit Aggregator
  - `RULES.md` — AI auditor behavior rules: evidence-first findings, confidence tiers (`high/medium/low`), severity tiers (`critical/major/minor`), merge-impact classification (`block/review/advisory`), advisory-first rollout mandate, RTK mandatory for all shell guidance, PR scope discipline, and adapter discipline
  - `CHECKLIST.md` — per-category review checklist across Boundaries, DDD, SOLID, Tests, Delivery Layer, Governance, and RTK compliance
  - `ANTI_PATTERNS.md` — ten recognized anti-patterns with descriptions: Fat Controller, Repository With Domain Logic, Anemic Entity, God Service, DTO With Domain Behavior, Test That Verifies Implementation, Excessive Mocking, Fake Integration Test, E2E Covering Domain Logic, Time-Coupled Domain Logic
  - `REVIEW_OUTPUT_TEMPLATE.md` — standardized JSON finding structure (status, severity, confidence, merge_impact, category, rule, evidence, why_matters, suggested_fix, possible_exception) and Markdown report format with auxiliary score policy
- `.github/workflows/ai-audit.yml` — advisory PR audit workflow: runs on every PR, reads `.agents/governance/` as normative base, posts findings as PR comment (sticky, replaces on update), no merge block, graceful skip when `OPENAI_API_KEY` is absent
- `scripts/ai_audit.py` — audit script foundation: reads diff, loads governance files, builds LLM prompt, calls OpenAI with safe fallback (missing key → friendly skip report, exit 0; empty diff → skip; missing governance files → skip with clear message; API error → safe report)
- `docs/architecture/ai-governance.md` — human explanation of the governance layer, rollout model, advisory-first rationale, and RTK scope
- `docs/architecture/information-architecture.md` — full layer map with responsibilities, anti-patterns for information architecture, and explicit authority table

### Changed

- `AGENTS.md` (root) — added `Governance layer` section pointing to `.agents/governance/*` with usage guidance
- `CLAUDE.md` — added `Governance extension` section listing governance files and when to consult them
- `.github/copilot-instructions.md` — added `Architecture and Governance` section with pointers to `.agents/AGENTS.md` and `.agents/governance/`
- `README.md` — added `The Governance Problem This Solves` and `Why .agents/ As The Normative Root` sections; updated `What This Repository Contains` with governance entries; updated `AI Governance Structure` table; updated Repository Structure diagram
- `.agents/skills/review/SKILL.md` — updated read-first list to reference `.agents/governance/` instead of deleted `.agents/workflows/review.md`
- `docs/ai/CONTEXT_MAP.md` — added `Architecture audit context` section with governance file pointers and skill invocation guidance

### Removed

- `.agents/adapters/gsd.md` — stale GSD adapter, removed post-v3.0 cleanup
- `docs/ai/GSD_SURFACE.md` — stale GSD surface documentation, removed post-v3.0 cleanup

### Design decisions

**Why `.agents/governance/` and not `docs/ai/` or `vault/`?**
Governance rules are normative for AI agents — they define what the auditor must do, not explain it to humans. Normative AI content belongs in `.agents/`. Human explanations live in `docs/architecture/`.

**Why advisory-only on first rollout?**
Heuristics need calibration against real PRs before becoming gates. False positives on merge blocking erode trust faster than they enforce discipline. The model is: advise → calibrate → gate.

**Why RTK in governance guidance but not in CI scripts?**
RTK is a token-optimization proxy for human + AI shell interaction. CI runners do not have RTK installed and do not need it — their output does not consume AI context windows. The exception is explicit and bounded to machine automation only.

---

## [3.0.0] — 2026-04-09

### Added
- `RTK.md` — canonical mandatory RTK (Rust Token Killer) instruction consumed by all AI runtimes
- `scripts/install-rtk.sh` — OS-aware RTK installer with auto-detection for macOS (Homebrew), Linux (curl), Windows (winget); supports `--init-all` flag to auto-detect and initialize all AI tools
- `.codex/RTK.md` — Codex-specific RTK instruction with `@RTK.md` reference
- `.gemini/RTK.md` and `.gemini/hooks/rtk-hook-gemini.sh` — project-level Gemini CLI RTK hook reference
- `vault/` — Obsidian knowledge vault with structured project knowledge:
  - `vault/00-Home/Dashboard.md` — navigation hub
  - `vault/RTK/` — RTK overview, command reference, and installation guide
  - `vault/Standards/` — TDD, SOLID, Git Flow, and Code Review standards
  - `vault/AI-Workflow/` — Agent contract and artifact reference
  - `vault/Skills/` — Execute, Plan, Verify, and Review skill references
  - `vault/Templates/` — Feature plan, ADR, session note, and bug report templates

### Changed
- `AGENTS.md` (root) — replaced GSD Operational Layer section with RTK Operational Layer; updated runtime adapter list to include Gemini and `.codex/RTK.md`
- `CLAUDE.md` — added RTK mandatory section; removed raw shell command prohibition
- `.github/copilot-instructions.md` — added RTK mandatory section with `rtk init -g --copilot` setup instruction; removed GSD-specific prohibition
- `.agents/AGENTS.md` — added RTK mandatory section with per-runtime init commands; updated Prohibitions to include raw shell commands that bypass `rtk`
- `README.md` — complete rewrite: Quick Start now leads with RTK install; added RTK command table; added Obsidian vault section; removed GSD-specific Quick Start, prerequisites, and local model sections

### Removed
- All GSD skills from `.github/skills/gsd-*/` (11 skill directories)
- All GSD-branded agent definitions from `.agents/agents/gsd-*.md` (18 agent files)
- All GSD workflow files from `.agents/workflows/*.md` (50+ workflow files)
- `.agents/bin/` — Node.js GSD tooling
- All `gsd-file-manifest.json` manifests (`.github/`, `.claude/`, `.codex/`, `.agents/runtimes/claude/`, `.agents/runtimes/github/`)

---

## [2.0.1] — 2026-04-04

### Changed
- Recorded the `v2.0.0` release notes in `CHANGELOG.md` after the release cut so repository history and release documentation stay aligned.

---

## [2.0.0] — 2026-04-04

### Added
- `.agents/AGENTS.md` as the canonical repository contract for all AI runtimes
- `.agents/manifest.json` and `.agents/adapters/` to centralize runtime inventory and adapter semantics
- `.agents/skills/` for the shared workflow-core, discuss, plan, execute, verify, review, quick-task, and docs-update capabilities
- `.agents/runtimes/{claude,codex,github}/` to own runtime-managed wrapper content
- `.agents/scripts/validate-agents.sh`, `.agents/scripts/generate-runtime-shims.sh`, and `.agents/scripts/sync-runtime-adapters.sh` for centralization enforcement
- `docs/architecture/agents-centralization.md`, `docs/architecture/agents-migration-plan.md`, `docs/architecture/runtime-shims-spec.md`, and `docs/architecture/testing-governance.md`

### Changed
- Centralized the GSD operational layer under `.agents/` and reduced root/runtime surfaces to compatibility adapters
- Updated `AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` to delegate to the centralized contract
- Aligned validation and workflow templates with the release v2 runtime model
- Hardened `.agents/scripts/validate-agents.sh` for environments without `rg`
- Compacted `.planning/STATE.md` to remain within the enforced artifact budget

### Removed
- Runtime-owned duplicate content under legacy `get-shit-done` locations in favor of `.agents/` ownership and synchronized materialized wrappers

---

## [1.0.0] — 2026-04-02

### Added
- `scripts/validate-workflow.sh` — 13-point conformance check for canonical docs, planning artifacts, runtime adapters, and STATE.md structure
- `.github/workflows/validate.yml` — CI check that runs the validation script on every push and PR
- `docs/examples/01-new-feature-example.md` — end-to-end flow: objective → atomic plan → execution → verification → compact handoff
- `docs/ai/SUCCESS.md` — behavioral checklist covering pre-implementation, during implementation, post-implementation, and session boundary gates
- Workflow diagram in README showing how artifacts connect across a delivery cycle
- "Why Use This" and "Quick Start" sections in README
- Badges for CI status and MIT license in README

### Changed
- `docs/ai/WORKFLOW.md` — added Token Economy And Context Continuity section (9 rules) and expanded What Agents Must Avoid with anti-waste rules
- `AGENTS.md` — added 3 operational rules to Execution Quality Bar: path references over pasting content, mandatory compact handoffs, no task mixing
- `.planning/summaries/00-TEMPLATE-SUMMARY.md` — added structured Handoff block with 180-word limit
- `scripts/bootstrap-template.sh` — replaced hardcoded absolute path with dynamic detection so the bootstrap works correctly on any machine

### Foundation (pre-1.0.0)
- Cross-AI workflow contract in `docs/ai/WORKFLOW.md`
- Artifact contract in `docs/ai/ARTIFACTS.md`
- Repository operating manual in `AGENTS.md`
- Runtime adapters for GitHub Copilot, Claude, and Codex
- Local GSD runtime installation
- Bootstrap script with `--project-name` and `--copyright-holder` options
- Planning artifact templates: STATE.md, ROADMAP.md, plan, summary, verification

---

## Future

Planned improvements tracked in `.planning/ROADMAP.md`.
