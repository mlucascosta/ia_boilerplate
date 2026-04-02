# Risk Register

| Risk | Impact | Probability | Mitigation | Trigger | Owner |
|---|---|---:|---|---|---|
| Context drift between chat and repo artifacts | High | Medium | Keep STATE, plans, and summaries updated after each slice | Repeated re-explanations or conflicting guidance | Project owner |
| Architectural drift during local execution | High | Medium | Require ADR or governance update for structural changes | Cross-module change appears inside local task | Project owner |
| Excessive token consumption | Medium | High | Use narrow scope, context map, and summary rotation | Long chats, repeated file loading, broad prompts | Project owner |
| AI-generated code accepted without validation | High | Medium | Apply validation proportional to risk | Critical change merged without tests or checks | Project owner |
| Rule duplication across docs | Medium | Medium | Keep canonical rules in WORKFLOW and short reminders elsewhere | Same policy appears in multiple files with divergence | Project owner |
| Overly large task slices | High | High | Break work into smaller plans and enforce one-slice-at-a-time delivery | Tasks span multiple modules or many decisions | Project owner |
| Dependency or tool lock-in | Medium | Medium | Keep adapters thin and canonical rules runtime-agnostic | Workflow depends on one vendor-specific feature | Project owner |
| Stale summaries or plans | Medium | Medium | Refresh summaries and close outdated plans | Summary no longer matches current code or state | Project owner |
