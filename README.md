# IA Boilerplate

[![Workflow Conformance](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml/badge.svg)](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

IA Boilerplate is a repository-level, cross-AI workflow bootstrap for software delivery.

It provides a shared operating model for GitHub Copilot, Codex, Claude, and Gemini so they can work against the same planning artifacts, documentation rules, and execution constraints — while using **RTK** to reduce token consumption by 60–90% on every shell command.

This repository is intentionally focused on workflow infrastructure rather than application code. Its purpose is to make AI-assisted delivery more predictable, auditable, and portable across runtimes.

> **v3.1:** This release adds a formal AI governance layer — architectural audit skills, code review rules, anti-pattern detection, and an advisory PR audit workflow — all rooted in `.agents/governance/` as a normative extension of the existing `.agents/` contract.

## Quick Start

```sh
# 1. Clone and enter the repo
git clone <your-fork> && cd ia_boilerplate

# 2. Install RTK (auto-detects OS)
./scripts/install-rtk.sh

# 3. Initialize RTK for your AI tool
rtk init -g                  # Claude Code
rtk init -g --copilot        # GitHub Copilot (VS Code)
rtk init -g --gemini         # Gemini CLI
rtk init -g --codex          # OpenAI Codex

# 4. Verify
rtk --version
rtk gain
```

## RTK — Mandatory Token Optimization

[RTK (Rust Token Killer)](https://github.com/rtk-ai/rtk) is required for all shell commands.
All AI agents in this project **must** prefix commands with `rtk`:

| Instead of | Use |
|---|---|
| `git status` | `rtk git status` |
| `cat file` | `rtk read file` |
| `ls` | `rtk ls .` |
| `cargo test` | `rtk cargo test` |
| `grep pattern .` | `rtk grep "pattern" .` |

RTK reduces token consumption by 60–90% per command. See `RTK.md` for the full rewrite table.

## Why Use This

- **Stop context drift** — state lives in repository artifacts, not in chat history that disappears between sessions
- **One workflow, any AI** — Copilot, Claude, Gemini, and Codex follow the same rules from the same source of truth
- **Token-efficient by design** — RTK mandatory for all commands, atomic loops, compact handoffs, explicit scope boundaries
- **Built-in quality bar** — SOLID architecture and complete in-code documentation are non-negotiable defaults
- **Engineering discipline built in** — TDD-first delivery, unit/integration/E2E coverage by risk, and hybrid Agile + PMBOK governance
- **Architectural governance** — AI-assisted PR audits catch boundary violations, anti-patterns, and test quality issues before merge

## The Governance Problem This Solves

When teams scale AI-assisted delivery, a consistent challenge emerges: AI tools make changes quickly, but without architectural guardrails they drift toward fat controllers, anemic entities, and untested behavior boundaries. Code review catches some of this — but only if reviewers know what to look for and have the bandwidth to do it consistently.

This repository addresses that problem by giving every PR an advisory architectural audit, driven by the same normative rules that human reviewers would apply:

- **Clean Architecture** — dependency direction, boundary isolation, no domain leakage into infrastructure
- **DDD** — value object immutability, entity behavior, ubiquitous language coherence
- **SOLID** — SRP, OCP, LSP, ISP, DIP checked pragmatically against the diff
- **TDD discipline** — behavior changes without test coverage are flagged, not silently accepted
- **Test realism** — fake integration tests and over-mocked unit tests are identified
- **Controller discipline** — delivery adapters stay thin

The audit is **advisory-only on first rollout**. No merge is blocked. Findings are comments, not gates. The goal is to calibrate heuristics and build trust before enabling stricter enforcement.

## Why `.agents/` As The Normative Root

Most AI workflow systems scatter rules across runtime-specific files: `CLAUDE.md` for Claude, `.github/copilot-instructions.md` for Copilot, and so on. This creates drift — contradictions between files, rules that only one runtime sees, and no clear authority when files disagree.

This repository inverts that: **`.agents/` is the only normative AI layer.** Runtime-specific files (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`) are adapters — thin compatibility surfaces that point back to the canonical contract. They constrain read budget, path selection, output shape, and tool-specific syntax, but they do not define behavior.

The governance layer follows the same principle: `.agents/governance/` is an extension of `.agents/`, not a parallel source of truth. All architectural rules, audit skills, checklists, and output templates live there — once — and every runtime reads them from the same location.

This model eliminates a whole class of problems:
- No contradictions between runtime files
- No hidden rules that only Claude sees but Copilot misses
- No governance rules scattered across `docs/`, `vault/`, and various adapter files
- One place to update when heuristics change

## What This Repository Contains

- `RTK.md` — canonical mandatory RTK instruction for all AI runtimes
- `scripts/install-rtk.sh` — OS-aware RTK installer (macOS, Linux, Windows)
- A canonical workflow in `docs/ai/WORKFLOW.md`
- A canonical artifact contract in `docs/ai/ARTIFACTS.md`
- A canonical agent contract in `.agents/AGENTS.md`
- A governance layer in `.agents/governance/` — audit skills, rules, checklist, anti-patterns, output template
- An advisory PR audit workflow in `.github/workflows/ai-audit.yml` — comments findings, never blocks merge
- Runtime adapters for Copilot, Claude, Codex, and Gemini — all enforcing RTK and governance
- A `.planning/` bootstrap structure for roadmap, state, planning, summaries, and verification artifacts
- A conformance validation script in `scripts/validate-workflow.sh`
- A pull request template with workflow path, verification, governance, and documentation signals
- Integration tests for the bootstrap script in `tests/test-bootstrap.sh`
- Derived-repo migration support in `scripts/migrate-derived-repo.sh`
- An end-to-end usage example in `docs/examples/01-new-feature-example.md`
- Scenario-based adoption playbooks in `docs/adoption/`
- Multi-stack Todo API examples in `docs/examples/todo/` (Node, Python, Go, Rust, PHP)
- `vault/` — Obsidian knowledge vault with RTK, standards, skills, and templates

## Goals

- Keep AI-assisted work consistent across different runtimes
- Make planning and execution artifact-driven instead of chat-history-driven
- Enforce RTK across all AI tools to minimize token waste
- Treat documentation as operational memory
- Enforce one delivery system with hybrid governance, agile execution, Git Flow discipline, and mandatory quality gates

## How The Workflow Fits Together

```
  Define objective          Plan atomic slice        Execute focused diff
   STATE.md          →      plans/PLAN.md       →      rtk git commit
       ↓                         ↓                          ↓
  ROADMAP.md             verification steps            SOLID boundaries
  (phased work)          done criteria                 TDD coverage
                                                            ↓
                         Compact handoff           Log results
                         summaries/            ←   verification/
                         (≤180 words)              next STATE.md step
```

Choose the lightest path that still preserves correctness:

| Situation | Path |
|---|---|
| Copy, labels, single-file local fix | **Trivial** — edit directly |
| Bug fix, one endpoint, one component | **Focused** — short plan + validate |
| New feature, risky refactor, auth, billing, infra | **Full** — map → plan → execute → verify → capture |

## Obsidian Knowledge Vault

The `vault/` directory is an Obsidian vault with structured knowledge for this project:

```
vault/
  00-Home/Dashboard.md        ← Navigation hub
  RTK/                        ← RTK overview, commands, installation
  Standards/                  ← TDD, SOLID, Git Flow, Code Review
  AI-Workflow/                ← Agent contract, artifact reference
  Skills/                     ← Execute, Plan, Verify, Review skills
  Templates/                  ← Feature plan, ADR, session note, bug report
```

Open `vault/` in Obsidian as a vault to use it.

## Runtime Support

This repository is prepared to work with:

- GitHub Copilot (VS Code)
- Claude (Claude Code CLI)
- Gemini CLI
- OpenAI Codex

Each runtime is adapted back to the same repository-level source of truth so the workflow stays consistent. All runtimes enforce RTK for token optimization.

Adapters are intentionally minimal: they constrain read budget, path selection, output shape, verification level, artifact updates, RTK compliance, and hard prohibitions.

## Core Rules

- Complete in-code documentation using TSDoc, PHPDoc, or an equivalent language-appropriate standard
- SOLID-oriented architecture
- TDD by default when behavior changes
- Unit, integration, E2E, and security validation proportional to risk
- **RTK mandatory** for all shell commands across all AI runtimes
- Git Flow mandatory — `develop` as integration branch, `feature/*` from `develop`

## Boilerplate Setup

If you use this repository as a template, run the bootstrap script after cloning:

```sh
./scripts/bootstrap-template.sh --project-name "Your Project"
```

## Derived Repository Migration

If a repository was already bootstrapped and needs a newer workflow layer:

```sh
./scripts/migrate-derived-repo.sh --target /path/to/derived-repo
```

Use `--dry-run` to preview changes.

## Repository Structure

```
.
├── RTK.md                  ← Mandatory RTK instruction (all runtimes)
├── AGENTS.md               ← Root agent rules
├── CLAUDE.md               ← Claude adapter
├── .agents/                ← Canonical shared runtime layer
│   └── governance/         ← Architectural audit and governance extension
├── .claude/                ← Claude runtime compatibility surface
├── .codex/                 ← Codex runtime compatibility surface
├── .gemini/                ← Gemini CLI hooks and RTK setup
├── .github/                ← Copilot hooks and instructions
├── .planning/              ← State, roadmap, plans, verification, summaries
├── docs/                   ← Workflow, artifacts, context map, examples
│   └── architecture/       ← Human-facing architecture and governance docs
├── scripts/                ← Bootstrap, validation, RTK install, utilities
├── vault/                  ← Obsidian knowledge vault
└── tests/                  ← Conformance and bootstrap tests
```

## AI Governance Structure

This repository uses a centralized AI governance model rooted in `.agents/`.

### Normative layer

The only normative AI layer is `.agents/`. Everything else is documentation, workflow guidance, or adapter compatibility.

| Path | Role |
|---|---|
| `.agents/AGENTS.md` | Canonical repository agent contract |
| `.agents/governance/SKILLS.md` | Architectural audit skills |
| `.agents/governance/RULES.md` | Audit behavior, confidence, and merge impact rules |
| `.agents/governance/CHECKLIST.md` | Per-category review checklist |
| `.agents/governance/ANTI_PATTERNS.md` | Recurring anti-pattern catalog |
| `.agents/governance/REVIEW_OUTPUT_TEMPLATE.md` | Standardized audit output format |

### Human-facing docs

- `docs/ai/` — workflow, artifacts, execution model, context maps
- `docs/architecture/ai-governance.md` — governance purpose and rollout
- `docs/architecture/information-architecture.md` — full layer map and responsibilities

### Runtime adapters

Compatibility entrypoints only; not sources of truth:

- `AGENTS.md`
- `CLAUDE.md`
- `.github/copilot-instructions.md`

### Advisory PR audit

`.github/workflows/ai-audit.yml` runs an advisory architectural audit on every PR.
It reads `.agents/governance/` as its normative base and comments findings on the PR.
No `OPENAI_API_KEY` means the audit is skipped gracefully — no merge is blocked.

### Obsidian vault

`vault/` is a knowledge vault for structured notes. It is not normative.

## Contributing

Contributions are open. Open an issue or submit a pull request.
Please read `CONTRIBUTING.md` before sending changes.

## License

MIT License. See `LICENSE` for details.


