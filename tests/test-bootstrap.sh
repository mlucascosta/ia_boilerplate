#!/usr/bin/env bash

# Integration tests for scripts/bootstrap-template.sh
# Tests are written against the actual script behavior, not assumptions.
#
# What the bootstrap does (verified from source):
#   1. Replaces TEMPLATE_ROOT paths with REPO_ROOT across all files
#   2. Renames the Codex workflow skill directory and references
#   3. Replaces old project name in README.md, AGENTS.md, .planning/PROJECT.md
#   4. Replaces old copyright holder in LICENSE
#   5. Derives project name from --project-name flag or folder basename

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
  # Copy the repo without .git to keep the clone lightweight
  rsync -a --exclude='.git' "$SOURCE_ROOT/" "$WORK_DIR/"
  # Initialise a throwaway git repo so the script's grep/rg ignore rules work
  git -C "$WORK_DIR" init -q
}

teardown() {
  if [[ -n "$WORK_DIR" && -d "$WORK_DIR" ]]; then
    rm -rf "$WORK_DIR"
  fi
}

# Always clean up, even on failure
trap teardown EXIT

echo ""
echo "IA Boilerplate — Bootstrap Integration Tests"
echo "============================================="
echo ""

# ------------------------------------------------------------------
# TEST 1: Bootstrap exits 0 with --project-name
# ------------------------------------------------------------------
echo "1. Basic execution"
setup
if bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "Test App" > /dev/null 2>&1; then
  pass "Exits 0 with --project-name"
else
  fail "Non-zero exit with --project-name"
fi
teardown

# ------------------------------------------------------------------
# TEST 2: Bootstrap exits 0 without --project-name (derives from folder)
# ------------------------------------------------------------------
echo ""
echo "2. Derived project name"
setup
if bash "$WORK_DIR/scripts/bootstrap-template.sh" > /dev/null 2>&1; then
  pass "Exits 0 without --project-name (folder-derived)"
else
  fail "Non-zero exit without --project-name"
fi
teardown

# ------------------------------------------------------------------
# TEST 3: README project name replaced
# ------------------------------------------------------------------
echo ""
echo "3. README.md replacement"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "My Cool Project" > /dev/null 2>&1
if grep -q "My Cool Project" "$WORK_DIR/README.md"; then
  pass "README.md contains new project name"
else
  fail "README.md still has old name"
fi
teardown

# ------------------------------------------------------------------
# TEST 4: Bootstrap output includes project name
# ------------------------------------------------------------------
echo ""
echo "4. Bootstrap output"
setup
out="$(bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "My Cool Project" 2>&1)"
if echo "$out" | grep -q "My Cool Project"; then
  pass "Output includes project name"
else
  fail "Output missing project name"
fi
teardown

# ------------------------------------------------------------------
# TEST 5: LICENSE copyright holder updated
# ------------------------------------------------------------------
echo ""
echo "5. LICENSE copyright"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "My Cool Project" > /dev/null 2>&1
if grep -q "My Cool Project contributors" "$WORK_DIR/LICENSE"; then
  pass "LICENSE has new copyright holder"
else
  fail "LICENSE still has old copyright holder"
fi
teardown

# ------------------------------------------------------------------
# TEST 6: Custom --copyright-holder
# ------------------------------------------------------------------
echo ""
echo "6. Custom copyright holder"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "Acme" --copyright-holder "Acme Corp" > /dev/null 2>&1
if grep -q "Acme Corp" "$WORK_DIR/LICENSE"; then
  pass "LICENSE has custom copyright holder"
else
  fail "LICENSE missing custom copyright holder"
fi
teardown

# ------------------------------------------------------------------
# TEST 7: .planning/PROJECT.md project name replaced
# ------------------------------------------------------------------
echo ""
echo "7. PROJECT.md replacement"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "My Cool Project" > /dev/null 2>&1
if [[ -f "$WORK_DIR/.planning/PROJECT.md" ]] && grep -q "My Cool Project" "$WORK_DIR/.planning/PROJECT.md"; then
  pass "PROJECT.md contains new project name"
else
  fail "PROJECT.md missing or still has old name"
fi
teardown

# ------------------------------------------------------------------
# TEST 8: Codex workflow skill renamed
# ------------------------------------------------------------------
echo ""
echo "8. Codex skill rename"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "My Cool Project" > /dev/null 2>&1
if [[ -d "$WORK_DIR/.codex/skills/my-cool-project-workflow" ]]; then
  pass "Codex skill directory renamed to my-cool-project-workflow"
else
  fail "Codex skill directory not renamed"
fi
teardown

# ------------------------------------------------------------------
# TEST 9: Canonical workflow files preserved
# ------------------------------------------------------------------
echo ""
echo "9. Canonical files preserved"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "Test" > /dev/null 2>&1
ok=true
for f in docs/ai/WORKFLOW.md docs/ai/ARTIFACTS.md AGENTS.md CLAUDE.md scripts/validate-workflow.sh; do
  if [[ ! -f "$WORK_DIR/$f" ]]; then
    fail "$f missing after bootstrap"
    ok=false
  fi
done
if $ok; then
  pass "All canonical files preserved"
fi
teardown

# ------------------------------------------------------------------
# TEST 10: validate-workflow.sh still passes after bootstrap
# ------------------------------------------------------------------
echo ""
echo "10. Post-bootstrap validation"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "Test" > /dev/null 2>&1
if bash "$WORK_DIR/scripts/validate-workflow.sh" > /dev/null 2>&1; then
  pass "validate-workflow.sh passes after bootstrap"
else
  fail "validate-workflow.sh fails after bootstrap"
fi
teardown

# ------------------------------------------------------------------
# TEST 11: Idempotent — running twice does not break
# ------------------------------------------------------------------
echo ""
echo "11. Idempotency"
setup
bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "Twice" > /dev/null 2>&1
if bash "$WORK_DIR/scripts/bootstrap-template.sh" --project-name "Twice" > /dev/null 2>&1; then
  pass "Second run exits 0"
else
  fail "Second run fails — not idempotent"
fi
teardown

# ------------------------------------------------------------------
# TEST 12: --help exits 0
# ------------------------------------------------------------------
echo ""
echo "12. Help flag"
if bash "$SOURCE_ROOT/scripts/bootstrap-template.sh" --help > /dev/null 2>&1; then
  pass "--help exits 0"
else
  fail "--help exits non-zero"
fi

# ------------------------------------------------------------------
# TEST 13: Unknown flag exits non-zero
# ------------------------------------------------------------------
echo ""
echo "13. Unknown flag"
setup
if bash "$WORK_DIR/scripts/bootstrap-template.sh" --bogus 2>/dev/null; then
  fail "Unknown flag should exit non-zero"
else
  pass "Unknown flag exits non-zero"
fi
teardown

# ------------------------------------------------------------------
# RESULTS
# ------------------------------------------------------------------
echo ""
echo "============================================="
echo "Result: $PASSED passed, $FAILED failed"
echo "============================================="

if [[ "$FAILED" -eq 0 ]]; then
  echo -e "${GREEN}All bootstrap tests passed.${NC}"
  exit 0
else
  echo -e "${RED}${FAILED} test(s) failed.${NC}"
  exit 1
fi
