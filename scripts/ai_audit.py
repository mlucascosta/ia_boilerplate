#!/usr/bin/env python3
"""
AI Architecture Audit Script for PRs.
Advisory-only mode. Safe fallback if no API key is configured.
"""
import os
import subprocess
from pathlib import Path

REPORT_PATH = Path("audit-report.md")
GOVERNANCE_DIR = Path(".agents/governance")

REQUIRED_FILES = {
    "skills": GOVERNANCE_DIR / "SKILLS.md",
    "rules": GOVERNANCE_DIR / "RULES.md",
    "template": GOVERNANCE_DIR / "REVIEW_OUTPUT_TEMPLATE.md",
}

MAX_DIFF_CHARS = 30_000
REPORT_HEADER = "## 🤖 AI Architecture Audit"


def write_report(text: str) -> None:
    if REPORT_HEADER not in text:
        text = f"{REPORT_HEADER}\n\n{text}"
    REPORT_PATH.write_text(text, encoding="utf-8")


def read_file_safe(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except FileNotFoundError:
        return f"[MISSING: {path}]\n"


def get_diff() -> str:
    base_ref = os.environ.get("GITHUB_BASE_REF", "main")
    subprocess.run(["git", "fetch", "origin", base_ref], capture_output=True, check=False)
    try:
        result = subprocess.run(
            ["git", "diff", f"origin/{base_ref}...HEAD"],
            capture_output=True,
            text=True,
            check=False,
            timeout=30,
        )
        diff = result.stdout or ""
        if not diff:
            result = subprocess.run(
                ["git", "diff", "HEAD~1"],
                capture_output=True,
                text=True,
                check=False,
                timeout=30,
            )
            diff = result.stdout or ""
        return diff
    except Exception as exc:
        return f"<<diff unavailable: {exc}>>"


def truncate_diff(diff: str, max_chars: int = MAX_DIFF_CHARS) -> str:
    if len(diff) <= max_chars:
        return diff
    keep_head = int(max_chars * 0.8)
    keep_tail = max_chars - keep_head
    return (
        diff[:keep_head]
        + "\n\n... [diff truncated due to size] ...\n\n"
        + diff[-keep_tail:]
    )


def build_prompt(diff: str) -> str:
    skills = read_file_safe(REQUIRED_FILES["skills"])
    rules = read_file_safe(REQUIRED_FILES["rules"])
    template = read_file_safe(REQUIRED_FILES["template"])
    truncated_diff = truncate_diff(diff)

    return f"""
You are performing an advisory architectural audit for this repository.

Mandatory repository context:
- .agents/AGENTS.md
- .agents/governance/RULES.md
- .agents/governance/SKILLS.md

Constraints:
- RTK is mandatory for shell guidance in human-facing instructions (CI automation exempt).
- Do not invent issues beyond the provided diff.
- Prefer evidence-based findings.
- Keep the rollout advisory-first.

Review template:
{template}

Governance rules:
{rules}

Governance skills:
{skills}

Diff (may be truncated):
{truncated_diff}
"""


def call_llm(prompt: str, api_key: str, model: str) -> str:
    try:
        from openai import OpenAI, APITimeoutError, APIError
    except ImportError:
        return "OpenAI library not installed. Cannot perform audit."

    client = OpenAI(api_key=api_key, timeout=30.0)
    try:
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0.1,
        )
        return response.choices[0].message.content or f"{REPORT_HEADER}\n\nNo response content."
    except APITimeoutError:
        return f"{REPORT_HEADER}\n\nLLM request timed out. Audit skipped."
    except APIError as exc:
        return f"{REPORT_HEADER}\n\nLLM API error: {exc}\nAudit skipped."
    except Exception as exc:
        return f"{REPORT_HEADER}\n\nUnexpected error during LLM call: {exc}\nAudit skipped."


def main() -> None:
    api_key = os.environ.get("OPENAI_API_KEY")
    model = os.environ.get("AUDIT_MODEL", "gpt-4o-mini")
    diff = get_diff()

    if not api_key:
        write_report(
            "**Status:** Skipped (missing `OPENAI_API_KEY`)\n\n"
            "The audit workflow is installed, but no LLM credential is configured.\n"
            "No merge decision was affected."
        )
        return

    if not diff.strip():
        write_report(
            "**Status:** Skipped (no meaningful diff detected)\n\n"
            "No merge decision was affected."
        )
        return

    missing_files = [p for p in REQUIRED_FILES.values() if not p.exists()]
    if missing_files:
        missing_list = "\n".join(f"- `{f}`" for f in missing_files)
        write_report(
            f"**Status:** Skipped (missing governance files)\n\n"
            f"The following required files are missing:\n{missing_list}\n\n"
            f"Please ensure `.agents/governance/` is fully populated."
        )
        return

    prompt = build_prompt(diff)
    content = call_llm(prompt, api_key, model)
    write_report(content)


if __name__ == "__main__":
    main()
