# Claude adapter for ia_boilerplate

Follow `AGENTS.md` (which points to WORKFLOW.md + ARTIFACTS.md).

## Hard constraints for this session
- Use lightest possible path (Trivial > Focused > Full). Escalate only if correctness demands.
- Never read more than: 1 workflow + 1 active artifact + requested files.
- Output only the minimal diff/patch. No unnecessary summaries, no context replay.
- State file ≤200 words; rotate history to `summaries/`.
- Verification: V0 or V1 unless task is Full (use V2 only when change risk justifies it).
- Never paste entire files – only minimal excerpts when needed.

## Flags in plans (compact)
`DOC=full|min`, `ARCH=solid|none`, `VERIFY=V0|V1|V2`, `SCOPE=<files>`