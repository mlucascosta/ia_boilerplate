# Decision Rules

This file defines when each planning artifact must be updated.

## Update STATE.md when
- a slice is completed
- the immediate next step changes
- a blocker appears
- the active focus changes
- a key assumption changes

## Update a plan in `.planning/plans/` when
- the current slice gains or loses steps
- the implementation path changes
- additional scoped work is required
- the task needs explicit acceptance criteria

## Update ROADMAP.md when
- priorities change
- a milestone changes
- work moves across modules or phases
- the order of delivery changes
- scope expands beyond the current plan

## Update VISION.md when
- product direction changes
- the intended user value changes
- the operating model changes
- the high-level product boundaries change

## Create or update an ADR when
- a structural technical decision is made
- a dependency changes in a significant way
- an architectural pattern changes
- a persistence, queue, integration, or security strategy changes
- a decision needs durable reasoning and traceability

## Create a summary in `.planning/summaries/` when
- the chat becomes too long
- multiple attempts were made
- a meaningful slice ends
- a handoff is likely
- temporary reasoning must be compressed

## Create verification notes when
- risk is medium or high
- an important change was validated
- the slice touched critical behavior
- there is a result worth preserving for later confidence

## Escalate from execution to governance when
- the change affects more than one module
- there is architecture impact
- a new external dependency is introduced
- a security, compliance, or observability concern appears
- the work is no longer a local slice

## Stay in execution mode when
- the task is local and bounded
- the change is reversible and low risk
- the work fits one slice
- the implementation does not alter project-wide rules
