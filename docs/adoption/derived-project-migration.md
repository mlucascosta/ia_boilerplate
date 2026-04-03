# Derived Project Migration

Use this playbook when a repository already bootstrapped from this boilerplate needs to pick up newer workflow infrastructure without resetting its product docs or app code.

## Goal

Sync the workflow layer forward while preserving project-specific identity and implementation history.

## Command

```bash
./scripts/migrate-derived-repo.sh --target /path/to/derived-repo
```

Optional flags:

- `--dry-run` to preview the files that would be updated
- `--include-ci` to also sync `.github/workflows/validate.yml`

## What It Syncs

- canonical workflow docs in `docs/ai/`
- adoption playbooks in `docs/adoption/`
- runtime adapters and PR template
- starter templates in `.planning/`
- local validation and migration scripts
- validation test coverage for the workflow layer

## What It Avoids

- product README changes
- application code changes
- active project state such as `.planning/STATE.md`, `ROADMAP.md`, or `PROJECT.md`
- CI workflow changes unless `--include-ci` is requested

## Recommended Sequence

1. Run the command with `--dry-run`.
2. Run the command without `--dry-run` once the target paths look correct.
3. In the target repository, run `bash scripts/validate-workflow.sh`.
4. If CI sync was included, review `.github/workflows/validate.yml` before merge.