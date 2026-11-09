---
name: discuss-build-review
description: Carry out a coding task with concise direction-setting and an independent code/design review and repair loop. Use when the user wants iterative quality improvement before their final review.
---

# Discuss Build Review

Own implementation, solution design, and verification in the main agent. Delegate independent problem assessment to a reviewer, so the user receives work that has already gone through substantive quality review.

Apply this workflow to the authorized task. When joining existing work, start at the relevant stage; preserve directions and decisions already established. This orchestration is for the implementing agent. The delegated reviewer follows the reviewer role, without taking over implementation or starting another review loop.

## Make the direction understandable

Before implementation, help the user form a mental model they can use to follow the work and evaluate the result. Explain the representative execution flow and the proposed change using consistent example code or data beside the explanation. Distinguish established facts from assumptions. Where meaningful alternatives exist, compare the recommendation, reasons, and costs concretely enough for the user to judge. Keep the explanation concise while retaining the causal links needed to understand the choice.

For nontrivial tasks, end the turn after this explanation and invite questions, adjustments, or agreement to proceed. Wait for the user's agreement before editing production code or tests. Refine the explanation or direction in response to their feedback. This discussion is the default even when the issue gives a clear solution; the user should have an opportunity to understand the approach before implementation starts.

Skip this exchange for trivial tasks with no meaningful behavior or design choices. Judge this by impact and uncertainty, not the number of changed lines. When the direction has already been discussed and accepted, continue under that agreement without repeating the discussion or seeking approval for routine implementation and review repairs. Revisit the discussion if the work requires a material change to the agreed direction.

## Delegate an independent review

Once implementation and appropriate author checks are ready, identify the actual review range: the requested PR, branch changes, commit, or worktree changes. Keep unrelated existing edits outside the task.

Read [references/reviewer.md](references/reviewer.md) at delegation time and pass its complete role instructions to a separate reviewer subagent. Prefer a fresh task context with the original request, agreed requirements and constraints, relevant engineering guidance, and the review range. Give the reviewer access to the actual diff and related code and consumers; an author-written summary alone is insufficient. Treat the author's design rationale as a claim to examine, not an approved conclusion.

Wait for the review before deciding the next changes. If subagents are unavailable, disclose that the independent review could not be performed; do not describe self-review as independent review.

## Resolve findings and re-review

Judge each finding against the code, requirements, and evidence. Investigate material uncertainty. The author chooses and implements the solution to warranted problems and performs verification appropriate to the changes. Record a concise reason when a finding is unsupported or does not warrant a change; do not silently discard it or fix it solely to satisfy the reviewer.

Return changed code, finding dispositions, and newly established facts to the independent reviewer. Have it assess whether the original problems are resolved and whether the resulting change introduces another worthwhile problem. A disposition or a passing test alone does not establish that a design problem is resolved.

Use the task's review budget. For initial trials, default to at most three reviewer passes, including the first; this is an adjustable budget, not a quality threshold or a required number of rounds. Finish earlier when there is no worthwhile unresolved issue in the reviewed scope and required author checks pass. Stop and hand off concrete unresolved issues when user judgment is required, review stops making progress, or the budget is exhausted. Do not label unresolved work ready.

## Hand back a reviewable result

Summarize the resulting behavior and important reasons, verification and its limits, substantive improvements from review, and any unresolved decisions or findings. Use a representative code or data example when it helps the user understand. Keep the review history concise; the user should not have to mediate each internal exchange.
