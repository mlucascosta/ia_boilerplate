# Testing and Delivery Governance
## Engineering Quality Model for `ia_boilerplate`

## 1. Purpose

This document defines the engineering governance model that the repository must enforce across planning, implementation, validation, review, and release workflows.

It formalizes the mandatory quality standards that apply to all work executed through the centralized `.agents/` architecture.

This document covers:

- TDD as the default implementation model
- tests-first execution order
- unit, integration, and E2E testing policy
- SOLID-oriented implementation rules
- hybrid Agile + PMBOK governance
- Git Flow policy
- verification levels
- review expectations
- examples of compliant and non-compliant execution

This document is normative.

---

## 2. Governing Principle

The repository follows a strict engineering principle:

> Behavioral changes must begin with tests, evolve through minimal implementation, preserve SOLID-oriented structure, and be validated with unit, integration, and E2E tests in proportion to delivery risk.

This rule is not optional. It is the default delivery contract.

---

## 3. Engineering Governance Model

The repository enforces a hybrid governance model:

- **Agile** governs incremental execution, slicing, iteration, and fast feedback
- **PMBOK-style governance** governs scope, traceability, milestones, risk, documentation, and control
- **Git Flow** governs branching and integration
- **TDD + layered testing** govern implementation quality
- **SOLID** governs code structure

This means the repository does not treat software delivery as only a coding process. It treats it as a managed engineering system.

---

## 4. TDD Is Mandatory by Default

## 4.1 Rule

For any behavioral change, the implementation sequence must begin with a failing test.

Default sequence:

1. define expected behavior
2. write the test first
3. run the test and observe failure
4. implement the smallest valid solution
5. refactor while preserving green state
6. validate the required test layers
7. update durable artifacts if needed

## 4.2 What counts as a behavioral change

A behavioral change includes, but is not limited to:

- new features
- bug fixes
- refactors that alter externally visible behavior
- workflow rule changes
- runtime adapter behavior changes
- planning or verification logic changes
- API contract changes
- orchestration changes
- business rule changes

## 4.3 Exceptions

The default tests-first rule may be relaxed only for:

- pure documentation edits
- metadata-only changes
- formatting-only changes
- strictly non-behavioral renames
- trivial repository maintenance with zero behavioral effect

Even in these cases, the change must still be reviewed for whether it truly qualifies as non-behavioral.

---

## 5. Tests First, Then Real Code

## 5.1 Rule

Tests are written before production classes, functions, modules, services, handlers, adapters, or orchestration logic whenever behavior is changing.

This rule applies to:

- application code
- infrastructure glue code
- planner logic
- runtime shims where behavior exists
- repository automation where behavior exists
- agent orchestration logic

## 5.2 Forbidden default

The following is not acceptable as the default path:

```text
Implement behavior first → add tests later
```

## 5.3 Required default

The required path is:

```text
Define expected behavior → write failing test → implement minimal code → refactor → validate required layers
```

---

## 6. Layered Testing Policy

The repository uses a layered testing model based on risk.

The three mandatory layers are:

* unit tests
* integration tests
* E2E tests

Not every change requires every layer, but every behavioral change requires the correct layers for its risk profile.

---

## 7. Unit Testing Policy

## 7.1 Purpose

Unit tests validate isolated behavior.

They are used for:

* pure functions
* validators
* mappers
* policies
* use cases
* domain services
* error formatting logic
* planning utilities
* diff minimization logic
* selection logic
* transformation rules

## 7.2 Expectations

Unit tests should be:

* fast
* deterministic
* isolated
* readable
* directly tied to behavior

## 7.3 Example

Example unit test target:

* a `PathSelector` deciding whether work is Trivial, Focused, or Full
* a `VerificationLevelResolver`
* a `BranchPolicyValidator`
* a `PlanFormatter`

### Example

```ts
describe("VerificationLevelResolver", () => {
  it("returns V3 for auth-related workflow changes", () => {
    const result = resolveVerificationLevel({
      touchesAuth: true,
      touchesPersistence: true,
      affectsUserFlow: true
    });

    expect(result).toBe("V3");
  });
});
```

---

## 8. Integration Testing Policy

## 8.1 Purpose

Integration tests validate interactions between modules, services, adapters, and infrastructure boundaries.

They are used when the behavior depends on more than one component working together.

## 8.2 Typical targets

* repository + database
* service + queue
* use case + repository
* API route + service + persistence
* runtime shim generator + manifest loader
* artifact writer + planning service
* validation script + filesystem state

## 8.3 Example scenarios

* generating runtime wrappers from manifest
* persisting plan artifacts after plan-phase execution
* validating branch policy before opening PR automation
* running a planning flow that reads active state and writes a plan file

### Example

```ts
describe("runtime shim generation", () => {
  it("creates minimal Claude, Codex, and Copilot shims from the manifest", async () => {
    const result = await generateRuntimeShims({
      manifestPath: ".agents/manifest.json"
    });

    expect(result.generated).toContain(".claude/CLAUDE.md");
    expect(result.generated).toContain(".github/copilot-instructions.md");
    expect(result.generated).toContain(".codex/skills/project-workflow/SKILL.md");
  });
});
```

---

## 9. E2E Testing Policy

## 9.1 Purpose

E2E tests validate complete user-visible or workflow-visible flows.

They must be used when the risk extends beyond isolated logic or infrastructure interactions.

## 9.2 Typical targets

* auth flows
* tenant flows
* billing flows
* release workflows
* branch and PR lifecycle automation
* plan → execute → verify workflow
* runtime compatibility behavior in realistic conditions

## 9.3 Example scenarios

* creating a feature branch from `develop`, planning work, implementing work, and validating branch policy
* completing a full `discuss → plan → execute → verify` flow using real planning artifacts
* validating a real end-user application flow in the product code

### Example

```text
Given the repository is on develop
When a feature branch is created
And plan-phase produces a test-first implementation plan
And execute-phase runs the work
Then verification confirms:
- tests existed first
- branch naming is valid
- output artifacts are written
- the feature can merge back into develop
```

---

## 10. Risk-Proportional Test Coverage

## 10.1 Rule

The required validation depth depends on delivery risk.

## 10.2 Suggested guidance

### Low risk

Examples:

* isolated helper logic
* local transformation logic
* non-structural pure functions

Expected:

* unit tests
* possibly `V1`

### Medium risk

Examples:

* service logic with persistence
* artifact writing
* branching automation logic
* runtime generation logic

Expected:

* unit + integration
* usually `V2`

### High risk

Examples:

* authentication
* permissions
* billing
* queue orchestration
* release flow
* user-visible critical flows
* repository workflow engine changes

Expected:

* unit + integration + E2E
* usually `V3`

---

## 11. SOLID Is Mandatory

## 11.1 Rule

All real implementation must be guided by SOLID-oriented design.

This includes:

* single responsibility
* extension without fragile rewrites
* substitutable abstractions
* explicit interface boundaries where appropriate
* dependency inversion between core logic and infrastructure

## 11.2 Repository-specific implications

This applies to:

* workflow engines
* planners
* verifiers
* artifact writers
* runtime shim generators
* CI validation utilities
* application code in downstream use

## 11.3 Example of non-compliant structure

```ts
class ExecutePhaseHandler {
  async run() {
    // read files
    // select path
    // create tests
    // write code
    // generate docs
    // validate branch naming
    // commit changes
    // create release notes
  }
}
```

This is structurally overloaded.

## 11.4 Better structure

```ts
class ExecutePhaseHandler {
  constructor(
    private readonly planReader: PlanReader,
    private readonly implementationRunner: ImplementationRunner,
    private readonly verificationRunner: VerificationRunner
  ) {}

  async run() {
    const plan = await this.planReader.read();
    await this.implementationRunner.execute(plan);
    await this.verificationRunner.verify(plan);
  }
}
```

Each specialized service should then own its own smaller responsibility.

---

## 12. Hybrid Agile + PMBOK Governance

## 12.1 Agile responsibilities

Agile governs:

* slicing work
* incremental delivery
* adapting to feedback
* reducing batch size
* short planning cycles
* feature-focused iteration

## 12.2 PMBOK-style governance responsibilities

PMBOK-style governance governs:

* scope boundaries
* risk visibility
* dependency visibility
* milestone structure
* durable documentation
* traceability
* execution discipline at project scale

## 12.3 Separation rule

Execution artifacts and governance artifacts must not be mixed carelessly.

### Governance examples

* roadmap
* milestone documents
* ADRs
* release planning
* risk tracking
* scope boundaries

### Execution examples

* state
* active plans
* summaries
* verification outputs
* local implementation evidence

The repository must preserve this distinction.

---

## 13. Git Flow Is Mandatory

## 13.1 Main branches

### `main`

Stable release branch. Represents production-grade or releasable state.

### `develop`

Primary integration branch for ongoing development.

All normal feature work must branch from `develop`.

## 13.2 Supporting branches

### `feature/*`

Used for bounded feature work or refactors.

Rules:

* created from `develop`
* merged back into `develop`

### `release/*`

Used for stabilization before release.

Rules:

* created from `develop`
* merged into `main`
* merged back into `develop`

### `hotfix/*`

Used for urgent production fixes.

Rules:

* created from `main`
* merged into `main`
* merged back into `develop`

## 13.3 Prohibitions

The following are not allowed under normal flow:

* feature work directly on `main`
* feature branches created from `main`
* merging features straight into `main`
* failing to merge a `hotfix/*` branch back into `develop`
* treating Git Flow as advisory only

---

## 14. Verification Levels

The repository must use explicit verification levels.

## `V0`

Reasoning only.

Allowed for:

* pure docs
* metadata-only trivial changes
* truly non-behavioral maintenance

## `V1`

One focused validation layer.

Typical:

* unit test
* bounded local check

## `V2`

Multiple validation checks.

Typical:

* unit + integration
* equivalent multi-check proof

## `V3`

Full validation.

Typical:

* unit + integration + E2E
* required for high-risk or critical user-visible workflows

---

## 15. Review Expectations

Reviews must verify more than syntax and correctness.

A valid review should check:

* Was the work test-first?
* Were the right test layers used?
* Was SOLID preserved?
* Was Git Flow respected?
* Was the verification level appropriate?
* Were governance and execution artifacts kept separate?
* Was the implementation proportionate to the stated scope?

---

## 16. Skill-Level Governance Expectations

The centralized skills must encode governance behavior.

## `workflow-core`

Must define:

* TDD default
* layered testing model
* SOLID expectation
* Git Flow
* verification semantics
* hybrid governance distinction

## `plan-phase`

Must define:

* what tests come first
* what layers are required
* what branch expectations apply
* what the risk profile implies

## `execute-phase`

Must enforce:

* tests first
* minimum implementation
* refactor under SOLID
* bounded execution
* no hidden structural drift

## `verify-phase`

Must check:

* tests existed before implementation where behavior changed
* correct validation layers were applied
* branch strategy was respected
* evidence matches risk

## `review`

Must verify:

* architecture
* testing discipline
* branching discipline
* quality of change boundaries

---

## 17. Examples of Compliant and Non-Compliant Work

## 17.1 Compliant

Scenario:
A new `feature/runtime-shim-validation` branch is created from `develop`.

The team:

1. writes failing unit tests for shim validation rules
2. adds integration tests for manifest + generator behavior
3. implements the validator minimally
4. refactors responsibilities into small services
5. runs `V2`
6. opens PR into `develop`

This is compliant.

## 17.2 Non-compliant

Scenario:
A developer edits shim generation logic directly on `main`, implements first, adds tests later, and only performs manual reasoning verification.

This is non-compliant because it breaks:

* Git Flow
* tests-first policy
* proportional validation
* release discipline

---

## 18. Example Engineering Flow

A compliant medium-risk change should look like this:

```text
1. Checkout develop
2. Pull latest changes
3. Create feature/...
4. Write failing unit tests
5. Write integration tests if components interact
6. Implement minimal code
7. Refactor under SOLID
8. Run verification
9. Update artifacts if durable behavior changed
10. Open PR to develop
```

A high-risk change adds E2E validation before merge.

---

## 19. CI and Enforcement

The CI pipeline should support this governance model by enforcing at least:

* test execution
* runtime shim generation validation
* no-drift checks
* branch policy checks where possible
* architecture validation scripts
* failure if required generated files differ from committed versions

Potential checks include:

```bash
npm test
bash .agents/scripts/validate-agents.sh
bash .agents/scripts/generate-runtime-shims.sh
git diff --exit-code
```

Project-specific CI may add:

* branch naming validation
* PR target validation
* release branch validation
* hotfix back-merge validation

---

## 20. Completion Criteria for a Change

A change is considered complete only when:

* the right branch strategy was used
* the right tests were written first
* the right implementation was added
* SOLID boundaries were preserved
* the appropriate verification level was met
* required artifacts were updated
* review confirms policy compliance

Anything less is incomplete.

---

## 21. Final Rule

> The repository does not accept behavior-changing work as complete unless it follows a tests-first path, preserves SOLID structure, uses risk-appropriate layered testing, respects Git Flow, and remains consistent with the hybrid Agile + PMBOK governance model.
