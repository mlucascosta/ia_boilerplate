# Unified AI Workflow

This repository combines two ideas:

1. Pster's workflow for explicit, documentation-first, developer-controlled execution.
2. GSD for artifact-driven planning, phased delivery, verification, and persistent workflow state.

The result is a model-agnostic workflow that can be followed by Copilot, Codex, Claude, or any other capable coding agent.

## Principles

1. Developer-controlled path: the human or lead agent chooses the path explicitly.
2. Context-first execution: read code, docs, and constraints before implementation.
3. Documentation as memory: `docs/` and `.planning/` carry forward durable project knowledge.
4. Dynamic rigor: small work can stay light; risky work must go deeper.
5. Verifiable delivery: each meaningful task needs a concrete validation path.
6. Explicit design delivery: implementation work is expected to preserve complete code-level documentation and a SOLID-oriented architecture.
7. Mandatory Git Flow discipline: meaningful work must happen on Git Flow-compatible branches, not directly on the protected primary branch.
8. TDD-first implementation: behavior changes start with tests, then minimal implementation, then refactor.

## Delivery Model

This repository uses a hybrid delivery model. See `docs/ai/PROJECT_METHOD.md` for full rationale.

## Delivery Policy

This project uses one delivery system with distinct layers:

- PMBOK-inspired governance for direction, scope, risks, architecture, quality policy, and major change control
- Agile-inspired execution for backlog-driven work, small slices, short iterations, AI-assisted delivery, and incremental validation
- Git Flow for integration discipline across feature, fix, release, and hotfix work
- Mandatory quality gates for all non-trivial code changes

### Governance layer
Use governance artifacts for:
- project direction
- scope boundaries
- architectural decisions
- risks
- quality rules
- canonical documentation

### Execution layer
Use execution artifacts for:
- backlog-driven implementation
- small slices
- AI-assisted pair programming
- short validation loops
- summaries and handoffs

### Core rule
Stable decisions must be recorded before repeated execution begins.
Exploratory work must be broken into small, testable slices.

## Human and AI Roles

Humans own: judgment, prioritization, architecture, security, validation, approval.

AI accelerates: drafting, local analysis, implementation support, tests, refactors, summaries.

AI does not own final approval. No critical delivery is accepted without human validation proportional to risk.

## Standard Paths

### Path A: Full Feature Flow

Use for new features, architectural changes, multi-file refactors, integrations, data work, auth, billing, operations, or anything with non-trivial risk.

1. Map
   Read the affected codebase area, identify current patterns, constraints, and undocumented gaps.
2. Foundation Docs
   Create or refresh the minimum docs needed to avoid blind implementation.
3. Brainstorm
   Clarify scope, goals, constraints, user-facing behavior, edge cases, and acceptance criteria.
4. Plan
   Break work into phases or atomic plans that can be executed and verified independently.
5. Quality Gates
   Resolve major ambiguities, check coverage, and confirm the plan aligns with docs and requirements.
6. Execute
   Implement one atomic task at a time, starting with failing tests, then minimal implementation, then refactor. Parallelize only when dependencies and file conflicts are clear.
7. Verify
   Run tests, checks, manual validation, or artifact-based verification against the defined acceptance criteria.
8. Capture
   Update docs and record reusable learnings when the work introduced durable knowledge.

### Path B: Focused Change Flow

Use for bounded changes that do not justify a full phase plan.

1. Read the relevant code and docs.
2. Clarify the exact ask and constraints.
3. Make a short implementation plan.
4. Implement the focused change.
   Start with the smallest failing test, then implement the minimum real code, then refactor.
5. Validate the outcome.
6. Update docs if the change altered durable project knowledge.

### Path C: Trivial Change Flow

Use for clearly local, low-risk edits.

1. Confirm the change is truly local.
2. Edit directly.
3. Run the smallest relevant validation.
4. Skip planning artifacts unless the user asks for them.

## Decision Matrix

Choose the lightest path that still preserves correctness.

| Situation | Required Path |
| --- | --- |
| Copy, labels, small styling, single-file local fix | Trivial |
| One focused bug fix, one endpoint, one component, one test addition | Focused |
| New feature, risky refactor, migration, auth, billing, queue, infra, cross-cutting docs | Full |

## Handling large scopes

When a request is broader than a single feature or bugfix (for example: project-wide planning, full MVP definition, large-scale documentation, multi-module architecture, or execution planning across multiple areas), treat it as a **Full** workflow by default.

### Rules
1. **Do not execute the whole scope in a single pass.**
   Large scopes must be converted into planning artifacts before documentation or implementation begins.

2. **Build the planning machine first.**
   Create or update, as needed:
   - `STATE.md` with the current objective, working hypothesis, main risk, and immediate next step
   - `ROADMAP.md` with the macro-phases of the work
   - `.planning/epics/` when a macro-phase needs its own grouped breakdown
   - `.planning/plans/PLAN-XXX-*.md` for atomic executable slices

3. **Proceed iteratively.**
   Work one atomic plan at a time. After each completed slice:
   - update `STATE.md`
   - write a compact handoff in `summaries/`
   - move to the next plan only after the current one is stable

4. **Never attempt "complete MVP documentation" in one handoff.**
   That violates atomicity, increases token waste, and raises the risk of scope drift.

### Practical interpretation
Use this sequence for large scopes:

`raw scope -> STATE.md -> ROADMAP.md -> epics -> atomic plans -> execution/docs -> summaries -> next slice`

## Unified Command Equivalents

Different runtimes expose different commands. Use the conceptual stage, not the literal slash command, as the source of truth.

| Intent | Pster concept | GSD concept | Cross-AI expectation |
| --- | --- | --- | --- |
| Workspace bootstrap | `pwf-setup`, `pwf-doc-foundation` | `gsd:map-codebase`, `gsd:new-project` | Establish docs and current-state understanding |
| Scope shaping | `pwf-brainstorm` | `gsd:discuss-phase` | Clarify decisions before planning |
| Planning | `pwf-plan` | `gsd:plan-phase` | Produce phased or atomic executable tasks |
| Quality checks | `pwf-checklist`, `pwf-clarify`, `pwf-analyze` | plan verification and reviews | Remove ambiguity and weak plans |
| Execution | `pwf-work-plan`, `pwf-work`, `pwf-work-tdd` | `gsd:execute-phase`, `gsd:quick`, `gsd:fast` | Implement in small verifiable units |
| Verification | `pwf-review` plus manual checks | `gsd:verify-work`, `gsd:review` | Confirm implementation and surface gaps |
| Documentation capture | `pwf-doc*` family | planning artifacts plus summaries | Persist durable knowledge |

## Required Artifacts

Store workflow state in `.planning/` and durable project knowledge in `docs/`.

Minimum artifact expectations:

1. `docs/ai/ARTIFACTS.md` defines the artifact contract.
2. `docs/ai/PROJECT_METHOD.md` defines the hybrid delivery model.
3. `docs/ai/DECISION_RULES.md` defines when to update each artifact.
4. `.planning/STATE.md` tracks current phase, decisions, blockers, and next steps for non-trivial work.
5. `.planning/ROADMAP.md` exists when work is phased.
6. `.planning/VISION.md` captures durable product direction when the project scope justifies it.
7. `.planning/RISK_REGISTER.md` tracks known risks with mitigations.
8. `.planning/epics/` groups related plans for macro-phases when needed.
9. `.planning/adrs/` stores structural technical decisions with durable reasoning.
10. `.planning/plans/` contains atomic plans when the task is large enough to need them.
11. `docs/` holds stable docs, runbooks, architecture notes, and reusable learnings.

## Planning Standards

Each atomic plan should answer:

1. What is being built or changed.
2. Which files or subsystems are expected to change.
3. What constraints must be preserved.
4. How success will be verified.
5. What is explicitly out of scope.

Prefer atomic plans that fit in a fresh context window without hidden dependencies.

## Verification Standards

Verification must be explicit and proportional to risk.

## Quality Policy

All non-trivial changes require validation proportional to risk.

Default expectations:

- TDD for behavior changes
- unit tests for isolated logic
- integration tests for real boundaries
- E2E tests for critical user flows
- security validation for exposed or sensitive paths
- SOLID review for design quality

### Verification levels

| Level | When | What |
| --- | --- | --- |
| V0 | Trivial path | Reasoning only — confirm the change is correct by inspection |
| V1 | Focused path | One targeted unit check or equivalent local validation |
| V2 | Full path | Unit + integration checks, or equivalent multi-check evidence |
| V3 | Critical full path | Unit + integration + E2E when user-facing or system risk justifies it |

Default to the lowest level that still preserves correctness.

### Verification checklist

1. Code changes must leave complete code documentation in a consistent standard such as TSDoc, PHPDoc, or an equivalent format appropriate to the language.
2. Architectural changes must preserve SOLID-oriented design and make responsibilities, boundaries, and dependencies easy to reason about.
3. DB changes require explicit validation of idempotency, rollback awareness, and migration safety.
4. UI changes still require behavior validation on intended flows, not only static inspection.
5. Docs changes must confirm docs match implementation rather than aspirational future state.
6. Reviews must prioritize bugs, regressions, missing documentation, architectural drift, and operational risk.

## TDD Policy

Use TDD by default when:

- changing business behavior
- fixing a bug with reproducible behavior
- adding a new rule or contract
- refactoring behavior-sensitive logic

TDD may be lighter when:

- changing static content
- doing cosmetic UI-only work
- editing documentation
- performing low-risk configuration changes

### Default implementation order

For behavior changes, the default execution order is:

1. Define expected behavior.
2. Write the test first.
3. Run the test and observe failure.
4. Implement the minimum real code.
5. Refactor under SOLID constraints.
6. Re-run the required validation layers.

Implementation first and cover later is not the default path.

## Test Matrix

### Unit tests

Required for:

- pure logic
- services
- validators
- mappers
- policies
- domain rules

### Integration tests

Required for:

- database access
- queues
- external APIs
- cache
- file storage
- auth boundaries

### E2E tests

Required for:

- login
- registration
- checkout or payment
- critical CRUD flows
- permission-sensitive user journeys
- any top-tier business path

### Security validation

Required for:

- auth and session changes
- permission changes
- file upload
- public endpoints
- input parsing
- secrets and config exposure

## Security Gate

A change must trigger security validation when it affects:

- authentication
- authorization
- session handling
- public endpoints
- file upload or download
- external integrations
- user input parsing
- secrets, tokens, or credentials

## SOLID Usage

SOLID is used as a design review lens. It is not a license for overengineering.

Apply SOLID most strongly when:

- creating services
- defining interfaces
- refactoring domain logic
- isolating external dependencies
- reducing coupling in growing modules

## Branch Policy

Git Flow is mandatory for meaningful implementation work.

1. Agents must not execute meaningful implementation work directly on `main`, `master`, or any protected primary branch.
2. Feature work must happen on `feature/*` branches.
3. Bounded fixes should happen on `fix/*` branches.
4. Release stabilization work must happen on `release/*` branches.
5. Urgent production fixes must happen on `hotfix/*` branches.
6. If the repository documents a different protected-branch naming policy, preserve that policy while keeping Git Flow branch families for delivery work.
7. Planning, execution, and merge recommendations must assume branch-based delivery rather than direct commits to the primary branch.
8. All non-trivial work must go through pull request review.

## Documentation Standards

Use docs as operational memory.

1. Foundation docs cover architecture, infrastructure, integrations, environments, and glossary when relevant.
2. Scoped docs cover modules, features, runbooks, and ADR-like decisions.
3. Solution capture is reserved for stable patterns, not temporary noise.
4. Docs should be refreshed when implementation invalidates them.

## Project-Specific Working Rules

When this repository is used as a project workflow base, keep these constraints active:

1. Implementation work must maintain complete in-code documentation using TSDoc, PHPDoc, or an equivalent language-appropriate standard.
2. Architectural work must preserve SOLID-oriented design and keep core business rules explicit in application code.
3. Preserve explicit isolation boundaries, audit trails, and immutable history where the domain requires them.
4. Prefer the simplest architecture and infrastructure that satisfies the documented constraints.
5. Treat frontend structure, tokens, typography, and interaction rules as deliberate system design, not incidental styling.
6. Do not introduce major framework or infrastructure shifts without first documenting and approving the direction.

## Token Economy And Context Continuity

Treat token cost and context continuity as engineering constraints, not afterthoughts.

1. Keep active state in `.planning/STATE.md`, not in implicit chat memory.
2. Reference file paths instead of pasting large content into prompts.
3. Request diff-oriented outputs, not full-file rewrites.
4. Use short constraint lists (3-7 bullets) instead of narrative instructions.
5. Keep each execution loop atomic: one plan, one slice, one verification.
6. At session boundaries or model switches, write a compact handoff summary (max 120 words) covering objective, changed files, checks run, open risks, and next action.
7. Store handoff summaries in `.planning/summaries/` and mirror the next action in `.planning/STATE.md`.
8. If a chat drifts from the current objective, compact context into artifacts and restart from `.planning/STATE.md`.
9. Prefer deterministic, artifact-backed instructions over long freeform prompts.
10. On first read, load `docs/ai/WORKFLOW_SHORT.md`. Consult `WORKFLOW.md` only when ambiguity requires it.
11. Use `docs/ai/CONTEXT_MAP.md` to determine which files to load per area instead of discovering scope each session.
12. If `STATE.md` exceeds 120 words during execution, compress it immediately and rotate old context to `.planning/summaries/`.

### Session reset triggers

If any of these conditions is met, the agent must reset:

- Chat exceeds **12 turns**, or
- **3 scope changes** within one session, or
- **2 failed attempts** at the same task.

Reset procedure:
1. Write a `SUMMARY` for the current slice.
2. Compress `STATE.md` to ≤120 words.
3. Restart from `STATE.md` + active `PLAN` only.

### Task manifest flags

Every atomic plan should carry compact flags at the top:

```
SCOPE=trivial|focused|full
DOC=full|min
ARCH=solid|none
VERIFY=V0|V1|V2
FILES=<comma-separated paths>
OUT=<explicit exclusions>
```

This lets agents parse task constraints in ~10 lines instead of re-reading prose.

## What Agents Must Avoid

1. Skipping codebase reading before proposing structural changes.
2. Making architecture decisions without updating the relevant docs.
3. Treating `.planning/` as disposable scratch output for non-trivial work.
4. Using a full workflow for trivial edits or a trivial workflow for risky changes.
5. Hiding assumptions that materially affect scope, delivery, or validation.
6. Asking the model to re-read everything when file-scope can be explicit.
7. Combining unrelated tasks in a single prompt.
8. Continuing drifted chats instead of compacting into artifacts and restarting (see Token Economy rule 8).
9. Skipping handoff summaries at session boundaries, because missing context causes expensive rework.

## Definition of Done

A slice is done only when:
- the scoped change is implemented
- required tests were added or updated
- validation appropriate to risk was completed
- security impact was checked when applicable
- design remains maintainable under a SOLID review lens
- the result is summarized
- `STATE.md` is updated
- no unresolved structural decision is hidden inside execution notes
