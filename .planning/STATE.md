# State

## Objective

Keep workflow explicit, cheap.

## Active Work

branch: `feature/agents-architecture-docs`
Wrote/replaced 4 architecture docs under `docs/architecture/`:
- `agents-centralization.md` — consolidated spec (28 sections)
- `agents-migration-plan.md` — file-by-file 9-phase migration plan
- `runtime-shims-spec.md` — shim contract per runtime
- `testing-governance.md` — TDD, layered tests, SOLID, Git Flow, Agile+PMBOK

## Locked Decisions

1. `WORKFLOW.md` and `ARTIFACTS.md` canonical.
2. Runtime root files remain thin adapters.
3. Runtime-managed wrapper content lives under `.agents/runtimes/`.
4. Derived-repo migration preserves project identity and Codex skill naming.
5. Delivery = hybrid governance + agile execution + Git Flow + quality gates.
6. Active plan, when present, is hot artifact.
7. Default model profile: `budget`; non-Anthropic => `inherit`.
8. `.agents/` is the only normative source; runtime surfaces are derived, minimal, disposable.

## Open Questions

None.

## Blockers

None.

## Next Step

Commit docs on `feature/agents-architecture-docs`, then open PR to `develop`.
