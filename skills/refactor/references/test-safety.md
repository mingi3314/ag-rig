# Test Safety

Use this reference before production-code edits when a selected refactor touches behavior-sensitive logic or when coverage is unclear.

## Coverage Assessment

Existing coverage is sufficient when it:

- Executes the selected code path through a realistic public boundary or stable internal API.
- Asserts the observable behavior or invariant that could be broken by the refactor.
- Covers important branches, edge cases, and error paths affected by the cleanup.
- Can be run locally with a clear project command.

Coverage is not sufficient when tests only check construction, mocks, snapshots without meaningful assertions, broad happy paths that miss the target logic, or implementation details unrelated to the behavior being preserved.

## When to Stop and Ask

Stop before production-code edits and ask for permission to add tests when:

- The refactor touches business rules, state transitions, persistence behavior, external payloads, authorization, financial calculations, retries, idempotency, or concurrency.
- Existing tests do not execute the selected path.
- Existing tests execute the path but do not assert the invariant that could change.
- The only available verification is manual inspection and the code is behavior-sensitive.

It is usually acceptable to continue without a checkpoint for purely mechanical changes where static tooling provides strong protection, such as local renames, import moves, extracting a private helper without changing expressions, or updating tests after a symbol move.

## Proposed Test Types

- Characterization test: capture current behavior before changing structure.
- Behavior test: assert public output, state transition, persisted effect, emitted event, or thrown error.
- Contract test: protect API shape, provider payload fields, event schema, or CLI output.
- Regression-style test: use when an existing known scenario must keep working, without changing the behavior during refactoring.

Prefer assertions on observable results over private helper calls. Use snapshots only when the serialized output is stable, intentional, and reviewed; otherwise assert important fields explicitly.

## High-Risk Behavior Examples

For payments, billing, and accounting, protect:

- Amount calculation, currency handling, rounding, tax, discount, and fee rules.
- Payment, refund, cancellation, dispute, and settlement state transitions.
- Idempotency keys, retry behavior, duplicate request handling, and transaction boundaries.
- External provider request and response mapping.
- Ledger entries, audit logs, reconciliation identifiers, and timestamps when semantically relevant.

For auth and permissions, protect:

- Access checks, role inheritance, tenant boundaries, token/session handling, and failure modes.

For migrations and persistence, protect:

- Read/write compatibility, query filters, default values, ordering, uniqueness assumptions, and backfill behavior.

## Checkpoint Content

When asking for permission, write the user-facing checkpoint in Korean and include:

- Selected refactoring target.
- Behaviors or invariants that need protection.
- Existing tests found.
- Missing scenarios.
- Proposed tests to add.
- Why the refactor should not proceed without that coverage.

Do not ask a vague question such as "Should I add tests?" Make the risk and proposed safety net concrete.
