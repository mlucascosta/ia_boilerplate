# Review Output Template

Each finding should use this structure.

```json
{
  "status": "fail | warning | inconclusive",
  "severity": "critical | major | minor",
  "confidence": "high | medium | low",
  "merge_impact": "block | review | advisory",
  "category": "architecture | ddd | solid | testing | presentation | infra",
  "rule": "Name of the applied governance rule or skill",
  "evidence": {
    "file": "path/to/file",
    "line": 0,
    "snippet": "direct code evidence"
  },
  "why_matters": "Why this matters structurally",
  "suggested_fix": "Focused correction proposal",
  "possible_exception": "When this may be acceptable"
}
```

## Report structure

- overall summary
- auxiliary score
- grouped findings
- next steps

## Score policy

Score is auxiliary only.

Suggested deduction model:

- critical: -20
- major: -10
- minor: -3

Low-confidence warnings may be excluded from score.
