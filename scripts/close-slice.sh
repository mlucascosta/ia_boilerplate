#!/usr/bin/env bash
# close-slice.sh — Close the current work slice: generate summary stub, compress STATE, prepare next.
# Usage: scripts/close-slice.sh <slice-name>
# Example: scripts/close-slice.sh 03-add-auth

set -euo pipefail

SLICE="${1:?Usage: close-slice.sh <slice-name>}"
STATE_FILE=".planning/STATE.md"
SUMMARIES_DIR=".planning/summaries"
SUMMARY_FILE="$SUMMARIES_DIR/${SLICE}-SUMMARY.md"

mkdir -p "$SUMMARIES_DIR"

# Create summary stub if it doesn't exist
if [[ ! -f "$SUMMARY_FILE" ]]; then
  cat > "$SUMMARY_FILE" <<EOF
# Summary: $SLICE

## What Changed

## Validation

## Risks Or Follow-ups
EOF
  echo "Created summary stub: $SUMMARY_FILE"
  echo "  → Fill it in (max 120 words)."
else
  echo "Summary already exists: $SUMMARY_FILE"
fi

# Check STATE budget
if [[ -f "$STATE_FILE" ]]; then
  word_count=$(wc -w < "$STATE_FILE" | tr -d ' ')
  if (( word_count > 120 )); then
    echo ""
    echo "WARNING: $STATE_FILE has $word_count words (budget: 120)."
    echo "  → Compress it before starting the next slice."
  else
    echo "STATE.md is within budget ($word_count/120 words)."
  fi
fi

echo ""
echo "Next steps:"
echo "  1. Fill $SUMMARY_FILE (≤120 words)"
echo "  2. Update $STATE_FILE with next objective (≤120 words)"
echo "  3. Start the next plan"
