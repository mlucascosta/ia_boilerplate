# AI Governance Rules

This directory defines the architectural audit and governance layer for this repository.

It extends `.agents/AGENTS.md` and must be interpreted together with:

- `.agents/AGENTS.md`
- `docs/ai/WORKFLOW_SHORT.md`
- `docs/ai/WORKFLOW.md`
- `docs/ai/ARTIFACTS.md`

## Scope

Use this governance layer when the task involves:

- architecture review
- pull request audit
- anti-pattern detection
- code quality governance
- merge-impact classification
- test quality review
- structural recommendations

## Source of truth

`.agents/` remains the only normative AI layer.

Files outside `.agents/` may serve as:

- human-facing documentation
- workflow documentation
- runtime compatibility adapters
- knowledge vault content

They must not become competing normative sources.

## RTK — Mandatory Token Optimization

RTK is mandatory for all shell commands in **guidance, human-assisted AI usage, and operational instructions**.

Required patterns for human/AI interaction:

- `rtk git status`
- `rtk git diff`
- `rtk read <file>`
- `rtk grep "pattern" .`
- `rtk ls .`
- `rtk pytest`
- `rtk cargo test`
- `rtk npm test`
- `rtk go test`

Never recommend raw shell commands in repository-facing guidance when an RTK equivalent exists.

**Exception:** Automation scripts (e.g., CI/CD workflows) may use raw commands when RTK is not available in the runner environment. Such exceptions must be limited to machine boundaries and documented explicitly.

## Evidence First

Never produce a blocking architectural finding without direct evidence.

Direct evidence includes:

- imports
- dependency direction
- concrete code usage
- method bodies
- inheritance contracts
- direct infrastructure coupling
- observable test behavior

If the conclusion depends mainly on interpretation, mark it as:

- `warning` or `inconclusive`
- with `confidence: low` or `medium`

## Confidence Rules

- `high`: structural evidence is explicit
- `medium`: evidence is strong but interpretation is involved
- `low`: inference depends on context, conventions, or partial semantic reading

Without direct evidence, never emit `fail`.

## Severity Rules

- `critical`: hard architectural break, test reliability break, or clear contract violation
- `major`: significant structural risk or strong design smell
- `minor`: local improvement opportunity or low-risk drift

## Merge Impact Rules

- `block`: only for clear hard-rule violations with direct evidence
- `review`: important issues requiring human decision
- `advisory`: informational or non-blocking improvement

Initial rollout must remain advisory-first. Do not assume blocking mode unless the repository explicitly enables it.

## Review Discipline

Prefer:

- smallest correction that restores architectural correctness
- explicit explanation grounded in repository rules
- proportional recommendations

Avoid:

- overengineering
- unnecessary abstraction
- suggesting multiple patterns for the same local problem
- broad rewrites when a focused correction is enough

## PR Scope Discipline

Analyze only:

- the provided diff
- the files explicitly included in scope
- the minimal surrounding context needed for correctness

Do not infer repository-wide violations from a local slice unless the evidence is direct.

## Testing Governance

Behavioral changes should be reviewed with risk-proportional validation:

- unit tests for local isolated behavior
- integration tests for boundary interactions
- E2E only when system/user flow risk justifies it

Default expectation remains TDD-first.

## Adapter Discipline

`AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` are adapters.

They may summarize or point to governance rules, but must not become alternate sources of truth.
