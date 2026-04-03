# AI Agent Rules (minimal adapter)

Canonical source of truth: `.agents/AGENTS.md`.
This repository-root file is a compatibility adapter that points runtimes and humans back to the shared `.agents` contract.

You MUST follow:
- `.agents/AGENTS.md` (canonical repository contract)
- `docs/ai/WORKFLOW_SHORT.md` (pocket card — read first)
- `docs/ai/WORKFLOW.md` (full reference — consult only when ambiguous)
- `docs/ai/ARTIFACTS.md` (artifacts contract)

## Default behavior
- **Path selection** (Trivial / Focused / Full) is automatic:
  - Trivial: ≤1 file, no auth/infra/migration, no cross-cutting.
  - Focused: 2–3 files or requires validation.
  - Full: >3 files, auth, billing, infra, queue, migration, or cross-cutting docs.
  - **Escalate path if correctness is at risk** – do not guess when missing context.
- Requests broader than a single feature must follow the large-scope handling rules in `docs/ai/WORKFLOW.md`.
- **Reading**: before acting, read only:
  - `WORKFLOW_SHORT.md` (not the full workflow)
  - 1 active artifact (`STATE.md` or `PLAN.md`)
  - Files from `docs/ai/CONTEXT_MAP.md` for the relevant area
  - Files explicitly cited in the request.
- If an active `PLAN` exists, use it as the hot execution artifact and keep `STATE.md` as the global header only.
- **Output**: return only diff/patch of expected changes. No workflow recap, no file dumps, no context replay.
- Prefer flags and manifests over prose. If a plan already exposes compact flags, do not restate them in natural language.
- **Verification levels**:
  - V0 = reasoning only (Trivial)
  - V1 = single targeted check (Focused)
  - V2 = multi-check + evidence (Full, but still minimal)
- **State**: `STATE.md` ≤120 words, telegraphic format. Archive old context to `summaries/`.
- **Session reset**: >12 turns, >3 scope changes, or >2 failed attempts → write SUMMARY → compress STATE → restart.

Prohibited: pasting **entire** files. Small excerpts are allowed when necessary for clarity.

## Hybrid delivery model
This project uses hybrid delivery:
- governance artifacts for stable direction
- execution artifacts for daily AI-assisted delivery

Read the canonical workflow first.
Do not mix roadmap-level decisions with slice execution notes.
Do not treat chat history as the source of truth.

## Engineering Defaults

- TDD by default: write tests first, then implement
- Behavioral changes require proportional validation
- Use unit, integration, and E2E coverage according to delivery risk
- Refactor under SOLID constraints
- Do not implement first and cover later as the default path
- Preserve hybrid governance: agile execution, PMBOK-style control and traceability

## Git Strategy

- Git Flow is mandatory
- Detect the stable branch as `main` or `master`
- `develop` is the default integration and base branch for feature work
- Create `feature/*` branches from `develop`
- Merge feature branches back into `develop`
- Reserve the stable branch for release state
- Use `release/*` for stabilization and `hotfix/*` for urgent production fixes
- Do not work directly on the stable branch for normal feature delivery
- If the stable branch exists but `develop` does not, create `develop` from the stable branch before feature work starts
- If neither `develop` nor a stable branch exists, ask the user to identify the long-lived branches before proceeding, then initialize Git Flow with `develop` as the integration branch

## Runtime Adapters

Use the runtime-specific files only as adapters to this manual:

1. Copilot: `.github/copilot-instructions.md`
2. Claude: `CLAUDE.md`
3. Codex: `.codex/skills/boilerplate-workflow/SKILL.md`

If two files disagree, `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md` take precedence, then this file, then runtime-specific adapters.

## GSD Operational Layer

Canonical GSD artifacts live in `.agents/` — one copy, consumed by all runtimes:

- **Workflows**: `.agents/workflows/` — executable workflow definitions
- **Templates**: `.agents/templates/` — artifact templates
- **References**: `.agents/references/` — model profiles, verification patterns, etc.
- **Agent definitions**: `.agents/agents/` — 18 subagent definitions
- **Node tooling**: `.agents/bin/` — gsd-tools.cjs and support libs
- **Adapter docs**: `.agents/adapters/` — runtime syntax reference
- **Runtime-owned files**: `.agents/runtimes/` — Codex, Claude, and Copilot wrapper content

Runtime-specific wrappers delegate to `.agents/` via root entrypoints that point into `.agents/runtimes/`:
- Claude: `.claude/commands/gsd/*.md` (invoked as `/gsd:<name>`)
- Codex: `.codex/skills/gsd-*/SKILL.md` (invoked as `$gsd-<name>`)
- Copilot: `.github/skills/gsd-*/SKILL.md`

The repository-root runtime folders remain only for runtime compatibility. Their managed contents live under `.agents/runtimes/`, and agent definitions in `.claude/agents/`, `.codex/agents/`, `.github/agents/` are thin wrappers to `.agents/agents/`.
