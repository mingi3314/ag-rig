# Legacy Code

Use this reference when the target area is poorly tested, tightly coupled, hard to instantiate, or relies on implicit side effects.

## Strategy

1. Characterize current behavior through the narrowest stable public boundary available.
2. Add tests around the behavior that the planned refactor could break.
3. Make the smallest structure change that improves the next step.
4. Re-run the characterization tests.
5. Repeat only while the scope remains bounded.

## Characterization Tests

- Capture current observable behavior, even if the behavior looks odd.
- Avoid encoding assumptions that are not visible from the current system behavior.
- Prefer real domain inputs and outputs over deep mocks.
- Mock only slow, nondeterministic, or external dependencies.
- Name tests after the behavior being preserved, not after the implementation detail.

If current behavior appears buggy, do not fix it during refactoring. Note the suspected bug separately.

## Creating Seams

When code is hard to test:

- Extract a pure calculation from orchestration code.
- Introduce a small wrapper around time, randomness, network, filesystem, or provider clients.
- Split command side effects from query/calculation logic.
- Pass dependencies explicitly only when it reduces coupling and matches local style.
- Avoid large dependency-injection rewrites unless the codebase already uses that pattern.

## Large Functions

For long functions:

- First split by named behavior blocks using extract-function.
- Preserve statement order when side effects, mutation, or early returns are involved.
- Keep names domain-specific.
- Leave simple readable statements inline when extraction would only create a thin wrapper.
- Do not introduce generic helpers until duplication or responsibility boundaries are clear.

## When to Reduce Scope

Reduce scope or ask the user before continuing when:

- No practical test boundary can be established.
- The refactor requires changing public contracts or database schema.
- The required tests are larger than the requested cleanup.
- Understanding the behavior requires domain decisions the code does not reveal.
