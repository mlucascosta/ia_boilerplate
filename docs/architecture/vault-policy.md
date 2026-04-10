# Vault Policy

This document defines the role, authority, and constraints of the `vault/` directory in `ia_boilerplate`.

## What the vault is

`vault/` is an [Obsidian](https://obsidian.md/) knowledge vault.

It provides a navigable, editorial knowledge surface for humans using Obsidian.
It is organized as a reading and reference aid, not as an operational or normative layer.

## What the vault is not

The vault is **not**:

- a source of normative AI behavior rules
- a replacement for `.agents/` contracts
- a source of workflow instructions
- a requirement for running the workflow

A user who never opens Obsidian must still be able to use this repository correctly.
The vault adds value for those who use it; it does not gate anyone who does not.

## Authority hierarchy

```
.agents/              ← normative (wins all conflicts)
.agents/governance/   ← normative extension (audit/review)
docs/ai/              ← workflow authority
docs/architecture/    ← human explanation
vault/                ← editorial, knowledge, Obsidian — not normative
```

If vault content contradicts `.agents/` or `docs/ai/`, the vault is wrong.

## What belongs in the vault

- Standards summaries (TDD, SOLID, Git Flow, Code Review)
- RTK command reference in readable format
- Workflow overviews for human orientation
- Governance summaries linking to normative sources
- Templates for ADRs, feature plans, session notes
- Research notes and similar-project references

## What does not belong in the vault

- Normative behavior rules for AI agents
- Canonical workflow definitions
- Authoritative artifact contracts
- Governance rules that override `.agents/governance/`

## Vault structure

```
vault/
  00-Home/            ← navigation dashboard
  10-Standards/       ← TDD, SOLID, Git Flow, Code Review, RTK
  20-Workflow/        ← workflow and artifact lifecycle overviews
  30-Governance/      ← audit governance summaries
  40-Research/        ← similar projects, references
  50-Templates/       ← ADR, feature plan, session note, bug report
```

## Sync discipline

Vault content summarizes or points to canonical sources.
When canonical sources change, vault summaries should be updated to reflect them.
Vault content must never become the primary definition.
