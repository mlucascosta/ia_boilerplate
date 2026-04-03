#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

errors=0

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; errors=$((errors + 1)); }

check_file() {
  local path="$1"
  [[ -f "$REPO_ROOT/$path" ]] && pass "$path exists" || fail "$path missing"
}

echo ""
echo ".agents Conformance Check"
echo "========================="

check_file ".agents/AGENTS.md"
check_file ".agents/manifest.json"
check_file ".agents/adapters/claude.md"
check_file ".agents/adapters/codex.md"
check_file ".agents/adapters/copilot.md"
check_file ".agents/adapters/gsd.md"
check_file ".agents/skills/workflow-core/SKILL.md"
check_file ".agents/skills/discuss-phase/SKILL.md"
check_file ".agents/skills/plan-phase/SKILL.md"
check_file ".agents/skills/execute-phase/SKILL.md"
check_file ".agents/skills/verify-phase/SKILL.md"
check_file ".agents/skills/quick-task/SKILL.md"
check_file ".agents/skills/docs-update/SKILL.md"
check_file ".agents/skills/review/SKILL.md"
check_file ".agents/scripts/validate-agents.sh"
check_file ".agents/scripts/generate-runtime-shims.sh"
check_file ".agents/scripts/sync-runtime-adapters.sh"

grep -Fq '"sourceOfTruth": ".agents"' "$REPO_ROOT/.agents/manifest.json" \
  && pass "manifest sourceOfTruth is .agents" \
  || fail "manifest sourceOfTruth must be .agents"

grep -Fq 'primary source of truth' "$REPO_ROOT/.agents/AGENTS.md" \
  && pass ".agents/AGENTS.md declares canonical role" \
  || fail ".agents/AGENTS.md must declare canonical role"

if bash "$REPO_ROOT/.agents/scripts/generate-runtime-shims.sh" --check > /dev/null 2>&1; then
  pass "runtime shims match expected targets"
else
  fail "runtime shims are missing or drifted"
fi

if rg -n '/Users/.*/\.claude/get-shit-done|/home/.*/\.claude/get-shit-done' "$REPO_ROOT/.agents" | grep -v '/.agents/scripts/validate-agents.sh:' > /dev/null 2>&1; then
  fail "legacy absolute template paths remain under .agents/"
else
  pass "no legacy absolute template paths remain under .agents/"
fi

echo ""
if [[ "$errors" -eq 0 ]]; then
  echo "Result: PASS"
else
  echo "Result: FAIL — $errors error(s)"
fi

exit "$errors"
