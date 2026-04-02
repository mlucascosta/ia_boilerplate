#!/usr/bin/env bash
# new-plan.sh — Scaffold a new atomic plan from the canonical template.
# Usage: scripts/new-plan.sh <number> <slug>
# Example: scripts/new-plan.sh 03 add-auth

set -euo pipefail

NUM="${1:?Usage: new-plan.sh <number> <slug>}"
SLUG="${2:?Usage: new-plan.sh <number> <slug>}"
PLANS_DIR=".planning/plans"
FILE="$PLANS_DIR/${NUM}-${SLUG}-PLAN.md"

mkdir -p "$PLANS_DIR"

if [[ -f "$FILE" ]]; then
  echo "Plan already exists: $FILE"
  exit 1
fi

cat > "$FILE" <<'EOF'
# Plan: <name>
SCOPE=trivial|focused|full
DOC=full|min
ARCH=solid|none
VERIFY=V0|V1|V2
FILES=
OUT=

## Objective

## Expected Changes

## Constraints

## Verification

## Done Criteria
EOF

echo "Created: $FILE"
