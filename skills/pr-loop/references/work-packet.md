# Work Packet Design

Use this reference when a PR unit is non-trivial enough to need an explicit subagent brief.

## Goal

Give a fresh subagent enough context to act safely without reconstructing hidden thread history.

Default to an inline brief. Persist `./scratchpad/current-packet.md` only when resumability or work fragility justifies it.

Packets are for delegated workers. They are not a license for the parent orchestrator to impersonate the implementer or reviewer locally.

## Brief quality

- Aim for the minimum sufficient context, not the smallest possible packet.
- Leave out background that does not affect this role's decisions.
- Include every fact that could change what this worker edits, validates, reviews, or escalates.
- Prefer concrete repo facts, file paths, diff targets, commands, and unresolved findings over thread-history summaries.

## Ownership split

- The parent orchestrator owns the work contract.
- The implementer owns the code-level plan.
- The reviewer judges the diff against the contract and shipped behavior.

## Implementer brief

Include only what the worker needs now:

- outcome
- why this PR exists
- current repo facts
- must-read files
- editable scope
- unresolved review findings to address on fix cycles
- out-of-scope or non-goals
- constraints or invariants
- risk flags that materially affect validation depth
- acceptance criteria
- checks / evidence to produce
- stop or escalate conditions

Ask for a short readback when the work is non-trivial, ambiguous, order-sensitive, or risk-flagged.
That readback should name:

- intended edit surfaces
- key invariant to preserve
- validation plan
- highest-risk assumption

## Reviewer brief

Keep reviewer packets narrower than implementer packets. Include:

- exact diff or branch target
- whether the pass is full or delta review
- current check summary
- acceptance criteria and checks that matter for this pass
- risk flags that deserve extra skepticism
- scope boundaries when they matter
- hotspots worth skepticism
- prior unresolved `blocking` or `should-fix` findings for delta review

When the local `$code-review` skill exists, use its finding-first review contract for the reviewer verdict.

## Orchestrator checkpoint

Before handing work to a subagent or changing lane status, the parent should restate:

- `Current role`
- `Active lane`
- `Allowed next actions`
- `Disallowed actions`

## Default packet shape

```markdown
Work Unit: [short PR title]
Role: [implementer | reviewer]
Branch / diff target: [branch name, commit, or diff scope]
PR status: [pending | in_progress | blocked | ready_for_submit | submitted | completed]

Outcome:
- [what should be true after this role completes]

Why:
- [why this pass exists]

Current repo facts:
- [confirmed observations only]

Must-read context:
- [path]: why it matters

Role-specific target:
- [editable scope or exact review target]

Out of scope:
- [explicit boundaries]

Constraints and invariants:
- [rules that must still hold]

Risk flags:
- [only when they materially change validation or review depth]

Acceptance / success signal:
- [observable done condition]

Checks / evidence:
- [commands to run or evidence to rely on]

Assumptions / open questions:
- [label anything not yet confirmed]

Stop / escalate if:
- [missing dependency, conflicting repo reality, broader refactor required]
```

## Failure modes to avoid

- vague PR bullets with no file entry points or boundaries
- packets that repeat chat history instead of current repo facts
- packets that optimize for brevity but omit a fact that changes file choice, validation scope, review depth, or escalation behavior
- over-specified implementation paths that remove useful local judgment
- packets with acceptance criteria that are not tied to any credible check or review evidence
- reviewer packets that copy the whole implementer brief without narrowing the task
- a parent agent that skips delegation and performs the role locally anyway
