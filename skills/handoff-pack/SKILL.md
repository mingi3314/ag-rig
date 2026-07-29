---
name: handoff-pack
description: Create or refresh `./scratchpad/handoff.md` as the single durable workflow artifact for a stacked PR workflow. Use when scope has converged enough to freeze the execution contract into reviewer-friendly PR units and current focus.
---

# Handoff Pack

Use this skill to write the durable contract for the workflow. Read [workflow.md](../workflow-orchestrator/references/workflow.md) before substantial edits, then start from [handoff-template.md](assets/handoff-template.md) and delete optional lines that do not matter.

## Write only the stable contract

- Capture the goal, stable constraints, reviewer-friendly PR units, and current focus.
- Keep the PR as the default execution unit. Do not introduce nested checklists unless the coordination boundary is real.
- Express `acceptance criteria` as observable outcomes, not vague intent.
- Use `invariants` for the properties that must remain true while the PR lands.
- Use `checks / evidence` for the exact commands, artifacts, or repo facts that will prove the contract is satisfied.
- Add `risk flags` only when they materially change verification or review depth.
- Record non-goals only when nearby cleanup or follow-up work is likely to be reopened.
- Add a decision note only when future sessions are likely to revisit the tradeoff.
- If you ran a feasibility spike, record only the conclusion that changes execution; do not preserve the whole exploration.
- Keep ephemeral repo observations, runtime agent state, and packet chatter out of `handoff.md`.

## Required output

- Create or update `./scratchpad/handoff.md` unless the user asked for another path.
- Report which file was updated and any assumptions or blockers that remain.
