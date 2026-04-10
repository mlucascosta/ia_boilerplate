# Canonical Agent Contract

This file is the primary source of truth for repository-level agent behavior.

Repository-root `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, and Codex runtime skills are compatibility adapters back to this contract.

## Required Reading Order

You MUST follow:
- `docs/ai/WORKFLOW_SHORT.md` first
- `docs/ai/WORKFLOW.md` only when ambiguity remains
- `docs/ai/ARTIFACTS.md`

## Default Behavior

- Path selection is automatic: `trivial`, `focused`, or `full`
- Read only the pocket workflow, one active artifact, relevant context-map files, and files explicitly cited by the task
- If an active plan exists, treat it as the hot execution artifact and keep `STATE.md` as the global header
- Return only the minimal diff or patch
- Prefer flags and manifests over prose when artifacts already expose compact scope
- Escalate path and verification when correctness risk increases

## Engineering Defaults

- TDD by default: write tests first, then implement
- Behavioral changes require validation proportional to risk
- Use unit, integration, and E2E coverage according to delivery risk
- Refactor under SOLID constraints
- Do not implement first and cover later as the default path
- Preserve hybrid governance: agile execution with PMBOK-style control and traceability

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

## Verification Levels

- `V0` = reasoning only for trivial non-behavioral work
- `V1` = one targeted check for focused work
- `V2` = multi-check evidence for full work
- `V3` = unit + integration + E2E evidence when user-facing or system risk justifies it

## State Rules

- Keep `.planning/STATE.md` telegraphic and within 120 words
- Archive stale context into `.planning/summaries/`
- Treat chat history as temporary memory only

## Runtime Model

- `.agents/` is the canonical operational layer
- `.agents/workflows/`, `.agents/templates/`, `.agents/references/`, `.agents/skills/`, and `.agents/agents/` are the shared runtime surface
- Runtime-specific files under `.claude/`, `.codex/`, and `.github/` are thin compatibility shells or generated artifacts

## RTK — Mandatory Token Optimization

RTK is required for all shell commands. Read `RTK.md` at the repository root.

- All git operations: `rtk git <subcommand>`
- All file reads via terminal: `rtk read <file>` or `rtk grep "pattern" .`
- All test runs: `rtk <runner>` (e.g. `rtk cargo test`, `rtk pytest`, `rtk go test`)
- All builds and lints: `rtk <tool>` (e.g. `rtk tsc`, `rtk lint`, `rtk cargo build`)
- Directory listing: `rtk ls .`
- Never run raw `git`, `ls`, `cat`, `grep`, `rg`, `find`, `cargo test`, `pytest`, `go test`, or any other command that has an `rtk` equivalent

Initialize RTK for your AI tool after installation:
- Claude Code: `rtk init -g`
- Copilot: `rtk init -g --copilot`
- Gemini CLI: `rtk init -g --gemini`
- Codex: `rtk init -g --codex`

## Prohibitions

- No full repository scan unless correctness requires escalation
- No workflow recap in normal task output
- No full file dumps
- No hidden structural changes inside execution notes
- No raw shell commands that bypass `rtk`
