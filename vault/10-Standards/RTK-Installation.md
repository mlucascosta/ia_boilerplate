---
tags: [rtk, installation, setup]
---

# RTK Installation

## Quick Install

Run the project installer — it auto-detects your OS:

```sh
./scripts/install-rtk.sh
```

Or install manually:

### macOS (recommended)

```sh
brew install rtk
```

### Linux / macOS (curl)

```sh
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc   # or ~/.bashrc
```

### Cargo (any OS with Rust)

```sh
cargo install --git https://github.com/rtk-ai/rtk
```

### Windows

```sh
winget install rtk-ai.rtk
```

## Verify Installation

```sh
rtk --version    # Should print: rtk 0.35.0 (or later)
rtk gain         # Should show token savings stats
```

## Initialize for Your AI Tool

Run **once** after installing:

```sh
rtk init -g                  # Claude Code (default)
rtk init -g --copilot        # GitHub Copilot (VS Code)
rtk init -g --gemini         # Gemini CLI
rtk init -g --codex          # OpenAI Codex
rtk init -g --agent cursor   # Cursor
```

Or auto-init all detected AI tools:

```sh
./scripts/install-rtk.sh --init-all
```

## What `rtk init` Does per AI Tool

| AI Tool | Effect |
|---|---|
| Claude Code | PreToolUse hook in `~/.claude/settings.json` + global `RTK.md` |
| Copilot (VS Code) | `.github/hooks/rtk-rewrite.json` + patches `copilot-instructions.md` |
| Gemini CLI | `~/.gemini/hooks/rtk-hook-gemini.sh` + patches `~/.gemini/settings.json` |
| Codex | `~/.codex/RTK.md` + `~/.codex/AGENTS.md` with `@RTK.md` |
| Cursor | `~/.cursor/hooks/rtk-rewrite.sh` + patches `~/.cursor/hooks.json` |

## Troubleshooting

- https://github.com/rtk-ai/rtk/blob/master/docs/TROUBLESHOOTING.md
- If `rtk gain` fails, you may have the wrong `rtk` package. Use `cargo install --git` above.
