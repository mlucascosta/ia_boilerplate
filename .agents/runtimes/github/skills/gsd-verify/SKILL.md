---
name: gsd-verify
description: Validate built features through UAT — diagnoses gaps and creates fix plans
---

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
</execution_context>
