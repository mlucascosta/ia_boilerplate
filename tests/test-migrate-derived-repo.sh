#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR=""
PASSED=0
FAILED=0

pass() { echo -e "  ${GREEN}[PASS]${NC} $1"; PASSED=$((PASSED + 1)); }
fail() { echo -e "  ${RED}[FAIL]${NC} $1"; FAILED=$((FAILED + 1)); }

setup_target() {
  TARGET_DIR="$(mktemp -d)"
  rsync -a --exclude='.git' "$SOURCE_ROOT/" "$TARGET_DIR/"
  bash "$TARGET_DIR/scripts/bootstrap-template.sh" --project-name "Acme App" > /dev/null 2>&1
}

teardown_target() {
  if [[ -n "$TARGET_DIR" && -d "$TARGET_DIR" ]]; then
    rm -rf "$TARGET_DIR"
  fi
}

trap teardown_target EXIT

echo ""
echo "IA Boilerplate — Derived Repo Migration Tests"
echo "============================================="

echo ""
echo "1. Dry run does not change target"
setup_target
rm "$TARGET_DIR/.planning/00-TEMPLATE-RISK_REGISTER.md"
if bash "$SOURCE_ROOT/scripts/migrate-derived-repo.sh" --target "$TARGET_DIR" --dry-run > /dev/null 2>&1 && [[ ! -f "$TARGET_DIR/.planning/00-TEMPLATE-RISK_REGISTER.md" ]]; then
  pass "Dry run leaves target unchanged"
else
  fail "Dry run should not create files"
fi
teardown_target

echo ""
echo "2. Migration restores workflow files"
setup_target
rm "$TARGET_DIR/.planning/00-TEMPLATE-RISK_REGISTER.md"
rm "$TARGET_DIR/.agents/manifest.json"
printf 'broken\n' > "$TARGET_DIR/CLAUDE.md"
printf '# Custom README\n' > "$TARGET_DIR/README.md"
if bash "$SOURCE_ROOT/scripts/migrate-derived-repo.sh" --target "$TARGET_DIR" > /dev/null 2>&1 \
  && [[ -f "$TARGET_DIR/.planning/00-TEMPLATE-RISK_REGISTER.md" ]] \
  && [[ -f "$TARGET_DIR/.agents/manifest.json" ]] \
  && grep -q '## Source of truth' "$TARGET_DIR/CLAUDE.md" \
  && grep -q '# Custom README' "$TARGET_DIR/README.md"; then
  pass "Migration restores workflow infrastructure without overwriting project README"
else
  fail "Migration did not restore expected files"
fi
teardown_target

echo ""
echo "3. Migration preserves target Codex skill name"
setup_target
rm -rf "$TARGET_DIR/.codex/skills/acme-app-workflow"
if bash "$SOURCE_ROOT/scripts/migrate-derived-repo.sh" --target "$TARGET_DIR" > /dev/null 2>&1 \
  && [[ -f "$TARGET_DIR/.codex/skills/acme-app-workflow/SKILL.md" ]] \
  && grep -q 'acme-app-workflow' "$TARGET_DIR/AGENTS.md" \
  && grep -q 'acme-app-workflow' "$TARGET_DIR/scripts/validate-workflow.sh" \
  && grep -q 'name: acme-app-workflow' "$TARGET_DIR/.codex/skills/acme-app-workflow/SKILL.md"; then
  pass "Migration keeps the target Codex workflow skill name"
else
  fail "Migration did not preserve target Codex skill naming"
fi
teardown_target

echo ""
echo "4. Optional CI sync works"
setup_target
rm "$TARGET_DIR/.github/workflows/validate.yml"
if bash "$SOURCE_ROOT/scripts/migrate-derived-repo.sh" --target "$TARGET_DIR" > /dev/null 2>&1 && [[ ! -f "$TARGET_DIR/.github/workflows/validate.yml" ]]; then
  pass "CI workflow stays untouched without --include-ci"
else
  fail "Migration should not sync CI workflow by default"
fi
if bash "$SOURCE_ROOT/scripts/migrate-derived-repo.sh" --target "$TARGET_DIR" --include-ci > /dev/null 2>&1 && [[ -f "$TARGET_DIR/.github/workflows/validate.yml" ]]; then
  pass "CI workflow syncs with --include-ci"
else
  fail "Migration should sync CI workflow when requested"
fi
teardown_target

echo ""
echo "============================================="
echo "Result: $PASSED passed, $FAILED failed"
echo "============================================="

if [[ "$FAILED" -eq 0 ]]; then
  echo -e "${GREEN}All derived repo migration tests passed.${NC}"
  exit 0
else
  echo -e "${RED}${FAILED} test(s) failed.${NC}"
  exit 1
fi
