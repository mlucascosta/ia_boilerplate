# Changelog

All notable changes to this project follow [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) conventions and [Semantic Versioning](https://semver.org/).

Format: `[version] — YYYY-MM-DD`

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
