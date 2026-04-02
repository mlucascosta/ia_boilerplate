# Recipes

These recipes standardize common AI-assisted work patterns.

## Focused bugfix
Read:
- `.planning/STATE.md`
- active plan if present
- failing files
- relevant test file

Deliver:
- root cause
- minimal change
- targeted validation
- short summary
- updated state

## Local feature slice
Read:
- `.planning/STATE.md`
- active plan
- target files
- one canonical doc if needed

Deliver:
- scoped implementation
- acceptance check
- short summary
- updated state
- next slice suggestion

## Structural change
Read:
- `.planning/STATE.md`
- `docs/ai/WORKFLOW.md`
- `docs/ai/PROJECT_METHOD.md`
- related architecture docs
- existing ADRs if applicable

Deliver:
- proposed decision
- implementation boundary
- governance updates first
- then implementation slice
- verification notes

## Documentation update
Read:
- `.planning/STATE.md`
- target doc
- nearest source of truth

Deliver:
- concise documentation update
- no duplicated policy
- references to canonical files
- updated state if scope changed

## Large-scope planning
Read:
- `.planning/STATE.md`
- `.planning/ROADMAP.md`
- `docs/ai/WORKFLOW.md`

Deliver:
- reduced scope into slices
- plan files
- updated roadmap if required
- no attempt to execute the full scope in one pass

## Handoff
Read:
- `.planning/STATE.md`
- active plan
- latest summary if present

Deliver:
- what changed
- what was verified
- what remains
- exact next step
- no narrative history beyond what is needed
