# IA Boilerplate

[![Workflow Conformance](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml/badge.svg)](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

IA Boilerplate is a repository-level, cross-AI workflow bootstrap for software delivery.

It provides a shared operating model for GitHub Copilot, Codex, Claude, and Gemini so they can work against the same planning artifacts, documentation rules, and execution constraints — while using **RTK** to reduce token consumption by 60–90% on every shell command.

This repository is intentionally focused on workflow infrastructure rather than application code. Its purpose is to make AI-assisted delivery more predictable, auditable, and portable across runtimes.

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

## What This Repository Contains

- `RTK.md` — canonical mandatory RTK instruction for all AI runtimes
- `scripts/install-rtk.sh` — OS-aware RTK installer (macOS, Linux, Windows)
- A canonical workflow in `docs/ai/WORKFLOW.md`
- A canonical artifact contract in `docs/ai/ARTIFACTS.md`
- A canonical agent contract in `.agents/AGENTS.md`
- Runtime adapters for Copilot, Claude, Codex, and Gemini — all enforcing RTK
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
├── .claude/                ← Claude runtime compatibility surface
├── .codex/                 ← Codex runtime compatibility surface
├── .gemini/                ← Gemini CLI hooks and RTK setup
├── .github/                ← Copilot hooks and instructions
├── .planning/              ← State, roadmap, plans, verification, summaries
├── docs/                   ← Workflow, artifacts, context map, examples
├── scripts/                ← Bootstrap, validation, RTK install, utilities
├── vault/                  ← Obsidian knowledge vault
└── tests/                  ← Conformance and bootstrap tests
```

## Contributing

Contributions are open. Open an issue or submit a pull request.
Please read `CONTRIBUTING.md` before sending changes.

## License

MIT License. See `LICENSE` for details.

