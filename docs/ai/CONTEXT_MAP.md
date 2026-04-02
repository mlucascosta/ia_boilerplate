# Context Map

Selective loading index. Agents must use this to determine which files to read per area instead of discovering scope each session.

## How to use

1. Find the area matching your task.
2. Load only the files listed under **Read first**.
3. Load files under **If needed** only when the task requires them.
4. Never load files outside these lists unless the user explicitly requests it.

## Template per area

```md
## <Area Name>
Read first:
- .planning/STATE.md
- <primary doc for this area>

If needed:
- <secondary docs>

Never load unless relevant:
- <unrelated docs that agents tend to pull in>
```

## Areas

> Populate the sections below as the project grows. Each area should list 2–5 files max under "Read first".

## Architecture
Read first:
- .planning/STATE.md
- docs/architecture/

If needed:
- docs/integrations/
- docs/infrastructure/

## Features
Read first:
- .planning/STATE.md
- docs/features/<relevant-feature>.md

If needed:
- docs/modules/<relevant-module>.md

## Infrastructure
Read first:
- .planning/STATE.md
- docs/infrastructure/

If needed:
- docs/environments/
- docs/runbooks/

## Integrations
Read first:
- .planning/STATE.md
- docs/integrations/<relevant-integration>.md

If needed:
- docs/architecture/
