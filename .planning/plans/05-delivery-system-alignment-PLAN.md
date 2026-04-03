# Plan: Delivery System Alignment

SCOPE=full  DOC=min  ARCH=solid  VERIFY=V2  FILES=docs/ai/WORKFLOW.md,docs/ai/PROJECT_METHOD.md,.github/pull_request_template.md,scripts/validate-workflow.sh,tests/test-validate-workflow.sh,README.md,CONTRIBUTING.md,.planning/ROADMAP.md,.planning/STATE.md  OUT=CI branch enforcement, cross-platform install docs

## Objective

Formalize one delivery system that combines hybrid governance, agile execution, Git Flow discipline, and mandatory quality gates.

## Scope

In scope: canonical workflow policy, project method alignment, PR review signals, and conformance updates for the new delivery and quality model.

Out of scope: CI enforcement for branch naming, full security automation, or new platform setup docs.

## Constraints

- Keep `WORKFLOW.md` canonical.
- Add policy as concise rules, not long methodology prose.
- Keep validation proportional to risk instead of turning every change into a heavy ritual.

## Verification

- `bash scripts/validate-workflow.sh`
- `bash tests/test-validate-workflow.sh`

## Done Criteria

- The delivery model is explicit in the canonical workflow.
- The PR template forces quality and security disclosure.
- Conformance fails when the PR template drops required governance or quality sections.