# Claude Adapter

Use `AGENTS.md` as the repository-wide operating manual.
The canonical workflow lives in `docs/ai/WORKFLOW.md`.
The canonical artifact contract lives in `docs/ai/ARTIFACTS.md`.

## Required Behavior

1. For non-trivial work, follow map -> clarify -> plan -> execute -> verify -> capture.
2. Read relevant docs before implementation.
3. Maintain `.planning/` for active workflow state when work is phased or risky.
4. Keep documentation aligned with implementation.
5. Preserve project constraints, especially mandatory complete in-code documentation and SOLID-oriented architecture for meaningful implementation work.
6. Preserve the documented architectural direction and avoid introducing undeclared platform shifts.

## Notes

1. If native GSD commands are available, use them as runtime helpers, not as replacements for the repository contract.
2. If native Pster commands are available, use them to generate or refresh docs and plans while keeping repository artifacts aligned with `docs/ai/ARTIFACTS.md`.