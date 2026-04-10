<!-- ADAPTER FILE -->
<!-- Canonical source: .agents/AGENTS.md -->
<!-- Governance extension: .agents/governance/ -->
<!-- Do not add normative rules here -->

# RTK — Token-Optimized CLI

**rtk** is a CLI proxy that filters and compresses command outputs, saving 60-90% tokens.

## Rule

Always prefix shell commands with `rtk`:

```bash
# Instead of:              Use:
git status                 rtk git status
git log -10                rtk git log -10
cargo test                 rtk cargo test
docker ps                  rtk docker ps
kubectl get pods           rtk kubectl pods
```

## Meta commands (use directly)

```bash
rtk gain              # Token savings dashboard
rtk gain --history    # Per-command savings history
rtk discover          # Find missed rtk opportunities
rtk proxy <cmd>       # Run raw (no filtering) but track usage
```

## Architecture and Governance

In addition to RTK usage, follow the repository governance rules:

- `.agents/AGENTS.md` — canonical agent contract
- `.agents/governance/RULES.md` — audit behavior, confidence, severity, and merge impact rules
- `.agents/governance/SKILLS.md` — architectural audit skills
- `.agents/governance/CHECKLIST.md` — review checklist

Key expectations:

- Domain must not depend on infrastructure
- Prefer TDD for behavior changes
- Respect the workflow and artifact contracts in `docs/ai/`
- Treat `.agents/` as the only normative AI layer
- Use governance files when reviewing architecture, tests, and pull request quality
- RTK remains mandatory for all shell guidance
