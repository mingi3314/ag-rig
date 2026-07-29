---
name: refactor
description: Focused behavior-preserving refactoring of a specified codebase area, module, domain, or feature path. Reduce the next reader's inference cost by clarifying names, responsibility boundaries, structure, maintainability, and testability without adding features, fixing bugs, or changing external behavior.
---

# Refactor

## Mission

Refactor the user-specified scope as an independent cleanup task. Preserve external behavior while reducing the next reader's inference cost: names, boundaries, and local structure should help a reader predict responsibility, side effects, scope, and abstraction level before reading every implementation detail.

Preserve public APIs, CLI/UI behavior, data contracts, persistence effects, emitted events, audit/logging expectations, external-provider payloads, and documented business rules.

Do not add features, fix bugs, change schemas, change public contracts, or improve business behavior as part of refactoring. If a bug or product behavior issue is discovered, report it separately unless the user explicitly changes the task.

## Operating Rules

- Stay inside the requested scope. Expand only to necessary call sites, tests, type definitions, or configuration directly affected by the refactor.
- Prefer existing project patterns, naming style, layering, test style, and tooling.
- Make small behavior-preserving changes. Avoid broad rewrites, format-only churn, dependency migrations, or architecture changes not required by the selected cleanup.
- Keep abstractions earned. Add an abstraction only when it removes real complexity, reduces meaningful duplication, or matches a local pattern.
- Treat names as responsibility contracts. A reader should be able to infer a symbol's responsibility, role, scope, and abstraction level from its name before reading the implementation.
- Prefer names that clarify responsibility boundaries over names that are merely longer. If no accurate concise name exists, treat that as a signal of mixed responsibilities and consider extraction or separation.
- Make extracted functions earn their names. Do not turn readable inline code into thin pass-through wrappers that add navigation without reducing reader inference cost.
- Treat high-risk behavior with extra care: payments, billing, accounting, authorization, authentication, security, data migrations, concurrency, idempotency, external integrations, and audit trails.
- Preserve suspicious existing behavior during refactoring. Do not "correct" it unless the user explicitly approves a separate behavior change.

## Workflow

1. Map the scope.
   - Inspect the target code, call sites, tests, public contracts, side effects, and local conventions.
   - Before renaming, read the definition, callers, tests, docs, and any external surface that may depend on the name.
   - Identify behavior invariants that must not change. For behavior-sensitive or high-risk areas, read `references/test-safety.md`.

2. Select refactoring targets.
   - Choose targets that reduce change cost: duplicated logic, long functions, unclear names, mixed responsibilities, tangled conditionals, excessive coupling, or hard-to-test structure.
   - Treat unclear names as possible evidence of unclear responsibility boundaries, not only as local rename opportunities.
   - Record the concrete reason each target matters. Do not refactor code only because it looks different from personal preference.
   - Use `references/tactics.md` when choosing specific transformations.

3. Check test coverage before editing production code.
   - Inspect whether existing tests cover the selected targets and the behavior invariants.
   - If coverage is sufficient, run the relevant tests first to establish a baseline.
   - If coverage is insufficient for behavior-sensitive logic, stop before production-code edits and ask the user for permission to add tests. The user-facing checkpoint must be written in Korean using the format in "Human Checkpoint". Report the target, protected behaviors, tests found, missing tests, and proposed tests.
   - Do not add missing behavioral tests without user confirmation when the user asked for refactoring only.
   - Existing test maintenance caused by the refactor, such as import updates or renamed helper references, does not require a separate checkpoint.

3a. Optional test addition checkpoint.
   - Prefer characterization or behavior tests that capture current observable behavior.
   - Run the new tests before refactoring. They should pass against the current implementation unless they intentionally expose an already-known bug; do not proceed with a failing baseline without explaining it.
   - For legacy or poorly tested code, read `references/legacy-code.md`.

4. Refactor in small steps.
   - Apply one coherent transformation at a time.
   - Before extracting a function, confirm that the extraction reduces duplication, names a meaningful domain concept, hides real complexity, isolates side effects, or creates a needed test seam. Otherwise, keep the code inline.
   - After renaming, extraction, movement, or decomposition, read the caller again and confirm it communicates the right abstraction level without hiding important side effects or invariants.
   - Run focused tests after risky steps when practical.
   - Keep production changes limited to structure, naming, decomposition, movement, duplication removal, dependency direction, and testability improvements.

5. Verify.
   - Re-run the baseline tests and any newly added tests.
   - Run typecheck, lint, build, or smoke tests when the repository has clear commands and the refactor risk justifies them.
   - If verification cannot be run, state exactly what was not run and why.

6. Report.
   - Summarize the refactoring targets and structural changes.
   - Note any tests added after user approval.
   - List verification commands and outcomes.
   - Call out residual risks, unverified behavior, or follow-up refactoring candidates.

## Human Checkpoint

Use this Korean format when the selected refactor needs missing behavior tests. Do not replace it with an English summary, even when the surrounding conversation or task prompt is in English:

```text
다음 리팩토링 대상을 확인했습니다:
- <대상>

보호해야 할 동작 또는 invariant:
- <관찰 가능한 동작 또는 invariant>

현재 확인한 테스트:
- <테스트 파일 또는 케이스>

부족한 테스트 커버리지:
- <누락된 시나리오>

리팩토링 전에 추가가 필요한 테스트:
- <테스트 이름 또는 시나리오>

현재 테스트만으로는 이 리팩토링의 동작 보존을 충분히 검증하기 어렵습니다.
위 테스트를 먼저 추가한 뒤 리팩토링을 계속 진행해도 될까요?
```

## References

- Read `references/test-safety.md` for coverage assessment, high-risk behavior, and the human checkpoint criteria.
- Read `references/legacy-code.md` when the target is poorly tested, tightly coupled, or difficult to characterize.
- Read `references/tactics.md` when selecting concrete refactoring moves.
