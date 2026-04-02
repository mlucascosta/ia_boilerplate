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
| 07 | Automated tests for bootstrap script (macOS, Linux, WSL) | 06 | Planned |
| 08 | Cross-platform install docs (Linux apt/dnf, Windows WSL) | 06 | Planned |
| 09 | Additional stack examples: Vue.js 3 component, Python script | 06 | Planned |
| 10 | Migration script for projects on older workflow versions | 09 | Planned |

## Notes

**Why phases 07-10 are deferred:**

Phases 01-06 establish the workflow contract itself. Tests for the bootstrap and multi-stack examples require real usage data to know what scenarios to cover — shipping them speculatively before anyone has used the boilerplate would produce low-confidence tests and examples that do not reflect actual pain points. Phases 07-10 will be planned once real adoption provides concrete evidence of what breaks and what needs illustrating.