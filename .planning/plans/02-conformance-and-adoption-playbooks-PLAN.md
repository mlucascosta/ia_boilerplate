# Plan: Conformance And Adoption Playbooks

SCOPE=full  DOC=min  ARCH=solid  VERIFY=V2  FILES=scripts/validate-workflow.sh,.github/workflows/validate.yml,.github/pull_request_template.md,tests/test-validate-workflow.sh,docs/adoption/*.md,docs/ai/ARTIFACTS.md,README.md,CONTRIBUTING.md,.planning/ROADMAP.md,.planning/STATE.md  OUT=runtime adapter harmonization, phase 13 doc rewrites

## Objective

Complete roadmap phases 11 and 12 by enforcing more of the workflow in CI and by publishing adoption playbooks for the three main repository-entry scenarios.

## Scope

In scope: conformance checks, PR governance signals, validation tests, adoption playbooks, and documentation updates needed for discoverability.

Out of scope: adapter harmonization, migration tooling, and broader workflow rewrites.

## Constraints

- Keep `WORKFLOW.md` and `ARTIFACTS.md` canonical.
- Keep checks deterministic and shell-only.
- Avoid forcing GitHub-only semantics into the canonical docs.

## Verification

- `bash scripts/validate-workflow.sh`
- `bash tests/test-validate-workflow.sh`
- `bash tests/test-bootstrap.sh`

## Done Criteria

- Phase 11 and phase 12 are marked complete in `ROADMAP.md`.
- CI runs the new validation coverage.
- New contributors can choose an adoption path without inferring it from the general workflow.