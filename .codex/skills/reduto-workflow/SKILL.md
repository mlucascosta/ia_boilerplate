---
name: reduto-workflow
description: "Use when working in this repository with Codex, especially for phased features, documentation-first execution, planning artifacts, verification, and project constraints. Keywords: workflow, planning, docs, state, roadmap, verify, Reduto, TSDoc, PHPDoc, SOLID."
---

# Reduto Workflow Skill

This skill adapts the repository workflow for Codex.

## Source Of Truth

1. `AGENTS.md`
2. `docs/ai/WORKFLOW.md`
3. `docs/ai/ARTIFACTS.md`

## Operating Rules

1. Use the unified workflow rather than inventing a Codex-only process.
2. For non-trivial work, read existing docs and planning artifacts before implementation.
3. Keep `.planning/` current for phased or risky tasks.
4. Update durable docs when implementation changes durable knowledge.
5. Preserve project-specific constraints, including mandatory complete in-code documentation and SOLID-oriented architecture for meaningful implementation work.
6. Preserve the documented architectural direction and avoid introducing undeclared platform shifts.

## Crosswalk

1. Pster brainstorm or GSD discuss maps to clarify scope and decisions.
2. Pster plan or GSD plan maps to creating executable atomic plans.
3. Pster work or GSD execute maps to implementation in small validated units.
4. Pster docs or GSD summaries maps to repository documentation and memory capture.