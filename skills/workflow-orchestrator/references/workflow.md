# Stacked PR Workflow

This file is the canonical policy for a contract-driven stacked PR workflow. Use `skills/graphite-cli/references/operations.md` for Graphite command details and `skills/pr-loop/references/work-packet.md` for packet design details.

## Principles

- `PR` is the delivery unit and the default execution unit.
- Start from the simplest loop that can safely ship the work.
- Keep `./scratchpad/handoff.md` as the only durable workflow artifact.
- Keep one active PR lane at a time unless independence is obvious.
- Add extra artifacts, review passes, or orchestration only when they clearly reduce ambiguity or risk.
- Brief subagents with the minimum sufficient context for their role. Leave out background that does not affect this pass, but include every fact that could change edits, validation, review depth, or escalation.
- The parent orchestrator owns workflow state and the work contract.
- The implementer owns the code-level plan and runs the required checks.
- The reviewer stays independent and read-only.
- Treat tests, type-checks, lint, and other executable checks as the default evaluation plane.
- Add extra audit passes only when a PR carries a concrete risk that the default checks and review do not credibly cover.
- Use Graphite as the source of truth for stack topology and submission.

## Delegated orchestration mode

When `$workflow-orchestrator` is active, keep the parent agent in delegated orchestration mode for the rest of the session unless the user explicitly changes modes or the workflow ends.

Parent-agent responsibilities:

- own `handoff.md`, workflow state, and lane selection
- verify branch, Graphite, GitHub, and check state before status transitions
- create or refresh subagent briefs from the selected PR contract plus fresh repo facts
- decide whether work returns to implementation, review, targeted audit, publish, or blocked state
- update PR metadata and publish state after the required gates pass

Parent-agent hard gates:

- do not directly edit product code while acting as the orchestrator; only workflow artifacts such as `handoff.md` and PR metadata may be edited directly
- do not generate the reviewer verdict in the parent agent; obtain it from an independent reviewer worker
- do not mark a lane `ready_for_submit` without a reviewer verdict and the required check evidence
- do not silently collapse implementer or reviewer work back into the parent agent because it feels faster

Before each major step, re-anchor with a short checkpoint that names:

- `Current role`
- `Active lane`
- `Allowed next actions`
- `Disallowed actions`

## Core loop

1. Align on scope, constraints, and the intended PR shape.
2. If feasibility is still unclear, run a short spike before opening a branch lane and record only the conclusion that affects execution.
3. Run `$handoff-pack` to create or refresh `./scratchpad/handoff.md`.
4. Select the active PR unit from `handoff.md`.
5. Run `$pr-loop` until that PR is `ready_for_submit` or blocked.
6. Run `$stack-lane-publish` for the active `ready_for_submit` PR.
7. Move to the next PR unit and repeat.

## Status model

Use this vocabulary in `handoff.md`:

- `pending`: planned but not started
- `in_progress`: active implementation or fix cycle
- `blocked`: waiting on a concrete unblocker
- `ready_for_submit`: implementation, checks, and review are complete
- `submitted`: published as a PR
- `completed`: merged, closed, or intentionally finished

## Handoff contract

`handoff.md` should stay concise and durable across sessions. By default it should capture:

- overall goal
- stable constraints
- reviewer-friendly PR units
- current focus and blocker state

Default PR-unit fields:

- `branch`
- `status`
- `why`
- `goal`
- `scope`
- `acceptance criteria`
- `invariants`
- `checks / evidence`

Add optional fields only when they reduce ambiguity:

- `risk flags`
- `non-goals`
- `must-read context`
- `stop / escalate if`
- `notes`

If a tradeoff is likely to be reopened later, add a short decision note. Do not turn `handoff.md` into a transcript, packet dump, or runtime agent ledger.

## Delegation

- Brief subagents from the selected PR entry plus fresh repo facts.
- Optimize briefs for relevance and sufficiency, not maximum background or the smallest possible packet.
- If leaving out a fact could cause the worker to choose the wrong files, violate an invariant, run the wrong checks, miss a review hotspot, or fail to escalate, include it.
- Send packets inline by default.
- Persist `./scratchpad/current-packet.md` only when resumability or work fragility justifies it.
- Treat subagents as fresh by default. Do not persist runtime bookkeeping.
- Let the implementer choose the detailed edit sequence unless ordering is safety-critical.
- For non-trivial, ambiguous, order-sensitive, or risk-flagged work, require a short implementer readback before editing.
- That readback should name the intended edit surfaces, the key invariant that must remain intact, the validation plan, and the highest-risk assumption.
- When a lane returns from review, carry the unresolved findings and current check state into the next worker brief instead of making the worker reconstruct them from thread history.
- Verify local git state, branch topology, and check results before changing workflow status.
- If the runtime cannot create subagents for a lane that requires delegated implementation and review, stop and record the exact blocker instead of collapsing roles into the parent.

## Lane execution protocol

For each active lane, prefer this explicit runtime sequence:

1. preflight the branch lane, current contract, and subagent availability
2. spawn a fresh implementer worker from the selected PR contract plus fresh repo facts
3. require a readback before edits when the lane is non-trivial, ambiguous, order-sensitive, or risk-flagged
4. have the implementer edit product code, run the required checks, and report evidence back to the parent
5. spawn a fresh reviewer worker on the resulting diff
6. have the reviewer use the local `$code-review` finding-first contract when available
7. if review finds `blocking` or unresolved `should-fix` items, send the lane back through implementation and then rerun only the stale gates
8. mark the lane `ready_for_submit` only after checks, review, and any risk-triggered audit all satisfy the contract

## Verification and approval

- `acceptance criteria` should describe observable outcomes, not vague intent.
- `checks / evidence` should name the exact commands, artifacts, or repo facts that prove those outcomes or protect the changed contract.
- The reviewer should judge both the diff and whether the supplied checks actually protect the promised behavior.
- Default to executable checks plus independent review. Do not add a separate QA or evaluator loop unless a concrete risk justifies it.
- Common risk flags that may justify extra targeted audit are `migration`, `concurrency`, `external-contract`, `performance`, and `rollout-sensitive`.
- Review the whole PR diff on the first pass.
- After follow-up edits, prefer delta review unless the PR contract or public behavior changed materially.
- Review findings should use three buckets:
  - `blocking`: must fix before submission
  - `should-fix`: should normally be fixed in this PR or explicitly deferred
  - `note`: non-blocking observation
- Approval requires no unresolved `blocking` findings.
- `should-fix` findings need either a fix or an explicit defer decision.
- `note` findings should not reopen the loop on their own.
- `ready_for_submit` means the PR contract is still accurate, the required checks passed, review has no unresolved `blocking` findings, any `should-fix` items were fixed or explicitly deferred, and any risk-triggered audit is complete or explicitly unnecessary.

## Freshness rule

After a branch changes, rerun only the stale gate:

- workflow-only or metadata-only changes: no rerun
- test-only changes: rerun the affected checks; rerun review only if reviewer-facing semantics changed
- small implementation fixes in the same contract: rerun checks and a delta review
- risk-relevant changes in the same contract: rerun the affected checks and any targeted audit tied to that risk
- contract, rollout, or behavior changes: update `handoff.md` and run the relevant part of `$pr-loop` again

## Stack policy

- Start the branch when the PR lane starts, not after implementation.
- Do not create or rename branches while the PR contract is still unstable. If feasibility is still unclear, spike first and branch later.
- Keep one branch per planned PR.
- Use Graphite for branch creation, restack, and submission.
- Inspect `gt log short` and submit dry-run output at branch start and submission time.
- Use GitHub CLI for PR title and body updates only after Graphite has created or updated the PR.
- If a lower PR changes after submission, restack descendants, rerun the affected upper-lane gates, and refresh stale PR metadata.

## Runtime cleanup

- Runtime agents are session-local helpers, not durable workflow state.
- After a stack lane is successfully published, the orchestrator should close the implementer, reviewer, and any optional auditor agents that were created for that lane.
- If later work reopens that lane, prefer fresh agents over reviving stale runtime context unless there is a strong reason to reuse one.
