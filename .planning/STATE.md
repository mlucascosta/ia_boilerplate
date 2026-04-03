# State

## Objective

Keep the workflow enforceable, portable, and easy to upgrade in derived repositories.

## Active Work

Phases 15 and 16 completed.
Starter templates and lightweight derived-repo migration shipped.

## Locked Decisions

1. `docs/ai/WORKFLOW.md` is the canonical workflow source.
2. `docs/ai/ARTIFACTS.md` is the canonical artifact contract.
3. `AGENTS.md` is the repository-wide operating manual.
4. Runtime-specific files act only as adapters.
5. Adapter conformance is now enforced in validation.
6. Lightweight migration must preserve target project identity and Codex skill naming.

## Open Questions

Should phase 10 build a full version-boundary layer on top of the new lightweight sync?

## Blockers

None.

## Next Step

Execute phase 08 or define how phase 10 extends the lightweight migration script.