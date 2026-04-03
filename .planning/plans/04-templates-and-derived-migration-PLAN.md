# Plan: Templates And Derived Migration

SCOPE=full  DOC=min  ARCH=solid  VERIFY=V2  FILES=.planning/00-TEMPLATE-*.md,.planning/adrs/00-TEMPLATE-ADR.md,.planning/epics/00-TEMPLATE-EPIC.md,.planning/README.md,.planning/PROJECT.md,docs/ai/ARTIFACTS.md,docs/adoption/derived-project-migration.md,scripts/validate-workflow.sh,scripts/migrate-derived-repo.sh,tests/test-validate-workflow.sh,tests/test-migrate-derived-repo.sh,.github/workflows/validate.yml,README.md,CONTRIBUTING.md,.planning/ROADMAP.md,.planning/STATE.md  OUT=full version-boundary migration automation, product README rewrites in target repos

## Objective

Complete phases 15 and 16 by shipping first-class templates for the remaining workflow artifacts and a lightweight migration path for derived repositories.

## Scope

In scope: starter templates, template conformance, derived-repo migration script, migration docs, and migration tests.

Out of scope: full cross-version upgrade automation or overwriting project-specific documentation in targets.

## Constraints

- Keep the migration sync focused on workflow infrastructure.
- Preserve target Codex skill naming during migration.
- Do not overwrite target README or active planning state.

## Verification

- `bash scripts/validate-workflow.sh`
- `bash tests/test-validate-workflow.sh`
- `bash tests/test-migrate-derived-repo.sh`
- `bash tests/test-bootstrap.sh`

## Done Criteria

- Phases 15 and 16 are marked complete in `ROADMAP.md`.
- First-class templates cover governance, execution, epic, and ADR artifacts.
- Derived repositories can sync workflow infrastructure forward without resetting project-specific docs.