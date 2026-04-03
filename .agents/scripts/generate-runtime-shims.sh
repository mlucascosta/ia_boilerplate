#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

check_only=false

if [[ "${1:-}" == "--check" ]]; then
  check_only=true
fi

ensure_link() {
  local target="$1"
  local link_path="$2"

  if [[ "$check_only" == true ]]; then
    [[ -L "$link_path" ]] || { echo "Missing symlink: ${link_path#$REPO_ROOT/}"; return 1; }
    [[ "$(readlink "$link_path")" == "$target" ]] || {
      echo "Unexpected symlink target for ${link_path#$REPO_ROOT/}: $(readlink "$link_path")"
      return 1
    }
    return 0
  fi

  mkdir -p "$(dirname "$link_path")"
  ln -sfn "$target" "$link_path"
}

ensure_link "../.agents/agents" "$REPO_ROOT/.claude/agents"
ensure_link "../.agents/runtimes/claude/commands" "$REPO_ROOT/.claude/commands"
ensure_link "../.agents/runtimes/claude/gsd-file-manifest.json" "$REPO_ROOT/.claude/gsd-file-manifest.json"
ensure_link "../.agents/runtimes/claude/hooks" "$REPO_ROOT/.claude/hooks"
ensure_link "../.agents/runtimes/claude/package.json" "$REPO_ROOT/.claude/package.json"
ensure_link "../.agents/runtimes/claude/settings.json" "$REPO_ROOT/.claude/settings.json"
ensure_link "../.agents/runtimes/claude/settings.local.json" "$REPO_ROOT/.claude/settings.local.json"

ensure_link "../.agents/runtimes/codex/agents" "$REPO_ROOT/.codex/agents"
ensure_link "../.agents/runtimes/codex/gsd-file-manifest.json" "$REPO_ROOT/.codex/gsd-file-manifest.json"
ensure_link "../.agents/runtimes/codex/skills" "$REPO_ROOT/.codex/skills"

ensure_link "../.agents/agents" "$REPO_ROOT/.github/agents"
ensure_link "../.agents/runtimes/github/copilot-instructions.md" "$REPO_ROOT/.github/copilot-instructions.md"
ensure_link "../.agents/runtimes/github/gsd-file-manifest.json" "$REPO_ROOT/.github/gsd-file-manifest.json"
ensure_link "../.agents/runtimes/github/skills" "$REPO_ROOT/.github/skills"

if [[ "$check_only" == false ]]; then
  echo "Runtime shims synced."
fi
