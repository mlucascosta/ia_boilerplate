# Project Method

This project uses a hybrid delivery model designed for AI-assisted software development.

## Purpose
The goal of this method is to combine:
- stable governance for direction, architecture, risk, and quality
- adaptive execution for discovery, implementation, validation, and incremental delivery

## Operating principle
Governance handles what must remain stable.
Execution handles what must evolve quickly.

## Governance layer
Use governance artifacts for:
- project direction
- scope boundaries
- architecture
- major technical decisions
- risk management
- quality standards
- canonical documentation

Governance artifacts should be concise, durable, and updated only when meaningfully changed.

## Execution layer
Use execution artifacts for:
- backlog-driven work
- small slices
- AI-assisted pair programming
- validation loops
- local implementation notes
- short summaries and handoffs

Execution artifacts should be compact, current, and easy to rotate.

## Human and AI roles
Humans are responsible for:
- judgment
- prioritization
- architecture
- security
- validation
- approval

AI is responsible for accelerating:
- drafting
- local analysis
- implementation support
- tests
- refactors
- summaries

AI does not own final approval.

## Default working mode
1. Read current state.
2. Identify one slice.
3. Create or refine a short plan.
4. Execute with narrow scope.
5. Validate proportional to risk.
6. Summarize result.
7. Update state.
8. Continue to the next slice.

## Core rules
- Do not treat roadmap decisions as execution notes.
- Do not hide architectural changes inside implementation summaries.
- Do not continue large exploratory work without reducing it to slices.
- Do not let conversational history become the source of truth.

## Delivery policy
The repository is the source of truth.
Chats are temporary working memory.
Planning and state must survive outside the chat.
