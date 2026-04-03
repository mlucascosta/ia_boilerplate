# Contributing

Thank you for contributing.

This repository is open to improvements in workflow design, documentation quality, runtime adapters, planning artifacts, and cross-AI interoperability.

## What We Accept

Contributions are welcome for:

- Workflow clarifications
- Documentation improvements
- Runtime adapter fixes
- GSD alignment improvements
- Planning artifact quality improvements
- Consistency fixes across Copilot, Claude, and Codex support

## Contribution Expectations

Please keep contributions aligned with the repository rules:

- Prefer small, explicit changes over broad rewrites
- Keep the workflow generic, portable, and runtime-agnostic when possible
- Preserve the repository-level source of truth in `docs/ai/WORKFLOW.md` and `docs/ai/ARTIFACTS.md`
- Keep implementation guidance compatible across runtimes
- Keep runtime adapters minimal and semantically aligned; adapters should restrict behavior, not restate the full workflow
- For meaningful implementation changes, preserve complete in-code documentation, SOLID-oriented architecture, and validation proportional to risk

## Process

1. Open an issue if the change is large, structural, or ambiguous.
2. Keep pull requests focused.
3. Update documentation when behavior, architecture, or workflow expectations change.
4. Avoid introducing runtime-specific behavior as the source of truth.
5. Prefer clear rationale in PR descriptions, especially when changing workflow semantics.
6. Fill in the pull request workflow signals so reviewers can see path, verification level, and governance impact immediately.
7. Preserve project-specific identity when changing migration tooling; workflow sync should not overwrite product docs by default.
8. Use the PR template to declare TDD, test coverage, and security impact honestly rather than treating validation as implicit.

## Style Guidelines

- Write documentation in clear English
- Prefer explicit terminology over shorthand
- Avoid stack-specific assumptions unless the repository explicitly documents them
- Keep durable guidance in docs, not only in adapter files

## License

By contributing to this repository, you agree that your contributions will be licensed under the MIT License.
