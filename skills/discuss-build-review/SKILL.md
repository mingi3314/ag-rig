---
name: discuss-build-review
description: Carry out a coding task by agreeing on a direction, implementing it, and acting on independent review before handoff.
---

# Discuss Build Review

Own design decisions, implementation, and verification in the main agent. When joining existing work, start at the relevant stage and carry forward agreed requirements and decisions.

## Make the direction understandable

Before implementation, help the user form a mental model they can use to follow the work and evaluate the result. Explain the representative execution flow and the proposed change using consistent example code or data beside the explanation. Distinguish established facts from assumptions. Where meaningful alternatives exist, compare the recommendation, reasons, and costs concretely enough for the user to judge. Keep the explanation concise while retaining the causal links needed to understand the choice.

For nontrivial tasks, end the turn after this explanation and invite questions, adjustments, or agreement to proceed. Wait for the user's agreement before editing production code or tests. Refine the explanation or direction in response to their feedback. This discussion is the default even when the issue gives a clear solution; the user should have an opportunity to understand the approach before implementation starts.

Skip this exchange for trivial tasks with no meaningful behavior or design choices. Judge this by impact and uncertainty, not the number of changed lines. When the direction has already been discussed and accepted, continue under that agreement without repeating the discussion or seeking approval for routine implementation and review repairs. Revisit the discussion if the work requires a material change to the agreed direction.

## Delegate an independent review

Once the initial implementation and appropriate author checks are ready, identify the requested PR, branch, commit, or worktree changes, including any new task files. Keep unrelated edits outside the review.

Read [pr-review-v2](../pr-review-v2/SKILL.md) and use its review contract, perspectives, and synthesis. For a small, obvious change, delegate all perspectives to one independent reviewer. When the skill calls for separate perspective reviewers, launch them directly from the main agent and synthesize their findings. Give reviewers fresh context with the original request, agreed requirements and constraints, relevant engineering guidance, and access to the actual diff and surrounding code.

Wait for the review before deciding how to respond to its findings. If subagents are unavailable, disclose that limitation at handoff.

## Decide how to act on findings

Read [evaluate-review-feedback](../evaluate-review-feedback/SKILL.md) when findings need a decision. Apply it as the author to judge each finding's validity, priority, and benefit in the current scope. The main agent owns the disposition and implements warranted changes within the authorized task. A valid finding can justify a smaller fix, a conscious decision to keep the current design, or follow-up work outside the current scope. Record the decisive reason for material decisions. Capture worthwhile deferred work for follow-up, filing a separate issue when authorized.

Verify repairs in proportion to the affected behavior and risk. Request focused independent re-review when a repair changes a material design choice or raises a material question about resolution or regressions. Give the reviewer the affected diff, relevant dispositions, and new evidence.

Use the task's review budget, defaulting to at most three passes, including the initial review. Finish once required checks pass and remaining findings have a reasoned disposition. Surface any unresolved issue that still affects readiness when user judgment is required, review stops making progress, or the budget is exhausted.

## Hand back a reviewable result

Summarize the resulting behavior and important reasons, verification and its limits, substantive improvements from review, and any unresolved decisions or findings. Use a representative code or data example when it helps the user understand. Keep the review history concise; the user should not have to mediate each internal exchange.

## Handle feedback after handoff

Continue from the agreed direction and prior review. For a local, well-understood adjustment, make the change directly and check the affected behavior or artifact. A wording change may only need a diff check. A localized bug fix with clear expected behavior may need a targeted test. Reopen the direction discussion if the follow-up requires a material change to the agreed approach. Use independent review of the affected diff when a follow-up changes an important contract or guarantee, introduces material risk or uncertainty, or the user requests it.
