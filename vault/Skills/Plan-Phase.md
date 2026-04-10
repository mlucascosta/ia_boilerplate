---
tags: [skills, plan-phase, workflow]
---

# Plan Phase

The plan-phase skill produces an executable, atomic plan for a bounded slice of delivery work.

## When to Use

- A goal is defined but not yet broken into tasks
- The work spans 2+ files or requires validation
- You need an auditable record of the implementation approach

## Output: PLAN.md

Location: `.planning/plans/PLAN.md`

Structure:

```md
# Plan: [Phase Name]

## Goal
One sentence: what this plan delivers.

## Done Criteria
- [ ] Criterion A (verifiable)
- [ ] Criterion B (verifiable)

## Tasks
- [ ] T1: Write failing test for X
- [ ] T2: Implement X
- [ ] T3: Verify with rtk cargo test

## Risks
- Risk A → mitigation

## Verification
VERIFY=V1  (or V2, V3)
```

## Rules

- Tasks must be **atomic** — one commit per task
- Done criteria must be **verifiable** before execution starts
- Path selection is automatic: trivial / focused / full
- Research before planning when domain is unfamiliar

## Escalation

Escalate to Full path if:
- Cross-cutting change (>3 files)
- Auth, billing, infra, migrations, queues
- Structural or architectural impact

## File Reference

Skill definition: `.agents/skills/plan-phase/SKILL.md`
