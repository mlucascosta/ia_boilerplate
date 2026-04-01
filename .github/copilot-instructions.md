# Copilot Instructions

Apply the repository workflow defined in `AGENTS.md`, `docs/ai/WORKFLOW.md`, and `docs/ai/ARTIFACTS.md`.

## Copilot-Specific Adapter

1. Treat `docs/` and `.planning/` as first-class project memory.
2. For non-trivial work, read the relevant docs and planning artifacts before editing code.
3. Use the unified workflow stages even if the exact slash commands come from another ecosystem.
4. Keep changes small, explicit, and verifiable.
5. Update durable docs when architecture, operations, or reusable patterns change.

## Project-Specific Priorities

1. Meaningful implementation work must keep complete in-code documentation using TSDoc, PHPDoc, or an equivalent language-appropriate standard.
2. Meaningful implementation work must preserve SOLID-oriented architecture.
3. Meaningful implementation work must use Git Flow-compatible branching and avoid direct work on the protected primary branch.
4. Respect the documented project constraints and existing architectural direction.
5. Prefer predictable delivery over speculative autonomy.

<!-- GSD Configuration — managed by get-shit-done installer -->
# Instructions for GSD

- Use the get-shit-done skill when the user asks for GSD or uses a `gsd-*` command.
- Treat `/gsd-...` or `gsd-...` as command invocations and load the matching file from `.github/skills/gsd-*`.
- When a command says to spawn a subagent, prefer a matching custom agent from `.github/agents`.
- Do not apply GSD workflows unless the user explicitly asks for them.
- After completing any `gsd-*` command (or any deliverable it triggers: feature, bug fix, tests, docs, etc.), ALWAYS: (1) offer the user the next step by prompting via `ask_user`; repeat this feedback loop until the user explicitly indicates they are done.
<!-- /GSD Configuration -->
