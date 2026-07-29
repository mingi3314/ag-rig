---
name: maintain-living-docs
description: Maintain evolving plans, specifications, designs, roadmaps, briefs, and other canonical documents as clean current-state artifacts across multi-turn collaboration. Use when agreements revise, replace, remove, or narrow earlier content; when consolidating a discussion into a final document; or when material decision rationale should be preserved separately under decisions/DR-*.md without turning the main document into an edit history.
---

# Maintain Living Documents

Treat each canonical document as the current truth, not as a narration of how it changed. Preserve durable rationale in separate decision records.

## Maintain the Separation

- Keep the canonical document limited to the currently accepted goals, scope, requirements, design, and plan.
- Replace or remove obsolete content directly. Do not retain amendment-style prose such as "C was dropped in favor of C'" merely to preserve history.
- Keep an excluded item in `Non-goals`, constraints, or another current-state section only when that exclusion remains useful as an active scope boundary.
- Store material accepted decisions as individual `decisions/DR-*.md` files.
- Report what changed in the conversational response or change summary, outside the canonical document.
- Make the canonical document understandable without requiring the preceding conversation or decision history.

## Update the Documents

1. Read the canonical document, relevant `decisions/DR-*.md` files, and local documentation conventions before editing.
2. Distinguish accepted decisions from proposals, brainstorming, and tentative suggestions. Do not turn every conversational turn into a decision record.
3. Rewrite the affected canonical content to express only the newly accepted state.
4. Remove stale references, duplicated requirements, and contradictions elsewhere in the canonical document.
5. Decide whether the rationale has future value. Record a decision when it materially changes goals, scope, architecture, constraints, or commitments; is costly to reverse; is likely to be revisited; or is explicitly requested for preservation.
6. Skip a decision record for copy edits, corrections, rejected proposals, transient exploration, and minor changes whose rationale will not matter later.
7. Run a final consistency pass across the canonical document and any affected decision records.

When authorized to edit workspace documents and no existing convention applies, create `decisions/` beside the documentation root and name records `DR-NNN-short-kebab-title.md`. Use the next unused sequential identifier and never reuse an identifier.

When working only in chat, keep the proposed current document and decision records visibly separate. Do not create workspace files unless the user asked to create or update them.

## Write Decision Records

Keep one decision per file and keep it concise:

```markdown
# DR-NNN: Decision title

- Status: Accepted
- Date: YYYY-MM-DD
- Supersedes: None

## Context

State the pressure, constraint, or question that required a decision.

## Decision

State the accepted choice affirmatively.

## Rationale

Explain why this choice fits the context.

## Consequences

Record important tradeoffs, constraints, and follow-up effects.
```

If a later decision reverses or replaces an earlier record, create a new record. Mark the old record `Superseded by DR-NNN` and identify the old record in the new record's `Supersedes` field. Do not rewrite the old rationale to make it appear consistent with the new decision.

Reference a decision record from the canonical document only when the reference helps a reader understand or safely execute the current state.

## Recognize the Failure Mode

Suppose an initial draft contains:

```markdown
- Do A.
- Do B.
- Do C.
- Do D.
```

The user later accepts C' instead of C and decides that D is unnecessary.

Do not preserve the conversation as amendment prose in the canonical document:

```markdown
- Do A.
- Do B.
- Do not do C; do C' instead.
- Do not do D.
```

Rewrite the canonical document as the current truth:

```markdown
- Do A.
- Do B.
- Do C'.
```

Create a record such as `decisions/DR-001-adopt-c-prime.md` only when the choice and its rationale have future value. Record the exclusion of D only when that decision is material. If D remains an important current scope boundary, include it under `Non-goals`; otherwise remove it entirely from the canonical document.
