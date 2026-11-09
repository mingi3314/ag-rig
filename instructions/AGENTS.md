# Engineering Principles

These are default engineering preferences across projects. Apply them in the context of specific requirements and project-specific instructions and constraints. Do not turn decisions made for individual cases into universal prohibitions.

## Weigh the benefits and costs of added structure

When adding abstractions, layers, configuration, or state, consider both the problem they solve and the cost of understanding, changing, and maintaining them.
For solutions that meet the same requirements, prefer the structure that is easier to understand and change.
Do not add structure solely for anticipated future requirements.

## Design for the required guarantees

Introduce locks, retries, and duplicate prevention in proportion to the impact of the failures they prevent.
Use explicitly accepted tolerances or existing fallback paths where applicable, without arbitrarily weakening required guarantees such as data consistency and authorization.

## Base compatibility decisions on actual usage and dependencies

When changing a contract, check its deployment status, consumers, and persisted data to determine what must be preserved.
Avoid preserving unused contracts without a concrete need, and consider a transition path when changing contracts that are in use.

## Keep responsibilities cohesive and limit what callers need to know

Organize related policies and state transitions so they can be understood together, and make it clear where to change a policy.
Reconsider boundaries when callers must know hidden implementation state or a special calling sequence.
Use separation and abstraction when they clarify responsibilities and dependencies.

## Make interfaces and names reflect their purpose and behavior

Add fields, methods, and endpoints based on consumer needs and responsibilities.
Limit redundant information and unnecessary public surface area, and use names that make responsibilities and important side effects predictable.
Keep comments focused on the code's own responsibilities, explaining policies and reasons that are not apparent from the code.

## Evaluate tests by the value of the behavior they protect

Write tests that fail meaningfully when important behavior breaks, weighing the value of that protection against the cost of maintaining the tests.
Prefer testing public behavior and observable outcomes. Do not expand production interfaces solely for testing convenience.
Keep the key conditions and execution flow visible in the test.
Match the scope and repetition of verification to the risk of the change and the uncertainty that remains.

## Keep each change focused on a clear purpose

Do not mix in formatting, comment edits, or refactoring unrelated to the change's purpose.
Include structural changes that are needed, but separate improvements that can be evaluated independently.
Preserve the intent of existing user edits.

## Write for readers who were not part of the conversation

Explain the problem, the resulting behavior, and the reasoning needed to evaluate the change.
Leave out private work history and explanations that merely repeat the implementation, but retain important assumptions and evidence even when aiming for brevity.
Provide enough detail in design comparisons for the reader to evaluate the choices.
