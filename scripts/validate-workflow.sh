#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

errors=0
warnings=0

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; errors=$((errors + 1)); }
warn() { echo "  [WARN] $1"; warnings=$((warnings + 1)); }

word_count() {
  awk '{for (token_index = 1; token_index <= NF; token_index++) total++} END {print total + 0}' "$1"
}

nonempty_bullets() {
  grep -Ec '^[-*] ' "$1" || true
}

check_word_budget() {
  local file_path="$1"
  local limit="$2"
  local label="$3"
  local count

  count="$(word_count "$file_path")"
  if [[ "$count" -le "$limit" ]]; then
    pass "$label within $limit words ($count)"
  else
    fail "$label exceeds $limit words ($count)"
  fi
}

check_bullet_budget() {
  local file_path="$1"
  local limit="$2"
  local label="$3"
  local count

  count="$(nonempty_bullets "$file_path")"
  if [[ "$count" -le "$limit" ]]; then
    pass "$label within $limit bullets ($count)"
  else
    fail "$label exceeds $limit bullets ($count)"
  fi
}

check_adapter_contract() {
  local file_path="$1"
  local label="$2"
  local section
  local required_sections=(
    "## Source of truth"
    "## First read"
    "## Max read budget"
    "## Path selection"
    "## Output contract"
    "## Verification contract"
    "## Artifact update rules"
    "## Hard prohibitions"
  )

  grep -Fq 'Follow `AGENTS.md`.' "$file_path" && pass "$label follows AGENTS.md" || fail "$label must follow AGENTS.md"
  grep -Fq 'WORKFLOW_SHORT.md' "$file_path" && pass "$label references WORKFLOW_SHORT.md first" || fail "$label missing WORKFLOW_SHORT.md first read"
  grep -Fq 'only if ambiguous' "$file_path" && pass "$label limits full workflow reads" || fail "$label must restrict WORKFLOW.md to ambiguous cases"
  grep -Fq 'Do not scan the whole repository.' "$file_path" && pass "$label forbids full repository scans" || fail "$label must forbid full repository scans"
  grep -Fq 'No workflow recap.' "$file_path" && pass "$label forbids workflow recaps" || fail "$label must forbid workflow recaps"
  grep -Fq 'No file dumps.' "$file_path" && pass "$label forbids file dumps" || fail "$label must forbid file dumps"

  for section in "${required_sections[@]}"; do
    grep -Fq "$section" "$file_path" && pass "$label includes $section" || fail "$label missing $section"
  done
}

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
[[ -f "$REPO_ROOT/.planning/VISION.md" ]] && pass ".planning/VISION.md exists" || fail ".planning/VISION.md missing — required governance artifact"
[[ -f "$REPO_ROOT/.planning/PROJECT.md" ]] && pass ".planning/PROJECT.md exists" || fail ".planning/PROJECT.md missing — required governance artifact"
[[ -f "$REPO_ROOT/.planning/RISK_REGISTER.md" ]] && pass ".planning/RISK_REGISTER.md exists" || fail ".planning/RISK_REGISTER.md missing — required governance artifact"
[[ -d "$REPO_ROOT/.planning/plans" ]]      && pass ".planning/plans/ exists"     || warn ".planning/plans/ missing — required for non-trivial tasks"
[[ -d "$REPO_ROOT/.planning/summaries" ]]  && pass ".planning/summaries/ exists" || warn ".planning/summaries/ missing — required for session handoffs"
[[ -d "$REPO_ROOT/.planning/verification" ]] && pass ".planning/verification/ exists" || warn ".planning/verification/ missing — required for verification artifacts"

echo ""
echo "3. Starter templates"
[[ -f "$REPO_ROOT/.planning/00-TEMPLATE-STATE.md" ]] && pass "STATE template exists" || fail "Missing .planning/00-TEMPLATE-STATE.md"
[[ -f "$REPO_ROOT/.planning/00-TEMPLATE-ROADMAP.md" ]] && pass "ROADMAP template exists" || fail "Missing .planning/00-TEMPLATE-ROADMAP.md"
[[ -f "$REPO_ROOT/.planning/00-TEMPLATE-VISION.md" ]] && pass "VISION template exists" || fail "Missing .planning/00-TEMPLATE-VISION.md"
[[ -f "$REPO_ROOT/.planning/00-TEMPLATE-PROJECT.md" ]] && pass "PROJECT template exists" || fail "Missing .planning/00-TEMPLATE-PROJECT.md"
[[ -f "$REPO_ROOT/.planning/00-TEMPLATE-RISK_REGISTER.md" ]] && pass "Risk register template exists" || fail "Missing .planning/00-TEMPLATE-RISK_REGISTER.md"
[[ -f "$REPO_ROOT/.planning/epics/00-TEMPLATE-EPIC.md" ]] && pass "Epic template exists" || fail "Missing .planning/epics/00-TEMPLATE-EPIC.md"
[[ -f "$REPO_ROOT/.planning/adrs/00-TEMPLATE-ADR.md" ]] && pass "ADR template exists" || fail "Missing .planning/adrs/00-TEMPLATE-ADR.md"
[[ -f "$REPO_ROOT/.planning/plans/00-TEMPLATE-PLAN.md" ]] && pass "Plan template exists" || fail "Missing .planning/plans/00-TEMPLATE-PLAN.md"
[[ -f "$REPO_ROOT/.planning/summaries/00-TEMPLATE-SUMMARY.md" ]] && pass "Summary template exists" || fail "Missing .planning/summaries/00-TEMPLATE-SUMMARY.md"
[[ -f "$REPO_ROOT/.planning/verification/00-TEMPLATE-VERIFICATION.md" ]] && pass "Verification template exists" || fail "Missing .planning/verification/00-TEMPLATE-VERIFICATION.md"

echo ""
echo "4. Runtime adapters"
[[ -f "$REPO_ROOT/.github/copilot-instructions.md" ]] && pass "Copilot adapter exists" || warn "Copilot adapter missing"
[[ -f "$REPO_ROOT/CLAUDE.md" ]]  && pass "Claude adapter exists"  || warn "Claude adapter missing"
[[ -d "$REPO_ROOT/.codex" ]]     && pass "Codex adapter exists"   || warn "Codex adapter missing"
[[ -f "$REPO_ROOT/.github/pull_request_template.md" ]] && pass "PR template exists" || fail "PR template missing — add governance signals for pull requests"

echo ""
echo "5. Runtime adapter contract"
if [[ -f "$REPO_ROOT/CLAUDE.md" ]]; then
  check_adapter_contract "$REPO_ROOT/CLAUDE.md" "Claude adapter"
fi

if [[ -f "$REPO_ROOT/.github/copilot-instructions.md" ]]; then
  check_adapter_contract "$REPO_ROOT/.github/copilot-instructions.md" "Copilot adapter"
  grep -Fq 'explicitly asks' "$REPO_ROOT/.github/copilot-instructions.md" && pass "Copilot adapter gates GSD usage" || fail "Copilot adapter must gate GSD usage behind explicit user request"
  if grep -Fq 'prompt via `ask_user`' "$REPO_ROOT/.github/copilot-instructions.md" || grep -Fq 'repeat this feedback loop' "$REPO_ROOT/.github/copilot-instructions.md"; then
    fail "Copilot adapter must not require ask_user loops"
  else
    pass "Copilot adapter avoids ask_user loops"
  fi
fi

if [[ -f "$REPO_ROOT/.codex/skills/reduto-workflow/SKILL.md" ]]; then
  check_adapter_contract "$REPO_ROOT/.codex/skills/reduto-workflow/SKILL.md" "Codex adapter"
  grep -Fq 'Codex-only workflow' "$REPO_ROOT/.codex/skills/reduto-workflow/SKILL.md" && pass "Codex adapter forbids Codex-only workflow invention" || fail "Codex adapter must forbid Codex-only workflow invention"
fi

echo ""
echo "6. Pull request governance signals"
if [[ -f "$REPO_ROOT/.github/pull_request_template.md" ]]; then
  grep -q "## Workflow Path" "$REPO_ROOT/.github/pull_request_template.md" && pass "PR template defines Workflow Path" || fail "PR template missing Workflow Path section"
  grep -q "## Verification Level" "$REPO_ROOT/.github/pull_request_template.md" && pass "PR template defines Verification Level" || fail "PR template missing Verification Level section"
  grep -q "## Governance Impact" "$REPO_ROOT/.github/pull_request_template.md" && pass "PR template defines Governance Impact" || fail "PR template missing Governance Impact section"
  grep -q "## Documentation Impact" "$REPO_ROOT/.github/pull_request_template.md" && pass "PR template defines Documentation Impact" || fail "PR template missing Documentation Impact section"
fi

echo ""
echo "7. STATE.md content"
if [[ -f "$REPO_ROOT/.planning/STATE.md" ]]; then
  grep -q "## Objective" "$REPO_ROOT/.planning/STATE.md"  && pass "STATE.md has Objective"  || fail "STATE.md missing ## Objective section"
  grep -q "## Next Step" "$REPO_ROOT/.planning/STATE.md"  && pass "STATE.md has Next Step"  || fail "STATE.md missing ## Next Step section"
  grep -q "## Blockers"  "$REPO_ROOT/.planning/STATE.md"  && pass "STATE.md has Blockers"   || warn "STATE.md missing ## Blockers section"
fi

echo ""
echo "8. Artifact budgets"
if [[ -f "$REPO_ROOT/.planning/STATE.md" ]]; then
  check_word_budget "$REPO_ROOT/.planning/STATE.md" 120 "STATE.md"
fi

if [[ -d "$REPO_ROOT/.planning/plans" ]]; then
  while IFS= read -r plan_file; do
    check_word_budget "$plan_file" 180 "${plan_file#$REPO_ROOT/}"
  done < <(find "$REPO_ROOT/.planning/plans" -maxdepth 1 -type f -name '*PLAN.md' ! -name '00-*' | sort)
fi

if [[ -d "$REPO_ROOT/.planning/summaries" ]]; then
  while IFS= read -r summary_file; do
    check_word_budget "$summary_file" 120 "${summary_file#$REPO_ROOT/}"
  done < <(find "$REPO_ROOT/.planning/summaries" -maxdepth 1 -type f -name '*.md' ! -name '00-*' | sort)
fi

if [[ -d "$REPO_ROOT/.planning/verification" ]]; then
  while IFS= read -r verification_file; do
    check_bullet_budget "$verification_file" 8 "${verification_file#$REPO_ROOT/}"
  done < <(find "$REPO_ROOT/.planning/verification" -maxdepth 1 -type f -name '*.md' ! -name '00-*' | sort)
fi

if [[ -f "$REPO_ROOT/.planning/ROADMAP.md" ]]; then
  warn "ROADMAP.md budget is not machine-enforced yet — milestone tables are allowed, but keep the roadmap compact"
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
