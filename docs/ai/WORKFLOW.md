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
   Implement one atomic task at a time, or parallelize only when dependencies and file conflicts are clear.
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
2. `.planning/STATE.md` tracks current phase, decisions, blockers, and next steps for non-trivial work.
3. `.planning/ROADMAP.md` exists when work is phased.
4. `.planning/plans/` contains atomic plans when the task is large enough to need them.
5. `docs/` holds stable docs, runbooks, architecture notes, and reusable learnings.

## Planning Standards

Each atomic plan should answer:

1. What is being built or changed.
2. Which files or subsystems are expected to change.
3. What constraints must be preserved.
4. How success will be verified.
5. What is explicitly out of scope.

Prefer atomic plans that fit in a fresh context window without hidden dependencies.

## Verification Standards

Verification must be explicit.

1. Backend changes: tests first when required, then implementation, then validation.
2. DB changes: idempotency, rollback awareness, and migration safety.
3. UI changes: behavior validation on intended flows, not only static inspection.
4. Docs changes: confirm docs match implementation rather than aspirational future state.
5. Reviews: prioritize bugs, regressions, missing tests, and operational risk.

## Documentation Standards

Use docs as operational memory.

1. Foundation docs cover architecture, infrastructure, integrations, environments, and glossary when relevant.
2. Scoped docs cover modules, features, runbooks, and ADR-like decisions.
3. Solution capture is reserved for stable patterns, not temporary noise.
4. Docs should be refreshed when implementation invalidates them.

## Reduto-Specific Working Rules

When this repository is used for Reduto-related work, keep these constraints active:

1. Backend work uses TDD with Pest and SOLID-oriented design.
2. Respect the PHP 8.3 plus HTMX plus AlpineJS plus MySQL direction.
3. Preserve explicit multi-tenant boundaries, audit trails, and immutable financial ledgers.
4. Prefer lightweight infrastructure choices aligned with the documented MVP constraints.
5. Treat frontend tokens, typography, and component structure as deliberate system design, not incidental styling.

## What Agents Must Avoid

1. Skipping codebase reading before proposing structural changes.
2. Making architecture decisions without updating the relevant docs.
3. Treating `.planning/` as disposable scratch output for non-trivial work.
4. Using a full workflow for trivial edits or a trivial workflow for risky changes.
5. Hiding assumptions that materially affect scope, delivery, or validation.