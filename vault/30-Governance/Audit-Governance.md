# Governance Summary

This vault note summarizes the AI governance layer. It is editorial and human-first.

For normative rules, always consult `.agents/governance/` directly.

---

## Purpose

The governance layer (`agents/governance/`) adds architectural audit capabilities:

- detecting boundary violations (Clean Architecture, DDD, SOLID)
- identifying anti-patterns before merge
- providing standardized PR findings
- keeping the rollout advisory-first

## Files and their roles

| File | Role |
|---|---|
| `SKILLS.md` | Audit skills and heuristics per category |
| `RULES.md` | Auditor behavior: evidence, confidence, severity, merge impact |
| `CHECKLIST.md` | Per-category review checklist |
| `ANTI_PATTERNS.md` | Recognized anti-pattern catalog |
| `REVIEW_OUTPUT_TEMPLATE.md` | Standardized finding and report format |

## Advisory rollout

Initial rollout is advisory-only. Findings appear as PR comments.
No merge is blocked. Calibrate heuristics before enabling stricter gating.

## Normative source

All governance rules live in `.agents/governance/`.
This vault note is a reading aid — it does not define or override those rules.

See also: `docs/architecture/ai-governance.md`
