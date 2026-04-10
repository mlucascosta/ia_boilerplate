---
tags: [skills, review, workflow]
---

# Review

The review skill checks changes for correctness, risk, and architectural adherence before merging.

## Checklist

### Correctness
- [ ] Logic matches the stated requirement
- [ ] Edge cases are handled (null, empty, overflow, auth failure)
- [ ] No hardcoded secrets, credentials, or environment values

### Tests
- [ ] Behavioral tests exist for changed code
- [ ] Tests are meaningful (not just asserting `true`)
- [ ] Coverage proportional to delivery risk

### SOLID
- [ ] Each class/module has one reason to change
- [ ] Interfaces are narrow and injected
- [ ] No implementation hiding behind fat interfaces

### Security (OWASP Top 10)
- [ ] Input validated at system boundaries
- [ ] No SQL injection vectors (use parameterized queries)
- [ ] No XSS vectors in rendered output
- [ ] Auth/authz checks present where required
- [ ] Sensitive data not logged

### RTK Compliance
- [ ] No raw shell commands in AI session logs
- [ ] All rtk commands used in documented tooling

### Git
- [ ] Branch follows Git Flow conventions
- [ ] Commit messages follow Conventional Commits
- [ ] No force-pushes on shared branches

## Verdict

| Result | Action |
|---|---|
| PASS | Approve for merge |
| FLAG | Merge with noted items to address in follow-up |
| BLOCK | Do not merge — critical issues found |
