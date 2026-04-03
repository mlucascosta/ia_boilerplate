# Roadmap

## Milestone: Workflow Bootstrap Stable Foundation

| Phase | Goal | Dependency | Status |
| --- | --- | --- | --- |
| 01 | Core workflow contract and artifact templates | — | Completed |
| 02 | Runtime adapters for Copilot, Claude, Codex | 01 | Completed |
| 03 | Token economy and context continuity rules | 02 | Completed |
| 04 | Conformance validation script + CI check | 03 | Completed |
| 05 | End-to-end usage example (Node.js feature flow) | 04 | Completed |
| 06 | Workflow success checklist, diagram, CHANGELOG | 05 | Completed |

## Milestone: Broader Adoption

| Phase | Goal | Dependency | Status |
| --- | --- | --- | --- |
| 07 | Automated tests for bootstrap script (13 tests, CI matrix Ubuntu + macOS) | 06 | Completed |
| 08 | Cross-platform install docs (Linux apt/dnf, Windows WSL) | 06 | Planned |
| 09 | Multi-stack Todo API examples (Node, Python, Go, Rust, PHP) | 06 | Completed |
| 10 | Migration script for projects on older workflow versions | 09 | Planned |

## Milestone: Adoption Hardening

| Phase | Goal | Dependency | Status |
| --- | --- | --- | --- |
| 11 | Expand CI conformance checks for artifact budgets, minimum governance files, and PR review signals | 04, 07 | Completed |
| 12 | Add scenario-based adoption playbooks for new, legacy, and in-flight projects | 11 | Completed |
| 13 | Improve readability of dense operational docs (`DECISION_RULES`, `CONTEXT_MAP`, `RECIPES`) without changing their contract | 12 | Completed |
| 14 | Harmonize runtime adapters around one minimal contract and isolate GSD-specific behavior | 11 | Completed |
| 15 | Ship first-class templates for planning artifacts, ADRs, risks, and pull requests | 11 | Completed |
| 16 | Add lightweight migration support for derived repositories upgrading workflow versions | 14, 15 | Completed |

## Milestone: Delivery System Alignment

| Phase | Goal | Dependency | Status |
| --- | --- | --- | --- |
| 17 | Formalize the hybrid delivery and mandatory quality model across workflow, project method, and PR review | 16 | Completed |
| 18 | Automate branch, quality, and security gate enforcement where the workflow already defines policy | 17 | Planned |

## Notes

**Why phases 07-10 are deferred:**

Phases 01-06 establish the workflow contract itself. Tests for the bootstrap and multi-stack examples require real usage data to know what scenarios to cover — shipping them speculatively before anyone has used the boilerplate would produce low-confidence tests and examples that do not reflect actual pain points. Phases 07-10 will be planned once real adoption provides concrete evidence of what breaks and what needs illustrating.

**Why phases 11-16 are next:**

The workflow is already strong as a repository contract, but adoption still relies too heavily on manual discipline and prior familiarity with the model. These phases convert the current strengths into a more enforceable and easier-to-adopt system by hardening CI, adding scenario playbooks, improving document ergonomics, aligning runtime adapters, and reducing setup ambiguity for derived repositories.