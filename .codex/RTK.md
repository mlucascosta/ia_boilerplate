# RTK — Mandatory Token Optimization (Codex)

RTK is required for all shell commands in this project.
Prefix every command with `rtk` to reduce token consumption by 60–90%.

@RTK.md

## Codex-Specific Note

The `rtk init -g --codex` command installs RTK globally for Codex by writing
`~/.codex/RTK.md` and patching `~/.codex/AGENTS.md` with `@RTK.md`.

Run it once after installing RTK:

```sh
rtk init -g --codex
```

All shell commands in this project must use the `rtk` prefix.
See `RTK.md` at the repository root for the full command rewrite table.
