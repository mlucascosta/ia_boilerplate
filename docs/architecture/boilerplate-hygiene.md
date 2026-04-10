# Boilerplate Hygiene

Use this checklist when making changes to `ia_boilerplate` itself.

Its purpose is to prevent structural drift — the main risk in a repository that is more workflow infrastructure than application code.

---

## Contract integrity

- [ ] Changes to `.agents/AGENTS.md` were reflected in all runtime adapters (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`).
- [ ] Changes to `.agents/governance/` were referenced in adapter governance sections.
- [ ] No normative rules were added to adapter files — adapters must remain thin wrappers.
- [ ] `docs/ai/CONTEXT_MAP.md` was updated if a new artifact or layer was introduced.
- [ ] `docs/architecture/information-architecture.md` was updated if the layer model changed.

## Workflow integrity

- [ ] `docs/ai/WORKFLOW_SHORT.md` still fits in ≤50 lines and covers the essential path.
- [ ] New workflow steps are referenced in `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md` if they introduce new artifacts.
- [ ] `START.md` still reflects the correct entry path and layer map.

## RTK compliance

- [ ] New shell guidance uses `rtk` prefixed commands.
- [ ] No raw shell commands were added to human-facing documentation or AI guidance.
- [ ] If a CI script uses raw commands, the exception is explicit and bounded to machine automation only.
- [ ] `RTK.md` was updated if new command categories were introduced.

## Knowledge layers

- [ ] New normative content was placed in `.agents/` or `.agents/governance/`, not in `vault/` or `docs/architecture/`.
- [ ] New editorial or human-facing content placed in `vault/` does not contradict `.agents/` contracts.
- [ ] `vault/` content that summarizes normative sources was checked for accuracy after normative source changes.

## Scripts

- [ ] Modified scripts have their `LAST_VALIDATED` metadata header updated.
- [ ] Scripts that changed behavior were tested locally (`rtk bash scripts/<script>.sh` or equivalent).
- [ ] `scripts/validate-workflow.sh` still passes.

## Documentation

- [ ] `README.md` Quick Start is still accurate and completable in under 2 minutes.
- [ ] `CHANGELOG.md` has an entry for the change.
- [ ] Examples in `docs/examples/` still work without modification if any core file they reference changed.

---

## Anti-patterns to watch for

- Adding normative rules to adapter files (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`)
- Creating a new top-level directory without defining its authority in `information-architecture.md`
- Defining workflow behavior in `vault/` instead of `docs/ai/`
- Adding shell commands to documentation without `rtk` prefix
- Updating scripts without updating `LAST_VALIDATED`
- Letting `WORKFLOW_SHORT.md` grow beyond its intended size
