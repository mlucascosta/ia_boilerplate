---
tags: [rtk, commands, reference]
---

# RTK Command Reference

Full rewrite table organized by category.
All AI agents must use the `rtk` equivalent — never the raw command.

## Git

| Instead of | Use | What it does |
|---|---|---|
| `git status` | `rtk git status` | Compact status — changed files only, -80% |
| `git diff` | `rtk git diff` | Condensed diff |
| `git log` | `rtk git log -n 10` | One-line commits |
| `git add .` | `rtk git add` | Stages → `"ok"` |
| `git commit -m "msg"` | `rtk git commit -m "msg"` | Commits → `"ok abc1234"` |
| `git push` | `rtk git push` | Pushes → `"ok main"` |
| `git pull` | `rtk git pull` | Pulls → `"ok 3 files +10 -2"` |
| `git merge branch` | `rtk git merge branch` | Merge with compact output |
| `git checkout -b feat` | `rtk git checkout -b feat` | Branch switch, compact |

## GitHub CLI

| Instead of | Use | What it does |
|---|---|---|
| `gh pr list` | `rtk gh pr list` | Compact PR listing |
| `gh pr view 42` | `rtk gh pr view 42` | PR details + check status |
| `gh pr create` | `rtk gh pr create` | Create PR, compact |
| `gh issue list` | `rtk gh issue list` | Compact issues |
| `gh issue view 10` | `rtk gh issue view 10` | Issue details |
| `gh run list` | `rtk gh run list` | Workflow run status |
| `gh run view <id>` | `rtk gh run view <id>` | Run details, failures first |

## Filesystem

| Instead of | Use | What it does |
|---|---|---|
| `ls` / `ls -la` | `rtk ls .` | Token-optimized tree, -80% |
| `cat file` | `rtk read file` | Smart file reading |
| `head file` / `tail file` | `rtk read file` | Same — always use `rtk read` |
| `cat file` (signatures only) | `rtk read file -l aggressive` | Strips function bodies |
| `grep pattern .` | `rtk grep "pattern" .` | Grouped results, -80% |
| `rg pattern .` | `rtk grep "pattern" .` | Same — handles both |
| `find "*.rs" .` | `rtk find "*.rs" .` | Compact find |
| `diff f1 f2` | `rtk diff f1 f2` | Condensed diff |

## Rust

| Instead of | Use | What it does |
|---|---|---|
| `cargo test` | `rtk cargo test` | Failures only, -90% |
| `cargo build` | `rtk cargo build` | Errors grouped, -80% |
| `cargo clippy` | `rtk cargo clippy` | Warnings by file, -80% |
| `cargo check` | `rtk cargo check` | Compact type-check |
| `cargo run` | `rtk cargo run` | Run, compact output |

## Node.js / TypeScript / JavaScript

| Instead of | Use | What it does |
|---|---|---|
| `npm test` / `npx jest` | `rtk test npm test` | Failures only, -90% |
| `npx vitest run` | `rtk vitest run` | Compact failures only |
| `npx tsc` | `rtk tsc` | Errors by file, -80% |
| `npx eslint .` | `rtk lint` | Grouped by rule/file, -80% |
| `npx biome check .` | `rtk lint biome` | Biome compact |
| `npx prettier --check .` | `rtk prettier --check .` | Files needing formatting |
| `npx playwright test` | `rtk playwright test` | E2E failures only |
| `npx next build` | `rtk next build` | Build compact |
| `pnpm list` | `rtk pnpm list` | Dependency tree, compact |
| `pnpm outdated` | `rtk pnpm outdated` | Outdated packages |
| `npx prisma generate` | `rtk prisma generate` | No ASCII art |

## Python

| Instead of | Use | What it does |
|---|---|---|
| `pytest` | `rtk pytest` | Failures only, -90% |
| `python -m pytest` | `rtk pytest` | Same |
| `ruff check .` | `rtk ruff check` | JSON lint, -80% |
| `ruff format --check .` | `rtk ruff format --check .` | Files needing formatting |
| `pip list` | `rtk pip list` | Packages (auto-detects `uv`) |
| `pip outdated` | `rtk pip outdated` | Outdated packages |

## Go

| Instead of | Use | What it does |
|---|---|---|
| `go test ./...` | `rtk go test` | NDJSON failures only, -90% |
| `go build ./...` | `rtk go build` | Build errors only |
| `go vet ./...` | `rtk go vet` | Vet output, compact |
| `golangci-lint run` | `rtk golangci-lint run` | JSON lint, -85% |

## Ruby

| Instead of | Use | What it does |
|---|---|---|
| `bundle exec rspec` | `rtk rspec` | JSON output, -60%+ |
| `rake test` / `rails test` | `rtk rake test` | Minitest compact |
| `rubocop` | `rtk rubocop` | JSON lint, -60%+ |
| `bundle install` | `rtk bundle install` | Strips `Using` lines |
| `bundle update` | `rtk bundle update` | Compact update |

## PHP

| Instead of | Use | What it does |
|---|---|---|
| `./vendor/bin/pest` | `rtk test ./vendor/bin/pest` | Pest failures only |
| `./vendor/bin/phpunit` | `rtk test ./vendor/bin/phpunit` | PHPUnit failures only |
| `./vendor/bin/phpstan` | `rtk err ./vendor/bin/phpstan` | Static analysis errors |

## Docker / Kubernetes

| Instead of | Use | What it does |
|---|---|---|
| `docker ps` | `rtk docker ps` | Compact container list |
| `docker ps -a` | `rtk docker ps` | All containers, compact |
| `docker images` | `rtk docker images` | Compact image list |
| `docker logs <container>` | `rtk docker logs <container>` | Deduplicated logs |
| `docker compose ps` | `rtk docker compose ps` | Compose services |
| `kubectl get pods` | `rtk kubectl pods` | Compact pod list |
| `kubectl logs <pod>` | `rtk kubectl logs <pod>` | Deduplicated pod logs |
| `kubectl get services` | `rtk kubectl services` | Compact services |

## AWS

| Instead of | Use | What it does |
|---|---|---|
| `aws sts get-caller-identity` | `rtk aws sts get-caller-identity` | One-line identity |
| `aws ec2 describe-instances` | `rtk aws ec2 describe-instances` | Compact instances |
| `aws lambda list-functions` | `rtk aws lambda list-functions` | Name/runtime/memory |
| `aws logs get-log-events ...` | `rtk aws logs get-log-events ...` | Messages only |
| `aws cloudformation describe-stack-events` | `rtk aws cloudformation describe-stack-events` | Failures first |
| `aws dynamodb scan ...` | `rtk aws dynamodb scan ...` | Unwraps type annotations |
| `aws iam list-roles` | `rtk aws iam list-roles` | Strips policy documents |
| `aws s3 ls` | `rtk aws s3 ls` | Truncated with tee |

## Data & Network

| Instead of | Use | What it does |
|---|---|---|
| `curl <url>` | `rtk curl <url>` | JSON schema auto-detect |
| `wget <url>` | `rtk wget <url>` | Download, strips progress |
| `cat file.json` | `rtk json file.json` | Structure without values |
| `env` | `rtk env -f PREFIX` | Filtered env vars |
| `cat app.log` | `rtk log app.log` | Deduplicated log lines |

## Token Analytics

| Command | What it does |
|---|---|
| `rtk gain` | Session savings summary |
| `rtk gain --graph` | ASCII graph (last 30 days) |
| `rtk gain --history` | Recent command history |
| `rtk gain --daily` | Day-by-day breakdown |
| `rtk gain --all --format json` | JSON export for dashboards |
| `rtk discover` | Find missed savings opportunities |
| `rtk discover --all --since 7` | All projects, last 7 days |
| `rtk session` | RTK adoption across sessions |

## Passthrough / Utility

| Command | What it does |
|---|---|
| `rtk summary <cmd>` | Heuristic summary of any command output |
| `rtk proxy <cmd>` | Raw passthrough + token tracking |
| `rtk smart file.rs` | 2-line heuristic code summary |
| `rtk deps` | Dependencies summary |

## Global Flags

| Flag | Effect |
|---|---|
| `-u` / `--ultra-compact` | ASCII icons, inline format (extra savings) |
| `-v` / `-vv` / `-vvv` | Increase verbosity |

