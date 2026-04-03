#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
WORK_DIR=""
PASSED=0
FAILED=0

pass() { echo -e "  ${GREEN}[PASS]${NC} $1"; PASSED=$((PASSED + 1)); }
fail() { echo -e "  ${RED}[FAIL]${NC} $1"; FAILED=$((FAILED + 1)); }

setup() {
  WORK_DIR="$(mktemp -d)"
  rsync -a --exclude='.git' "$SOURCE_ROOT/" "$WORK_DIR/"
}

teardown() {
  if [[ -n "$WORK_DIR" && -d "$WORK_DIR" ]]; then
    rm -rf "$WORK_DIR"
  fi
}

trap teardown EXIT

echo ""
echo "IA Boilerplate — Validation Script Tests"
echo "========================================"

echo ""
echo "1. Baseline"
if bash "$SOURCE_ROOT/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  pass "Baseline repository passes validation"
else
  fail "Baseline repository should pass validation"
fi

echo ""
echo "2. Missing PR template fails"
setup
rm "$WORK_DIR/.github/pull_request_template.md"
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Missing PR template should fail validation"
else
  pass "Missing PR template fails validation"
fi
teardown

echo ""
echo "3. Missing PR section fails"
setup
tmp_file="$WORK_DIR/.github/pull_request_template.md.tmp"
grep -v '^## Security Impact$' "$WORK_DIR/.github/pull_request_template.md" > "$tmp_file"
mv "$tmp_file" "$WORK_DIR/.github/pull_request_template.md"
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Missing PR section should fail validation"
else
  pass "Missing PR section fails validation"
fi
teardown

echo ""
echo "4. Missing starter template fails"
setup
rm "$WORK_DIR/.planning/00-TEMPLATE-ROADMAP.md"
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Missing starter template should fail validation"
else
  pass "Missing starter template fails validation"
fi
teardown

echo ""
echo "5. STATE word budget enforced"
setup
cat <<'EOF' > "$WORK_DIR/.planning/STATE.md"
# State

## Objective

word word word word word word word word word word word word word word word word word word word word
word word word word word word word word word word word word word word word word word word word word
word word word word word word word word word word word word word word word word word word word word
word word word word word word word word word word word word word word word word word word word word
word word word word word word word word word word word word word word word word word word word word
word word word word word word word word word word word word word word word word word word word word
word word word word word word word word word word word word word word word word word word word word

## Active Work

Budget test.

## Locked Decisions

1. Keep format valid.

## Open Questions

None.

## Blockers

None.

## Next Step

Shrink the state file.
EOF
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Oversized STATE.md should fail validation"
else
  pass "Oversized STATE.md fails validation"
fi
teardown

echo ""
echo "6. Verification bullet budget enforced"
setup
cat <<'EOF' > "$WORK_DIR/.planning/verification/01-budget-check.md"
# Verification

- one
- two
- three
- four
- five
- six
- seven
- eight
- nine
EOF
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Verification with 9 bullets should fail validation"
else
  pass "Verification bullet budget fails validation"
fi
teardown

echo ""
echo "7. Adapter section contract enforced"
setup
tmp_file="$WORK_DIR/CLAUDE.md.tmp"
grep -v '^## Source of truth$' "$WORK_DIR/CLAUDE.md" > "$tmp_file"
mv "$tmp_file" "$WORK_DIR/CLAUDE.md"
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Missing adapter section should fail validation"
else
  pass "Missing adapter section fails validation"
fi
teardown

echo ""
echo "8. Copilot ask_user loop rejected"
setup
cat <<'EOF' >> "$WORK_DIR/.github/copilot-instructions.md"

- After every deliverable, prompt via `ask_user` and repeat this feedback loop.
EOF
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  fail "Copilot ask_user loop should fail validation"
else
  pass "Copilot ask_user loop fails validation"
fi
teardown

echo ""
echo "========================================"
echo "Result: $PASSED passed, $FAILED failed"
echo "========================================"

if [[ "$FAILED" -eq 0 ]]; then
  echo -e "${GREEN}All validation tests passed.${NC}"
  exit 0
else
  echo -e "${RED}${FAILED} test(s) failed.${NC}"
  exit 1
fi