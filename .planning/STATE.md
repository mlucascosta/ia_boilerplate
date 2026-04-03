# State

## Objective

Keep workflow explicit, cheap.

## Active Work

Phase 21 completed.
`.agents/` canonical. Runtime-owned files in `.agents/runtimes/{codex,claude,github}/`. Root runtimes = compatibility entrypoints. 11 skills/runtime. Goal: compact-but-complete surface, upstream capability absorbed via routing and flags.

## Locked Decisions

1. `WORKFLOW.md` and `ARTIFACTS.md` canonical.
2. Runtime root files remain thin adapters.
3. Runtime-managed wrapper content lives under `.agents/runtimes/`.
4. Derived-repo migration preserves project identity and Codex skill naming.
5. Delivery = hybrid governance + agile execution + Git Flow + quality gates.
6. Active plan, when present, is hot artifact.
7. Default model profile: `budget`; non-Anthropic => `inherit`.

## Open Questions

Should phase 18 enforce CI gates?

## Blockers

None.

## Next Step

Choose phase 18 or phase 08.
