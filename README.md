# IA Boilerplate

[![Workflow Conformance](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml/badge.svg)](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

IA Boilerplate is a repository-level, cross-AI workflow bootstrap for software delivery.

It provides a shared operating model for GitHub Copilot, Codex, Claude, and other coding agents so they can work against the same planning artifacts, documentation rules, and execution constraints.

This repository is intentionally focused on workflow infrastructure rather than application code. Its purpose is to make AI-assisted delivery more predictable, auditable, and portable across runtimes.

## Why Use This

- **Stop context drift** — state lives in repository artifacts, not in chat history that disappears between sessions
- **One workflow, any AI** — Copilot, Claude, and Codex follow the same rules from the same source of truth
- **Built-in quality bar** — complete in-code documentation and SOLID architecture are non-negotiable defaults
- **Token-efficient by design** — atomic loops, compact handoffs, and explicit scope boundaries reduce waste across every phase

## What This Repository Contains

- A canonical workflow in `docs/ai/WORKFLOW.md`
- A canonical artifact contract in `docs/ai/ARTIFACTS.md`
- Runtime adapters for Copilot, Claude, and Codex
- A local GSD installation aligned to the repository workflow
- A `.planning/` bootstrap structure for roadmap, state, planning, summaries, and verification artifacts
- A conformance validation script in `scripts/validate-workflow.sh`
- Integration tests for the bootstrap script in `tests/test-bootstrap.sh`
- An end-to-end usage example in `docs/examples/01-new-feature-example.md`
- Multi-stack Todo API examples in `docs/examples/todo/` (Node, Python, Go, Rust, PHP)

## Goals

- Keep AI-assisted work consistent across different runtimes
- Make planning and execution artifact-driven instead of chat-history-driven
- Treat documentation as operational memory
- Keep workflow expectations explicit, reviewable, and durable
- Enforce strong implementation standards around complete code documentation and SOLID-oriented architecture

## How The Workflow Fits Together

```
  Define objective          Plan atomic slice        Execute focused diff
   STATE.md          →      plans/PLAN.md       →      code changes
       ↓                         ↓                          ↓
  ROADMAP.md             verification steps            TSDoc / PHPDoc
  (phased work)          done criteria                 SOLID boundaries
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

## Workflow Foundation

This setup combines ideas from two public repositories that influenced the structure and operating model used here:

- `J-Pster/Psters_AI_Workflow` — https://github.com/J-Pster/Psters_AI_Workflow
- `gsd-build/get-shit-done` — https://github.com/gsd-build/get-shit-done

They are referenced here as foundational inspiration for documentation-first execution, phased planning, persistent workflow state, and agent-oriented delivery.

## Core Rules

The current repository policy is intentionally narrow and explicit.

For meaningful implementation work, the mandatory requirements are:

- Complete in-code documentation using TSDoc, PHPDoc, or an equivalent language-appropriate standard
- SOLID-oriented architecture

Validation, testing, and review still matter, but they are treated as context-dependent verification choices unless the project documentation says otherwise.

## Runtime Support

This repository is prepared to work with:

- GitHub Copilot
- Claude
- Codex

Each runtime is adapted back to the same repository-level source of truth so the workflow stays consistent even when native commands differ.

## Quick Start

```bash
# 1. Clone and bootstrap
git clone https://github.com/mlucascosta/ia_boilerplate.git my-project
cd my-project
./scripts/bootstrap-template.sh --project-name "My Project"

# 2. Validate conformance
bash scripts/validate-workflow.sh

# 3. Open the workflow and start
# docs/ai/WORKFLOW.md   — execution contract
# .planning/STATE.md    — set your current objective here
# docs/examples/        — see a complete flow in practice
```

## Prerequisites

Before using the runtime tooling, make sure the machine has:

- `git`
- `node`
- `npx`

If `npx` is not available, install Node.js first, because modern Node distributions include both `npm` and `npx`.

Examples:

```bash
# macOS with Homebrew
brew install node

# verify
node --version
npx --version
```

## Boilerplate Setup

If you use this repository as a template or boilerplate, run the bootstrap script after cloning it:

```bash
./scripts/bootstrap-template.sh --project-name "Your Project"
```

What the bootstrap does:

- Rewrites local absolute runtime paths to the directory where the boilerplate was cloned
- Renames project-facing boilerplate docs from `IA Boilerplate` to your project name
- Renames the internal Codex workflow skill from `reduto-workflow` to a project-derived identifier such as `your-project-workflow`
- Updates the MIT copyright holder, defaulting to `<Project Name> contributors`

If you omit `--project-name`, the script derives the name from the current folder.

If the bootstrap warns that `npx` is missing, install Node.js before trying to use the GSD runtime commands.

## Repository Structure

```text
.
├── .claude/
├── .codex/
├── .github/
├── .planning/
├── AGENTS.md
├── CLAUDE.md
└── docs/
```

## Current Limitations and Roadmap

This repository is at v1.0.0 — the workflow contract, tooling, and a Node.js example are in place. A few things are intentionally deferred:

| What | Why deferred | Planned |
|---|---|---|
| ~~Automated tests for the bootstrap script~~ | ~~Tests should cover real failure modes~~ | ~~Phase 07~~ — Done |
| ~~Multi-stack examples~~ | ~~One concrete example ships first~~ | ~~Phase 09~~ — Done |
| Cross-platform install docs (Linux, WSL, Windows) | Prerequisites section covers the common case; explicit multi-platform docs follow community feedback | Phase 08 |
| Migration tooling for derived projects | Only relevant once there is a v1.x → v2.x boundary to cross | Phase 10 |

Full roadmap: [`.planning/ROADMAP.md`](.planning/ROADMAP.md)

## Contributing

Contributions are open.

If you want to improve the workflow, adapters, planning artifacts, or documentation model, open an issue or submit a pull request.

Please read `CONTRIBUTING.md` before sending changes.

## License

This repository is licensed under the MIT License.

See `LICENSE` for details.
