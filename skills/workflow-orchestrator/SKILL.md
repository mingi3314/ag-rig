---
name: workflow-orchestrator
description: Coordinate a Graphite-based stacked PR workflow once scope has converged and execution should move through durable PR units. Use when Codex should stay in delegated orchestration mode, keep one workflow handoff, pick the active PR lane, and route implementation and independent review through supporting skills and fresh subagents.
---

# Workflow Orchestrator

Use this as the top-level skill for stacked execution. Read [workflow.md](references/workflow.md) before substantial execution work.

When this skill is active, the parent agent is the workflow orchestrator for the rest of the session unless the user changes modes or the workflow ends. Keep the parent in delegated orchestration mode: it owns workflow state, lane selection, handoffs, and publish decisions, while implementation and independent review run through fresh subagents.

## Quick start

- Read [workflow.md](references/workflow.md) before substantial execution work.
- Keep `./scratchpad/handoff.md` as the only durable workflow artifact and treat it as the workflow contract.
- Pick one active PR unit at a time unless the work is clearly independent.
- Verify local git, Graphite, and GitHub state before changing workflow status.
- Re-anchor before each major step with: current role, active lane, allowed next actions, and disallowed actions.

## Route work through the supporting skills

- `$handoff-pack` to create or refresh `handoff.md`
- `$pr-loop` to execute one selected PR lane through implementation, checks, and review
- `$stack-lane-publish` to publish a `ready_for_submit` stack lane, refresh GitHub metadata, and close lane-specific runtime agents
- `$graphite-cli` for stack-aware Graphite operations

## Keep it simple

- Treat the PR as the default execution unit.
- Add extra artifacts only when they improve clarity or resumability.
- Treat executable checks plus independent review as the default verification model.
- Add extra audit only for lanes whose risk is not credibly covered by the default checks and review.
- Brief subagents with the minimum sufficient context for their role: leave out background that does not affect this pass, but do not omit facts that would change edits, validation, review depth, or escalation.
- Treat subagents as fresh workers by default. Reuse is a runtime optimization, not durable workflow state.
- Let the implementer own the code-level plan unless sequencing is safety-critical.
- Keep the reviewer independent and read-only.
- Do not let the parent agent directly edit product code, directly produce a reviewer verdict, or mark a lane `ready_for_submit` without an independent reviewer result.

## Notes

- Do not assume `git status` will show `.codex/` or `./scratchpad/` edits in this repo; inspect those files directly when needed.
- If feasibility is still unclear, spike before you open a branch lane or freeze a PR contract.
- Do not open or rename Graphite branches speculatively while the PR contract is still unstable.
