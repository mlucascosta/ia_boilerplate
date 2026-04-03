# Plan: Adoption Hardening Foundation

SCOPE=focused  DOC=min  ARCH=solid  VERIFY=V1  FILES=.planning/ROADMAP.md,.planning/STATE.md,.planning/plans/01-adoption-hardening-foundation-PLAN.md  OUT=feature implementation, non-planning docs

## Objective

Turn the current repository review into a durable, prioritized execution sequence for adoption hardening.

## Scope

Capture the next milestone, first-wave priorities, and immediate execution order. Do not implement the phases yet.

## Expected Changes

- Add an adoption-hardening milestone to `ROADMAP.md`
- Record the first execution slice and its boundaries
- Update `STATE.md` so the next action is explicit

## Constraints

- Preserve `WORKFLOW.md` and `ARTIFACTS.md` as source of truth
- Stay within artifact size budgets
- Keep GSD support optional, not normative

## Verification

- Run `bash scripts/validate-workflow.sh`

## Done Criteria

- The next improvement wave is ordered and reviewable
- A first slice is ready to execute without rediscovery