# Runtime Shims Specification
## Minimal Compatibility Surfaces for Centralized `.agents/` Architecture

## 1. Purpose

This document defines the specification for runtime compatibility wrappers, also referred to as runtime shims.

These shims exist only to satisfy runtime discovery requirements while delegating all meaningful behavior to the centralized `.agents/` architecture.

They are not normative sources.

---

## 2. Core Rule

A runtime shim may exist outside `.agents/`, but it must not define or redefine workflow semantics.

A runtime shim may only:

- point to `.agents/AGENTS.md`
- point to runtime-specific notes in `.agents/adapters/`
- point to shared skills in `.agents/skills/`
- describe itself as compatibility-only

A runtime shim may not:

- redefine test strategy
- redefine branching rules
- redefine verification levels
- redefine artifact update policy
- redefine engineering defaults
- redefine architectural constraints

---

## 3. Supported Shim Targets

The initial generated targets are:

- `.claude/CLAUDE.md`
- `.codex/skills/project-workflow/SKILL.md`
- `.github/copilot-instructions.md`

Future runtimes may be added using the same model.

---

## 4. Required Properties of All Shims

All shims must be:

- minimal
- deterministic
- generated or regenerable
- non-normative
- traceable back to `.agents/`

All shims must explicitly indicate that `.agents/` is the source of truth.

---

## 5. Claude Shim Specification

## 5.1 Path

Recommended target:

```text
.claude/CLAUDE.md
```

## 5.2 Purpose

Provide Claude-compatible discovery while delegating all behavior.

## 5.3 Allowed Content

A Claude shim may include:

* a short title
* one sentence instructing the runtime to follow `.agents/AGENTS.md`
* a short pointer to `.agents/adapters/claude.md`
* optional pointers to shared skills and agents

## 5.4 Forbidden Content

A Claude shim may not include:

* its own workflow rules
* its own testing policy
* its own Git strategy
* its own output policy
* duplicated anti-patterns already owned centrally

## 5.5 Example

```md
# Runtime shim for Claude

Follow `.agents/AGENTS.md`.

Runtime-specific notes:
- See `.agents/adapters/claude.md`
- Shared skills live in `.agents/skills/`
- Shared agents live in `.agents/agents/`
```

---

## 6. Codex Shim Specification

## 6.1 Path

Recommended target:

```text
.codex/skills/project-workflow/SKILL.md
```

## 6.2 Purpose

Provide Codex-compatible skill discovery while delegating behavior centrally.

## 6.3 Allowed Content

A Codex shim may include:

* minimal frontmatter required by Codex
* one sentence instructing the runtime to follow `.agents/AGENTS.md`
* a pointer to `.agents/adapters/codex.md`
* a pointer to `.agents/skills/workflow-core/SKILL.md`

## 6.4 Forbidden Content

A Codex shim may not include:

* independent workflow logic
* test policy definitions
* branch policy definitions
* runtime-owned design constraints
* duplicate copies of central skill semantics

## 6.5 Example

```md
---
name: project-workflow
description: Minimal Codex shim that delegates to .agents
---

Follow `.agents/AGENTS.md`.
Runtime specifics: `.agents/adapters/codex.md`
Primary shared skill: `.agents/skills/workflow-core/SKILL.md`
```

---

## 7. Copilot Shim Specification

## 7.1 Path

Recommended target:

```text
.github/copilot-instructions.md
```

## 7.2 Purpose

Provide repository instruction compatibility for Copilot while preserving centralization.

## 7.3 Allowed Content

A Copilot shim may include:

* short statement directing behavior to `.agents/AGENTS.md`
* pointer to `.agents/adapters/copilot.md`
* explicit notice that the file is not the source of truth

## 7.4 Forbidden Content

A Copilot shim may not include:

* full workflow restatement
* test policy restatement
* design policy restatement
* branch strategy restatement
* verification model restatement

## 7.5 Example

```md
# Runtime shim for Copilot

Follow `.agents/AGENTS.md`.
Runtime-specific notes: `.agents/adapters/copilot.md`
Do not treat this file as a source of truth.
```

---

## 8. Shim Generation Rules

Runtime shims should be generated from `.agents/manifest.json` and centralized templates.

## 8.1 Inputs

The generator should consume:

* `.agents/manifest.json`
* runtime-specific adapter metadata
* shared shim templates
* target path definitions

## 8.2 Outputs

The generator should produce exact shim files at the expected runtime discovery locations.

## 8.3 Determinism

Generation must be deterministic. The same inputs must produce the same outputs.

## 8.4 Regeneration

A shim must be safely regenerable without losing repository behavior.

---

## 9. Shim Minimality Rules

A shim is considered valid only if it stays within minimal boundaries.

The following should be treated as shim bloat and architectural regression:

* embedding central workflow sections directly in the shim
* embedding testing policy
* embedding Git Flow policy
* embedding anti-pattern catalogs
* embedding detailed read-budget rules already owned centrally
* embedding plan/execute/verify semantics owned centrally

If any of these occur, the shim is no longer a compatibility surface and has become a shadow source of truth.

That must fail validation.

---

## 10. Validation Requirements

The repository should validate shims using automation.

Validation must confirm:

* target files exist
* target files match generator output
* target files explicitly point to `.agents/`
* target files remain minimal
* target files do not contain forbidden semantic sections

---

## 11. Example Validation Policy

A validation script may assert:

* shim length under a defined threshold
* required phrases present, such as:

  * `Follow .agents/AGENTS.md`
* forbidden phrases absent, such as:

  * `TDD by default`
  * `Git Flow is mandatory`
  * `Use V0, V1, V2, V3`

  if those lines belong centrally instead of in shims

This ensures the shim points to policy but does not become policy.

---

## 12. Error Cases

## 12.1 Runtime discovery file missing

Impact:

* runtime may fail to load repository instructions

Resolution:

* regenerate shim

## 12.2 Shim manually edited

Impact:

* drift from central architecture

Resolution:

* regenerate shim
* fail CI if checked-in file differs from generated output

## 12.3 Shim contains central semantics

Impact:

* second source of truth created

Resolution:

* move semantics into `.agents/`
* reduce shim to minimal wrapper
* revalidate

---

## 13. Lifecycle of a Shim

The lifecycle is:

1. central architecture changes
2. manifest and adapter notes update if needed
3. shim generator runs
4. runtime shim files are refreshed
5. CI validates no drift
6. runtime continues using minimal surface

Shims must never be treated as authoring-first artifacts.

---

## 14. Example End-to-End Flow

Suppose the repository updates the Git Flow policy centrally in `.agents/AGENTS.md`.

Correct result:

* Claude shim remains unchanged or changes only if generator template requires a different pointer layout
* Codex shim remains minimal
* Copilot shim remains minimal
* none of them restate the Git Flow policy

Incorrect result:

* each runtime shim gets its own new Git Flow section
* semantics become duplicated
* drift risk returns

Only the correct result is acceptable.

---

## 15. Recommended Generator Behavior

The generator should:

* read manifest
* identify enabled runtimes
* select template per runtime
* insert central references
* insert runtime adapter references
* write files to expected discovery locations
* preserve deterministic formatting

Optional enhancements:

* hash-based drift detection
* comments indicating generated origin
* support for future runtimes

---

## 16. Final Rule

> A runtime shim is valid only if it acts as a minimal compatibility pointer to `.agents/` and does not independently define workflow semantics, engineering policy, or architectural behavior.
