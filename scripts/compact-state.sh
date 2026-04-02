#!/usr/bin/env bash
# compact-state.sh — Validate and warn if STATE.md exceeds the 120-word budget.
# Usage: scripts/compact-state.sh [path-to-state]

set -euo pipefail

STATE_FILE="${1:-.planning/STATE.md}"
MAX_WORDS=120

if [[ ! -f "$STATE_FILE" ]]; then
  echo "STATE file not found: $STATE_FILE"
  exit 0
fi

word_count=$(wc -w < "$STATE_FILE" | tr -d ' ')

if (( word_count > MAX_WORDS )); then
  echo "WARNING: $STATE_FILE has $word_count words (budget: $MAX_WORDS)."
  echo "Action required: compress or rotate content to .planning/summaries/."
  exit 1
else
  echo "OK: $STATE_FILE has $word_count words (budget: $MAX_WORDS)."
fi
