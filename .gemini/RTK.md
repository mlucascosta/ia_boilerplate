# Gemini CLI — RTK Integration

RTK is mandatory for all shell commands in this project.
All commands must be prefixed with `rtk` to reduce token consumption by 60-90%.

## Setup (run once)

```sh
./scripts/install-rtk.sh    # Install RTK for your OS
rtk init -g --gemini         # Install the BeforeTool hook globally
```

This creates `~/.gemini/hooks/rtk-hook-gemini.sh` and patches `~/.gemini/settings.json`
to intercept every shell command and rewrite it to the `rtk` equivalent.

## Verification

```sh
rtk --version    # Should print rtk 0.35.0 or later
rtk gain         # Should show token savings stats
```

## Hard Rules

- Never run raw `git`, `cat`, `ls`, `grep`, `rg`, `find`, or any command with an `rtk` equivalent
- Read the full command rewrite table in `RTK.md` at the repository root
