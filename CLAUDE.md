# Claude adapter for ia_boilerplate

Follow `AGENTS.md` (which points to WORKFLOW.md + ARTIFACTS.md).

## Hard constraints for this session
- First read: `docs/ai/WORKFLOW_SHORT.md`. Full `WORKFLOW.md` only when ambiguous.
- Use `docs/ai/CONTEXT_MAP.md` to pick files per area.
- Never read more than: pocket card + 1 active artifact + area files + requested files.
- Output only the minimal diff/patch. No unnecessary summaries, no context replay.
- State file ≤120 words, telegraphic format; rotate history to `summaries/`.
- Verification: V0 or V1 unless task is Full (V2 only when change risk justifies it).
- Never paste entire files – only minimal excerpts when needed.
- Session reset: >12 turns, >3 scope changes, or >2 failed attempts → SUMMARY → compress STATE → restart.
- Use `docs/ai/RECIPES.md` for common task patterns.

## Flags in plans (compact)
`DOC=full|min`, `ARCH=solid|none`, `VERIFY=V0|V1|V2`, `SCOPE=<files>`