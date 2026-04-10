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
3. Codex: `.codex/RTK.md`

If two files disagree, `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md` take precedence, then this file, then runtime-specific adapters.

## RTK Operational Layer

RTK is the mandatory token optimization layer for all AI runtimes in this project.
Read `RTK.md` for the full command rewrite table and hard rules.

## Governance layer

This repository defines an architectural audit and governance layer under `.agents/governance/`.

Consult these files when the task involves architecture review, quality gates, pull request audit behavior, anti-pattern detection, or merge-impact classification:

- `.agents/governance/SKILLS.md`
- `.agents/governance/RULES.md`
- `.agents/governance/CHECKLIST.md`
- `.agents/governance/ANTI_PATTERNS.md`
- `.agents/governance/REVIEW_OUTPUT_TEMPLATE.md`

These files extend the canonical `.agents/` operating model with review and governance rules.
They do not replace `.agents/AGENTS.md`; they specialize it for architectural audit and code quality governance.
See `docs/architecture/ai-governance.md` for the human-facing explanation.

Install: `./scripts/install-rtk.sh`

Initialize per runtime:
- Claude Code: `rtk init -g`
- Copilot: `rtk init -g --copilot`
- Gemini CLI: `rtk init -g --gemini`
- Codex: `rtk init -g --codex`

Canonical RTK contract lives in `RTK.md` — one file, consumed by all runtimes:

- **Templates**: `.agents/templates/` — artifact templates
- **References**: `.agents/references/` — model profiles, verification patterns, etc.
- **Adapter docs**: `.agents/adapters/` — runtime syntax reference
- **Runtime-owned files**: `.agents/runtimes/` — Codex, Claude, and Copilot wrapper content
