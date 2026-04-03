#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# TEMPLATE_ROOT is the original absolute path baked into GSD internal references.
# The bootstrap replaces all occurrences of this path with REPO_ROOT so the
# workflow artifacts work correctly on any machine or directory.
# It is derived from the first absolute path found inside .claude/ references,
# falling back to REPO_ROOT itself if none is found.
# Search .agents/ first (new layout), then .claude/ as fallback (legacy layout)
TEMPLATE_ROOT="$(grep -roh '/[^ "]*ia_boilerplate[^ "]*' "$REPO_ROOT/.agents" "$REPO_ROOT/.claude" 2>/dev/null \
  | grep -v '\.git' | head -1 \
  | python3 -c "import sys,os; p=sys.stdin.read().strip(); print(os.path.dirname(os.path.dirname(p)) if '/.agents/' in p else os.path.dirname(os.path.dirname(os.path.dirname(p)))) if p else print('')" 2>/dev/null \
  || echo "$REPO_ROOT")"
if [[ -z "$TEMPLATE_ROOT" || "$TEMPLATE_ROOT" == "$REPO_ROOT" ]]; then
  TEMPLATE_ROOT="$REPO_ROOT"
fi

project_name=""
project_slug=""
copyright_holder=""
lite_mode=false

usage() {
  cat <<'EOF'
Usage:
  ./scripts/bootstrap-template.sh [--project-name "Your Project"] [--copyright-holder "Your Team"] [--lite]

Options:
  --project-name       Project display name for README and planning docs.
  --copyright-holder   MIT copyright holder. Defaults to "<Project Name> contributors".
  --lite               Lite mode: install only workflow docs and runtime adapters.
                       Skips GSD runtime tooling (.claude/, .codex/, .github/skills/).
                       Ideal for solo developers or teams not using Claude Code subagents.
  --help               Show this message.
EOF
}

title_case_from_path() {
  printf '%s' "$1" | perl -pe 's/[-_]+/ /g; s/(^|\s)([[:alpha:]])/$1\U$2/g'
}

slugify() {
  printf '%s' "$1" | perl -pe 's/[^[:alnum:]]+/-/g; s/^-+//; s/-+$//; $_=lc $_'
}

replace_literal_in_file() {
  local file="$1"
  local from="$2"
  local to="$3"

  if [[ ! -f "$file" ]]; then
    return 0
  fi

  FROM="$from" TO="$to" perl -0pi -e 's/\Q$ENV{FROM}\E/$ENV{TO}/g' "$file"
}

find_repo_files_with_literal() {
  local needle="$1"

  if command -v rg >/dev/null 2>&1; then
    rg -l --hidden --fixed-strings "$needle" "$REPO_ROOT" \
      -g '!/.git' \
      -g '!node_modules' \
      -g '!dist' \
      -g '!build' || true
    return 0
  fi

  grep -RIl --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=build -- "$needle" "$REPO_ROOT" || true
}

replace_literal_in_repo() {
  local from="$1"
  local to="$2"
  local file

  if [[ -z "$from" || "$from" == "$to" ]]; then
    return 0
  fi

  while IFS= read -r file; do
    if [[ -z "$file" ]]; then
      continue
    fi

    replace_literal_in_file "$file" "$from" "$to"
  done < <(find_repo_files_with_literal "$from")
}

current_readme_name() {
  if [[ -f "$REPO_ROOT/README.md" ]]; then
    sed -n '1s/^# //p' "$REPO_ROOT/README.md"
  fi
}

current_license_holder() {
  if [[ -f "$REPO_ROOT/LICENSE" ]]; then
    sed -n '2s/^Copyright (c) [0-9]\{4\} //p' "$REPO_ROOT/LICENSE"
  fi
}

warn_if_missing_runtime_prerequisites() {
  if ! command -v node >/dev/null 2>&1; then
    echo "Warning: 'node' was not found in PATH." >&2
    echo "Install Node.js before using the bundled AI runtime tooling." >&2
    return 0
  fi

  if ! command -v npx >/dev/null 2>&1; then
    echo "Warning: 'npx' was not found in PATH." >&2
    echo "Install a Node.js distribution that includes npm/npx before using the bundled AI runtime tooling." >&2
  fi
}

current_codex_workflow_skill_name() {
  if [[ -f "$REPO_ROOT/AGENTS.md" ]]; then
    sed -n 's|.*\.codex/skills/\([^/]*\)/SKILL\.md.*|\1|p' "$REPO_ROOT/AGENTS.md" | sed -n '1p'
  fi
}

rename_codex_workflow_skill() {
  local old_name="$1"
  local new_name="$2"
  local skills_dir="$REPO_ROOT/.codex/skills"
  local old_dir="$skills_dir/$old_name"
  local new_dir="$skills_dir/$new_name"
  local skill_file

  if [[ -z "$old_name" || -z "$new_name" || "$old_name" == "$new_name" ]]; then
    return 0
  fi

  replace_literal_in_repo "$old_name" "$new_name"

  if [[ -d "$old_dir" && ! -e "$new_dir" ]]; then
    mv "$old_dir" "$new_dir"
  fi

  skill_file="$new_dir/SKILL.md"
  if [[ -f "$skill_file" ]]; then
    replace_literal_in_file "$skill_file" "name: $old_name" "name: $new_name"
    replace_literal_in_file "$skill_file" "# Boilerplate Workflow Skill" "# $project_name Workflow Skill"
    replace_literal_in_file "$skill_file" "Boilerplate" "$project_name"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project-name)
      project_name="${2:-}"
      shift 2
      ;;
    --copyright-holder)
      copyright_holder="${2:-}"
      shift 2
      ;;
    --lite)
      lite_mode=true
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

if [[ -z "$project_name" ]]; then
  project_name="$(title_case_from_path "$(basename "$REPO_ROOT")")"
fi

project_slug="$(slugify "$project_name")"

if [[ -z "$copyright_holder" ]]; then
  copyright_holder="$project_name contributors"
fi

old_project_name="$(current_readme_name)"
if [[ -z "$old_project_name" ]]; then
  old_project_name="IA Boilerplate"
fi

old_copyright_holder="$(current_license_holder)"
if [[ -z "$old_copyright_holder" ]]; then
  old_copyright_holder="IA Boilerplate contributors"
fi

old_codex_workflow_skill_name="$(current_codex_workflow_skill_name)"
if [[ -z "$old_codex_workflow_skill_name" ]]; then
  old_codex_workflow_skill_name="boilerplate-workflow"
fi

new_codex_workflow_skill_name="$project_slug-workflow"

if [[ "$lite_mode" == false ]]; then
  warn_if_missing_runtime_prerequisites
fi

replace_literal_in_repo "$TEMPLATE_ROOT" "$REPO_ROOT"

rename_codex_workflow_skill "$old_codex_workflow_skill_name" "$new_codex_workflow_skill_name"

replace_literal_in_file "$REPO_ROOT/README.md" "$old_project_name" "$project_name"
replace_literal_in_file "$REPO_ROOT/AGENTS.md" "$old_project_name" "$project_name"
replace_literal_in_file "$REPO_ROOT/.agents/AGENTS.md" "$old_project_name" "$project_name"
replace_literal_in_file "$REPO_ROOT/.planning/PROJECT.md" "$old_project_name" "$project_name"
replace_literal_in_file "$REPO_ROOT/LICENSE" "$old_copyright_holder" "$copyright_holder"

if [[ "$lite_mode" == true ]]; then
  echo "Lite mode: removing GSD runtime tooling..."
  # Keep the canonical .agents contract, adapters, manifest, skills, and validation scripts.
  # Remove heavy runtime tooling and shared GSD execution assets.
  rm -rf "$REPO_ROOT/.agents/agents" "$REPO_ROOT/.agents/bin" "$REPO_ROOT/.agents/references" "$REPO_ROOT/.agents/runtimes" "$REPO_ROOT/.agents/templates" "$REPO_ROOT/.agents/workflows"
  # Remove Claude GSD commands and agents (keep root adapter files)
  rm -rf "$REPO_ROOT/.claude/commands" "$REPO_ROOT/.claude/agents"
  # Remove Codex and GitHub skill wrappers
  for skill_dir in "$REPO_ROOT/.codex/skills"/gsd-*; do
    [[ -d "$skill_dir" ]] && rm -rf "$skill_dir"
  done
  rm -rf "$REPO_ROOT/.github/skills"
  echo "GSD runtime tooling removed. Canonical .agents contract and workflow adapters retained."
fi

echo "Bootstrap complete."
echo "Project name: $project_name"
echo "Project slug: $project_slug"
echo "Repository root: $REPO_ROOT"
echo "Copyright holder: $copyright_holder"
if [[ "$lite_mode" == true ]]; then
  echo "Mode: lite (workflow docs only, no GSD runtime)"
fi
