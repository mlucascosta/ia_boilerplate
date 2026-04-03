# New Project Adoption

Use this playbook when the repository will be the starting point for a new product or service.

## Goal

Start with the workflow fully active from day zero, without adding unnecessary ceremony before the first slice ships.

## Steps

1. Bootstrap the repository with `./scripts/bootstrap-template.sh --project-name "Your Project"`.
2. Run `bash scripts/validate-workflow.sh` before inviting contributors or agents.
3. Set the initial project direction in `.planning/VISION.md`, `.planning/PROJECT.md`, and `.planning/STATE.md`.
4. Keep the first roadmap short: only the first milestone and immediate follow-up phases belong in `.planning/ROADMAP.md`.
5. Pick one thin, demonstrable slice and write one atomic plan in `.planning/plans/` before implementation starts.
6. Require pull requests to declare workflow path, verification level, governance impact, and documentation impact.
7. Update durable docs only when the slice creates reusable knowledge; keep execution notes in `.planning/`.

## Minimum Viable Adoption

- `docs/ai/WORKFLOW_SHORT.md`
- `.planning/STATE.md`
- `.planning/ROADMAP.md`
- one atomic plan
- one validation command

## Common Failure Modes

- Writing a broad roadmap before the first real slice exists.
- Letting runtime-specific instructions become the source of truth.
- Treating bootstrap success as proof that the team has actually adopted the workflow.