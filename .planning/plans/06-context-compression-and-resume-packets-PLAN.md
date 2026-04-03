# Plan: Context Compression And Resume Packets

SCOPE=full  DOC=min  ARCH=solid  VERIFY=V2  FILES=AGENTS.md,CLAUDE.md,.github/copilot-instructions.md,.codex/skills/reduto-workflow/SKILL.md,docs/ai/WORKFLOW_SHORT.md,docs/ai/CONTEXT_MAP.md,docs/ai/ARTIFACTS.md,.planning/plans/00-TEMPLATE-PLAN.md,.planning/summaries/00-TEMPLATE-SUMMARY.md,scripts/validate-workflow.sh,tests/test-validate-workflow.sh,.planning/ROADMAP.md,.planning/STATE.md  OUT=phase-18 CI automation,cross-platform install docs

## Objective

Reduce token waste by centralizing context compression rules around hot, warm, and cold loading, active-artifact precedence, manifest-first plans, and summary checkpoints.

## Constraints

- Keep `WORKFLOW.md` and `ARTIFACTS.md` canonical.
- Reduce duplicated context instead of adding more narrative guidance.
- Keep resume support as a reading convention, not a new durable artifact.

## Expected Changes

- Canonical reading rules updated across AGENTS and adapters
- Context map gains temperature layers and a resume packet
- Template and validation updates enforce manifest-first compression

## Verification

- `bash scripts/validate-workflow.sh`
- `bash tests/test-validate-workflow.sh`

## Done Criteria

- Agents prefer one hot artifact and avoid restating manifest flags.
- Context loading uses hot, warm, and cold layers with explicit negative rules.
- Summary and plan templates encode checkpoint-style continuity with less prose.