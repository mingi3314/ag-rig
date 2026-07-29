---
name: pr-loop
description: Drive one selected PR unit from `handoff.md` through Graphite branch activation, delegated implementation, checks, and independent diff review until it is ready for submission. Use when a single stacked PR lane is active and Codex should orchestrate that lane end-to-end without collapsing implementer and reviewer work into the parent agent.
---

# PR Loop

Read these before substantial work:

- [workflow.md](../workflow-orchestrator/references/workflow.md)
- [work-packet.md](references/work-packet.md)
- [operations.md](../graphite-cli/references/operations.md)

## Core loop

1. Read the selected PR entry from `handoff.md`.
2. If feasibility is still unclear, stop and run or refresh a short spike before opening the branch lane.
3. Confirm the contract is stable enough to deserve a branch lane.
4. Re-anchor delegated orchestration mode with the current role, active lane, allowed next actions, and disallowed actions.
5. If the runtime cannot support fresh implementer and reviewer subagents for this lane, stop and record the exact blocker instead of collapsing the roles into the parent agent.
6. Use Graphite to inspect stack state and create or switch to the correct branch.
7. Refresh the implementer brief with current repo facts before delegating.
8. Spawn a fresh implementer worker for product-code edits and checks.
9. For non-trivial, ambiguous, order-sensitive, or risk-flagged work, require a short implementer readback before editing.
10. Have the implementer make the change, run the required checks using the smallest credible scope first, and return the evidence and commit hash.
11. Spawn a fresh independent reviewer worker for the resulting diff and use the whole-PR diff on the first pass.
12. Have the reviewer use the local `$code-review` finding-first contract when available and require its verdict before readiness.
13. Fix `blocking` findings and either fix or explicitly defer `should-fix` findings by sending the lane back through the implementer.
14. After follow-up edits, prefer delta review unless the PR contract changed materially.
15. Run extra targeted audit only when the PR contract or risk flags justify more than checks plus review.
16. Mark the PR `ready_for_submit` or record the exact blocker in `handoff.md`.

## Keep it simple

- Use fresh implementer and reviewer agents by default.
- Keep runtime agent bookkeeping out of durable workflow files.
- Treat formatter, lint, type-check, and test commands as the default evaluation plane.
- Do not add a separate QA or evaluator loop unless the PR carries a concrete risk that those checks and review do not credibly cover.
- Make sure the packet links the contract's `acceptance criteria` to the expected `checks / evidence`.
- Prefer concrete file paths, git refs, commands, and observed repo facts over vague summaries.
- While acting as the lane orchestrator, the parent agent does not directly edit product code or write the reviewer verdict itself.
- Do not declare `ready_for_submit` until the implementer evidence, reviewer verdict, and any required targeted audit all exist and still match the current diff.

## Required outputs

- The Graphite command used to create or activate the branch, or the exact preflight blocker.
- The implementer readback summary when one was required.
- The worker-run check summary and result.
- The reviewer verdict, including any unresolved `blocking` or `should-fix` items.
- Any targeted audit that was required, or an explicit note that default checks and review were sufficient.
- The `handoff.md` status change or blocker.
- The commit hash when a commit was created.
