# Recipes

Ultra-short task templates for common operations. Use these to reduce prompt size and standardize agent behavior.

## Focused bugfix

```
Read: .planning/STATE.md + affected file(s)
Deliver: root cause + minimal diff + V1 verification
Summary: ≤80 words
```

## Doc change

```
Read: .planning/STATE.md + target doc
Deliver: updated doc (diff only)
Verify: V0 — confirm doc matches implementation
Summary: ≤60 words
```

## New endpoint

```
Read: .planning/STATE.md + route file + service file + relevant docs
Deliver: route + handler + service method + tests
Verify: V1 — single request test
Summary: ≤100 words
```

## Local refactor

```
Read: .planning/STATE.md + target file(s)
Deliver: refactored code (diff only) + updated in-code docs
Verify: V1 — existing tests pass
Summary: ≤80 words
```

## Component change (UI)

```
Read: .planning/STATE.md + component file + design tokens/system docs
Deliver: component diff + visual validation notes
Verify: V1 — behavior check on intended flow
Summary: ≤80 words
```

## Code review

```
Read: diff/PR + .planning/STATE.md
Deliver: bugs, regressions, missing docs, arch drift, operational risk
Format: bullet list, max 10 items
Summary: not needed
```

## Session handoff

```
Read: .planning/STATE.md + recent summaries
Deliver: compressed STATE (≤120 words) + SUMMARY (≤120 words)
Verify: V0 — next agent can continue without replaying chat
```

## New feature (Full path)

```
Read: .planning/STATE.md + CONTEXT_MAP area + relevant docs
Deliver: ROADMAP update + atomic PLANs + execute first slice
Verify: V2 per slice
Summary: per slice ≤120 words
```
