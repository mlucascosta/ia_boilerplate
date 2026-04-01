# CollabPix AI Operating Manual

This repository uses a cross-AI workflow that must remain consistent across Copilot, Codex, Claude, and any other coding agent.

The canonical workflow is documented in `docs/ai/WORKFLOW.md`.
The canonical artifact contract is documented in `docs/ai/ARTIFACTS.md`.

## Core Operating Rules

1. Follow the workflow phases in `docs/ai/WORKFLOW.md` instead of improvising ad-hoc execution.
2. Read existing docs and planning artifacts before proposing or implementing changes.
3. Prefer explicit plans, small batches, and verifiable execution over broad speculative edits.
4. Keep project docs current when a change affects architecture, flows, infrastructure, operations, or reusable patterns.
5. Treat `docs/` and `.planning/` as operational memory, not optional documentation.

## Default Workflow

For brownfield work on an existing codebase, use this order unless the user requests a lighter path:

1. Map the codebase and current constraints.
2. Update or create baseline docs if the relevant area is undocumented.
3. Clarify scope, constraints, and acceptance criteria.
4. Produce a phased or atomic plan.
5. Execute in small, verifiable tasks.
6. Run validation and surface remaining risks.
7. Capture reusable learnings in docs when the work was non-trivial.

## Planning Rules

1. Use a lightweight path for trivial local edits.
2. Use a phased plan for features, migrations, integrations, refactors, or risky work.
3. Prefer vertical slices that can be validated independently.
4. Keep one source of truth for task state in `.planning/`.
5. Do not skip verification for backend, database, auth, billing, queue, or infrastructure changes.

## Documentation Rules

1. Read relevant docs before implementation.
2. Update docs in the same unit of work when behavior, architecture, or operations change.
3. Capture stable patterns and non-obvious decisions.
4. Avoid documenting churn; document durable knowledge.

## Reduto Project Constraints

These constraints apply whenever work targets the Reduto stack described by project memory and roadmap material:

1. Backend work must use TDD with Pest and SOLID-oriented design.
2. Prefer PHP 8.3 with explicit business rules in application code.
3. Keep database access explicit and safe.
4. Preserve multi-tenant isolation, auditability, and immutable financial history.
5. Avoid introducing forbidden platform choices such as Laravel, Symfony, CodeIgniter abstractions for new architecture, Redis, RabbitMQ, Kafka, Docker, and Kubernetes unless the user explicitly changes the platform direction.
6. Frontend work should respect the existing HTMX plus AlpineJS direction and the documented design-token approach.

## Execution Quality Bar

1. Fix root causes instead of cosmetic patches when practical.
2. Keep diffs focused and consistent with existing conventions.
3. Validate with tests, checks, or explicit reasoning tied to acceptance criteria.
4. Call out blockers, assumptions, and residual risks clearly.

## Runtime Adapters

Use the runtime-specific files only as adapters to this manual:

1. Copilot: `.github/copilot-instructions.md`
2. Claude: `CLAUDE.md`
3. Codex: `.codex/skills/reduto-workflow/SKILL.md`

If two files disagree, `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md` take precedence, then this file, then runtime-specific adapters.