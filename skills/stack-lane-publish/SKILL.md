---
name: stack-lane-publish
description: Publish the current `ready_for_submit` stack lane through Graphite, refresh GitHub PR metadata, and close lane-specific runtime agents. Use when implementation, checks, and review are already complete for the active stacked PR lane.
---

# Stack Lane Publish

Read these before substantial work:

- [workflow.md](../workflow-orchestrator/references/workflow.md)
- [operations.md](../graphite-cli/references/operations.md)

Use the local PR body templates only when you need help drafting metadata:

- bottom PR: `templates/bottom-pr-body.ko.md`
- non-bottom PR: `templates/stack-pr-body.ko.md`

## Submission flow

1. Confirm the active PR unit and branch still match the `ready_for_submit` state in `handoff.md`.
2. Confirm the approval evidence carried forward from `$pr-loop`: required checks passed, review has no unresolved `blocking`, any `should-fix` items were fixed or explicitly deferred, and any risk-triggered audit is complete or explicitly unnecessary.
3. If the branch changed after approval, use the freshness rule from `workflow.md` to decide whether to rerun checks, rerun review, rerun targeted audit, or go back to `$pr-loop`.
4. Use Graphite to verify the lane and run a non-interactive dry run first.
5. Stop on auth, restack, drift, descendant-selection, or conflict blockers and surface the exact issue.
6. Submit with Graphite when the dry run is correct.
7. Update the PR title and body with `gh pr edit` after the PR exists.
8. Mark the PR `submitted` in `handoff.md` only after Graphite submission and GitHub metadata update both succeed.
9. Close the implementer, reviewer, and any optional auditor agents for that lane after publish succeeds, unless the parent orchestrator has an explicit reason to keep one open.

## Required outputs

- The approval evidence carried forward from `$pr-loop`, and whether any rerun was needed.
- Whether default checks plus review were sufficient, or which targeted audit result was also required.
- Any dry-run warning or blocker that mattered.
- The `gt submit` result and the PR that was created or updated.
- The `gh pr edit` result and final PR title.
- The `handoff.md` status change.
- Which lane-specific runtime agents were closed, or the explicit reason one stayed open.
