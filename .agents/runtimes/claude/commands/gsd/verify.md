---
name: gsd:verify
description: Validate built features through UAT — diagnoses gaps and creates fix plans
argument-hint: "[phase number] [--audit] [--validate] [--health [--repair]]"
allowed-tools:
  - Read
  - Bash
  - Glob
  - Grep
  - Edit
  - Write
  - Task
---
<objective>
Validate built work and close gaps.

**Default (phase number or none):** Conversational UAT validation.
- One test at a time, plain text responses
- Tracks results in `{phase}-UAT.md`
- When issues found: diagnoses gaps, creates fix plans ready for `/gsd:run --gaps-only`

**`--audit`:** Cross-phase audit of all outstanding UAT and verification items.
- Scans all phases for incomplete UAT, unresolved gaps, pending verification
- Produces a prioritized remediation list

**`--validate`:** Audit validation debt for a completed phase.
- Reconstructs or checks VALIDATION.md coverage
- Highlights missing tests or verification evidence

**`--health`:** Diagnose planning directory health and optionally repair issues.
- Checks artifact integrity, budget compliance, state consistency
- Add `--repair` to auto-fix detected issues

After issues are resolved: run `/gsd:ship` to create PR.
</objective>

<execution_context>
@.agents/workflows/verify-work.md
@.agents/workflows/audit-uat.md
@.agents/workflows/validate-phase.md
@.agents/workflows/health.md
@.agents/templates/UAT.md
</execution_context>

<context>
Arguments: $ARGUMENTS

**Routing:**
- `--audit` flag → cross-phase audit mode
- `--validate` flag → validation debt mode
- `--health` flag → health check mode (add `--repair` to fix)
- Phase number or none → verify-work UAT workflow

Context files are resolved inside the workflow.
</context>

<process>
Parse $ARGUMENTS:
- `--audit` → scan all .planning/ phases for UAT gaps, summarize findings, propose remediation order
- `--validate` → run validate-phase workflow for completed work
- `--health` → run planning directory diagnostics; if `--repair` also present, auto-fix issues
- Otherwise → execute verify-work workflow end-to-end, preserve all workflow gates
</process>
