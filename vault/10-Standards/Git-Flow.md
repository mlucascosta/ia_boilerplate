---
tags: [standards, git, git-flow]
---

# Git Flow

Git Flow is **mandatory** for this project. All AI agents must follow it.

## Branch Model

```
main (or master)        ← production-stable only
  ↑
develop                 ← integration branch, base for all features
  ↑
feature/*               ← individual feature branches
release/*               ← stabilization before merge to main
hotfix/*                ← urgent production fixes, branch from main
```

## Rules

1. **Never work directly on `main`** — it is release state only
2. **All feature work starts from `develop`** — `git checkout -b feature/my-feature develop`
3. **Merge feature branches back into `develop`** — never directly to `main`
4. **`release/*` branches** stabilize before merging to both `main` and `develop`
5. **`hotfix/*` branches** fix production bugs — branch from `main`, merge to both `main` and `develop`
6. **If `develop` doesn't exist** — create it from `main` before starting feature work

## Workflow via RTK

```sh
# Start a feature
rtk git checkout develop
rtk git pull
rtk git checkout -b feature/my-feature

# During work
rtk git add .
rtk git commit -m "feat: add user authentication"

# Finish feature
rtk git checkout develop
rtk git merge feature/my-feature
rtk git push

# Create a release
rtk git checkout -b release/1.2.0 develop
# ... stabilize, update version ...
rtk git checkout main
rtk git merge release/1.2.0
rtk git tag v1.2.0
rtk git checkout develop
rtk git merge release/1.2.0
```

## Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add OAuth2 login
fix: correct null check in UserService
chore: update dependencies
docs: update README installation steps
refactor: extract payment gateway interface
test: add integration tests for order flow
```

## Branch Naming

```
feature/user-authentication
feature/payment-gateway-stripe
fix/order-null-pointer
release/2.1.0
hotfix/critical-session-bug
```
