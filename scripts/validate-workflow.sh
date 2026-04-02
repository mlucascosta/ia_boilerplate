#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

errors=0
warnings=0

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; errors=$((errors + 1)); }
warn() { echo "  [WARN] $1"; warnings=$((warnings + 1)); }

echo ""
echo "IA Boilerplate — Workflow Conformance Check"
echo "============================================"

echo ""
echo "1. Canonical docs"
[[ -f "$REPO_ROOT/docs/ai/WORKFLOW.md" ]]  && pass "docs/ai/WORKFLOW.md exists"  || fail "docs/ai/WORKFLOW.md missing"
[[ -f "$REPO_ROOT/docs/ai/ARTIFACTS.md" ]] && pass "docs/ai/ARTIFACTS.md exists" || fail "docs/ai/ARTIFACTS.md missing"
[[ -f "$REPO_ROOT/AGENTS.md" ]]            && pass "AGENTS.md exists"            || fail "AGENTS.md missing"

echo ""
echo "2. Planning artifacts"
[[ -f "$REPO_ROOT/.planning/STATE.md" ]]   && pass ".planning/STATE.md exists"   || fail ".planning/STATE.md missing — create before starting work"
[[ -f "$REPO_ROOT/.planning/ROADMAP.md" ]] && pass ".planning/ROADMAP.md exists" || warn ".planning/ROADMAP.md missing — required for phased work"
[[ -d "$REPO_ROOT/.planning/plans" ]]      && pass ".planning/plans/ exists"     || warn ".planning/plans/ missing — required for non-trivial tasks"
[[ -d "$REPO_ROOT/.planning/summaries" ]]  && pass ".planning/summaries/ exists" || warn ".planning/summaries/ missing — required for session handoffs"
[[ -d "$REPO_ROOT/.planning/verification" ]] && pass ".planning/verification/ exists" || warn ".planning/verification/ missing — required for verification artifacts"

echo ""
echo "3. Runtime adapters"
[[ -f "$REPO_ROOT/.github/copilot-instructions.md" ]] && pass "Copilot adapter exists" || warn "Copilot adapter missing"
[[ -f "$REPO_ROOT/CLAUDE.md" ]]  && pass "Claude adapter exists"  || warn "Claude adapter missing"
[[ -d "$REPO_ROOT/.codex" ]]     && pass "Codex adapter exists"   || warn "Codex adapter missing"

echo ""
echo "4. STATE.md content"
if [[ -f "$REPO_ROOT/.planning/STATE.md" ]]; then
  grep -q "## Objective" "$REPO_ROOT/.planning/STATE.md"  && pass "STATE.md has Objective"  || fail "STATE.md missing ## Objective section"
  grep -q "## Next Step" "$REPO_ROOT/.planning/STATE.md"  && pass "STATE.md has Next Step"  || fail "STATE.md missing ## Next Step section"
  grep -q "## Blockers"  "$REPO_ROOT/.planning/STATE.md"  && pass "STATE.md has Blockers"   || warn "STATE.md missing ## Blockers section"
fi

echo ""
echo "============================================"
if [[ $errors -eq 0 && $warnings -eq 0 ]]; then
  echo "Result: PASS — no issues found."
elif [[ $errors -eq 0 ]]; then
  echo "Result: PASS with warnings — $warnings warning(s), 0 error(s)."
else
  echo "Result: FAIL — $errors error(s), $warnings warning(s)."
fi
echo ""

exit $errors
