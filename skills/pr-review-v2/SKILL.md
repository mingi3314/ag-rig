---
name: pr-review-v2
description: Review a pull request, branch, or diff against a base through independent failure, maintainability, and decision lenses. Use for PR review, branch review, code review, or diff audit when useful findings should include defects, comprehension barriers, design tradeoffs, and verification gaps instead of only high-severity bugs. Keep the review read-only unless the user explicitly asks for fixes.
---

# PR Review V2

Review changed code from distinct perspectives. Preserve every meaningful observation, then classify and prioritize it instead of suppressing minor findings.

## Review contract

- Keep the review read-only. Do not edit files, push commits, or post comments unless the user explicitly asks.
- Infer the base and head from PR metadata or repository defaults when safe. Ask only when ambiguity would materially change the review.
- Review only issues introduced or materially worsened by the change.
- Read repository guidance and enough surrounding code, callers, configuration, and tests to understand the change in context.
- Ground each observation in specific code or a specific decision. Exclude unsupported speculation, duplicates, and preference-only comments.
- Use repository-relative locations such as `src/file.ts:L10-L18`. Do not use GitHub blob URLs or absolute filesystem paths unless the user asks for links.
- Report only checks that were actually run. Do not expose secrets or run destructive commands.

## Review perspectives

For a small, obvious change, apply all perspectives directly. For a nontrivial change, run these three read-only reviewers independently and synthesize their results:

- `pr_v2_failure_reviewer`: Find what can break because of the change and follow plausible failure paths.
- `pr_v2_maintainer_reviewer`: Find where a teammate without the author's context would struggle to build an accurate mental model.
- `pr_v2_decision_reviewer`: Reconstruct and evaluate the decisions expressed by the change.

Give reviewers the user request, base, head, and repository location. Use a fresh subagent for each perspective and let each inspect the raw change independently; do not seed one reviewer with another's conclusions. If capacity is limited, run perspectives in waves instead of reusing a reviewer. If the custom reviewers are unavailable, use generic subagents with the same perspectives. Add a bounded specialist only when the change presents a material domain-specific risk. Do not create recursive fan-out.

### Failure perspective

Look for incorrect behavior, regressions, unsafe boundaries, broken contracts, and operational or verification gaps. Require a plausible path or concrete missing guarantee, but preserve minor valid issues.

### Maintainer perspective

Read as a teammate who does not share the author's context. Notice where understanding requires rereading, guesswork, or distant context. Explain what creates that friction and what intent, responsibility, state, or invariant the code fails to communicate.

For every changed element with callers or consumers, review outside-in before reading its implementation. Inspect only the consumer-visible name, signature, types or documentation, and call sites; record what a caller would reasonably infer and where usage feels awkward or requires hidden knowledge. Then read the implementation and compare its actual contract with that initial model. Report mismatches, hidden obligations, and avoidable call-site friction instead of rationalizing them with implementation knowledge.

Treat meaningful comprehension cost as a finding even when no current defect is proven. Distinguish it from personal style preference.

### Decision perspective

Infer decisions from the code, PR context, and local patterns. Separate observed facts, inferred intent, and unknown constraints. Evaluate whether each material choice is proportionate to its apparent goals and whether a meaningfully better option exists. Treat a merely different alternative as discussion, not a defect, but explain worthwhile discussions deeply enough for the user to evaluate without a follow-up question.

## Findings

Keep a finding when it is attributable to the change, grounded in a concrete location or decision, and useful for the author to see. Do not discard it merely because its impact is small or it does not predict a runtime failure.

Classify each finding by its nature:

- `defect`: Incorrect behavior or a concrete product, security, data, compatibility, or operational risk.
- `maintainability`: A barrier to understanding, safely changing, testing, or owning the code.
- `design`: A consequential decision or tradeoff with a materially better direction.
- `verification`: Missing evidence needed to trust changed behavior, rollout, or recovery.

Prioritize each finding by the cost of leaving it unresolved:

- `Blocker`: Do not merge without resolving it.
- `Important`: Address it or consciously accept the material risk or cost.
- `Minor`: Keep the valid improvement visible even though it is localized or safe to defer.

Do not automatically rank maintainability or design findings as `Minor`. Treat importance and certainty as separate dimensions. Put a grounded concern that still needs evidence under `Needs verification` rather than silently dropping it. Merge repeated manifestations of the same cause into one finding with representative locations.

## Synthesis and output

Verify candidate findings against the diff and relevant context. Correct inaccurate claims, merge overlap, and retain meaningful minority observations. Do not impose a minimum or maximum number of findings.

Write in the user's language. Order findings by `Blocker`, `Important`, then `Minor`; show the type in each title. For every finding, give its location, the observation, why it matters, and a proportionate direction. Omit empty priority sections.

After findings, include `Needs verification` for grounded unresolved concerns and `Discussion` for worthwhile design alternatives that are not findings. Give each discussion a descriptive title, relevant location, the current decision and its context, why the point matters, its tradeoffs, the alternative, and the conditions under which that alternative is preferable. Order discussions by likely value and do not compress them into summary-only bullets.

End with a brief summary of the reviewed scope and checks actually run. If there are no findings, say so directly without inventing any.
