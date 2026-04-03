# In-Flight Project Adoption

Use this playbook when the team already has active backlog items, existing branches, and live delivery pressure.

## Goal

Introduce the workflow incrementally, so the repository becomes the source of truth without disrupting current delivery.

## Steps

1. Keep the team’s current backlog and release cadence; do not force a project reset.
2. Mirror the active initiative into `.planning/STATE.md` and one matching atomic plan.
3. Record only the decisions that must survive across sessions: next step, blockers, risks, and structural choices.
4. Align the pull request template with the workflow path and verification level expected for the current change.
5. Add governance artifacts only when the work has real cross-cutting impact.
6. Use summaries to hand off between sessions, agents, or model switches instead of reconstructing context from memory.
7. Expand adoption one stream at a time after the first slice proves useful.

## Transition Rules

- Preserve the existing branch model if it is stricter than the default workflow.
- Avoid parallel documentation initiatives with no immediate execution owner.
- Prefer small proof points over broad mandate language.

## Common Failure Modes

- Forking the process so backlog work lives outside the repository while docs try to describe it later.
- Requiring every ongoing stream to migrate at once.
- Adding workflow language to PRs without updating state, plans, or validation habits.