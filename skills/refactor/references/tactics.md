# Refactoring Tactics

Use these tactics after selecting a bounded target and checking test coverage.

## Common Moves

| Target | Useful move | Watch for |
| --- | --- | --- |
| Long function | Extract Function | Preserve side-effect order, early returns, and mutation semantics. Do not extract thin wrappers from already-readable code. |
| Unclear names | Rename, Extract Function, or split responsibility | Read call sites before renaming. A hard-to-name symbol may be mixing responsibilities rather than needing a longer name. |
| Duplicate logic | Extract Function or shared domain helper | Avoid premature abstraction when duplicated code is likely to diverge. |
| Mixed responsibilities | Extract Class, Extract Module, or Move Function | Keep public API and dependency direction stable. |
| Large parameter lists | Introduce Parameter Object | Use only when values travel together as a real concept. |
| Complex conditionals | Extract Predicate, Guard Clauses, or Lookup Table | Preserve short-circuit behavior and evaluation order. |
| Data clumps | Introduce Value Object or local struct | Avoid schema or serialization changes unless explicitly approved. |
| Feature envy | Move Function | Verify call sites and access boundaries. |
| Dead code | Remove Dead Code | Confirm it is unreachable and not used by reflection, config, dynamic imports, or external entrypoints. |
| Hard-to-test orchestration | Separate Query from Command | Keep side effects explicit and behavior unchanged. |

## Selection Heuristics

- Prefer the smallest move that makes the next change easier.
- Prefer domain names over generic technical names.
- Reduce the next reader's inference cost: make responsibility, side effects, invariants, and abstraction level easier to predict from local context.
- Improve locality: related behavior should be easy to read together.
- Reduce coupling only where it blocks comprehension, testing, or change.
- Keep error handling and logging semantics stable unless the user approves a behavior change.

## Reader Empathy Check

Use this check before accepting a refactor:

- Can a reader predict this symbol's responsibility from its name?
- Can a reader tell whether this function mutates state, performs I/O, or only computes a value?
- Does the caller read at the right abstraction level, without mixing orchestration, policy, and low-level mechanics unnecessarily?
- Did the refactor reduce unnecessary navigation, or did it split readable code into helpers that force extra jumps?
- Are domain rules, invariants, exceptional cases, and intentional oddities easier to see?
- Does the code follow local naming and structure conventions that readers of this codebase already know?
- Would a reviewer understand why this improves maintainability from the diff itself?

## Naming and Responsibility

Use renaming to clarify responsibility, not to decorate implementation.

Good names should help readers predict:

- The concept the code represents.
- The action a function performs.
- Whether a function has side effects.
- The scope and abstraction level of the symbol.
- Which responsibility belongs here and which does not.

Before renaming:

- Read call sites and tests, not only the definition.
- Check whether the name is part of a public API, data contract, CLI/UI surface, event name, config key, reflection hook, dynamic import, or external integration.
- Preserve compatibility unless the user approves a contract change.

Prefer:

- Function names that expose the action and meaningful side effects.
- Class and module names that represent a concept or responsibility, not only what they own or coordinate.
- Domain names over generic names such as `Manager`, `Handler`, `Service`, `Util`, `Data`, or `Info` when a clearer concept exists.

If a name is hard to choose:

- Look for mixed responsibilities.
- Consider extracting a function, moving behavior, or splitting a class or module before forcing a longer name.
- Keep code inline when the proposed name merely restates an already obvious implementation.

## Function Extraction

Extract a function when at least one of these is true:

- It removes meaningful duplication.
- It gives a clear name to a non-obvious domain rule, policy, or calculation.
- It hides enough implementation detail that the caller becomes easier to read.
- It separates orchestration from pure calculation or side effects.
- It creates a practical test seam for behavior that needs protection.
- It matches an established local pattern for organizing the same kind of logic.

Keep code inline when:

- The extracted function would be a thin wrapper around one obvious expression or method call.
- The helper name merely restates the implementation, such as wrapping `foo.bar()` as `getFooBar(foo)`.
- The reader would need to jump to another function to understand code that was already clear in place.
- The extraction reduces line count but not cognitive load.
- The helper would be used once and does not name a real domain concept or isolate meaningful complexity.

Thin wrappers can still be worthwhile at system boundaries, such as adapters around time, randomness, network, filesystem, provider clients, or framework APIs. In those cases, the wrapper should express a boundary or policy, not just hide a single call.

## Avoid

- Large rewrites that replace understandable local complexity with unfamiliar architecture.
- New generic frameworks, base classes, or registries without repeated evidence.
- Refactors that require unrelated formatting churn.
- Changing tests to fit the new implementation while losing behavior assertions.
- Removing "weird" branches without proving they are unreachable.
- Splitting readable code into one-off helpers that only increase indirection.
