---
tags: [rtk, token-optimization, reference]
---

# RTK — Rust Token Killer

RTK is a high-performance CLI proxy that reduces LLM token consumption by **60–90%** on common dev commands.

## Why RTK is Mandatory

Raw command output is noisy. `git log` alone can dump thousands of tokens of irrelevant data.
RTK intercepts every shell command and applies four strategies before the AI sees the output:

1. **Smart Filtering** — removes comments, whitespace, boilerplate
2. **Grouping** — aggregates similar items (files by directory, errors by type)
3. **Truncation** — keeps relevant context, cuts redundancy
4. **Deduplication** — collapses repeated log lines with counts

Result: 80% fewer tokens on average across a full session.

## Average Savings per Command Type

| Command | Compression |
|---|---|
| `ls` / `tree` | -80% |
| `cat` / file reads | -70% |
| `grep` / `rg` | -80% |
| `git status` | -80% |
| `git diff` | -75% |
| `git log` | -80% |
| `cargo test` / `npm test` | -90% |
| `pytest` | -90% |
| `tsc` | -80% |

## Auto-Rewrite Hook

After `rtk init -g`, RTK installs a `PreToolUse` hook that **transparently rewrites** every bash command.
The AI never sees the rewrite — it just gets compressed output.

100% RTK adoption with zero effort from the agent.

## Repository: https://github.com/rtk-ai/rtk
