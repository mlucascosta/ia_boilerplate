# AI Agent Rules (minimal adapter)

You MUST follow:
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
- **Output**: return only diff/patch of expected changes. No workflow recap, no file dumps, no context replay.
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

## Runtime Adapters

Use the runtime-specific files only as adapters to this manual:

1. Copilot: `.github/copilot-instructions.md`
2. Claude: `CLAUDE.md`
3. Codex: `.codex/skills/reduto-workflow/SKILL.md`

If two files disagree, `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md` take precedence, then this file, then runtime-specific adapters.