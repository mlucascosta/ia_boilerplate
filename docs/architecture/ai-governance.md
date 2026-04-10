# AI Governance in `ia_boilerplate`

This document explains the architectural audit and governance extension added under `.agents/governance/`.

## Purpose

The governance layer adds:

- architecture audit rules
- code review guidance
- anti-pattern detection
- standardized PR findings
- merge-impact classification

It extends the repository operating model without replacing the canonical `.agents/` contract.

## Repository model

| Layer | Path | Role |
|---|---|---|
| Normative AI | `.agents/` | Only normative AI layer |
| Audit governance | `.agents/governance/` | Audit and review specialization |
| Workflow/artifacts | `docs/ai/` | Workflow and artifact documentation |
| Human architecture | `docs/architecture/` | Human-facing architectural explanations |
| Knowledge vault | `vault/` | Optional Obsidian support, not normative |

## Governance files

| File | Purpose |
|---|---|
| `SKILLS.md` | Architectural audit skills and heuristics |
| `RULES.md` | Behavior rules, confidence, severity, and merge impact |
| `CHECKLIST.md` | Per-category review checklist |
| `ANTI_PATTERNS.md` | Recognized anti-pattern catalog |
| `REVIEW_OUTPUT_TEMPLATE.md` | Standardized finding and report format |

## Rollout

Initial rollout is advisory-only.

That means:

- audit comments may be generated in PRs
- findings do not block merge yet
- heuristics should be calibrated before enabling stricter gating

To enable merge blocking: set `merge_impact: block` explicitly in findings and update the workflow accordingly. Do not enable blocking before at least one calibration cycle.

## Why RTK remains mandatory

The repository already treats RTK as mandatory for token-efficient shell usage.

The governance layer preserves that rule and extends it to:

- audit guidance
- validation guidance
- shell-oriented examples
- reviewer operational instructions

**Exception:** CI workflows and automation scripts may use raw commands when RTK is not installed in the runner. This exception is limited to machine boundaries only.
