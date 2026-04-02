# Workflow Success Checklist

Use this before closing any non-trivial slice of work to confirm the agent followed the workflow correctly.

## Before writing any code

- [ ] Objective is explicit in `.planning/STATE.md`
- [ ] Scope is bounded: impacted files are listed in an atomic plan under `.planning/plans/`
- [ ] Plan includes verification steps and done criteria

## During implementation

- [ ] Only planned files were modified (or scope update was documented)
- [ ] Every new public function, class, or method has complete in-code documentation (TSDoc, PHPDoc, or equivalent)
- [ ] Architecture follows SOLID orientation: responsibilities are separated, dependencies point inward

## After implementation

- [ ] Verification steps from the plan were run and results are logged
- [ ] `.planning/verification/` has evidence of what passed and what remains at risk
- [ ] `.planning/STATE.md` next step reflects the current real state

## At session boundaries

- [ ] A compact handoff summary (max 120 words) is stored in `.planning/summaries/`
- [ ] The summary covers: objective, changed files, checks run, open risks, next action
- [ ] The next action in the summary matches the next step in `STATE.md`

## Validation command

```bash
bash scripts/validate-workflow.sh
```

A passing score confirms structural conformance. This checklist confirms behavioral conformance.
