# IA Boilerplate

[![Workflow Conformance](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml/badge.svg)](https://github.com/mlucascosta/ia_boilerplate/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

IA Boilerplate is a repository-level, cross-AI workflow bootstrap for software delivery.

It provides a shared operating model for GitHub Copilot, Codex, Claude, and other coding agents so they can work against the same planning artifacts, documentation rules, and execution constraints.

This repository is intentionally focused on workflow infrastructure rather than application code. Its purpose is to make AI-assisted delivery more predictable, auditable, and portable across runtimes.

## Release V2 Direction

`release/v2` introduces the next architectural step for this repository:

- `.agents/` becomes the operational center for shared runtime behavior
- `.agents/AGENTS.md` is the canonical contract that all runtime adapters must read first
- the public GSD surface stays compact at 11 commands
- behavior is modeled as reusable skills and agents instead of runtime-specific command trees
- TDD-first delivery, SOLID design, and hybrid Agile + PMBOK governance are treated as mandatory engineering defaults
- Git Flow is operationalized with stable-branch detection for `main` or `master`, `develop` as the default base for `feature/*` work, and an explicit fallback when long-lived branches are missing

The target architecture is specified in `docs/architecture/agents-centralization.md`.

## Why Use This

- **Stop context drift** — state lives in repository artifacts, not in chat history that disappears between sessions
- **One workflow, any AI** — Copilot, Claude, and Codex follow the same rules from the same source of truth
- **Built-in quality bar** — complete in-code documentation and SOLID architecture are non-negotiable defaults
- **Engineering discipline built in** — TDD-first delivery, unit/integration/E2E coverage by risk, and hybrid Agile + PMBOK governance are part of the contract
- **Token-efficient by design** — atomic loops, compact handoffs, and explicit scope boundaries reduce waste across every phase

## What This Repository Contains

- A canonical workflow in `docs/ai/WORKFLOW.md`
- A canonical artifact contract in `docs/ai/ARTIFACTS.md`
- A canonical agent contract in `.agents/AGENTS.md`
- Runtime adapters for Copilot, Claude, and Codex
- Harmonized minimal adapter contracts across Copilot, Claude, and Codex
- A local GSD-aligned runtime layer centered on `.agents/`
- A `.planning/` bootstrap structure for roadmap, state, planning, summaries, and verification artifacts
- A conformance validation script in `scripts/validate-workflow.sh`
- A pull request template with workflow path, verification, governance, and documentation signals
- Integration tests for the bootstrap script in `tests/test-bootstrap.sh`
- Validation tests for conformance enforcement in `tests/test-validate-workflow.sh`
- Derived-repo migration support in `scripts/migrate-derived-repo.sh`
- An end-to-end usage example in `docs/examples/01-new-feature-example.md`
- Scenario-based adoption playbooks in `docs/adoption/`
- Multi-stack Todo API examples in `docs/examples/todo/` (Node, Python, Go, Rust, PHP)

## Goals

- Keep AI-assisted work consistent across different runtimes
- Make planning and execution artifact-driven instead of chat-history-driven
- Treat documentation as operational memory
- Keep workflow expectations explicit, reviewable, and durable
- Enforce one delivery system with hybrid governance, agile execution, Git Flow discipline, and mandatory quality gates

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

The current repository policy is intentionally explicit and system-oriented.

For meaningful implementation work, the mandatory requirements are:

- Complete in-code documentation using TSDoc, PHPDoc, or an equivalent language-appropriate standard
- SOLID-oriented architecture
- TDD by default when behavior changes
- Unit, integration, E2E, and security validation proportional to risk

Governance stays hybrid, execution stays incremental, Git Flow remains mandatory, and validation must match the real delivery risk.

In release v2, these rules are explicitly tied to the agent architecture as well: tests come before implementation, verification depth scales with risk, and real code is expected to be refactored under SOLID constraints rather than covered after the fact.

The branch policy is explicit: detect the stable branch as `main` or `master`, create `develop` from that stable branch when it does not exist yet, create `feature/*` branches from `develop`, merge them back into `develop`, use `release/*` for stabilization before publishing to the stable branch, and route urgent production corrections through `hotfix/*` from the stable branch back into both long-lived branches. If neither a stable branch nor `develop` exists, the workflow asks the user to identify the intended long-lived branches and then initializes Git Flow with `develop` as the integration branch.

## Runtime Support

This repository is prepared to work with:

- GitHub Copilot
- Claude (Claude Code CLI)
- Codex
- OpenRouter
- Local models via Ollama or LM Studio

Each runtime is adapted back to the same repository-level source of truth so the workflow stays consistent even when native commands differ.

Adapters are intentionally minimal: they constrain read budget, path selection, output shape, verification level, artifact updates, and hard prohibitions instead of restating the full workflow.

Release v2 tightens this model further: `.agents/` is the shared operational core, while `.claude/`, `.codex/`, and `.github/` are compatibility surfaces rather than independent sources of intelligence.

### Using Local Models (Ollama, LM Studio)

If you run a local model (e.g. `qwen2.5-coder`, `deepseek-coder-v2`) or use OpenRouter:

**Set `inherit` profile before using GSD commands** — this prevents GSD from calling Anthropic models for subagents:

```bash
# In .planning/config.json
{
  "model_profile": "inherit"
}
```

Or via the settings command (Claude Code):

```
/gsd:settings --profile inherit
```

Recommended local model allocation:

| Task | When to use local | When to use API |
|------|-------------------|-----------------|
| Code reading, search | Always — Haiku-equivalent local | — |
| Bug diagnosis, small edits | Usually fine locally | Complex reasoning |
| Architecture planning | Depends on model quality | Critical decisions |
| Verification checks | Always — read-only, cheap | — |

Ollama quick start:

```bash
# Install Ollama
brew install ollama   # macOS
curl -fsSL https://ollama.com/install.sh | sh   # Linux

# Pull a coding model
ollama pull qwen2.5-coder:7b

# Use with Claude Code by pointing to local endpoint
# (configure in Claude Code settings as custom API base)
```

## Quick Start

```bash
# 1. Clone and bootstrap
git clone https://github.com/mlucascosta/ia_boilerplate.git my-project
cd my-project

# Full (includes GSD runtime tooling for Claude Code / Codex)
./scripts/bootstrap-template.sh --project-name "My Project"

# Lite (workflow docs + adapters only — no GSD subagent tooling)
./scripts/bootstrap-template.sh --project-name "My Project" --lite

# 2. Validate conformance
bash scripts/validate-workflow.sh

# 3. Start working
# docs/ai/WORKFLOW.md   — execution contract
# .planning/STATE.md    — set your current objective here
# docs/examples/        — see a complete flow in practice
```

If using Claude Code, the 11 compact GSD commands are immediately available:

```
/gsd:start      Initialize project
/gsd:plan N     Plan phase N
/gsd:run N      Execute phase N
/gsd:verify N   Validate via UAT
/gsd:ship N     Create PR
/gsd:debug      Debug an issue
/gsd:session    Resume / pause / status
/gsd:capture    Note, todo, backlog
/gsd:settings   Model profile and toggles
/gsd:help       Full command reference
/gsd:update     Refresh the runtime bundle
```

**Cost tip:** Run `/gsd:settings --profile budget` to cut subagent costs ~50%. For non-Anthropic providers, use `--profile inherit`.

The public surface stays intentionally small. Brownfield mapping, quick tasks, fast fixes, reviews, backlog capture, milestone actions, and health checks are routed through these same 11 commands via flags instead of exposing 40+ standalone commands. See `docs/ai/GSD_SURFACE.md`.

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

## Derived Repository Migration

If a repository was already bootstrapped from this boilerplate and needs a newer workflow layer, use:

```bash
./scripts/migrate-derived-repo.sh --target /path/to/derived-repo
```

Use `--dry-run` to preview changes and `--include-ci` only if you also want to sync `.github/workflows/validate.yml`.

## Repository Structure

```text
.
├── .agents/
├── .claude/
├── .codex/
├── .github/
├── .planning/
├── AGENTS.md
├── CLAUDE.md
└── docs/
```

## Current Limitations and Roadmap

This repository is transitioning toward release v2. The workflow contract, tooling, and examples are in place, while the `.agents/`-centered architecture is being formalized and completed. A few things are intentionally deferred:

| What | Why deferred | Planned |
|---|---|---|
| ~~Automated tests for the bootstrap script~~ | ~~Tests should cover real failure modes~~ | ~~Phase 07~~ — Done |
| ~~Multi-stack examples~~ | ~~One concrete example ships first~~ | ~~Phase 09~~ — Done |
| Cross-platform install docs (Linux, WSL, Windows) | Prerequisites section covers the common case; explicit multi-platform docs follow community feedback | Phase 08 |
| Migration tooling for derived projects | Lightweight migration now exists for syncing workflow infrastructure; full version-boundary tooling remains deferred | Phase 10 |

Full roadmap: [`.planning/ROADMAP.md`](.planning/ROADMAP.md)

## Contributing

Contributions are open.

If you want to improve the workflow, adapters, planning artifacts, or documentation model, open an issue or submit a pull request.

Please read `CONTRIBUTING.md` before sending changes.

## License

This repository is licensed under the MIT License.

See `LICENSE` for details.
