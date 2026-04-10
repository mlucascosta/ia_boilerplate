# Information Architecture

This repository separates normative behavior, workflow guidance, architecture explanation, and knowledge support into distinct layers with clear responsibilities.

## Layer map

| Layer | Path | Authority |
|---|---|---|
| Normative AI | `.agents/` | Canonical source. Owns all behavior rules. |
| Audit governance | `.agents/governance/` | Extends `.agents/`. Owns review and audit rules. |
| Workflow | `docs/ai/` | Operationally authoritative for workflow, artifacts, and context loading. |
| Architecture | `docs/architecture/` | Human-facing. Explains decisions, structure, and governance rationale. |
| Knowledge vault | `vault/` | Obsidian-oriented. Supports navigation and notes. Not normative. |
| Runtime adapters | `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md` | Compatibility entrypoints only. Must not redefine normative rules. |

## Normative AI layer — `.agents/`

Owns:

- repository agent contract
- skills
- adapters
- runtime surfaces
- governance extension

All behavior rules for AI must originate here.

## Audit governance — `.agents/governance/`

An extension of `.agents/`. Owns:

- architectural audit skills
- review behavior rules
- anti-pattern catalog
- merge-impact classification
- standardized finding format

## Workflow layer — `docs/ai/`

Explains:

- workflow paths (trivial, focused, full)
- artifact contracts
- execution model
- context selection and loading
- decision rules

## Architecture layer — `docs/architecture/`

Explains:

- structural decisions
- centralization model
- governance rationale
- repository information architecture

Human audience. Not directly consumed by AI as operational rules.

## Knowledge layer — `vault/`

Obsidian-oriented knowledge surface.

May support navigation, operational notes, and editorial reference.

Must not become a competing normative source.

## Runtime adapters

The following files are compatibility entrypoints only:

- `AGENTS.md` — root adapter pointing to `.agents/AGENTS.md`
- `CLAUDE.md` — Claude-specific adapter
- `.github/copilot-instructions.md` — Copilot-specific adapter

They may summarize or point to the canonical layer, but must not redefine it.

## Anti-patterns for information architecture

Avoid:

- creating normative rules in `vault/`
- defining new adapter behavior in `docs/ai/`
- duplicating normative content across multiple runtime-specific files
- treating chat history as a source of truth
- promoting `docs/architecture/` to normative AI behavior
