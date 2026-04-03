# Claude adapter

Follow `.agents/AGENTS.md`.

## Source of truth

1. `.agents/AGENTS.md`
2. `docs/ai/WORKFLOW_SHORT.md`
3. `docs/ai/WORKFLOW.md` only if ambiguous
4. `docs/ai/ARTIFACTS.md`

## First read

- `docs/ai/WORKFLOW_SHORT.md`
- one active artifact: `.planning/STATE.md` or the active plan
- area files selected through `docs/ai/CONTEXT_MAP.md`
- files explicitly requested by the user

If an active plan exists, use it as the local execution guide and keep `STATE.md` as the global header only.

## Max read budget

Before acting, read only the first-read set and the smallest additional area context needed for correctness.
Do not scan the whole repository.
Do not load unrelated docs.

## Path selection

- Trivial: 1 file, no cross-cutting impact, default `VERIFY=V0`
- Focused: 2-3 files or targeted validation, default `VERIFY=V1`
- Full: more than 3 files, migration, infra, auth, billing, queue, or structural impact, default `VERIFY=V2`

Escalate path if correctness is at risk.

## Engineering defaults

- TDD by default: write tests first, then implement real code
- Behavioral changes require validation proportional to risk
- Use unit, integration, and E2E coverage as needed by impact
- Refactor under SOLID constraints before considering work complete
- Do not implement first and cover later as the default path
- Preserve hybrid governance: agile execution with PMBOK-style control and traceability

## Git strategy

- Git Flow is mandatory
- Detect the stable branch as `main` or `master`
- `develop` is the default integration and base branch for feature work
- Create `feature/*` branches from `develop`
- Merge feature branches back into `develop`
- Reserve the stable branch for release state
- Use `release/*` for stabilization and `hotfix/*` for urgent production fixes
- Do not work directly on the stable branch for normal feature delivery
- If the stable branch exists but `develop` does not, create `develop` from the stable branch before feature work starts
- If neither `develop` nor a stable branch exists, ask the user to identify the long-lived branches before proceeding, then initialize Git Flow with `develop` as the integration branch

## Output contract

- Return only the minimal diff or patch.
- Add a short decision note only when required for correctness.
- Add the exact next step only when the task remains open.
- Prefer flags and manifests over prose. Do not restate plan flags in natural language.
- No workflow recap.
- No file dumps.
- No context replay.

## Verification contract

- Use `V0` for trivial work, `V1` for focused work, `V2` for full work, and escalate to `V3` when user-facing or system risk requires unit + integration + E2E evidence.
- Escalate verification when risk exceeds the default path.
- Keep verification explicit and minimal.

## Artifact update rules

- Keep `.planning/STATE.md` telegraphic and within 120 words.
- Rotate old context into `.planning/summaries/`.
- Use `docs/ai/DECISION_RULES.md` before updating roadmap, ADRs, or plans.
- Treat chat history as temporary memory only.

## Hard prohibitions

- Pasting entire files.
- Re-explaining the workflow.
- Treating chat history as the source of truth.
- Hiding structural changes inside execution notes.
