# Plan: Doc Ergonomics And Adapter Alignment

SCOPE=full  DOC=min  ARCH=solid  VERIFY=V2  FILES=docs/ai/DECISION_RULES.md,docs/ai/CONTEXT_MAP.md,docs/ai/RECIPES.md,CLAUDE.md,.github/copilot-instructions.md,.codex/skills/reduto-workflow/SKILL.md,scripts/validate-workflow.sh,tests/test-validate-workflow.sh,README.md,CONTRIBUTING.md,.planning/ROADMAP.md,.planning/STATE.md  OUT=phase 15 templates, migration tooling

## Objective

Complete phases 13 and 14 by improving the readability of dense operational docs and aligning runtime adapters to one minimal contract.

## Scope

In scope: document reformatting, adapter rewrites, adapter conformance checks, and the small discoverability updates needed to make the contract visible.

Out of scope: template expansion, migration commands, or changes to the canonical workflow semantics.

## Constraints

- Keep `WORKFLOW.md` and `ARTIFACTS.md` canonical.
- Reduce prose instead of adding new policy.
- Keep adapter semantics aligned across runtimes.

## Verification

- `bash scripts/validate-workflow.sh`
- `bash tests/test-validate-workflow.sh`
- `bash tests/test-bootstrap.sh`

## Done Criteria

- Phases 13 and 14 are marked complete in `ROADMAP.md`.
- Dense operational docs are easier to scan without semantic drift.
- Runtime adapters share one minimal contract and CI enforces it.