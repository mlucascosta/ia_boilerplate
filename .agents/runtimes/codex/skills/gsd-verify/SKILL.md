---
name: "gsd-verify"
description: "Validate built features through UAT — diagnoses gaps and creates fix plans"
metadata:
  short-description: "Validate built features through UAT — diagnoses gaps and creates fix plans"
---

<codex_skill_adapter>
## A. Skill Invocation
- Invoked by mentioning `$gsd-SLUG`.
- Treat all user text after `$gsd-SLUG` as `{{GSD_ARGS}}`.

## B. AskUserQuestion → request_user_input Mapping
- `header` → `header`, `question` → `question`
- Execute mode fallback: plain-text numbered list, pick reasonable default

## C. Task() → spawn_agent Mapping
- `Task(subagent_type="X", prompt="Y")` → `spawn_agent(agent_type="X", message="Y")`
- `Task(model="...")` → omit
- Parallel: spawn → collect IDs → `wait(ids)` → `close_agent(id)`
</codex_skill_adapter>

<objective>
Validate built work and close gaps.

Default: Conversational UAT. One test at a time. Tracks in {phase}-UAT.md. Creates fix plans on failure.
--audit: Cross-phase scan of all outstanding UAT and verification items.
--validate: Audit validation debt for completed work.
--health: Planning directory diagnostics. Add --repair to auto-fix.

After passing: run gsd-ship to create PR.
</objective>

<context>
{{GSD_ARGS}}
Routing:
- `--audit` → audit UAT debt
- `--validate` → validate-phase workflow
- `--health` → health diagnostics
- else → verify-work UAT workflow
</context>

<process>
Parse arguments and execute the matched workflow end-to-end.
</process>

<execution_context>
@.agents/workflows/verify-work.md
@.agents/workflows/audit-uat.md
@.agents/workflows/validate-phase.md
@.agents/workflows/health.md
@.agents/templates/UAT.md
</execution_context>
