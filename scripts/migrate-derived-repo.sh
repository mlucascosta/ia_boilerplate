#!/usr/bin/env bash
# REPO_COMPONENT: derived-repo-migration
# LAST_VALIDATED: 2026-04-09
# EXPECTED_SCOPE: ia_boilerplate core

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

target_root=""
dry_run=false
include_ci=false

usage() {
  cat <<'EOF'
Usage:
  ./scripts/migrate-derived-repo.sh --target /path/to/derived-repo [--dry-run] [--include-ci]

Options:
  --target      Target repository root to update.
  --dry-run     Show planned updates without copying files.
  --include-ci  Also sync .github/workflows/validate.yml.
  --help        Show this message.
EOF
}

current_codex_workflow_skill_name() {
  local repo_root="$1"
  local skill_name

  if [[ -f "$repo_root/AGENTS.md" ]]; then
    skill_name="$(sed -n 's|.*\.codex/skills/\([^/]*\)/SKILL\.md.*|\1|p' "$repo_root/AGENTS.md" | sed -n '1p')"
    if [[ -n "$skill_name" ]]; then
      printf '%s\n' "$skill_name"
      return 0
    fi
  fi

  if [[ -d "$repo_root/.codex/skills" ]]; then
    skill_name="$(find "$repo_root/.codex/skills" -maxdepth 1 -mindepth 1 -type d | xargs -n 1 basename 2>/dev/null | grep 'workflow' | head -1 || true)"
    if [[ -n "$skill_name" ]]; then
      printf '%s\n' "$skill_name"
      return 0
    fi
  fi

  printf '%s\n' "boilerplate-workflow"
}

copy_file() {
  local source_file="$1"
  local target_file="$2"

  if [[ "$dry_run" == true ]]; then
    echo "[DRY RUN] copy ${target_file#$target_root/}"
    return 0
  fi

  mkdir -p "$(dirname "$target_file")"
  cp "$source_file" "$target_file"
}

copy_tree() {
  local source_dir="$1"
  local target_dir="$2"

  if [[ "$dry_run" == true ]]; then
    echo "[DRY RUN] sync ${target_dir#$target_root/}/"
    return 0
  fi

  mkdir -p "$target_dir"
  rsync -a --delete "$source_dir/" "$target_dir/"
}

replace_literal_in_file() {
  local file="$1"
  local from="$2"
  local to="$3"

  if [[ ! -f "$file" || -z "$from" || "$from" == "$to" ]]; then
    return 0
  fi

  FROM="$from" TO="$to" perl -0pi -e 's/\Q$ENV{FROM}\E/$ENV{TO}/g' "$file"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      target_root="${2:-}"
      shift 2
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    --include-ci)
      include_ci=true
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$target_root" ]]; then
  echo "Missing required --target argument." >&2
  usage >&2
  exit 1
fi

if [[ ! -d "$target_root" ]]; then
  echo "Target repository does not exist: $target_root" >&2
  exit 1
fi

target_root="$(cd "$target_root" && pwd)"

source_skill_name="$(current_codex_workflow_skill_name "$SOURCE_ROOT")"
target_skill_name="$(current_codex_workflow_skill_name "$target_root")"

workflow_files=(
  "AGENTS.md"
  "CLAUDE.md"
  ".agents/AGENTS.md"
  ".agents/manifest.json"
  ".agents/adapters/claude.md"
  ".agents/adapters/codex.md"
  ".agents/adapters/copilot.md"
  ".agents/adapters/gsd.md"
  ".agents/skills/workflow-core/SKILL.md"
  ".agents/skills/discuss-phase/SKILL.md"
  ".agents/skills/plan-phase/SKILL.md"
  ".agents/skills/execute-phase/SKILL.md"
  ".agents/skills/verify-phase/SKILL.md"
  ".agents/skills/quick-task/SKILL.md"
  ".agents/skills/docs-update/SKILL.md"
  ".agents/skills/review/SKILL.md"
  ".agents/scripts/validate-agents.sh"
  ".agents/scripts/generate-runtime-shims.sh"
  ".agents/scripts/sync-runtime-adapters.sh"
  ".github/copilot-instructions.md"
  ".github/pull_request_template.md"
  "docs/ai/ARTIFACTS.md"
  "docs/ai/CONTEXT_MAP.md"
  "docs/ai/DECISION_RULES.md"
  "docs/ai/PROJECT_METHOD.md"
  "docs/ai/RECIPES.md"
  "docs/ai/SUCCESS.md"
  "docs/ai/WORKFLOW.md"
  "docs/ai/WORKFLOW_SHORT.md"
  "docs/adoption/new-project.md"
  "docs/adoption/legacy-project.md"
  "docs/adoption/in-flight-project.md"
  "docs/adoption/derived-project-migration.md"
  ".planning/README.md"
  ".planning/00-TEMPLATE-STATE.md"
  ".planning/00-TEMPLATE-ROADMAP.md"
  ".planning/00-TEMPLATE-VISION.md"
  ".planning/00-TEMPLATE-PROJECT.md"
  ".planning/00-TEMPLATE-RISK_REGISTER.md"
  ".planning/adrs/README.md"
  ".planning/adrs/00-TEMPLATE-ADR.md"
  ".planning/epics/00-TEMPLATE-EPIC.md"
  ".planning/plans/00-TEMPLATE-PLAN.md"
  ".planning/summaries/00-TEMPLATE-SUMMARY.md"
  ".planning/verification/00-TEMPLATE-VERIFICATION.md"
  "scripts/validate-workflow.sh"
  "scripts/migrate-derived-repo.sh"
  "tests/test-validate-workflow.sh"
)

if [[ "$include_ci" == true ]]; then
  workflow_files+=(".github/workflows/validate.yml")
fi

for relative_path in "${workflow_files[@]}"; do
  copy_file "$SOURCE_ROOT/$relative_path" "$target_root/$relative_path"
done

copy_tree "$SOURCE_ROOT/.agents/agents" "$target_root/.agents/agents"
copy_tree "$SOURCE_ROOT/.agents/bin" "$target_root/.agents/bin"
copy_tree "$SOURCE_ROOT/.agents/references" "$target_root/.agents/references"
copy_tree "$SOURCE_ROOT/.agents/runtimes" "$target_root/.agents/runtimes"
copy_tree "$SOURCE_ROOT/.agents/skills" "$target_root/.agents/skills"
copy_tree "$SOURCE_ROOT/.agents/templates" "$target_root/.agents/templates"
copy_tree "$SOURCE_ROOT/.agents/workflows" "$target_root/.agents/workflows"

copy_file "$SOURCE_ROOT/.codex/skills/$source_skill_name/SKILL.md" "$target_root/.codex/skills/$target_skill_name/SKILL.md"

if [[ "$dry_run" == false ]]; then
  replace_literal_in_file "$target_root/AGENTS.md" "$source_skill_name" "$target_skill_name"
  replace_literal_in_file "$target_root/tests/test-validate-workflow.sh" "$source_skill_name" "$target_skill_name"
  replace_literal_in_file "$target_root/.codex/skills/$target_skill_name/SKILL.md" "$source_skill_name" "$target_skill_name"
fi

echo "Migration sync complete."
echo "Target: $target_root"
echo "Codex workflow skill: $target_skill_name"
echo "Included CI workflow: $include_ci"
