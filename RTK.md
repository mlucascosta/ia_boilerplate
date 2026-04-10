# RTK — Mandatory Token Optimization

RTK (Rust Token Killer) is the mandatory CLI proxy for this project.
All AI agents **must** prefix shell commands with `rtk` to reduce token consumption by 60–90%.

## Why RTK is Required

Raw command output bloats context windows with whitespace, boilerplate, and noise.
RTK filters, groups, truncates, and deduplicates output before the AI sees it.
Result: 60–90% fewer tokens per command, lower costs, faster sessions.

## Installation

Run the project installer which auto-detects your OS:

```sh
./scripts/install-rtk.sh
```

Or install manually — see [INSTALL.md](https://github.com/rtk-ai/rtk/blob/master/INSTALL.md).

After installing, initialize RTK for your AI tool:

```sh
rtk init -g                  # Claude Code (default)
rtk init -g --copilot        # GitHub Copilot (VS Code)
rtk init -g --gemini         # Gemini CLI
rtk init -g --codex          # OpenAI Codex
```

## Mandatory Command Rewrites

Every AI agent in this project MUST use these rewrites — no exceptions.

### Git

| Instead of | Use | What it does |
|---|---|---|
| `git status` | `rtk git status` | Compact status — changed files only, -80% tokens |
| `git diff` | `rtk git diff` | Condensed diff, strips identical context lines |
| `git log` | `rtk git log -n 10` | One-line commits, readable at a glance |
| `git add .` | `rtk git add` | Stages files → outputs `"ok"` |
| `git commit -m "msg"` | `rtk git commit -m "msg"` | Commits → outputs `"ok abc1234"` |
| `git push` | `rtk git push` | Pushes → outputs `"ok main"` |
| `git pull` | `rtk git pull` | Pulls → outputs `"ok 3 files +10 -2"` |
| `git merge branch` | `rtk git merge branch` | Merge with compact output |
| `git checkout -b feat` | `rtk git checkout -b feat` | Branch switch with compact output |

### GitHub CLI

| Instead of | Use | What it does |
|---|---|---|
| `gh pr list` | `rtk gh pr list` | Compact PR listing |
| `gh pr view 42` | `rtk gh pr view 42` | PR details + check status |
| `gh pr create` | `rtk gh pr create` | Create PR with compact output |
| `gh issue list` | `rtk gh issue list` | Compact issue listing |
| `gh issue view 10` | `rtk gh issue view 10` | Issue details |
| `gh run list` | `rtk gh run list` | Workflow run status |
| `gh run view <id>` | `rtk gh run view <id>` | Run details, failures first |

### Filesystem

| Instead of | Use | What it does |
|---|---|---|
| `ls` / `ls -la` | `rtk ls .` | Token-optimized directory tree, -80% tokens |
| `cat file` | `rtk read file` | Smart file reading, strips blank lines and boilerplate |
| `head file` / `tail file` | `rtk read file` | Same as above — use `rtk read` for all file reads |
| `cat file -l aggressive` | `rtk read file -l aggressive` | Signatures only — strips function bodies |
| `grep pattern .` | `rtk grep "pattern" .` | Grouped search results, -80% tokens |
| `rg pattern .` | `rtk grep "pattern" .` | Same — `rtk grep` handles both `grep` and `rg` |
| `find "*.rs" .` | `rtk find "*.rs" .` | Compact find results |
| `diff file1 file2` | `rtk diff file1 file2` | Condensed diff |

### Rust

| Instead of | Use | What it does |
|---|---|---|
| `cargo test` | `rtk cargo test` | Failures only, -90% tokens |
| `cargo build` | `rtk cargo build` | Build output, errors grouped, -80% |
| `cargo clippy` | `rtk cargo clippy` | Lint warnings grouped by file, -80% |
| `cargo check` | `rtk cargo check` | Type-check only, compact errors |
| `cargo run` | `rtk cargo run` | Run with compact output |

### Node.js / TypeScript / JavaScript

| Instead of | Use | What it does |
|---|---|---|
| `npm test` / `npx jest` | `rtk test npm test` | Failures only, -90% tokens |
| `npx vitest run` | `rtk vitest run` | Vitest compact output, failures only |
| `npx tsc` | `rtk tsc` | TypeScript errors grouped by file, -80% |
| `npx eslint .` | `rtk lint` | ESLint grouped by rule and file, -80% |
| `npx biome check .` | `rtk lint biome` | Biome lint compact output |
| `npx prettier --check .` | `rtk prettier --check .` | Files needing formatting |
| `npx playwright test` | `rtk playwright test` | E2E results, failures only |
| `npx next build` | `rtk next build` | Next.js build compact |
| `pnpm list` | `rtk pnpm list` | Compact dependency tree |
| `pnpm outdated` | `rtk pnpm outdated` | Outdated packages only |
| `npx prisma generate` | `rtk prisma generate` | Schema generation, no ASCII art |

### Python

| Instead of | Use | What it does |
|---|---|---|
| `pytest` | `rtk pytest` | Failures only, -90% tokens |
| `python -m pytest` | `rtk pytest` | Same |
| `ruff check .` | `rtk ruff check` | Lint output in JSON, -80% |
| `ruff format --check .` | `rtk ruff format --check .` | Files needing formatting |
| `pip list` | `rtk pip list` | Python packages (auto-detects `uv`) |
| `pip outdated` | `rtk pip outdated` | Outdated packages only |

### Go

| Instead of | Use | What it does |
|---|---|---|
| `go test ./...` | `rtk go test` | Go tests via NDJSON, failures only, -90% |
| `go build ./...` | `rtk go build` | Build errors only |
| `go vet ./...` | `rtk go vet` | Vet output, compact |
| `golangci-lint run` | `rtk golangci-lint run` | Go lint in JSON, -85% |

### Ruby

| Instead of | Use | What it does |
|---|---|---|
| `bundle exec rspec` | `rtk rspec` | RSpec tests in JSON, -60%+ tokens |
| `rake test` / `rails test` | `rtk rake test` | Ruby minitest, compact |
| `rubocop` | `rtk rubocop` | Ruby lint in JSON, -60%+ |
| `bundle install` | `rtk bundle install` | Strips verbose `Using` lines |
| `bundle update` | `rtk bundle update` | Compact update output |

### PHP

| Instead of | Use | What it does |
|---|---|---|
| `./vendor/bin/phpunit` | `rtk test ./vendor/bin/phpunit` | PHPUnit failures only |
| `./vendor/bin/pest` | `rtk test ./vendor/bin/pest` | Pest failures only |
| `./vendor/bin/phpstan` | `rtk err ./vendor/bin/phpstan` | Static analysis errors only |

### Docker / Kubernetes

| Instead of | Use | What it does |
|---|---|---|
| `docker ps` | `rtk docker ps` | Compact container list |
| `docker ps -a` | `rtk docker ps` | All containers, compact |
| `docker images` | `rtk docker images` | Compact image list |
| `docker logs <container>` | `rtk docker logs <container>` | Deduplicated log lines |
| `docker compose ps` | `rtk docker compose ps` | Compose services, compact |
| `kubectl get pods` | `rtk kubectl pods` | Compact pod list |
| `kubectl logs <pod>` | `rtk kubectl logs <pod>` | Deduplicated pod logs |
| `kubectl get services` | `rtk kubectl services` | Compact service list |

### AWS

| Instead of | Use | What it does |
|---|---|---|
| `aws sts get-caller-identity` | `rtk aws sts get-caller-identity` | One-line identity |
| `aws ec2 describe-instances` | `rtk aws ec2 describe-instances` | Compact instance list |
| `aws lambda list-functions` | `rtk aws lambda list-functions` | Name/runtime/memory, strips secrets |
| `aws logs get-log-events ...` | `rtk aws logs get-log-events ...` | Timestamped messages only |
| `aws cloudformation describe-stack-events` | `rtk aws cloudformation describe-stack-events` | Failures first |
| `aws dynamodb scan ...` | `rtk aws dynamodb scan ...` | Unwraps type annotations |
| `aws iam list-roles` | `rtk aws iam list-roles` | Strips policy documents |
| `aws s3 ls` | `rtk aws s3 ls` | Truncated with tee recovery |

### Data & Network

| Instead of | Use | What it does |
|---|---|---|
| `curl <url>` | `rtk curl <url>` | Auto-detects JSON, returns schema |
| `wget <url>` | `rtk wget <url>` | Download, strips progress bars |
| `cat file.json` | `rtk json file.json` | JSON structure without values |
| `env` | `rtk env -f AWS` | Filtered env vars by prefix |
| `cat app.log` | `rtk log app.log` | Deduplicated log lines |

### Token Analytics

| Command | What it does |
|---|---|
| `rtk gain` | Session savings summary |
| `rtk gain --graph` | ASCII graph (last 30 days) |
| `rtk gain --history` | Recent command history |
| `rtk gain --daily` | Day-by-day breakdown |
| `rtk gain --all --format json` | JSON export for dashboards |
| `rtk discover` | Find missed savings opportunities |
| `rtk discover --all --since 7` | All projects, last 7 days |
| `rtk session` | RTK adoption across recent sessions |

### Passthrough / Utility

| Command | What it does |
|---|---|
| `rtk summary <long-cmd>` | Heuristic summary of any command output |
| `rtk proxy <command>` | Raw passthrough + token tracking |
| `rtk smart file.rs` | 2-line heuristic code summary |
| `rtk deps` | Dependencies summary |

## Hard Rules for AI Agents

1. **Never run raw shell commands** that have an `rtk` equivalent.
2. **All git operations** go through `rtk git`.
3. **All file reads** via terminal use `rtk read` or `rtk grep`.
4. **All test runs** use `rtk test <runner>` or `rtk <runner>`.
5. **All builds and lints** use `rtk <tool>`.
6. Commands already using `rtk`, heredocs (`<<`), and shell builtins pass through unchanged.

## Token Analytics

```sh
rtk gain                 # Session savings summary
rtk gain --graph         # ASCII graph (last 30 days)
rtk discover             # Find missed savings opportunities
rtk session              # RTK adoption across recent sessions
```

## Verify Installation

```sh
rtk --version            # e.g. rtk 0.35.0
rtk gain                 # shows token savings stats
```

## Reference

- Repository: https://github.com/rtk-ai/rtk
- Docs: https://www.rtk-ai.app/
- Troubleshooting: https://github.com/rtk-ai/rtk/blob/master/docs/TROUBLESHOOTING.md
