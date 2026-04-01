# CollabPix

CollabPix is a repository-level, cross-AI workflow bootstrap for software delivery.

It provides a shared operating model for GitHub Copilot, Codex, Claude, and other coding agents so they can work against the same planning artifacts, documentation rules, and execution constraints.

This repository is intentionally focused on workflow infrastructure rather than application code. Its purpose is to make AI-assisted delivery more predictable, auditable, and portable across runtimes.

## What This Repository Contains

- A canonical workflow in `docs/ai/WORKFLOW.md`
- A canonical artifact contract in `docs/ai/ARTIFACTS.md`
- Runtime adapters for Copilot, Claude, and Codex
- A local GSD installation aligned to the repository workflow
- A `.planning/` bootstrap structure for roadmap, state, planning, summaries, and verification artifacts

## Goals

- Keep AI-assisted work consistent across different runtimes
- Make planning and execution artifact-driven instead of chat-history-driven
- Treat documentation as operational memory
- Keep workflow expectations explicit, reviewable, and durable
- Enforce strong implementation standards around complete code documentation and SOLID-oriented architecture

## Workflow Foundation

This setup combines ideas from two public repositories that influenced the structure and operating model used here:

- `J-Pster/Psters_AI_Workflow` — https://github.com/J-Pster/Psters_AI_Workflow
- `gsd-build/get-shit-done` — https://github.com/gsd-build/get-shit-done

They are referenced here as foundational inspiration for documentation-first execution, phased planning, persistent workflow state, and agent-oriented delivery.

## Core Rules

The current repository policy is intentionally narrow and explicit.

For meaningful implementation work, the mandatory requirements are:

- Complete in-code documentation using TSDoc, PHPDoc, or an equivalent language-appropriate standard
- SOLID-oriented architecture

Validation, testing, and review still matter, but they are treated as context-dependent verification choices unless the project documentation says otherwise.

## Runtime Support

This repository is prepared to work with:

- GitHub Copilot
- Claude
- Codex

Each runtime is adapted back to the same repository-level source of truth so the workflow stays consistent even when native commands differ.

## Boilerplate Setup

If you use this repository as a template or boilerplate, run the bootstrap script after cloning it:

```bash
./scripts/bootstrap-template.sh --project-name "Your Project"
```

What the bootstrap does:

- Rewrites local absolute runtime paths to the directory where the boilerplate was cloned
- Renames project-facing boilerplate docs from `CollabPix` to your project name
- Renames the internal Codex workflow skill from `reduto-workflow` to a project-derived identifier such as `your-project-workflow`
- Updates the MIT copyright holder, defaulting to `<Project Name> contributors`

If you omit `--project-name`, the script derives the name from the current folder.

## Repository Structure

```text
.
├── .claude/
├── .codex/
├── .github/
├── .planning/
├── AGENTS.md
├── CLAUDE.md
└── docs/
```

## Contributing

Contributions are open.

If you want to improve the workflow, adapters, planning artifacts, or documentation model, open an issue or submit a pull request.

Please read `CONTRIBUTING.md` before sending changes.

## License

This repository is licensed under the MIT License.

See `LICENSE` for details.
