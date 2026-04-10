# Start Here

This file is the shortest path into this repository.
Read it before anything else. It replaces the need to scan multiple directories on first contact.

---

## What this repository is

`ia_boilerplate` is a cross-runtime AI workflow bootstrap.

It gives GitHub Copilot, Claude, Codex, and Gemini a shared operating model so they work from the same rules, the same artifacts, and the same quality expectations — regardless of which tool you are using.

It is **not** an application. It is workflow infrastructure.

---

## The five layers and what they own

| Layer | Path | Owns |
|---|---|---|
| Normative AI | `.agents/` | All behavior rules for AI agents |
| Audit governance | `.agents/governance/` | Architectural review, anti-patterns, PR audit |
| Workflow | `docs/ai/` | How the workflow operates, artifact contracts, context loading |
| Architecture | `docs/architecture/` | Why decisions were made, layer explanations (human-facing) |
| Knowledge vault | `vault/` | Editorial notes, Obsidian navigation — not normative |

**If two layers disagree, `.agents/` wins.**

---

## What to read first for each situation

| You want to... | Read |
|---|---|
| Understand the current task | `.planning/STATE.md` |
| Start a new task | `docs/ai/WORKFLOW_SHORT.md` |
| Run a full workflow | `docs/ai/WORKFLOW.md` |
| Know the agent contract | `.agents/AGENTS.md` |
| Do an architecture review | `.agents/governance/RULES.md` then `.agents/governance/SKILLS.md` |
| Understand the layer hierarchy | `docs/architecture/information-architecture.md` |
| Set up RTK | `RTK.md` then `scripts/install-rtk.sh` |

---

## RTK is mandatory

All shell commands must be prefixed with `rtk`.

```sh
rtk git status
rtk git log -10
rtk read <file>
rtk ls .
rtk cargo test
rtk pytest
```

Install: `./scripts/install-rtk.sh`
Initialize: `rtk init -g` (Claude), `rtk init -g --copilot` (Copilot), `rtk init -g --gemini` (Gemini)

---

## Runtime adapters are thin

`AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` are compatibility adapters.
They constrain syntax and point back to `.agents/`. They do not define behavior.

When in doubt, go to `.agents/AGENTS.md`.

---

## How to avoid context drift

1. Keep execution state in `.planning/STATE.md` (≤120 words, telegraphic).
2. Rotate completed plans to `.planning/summaries/` (≤180 words).
3. Never treat chat history as the source of truth.
4. Use `docs/ai/CONTEXT_MAP.md` to know what to load and what to skip.

---

## What the vault is and is not

`vault/` is an Obsidian knowledge vault.
It is useful for browsing standards, templates, and notes in Obsidian.
It is **not** a source of normative rules. Nothing in `vault/` overrides `.agents/`.

See `docs/architecture/vault-policy.md` for the full policy.
