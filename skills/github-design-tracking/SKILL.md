---
name: github-design-tracking
description: "Organize ongoing engineering design in GitHub issues with a navigable design map, the issue body as the current design SSOT, and comments as investigation and decision history. Use to establish or maintain this workflow and connect accepted design to implementation tasks. Ordinary bug or task filing does not need this workflow."
---

# GitHub Design Tracking

Make the current design understandable from the issue body alone, with links to comments that explain the evidence, alternatives, and reasons behind it.

## Establish scope and authority

Use the user's chosen repository, issue, and documentation conventions. Read the latest body and relevant comments before updating existing work. If an issue needs to be created, check for an existing one covering the same design first.

Scope the single source of truth (SSOT) explicitly: the body describes the current engineering design and its open questions. Link to authoritative product policies and external contracts without duplicating their ownership. If an agreed final design document later becomes canonical, make that handoff explicit and keep the issue as its summary and task index.

Comments hold the decision history in this workflow. Add separate decision records or workspace documents when requested or required by project conventions.

Applying this skill does not authorize GitHub writes. Create or update issues, comments, or tasks when requested or already authorized. Continue under existing authorization without asking again for each routine update.

## Keep a navigable design map

Start with a few major design questions and expand only the branches that need detail. Preserve the user's structure and keep identifiers stable enough to reference in comments, decisions, and tasks. Do not impose a particular domain breakdown or create an issue for every leaf.

In discussion, briefly identify the current branch, the parent assumptions, and the question being decided. Explain why the decision matters, the behavior it must guarantee, and the costs of realistic implementation alternatives. Identify dependencies across branches; evidence found below may require reconsidering a parent decision.

Keep the full map in the body. In conversation, show the relevant path and refresh the full map at useful milestones rather than repeating it every turn.

## Separate current design from history

| Issue body: current state | Comments: review history |
| --- | --- |
| Goals, scope, and important constraints | The question and context of a particular investigation |
| Design map and topic status | Code observations, evidence, and alternatives |
| Accepted decisions and concise rationale | Proposals, review outcomes, and reasons for decisions or changes |
| Open questions and links to relevant discussions | Follow-up questions and next investigation steps |

Distinguish policy requirements, observed facts, assumptions, proposals, and accepted decisions. Track topic status using terms that fit the project, such as under review, decided, or deferred. An unresolved topic remains visible in the body without presenting a proposal as a settled choice.

A transient statement such as “we are discussing A2 next” belongs in a comment or conversation. The body can show that A2 is under review, what remains unresolved, and where to find its discussion.

Record a comment when an investigation, comparison, review, or decision produces a meaningful outcome. GitHub already supplies timestamps; add a separate date when the evidence has a distinct effective date. A useful comment identifies its map location, material premises and evidence, conclusion or proposal, and remaining questions. Scale detail to the outcome; avoid transcript dumps and empty template fields.

When an accepted decision changes, preserve the earlier reasoning and explain the change in a new comment. Update the affected body text to the currently valid design, including any affected constraints or questions, and link to the supporting comment. Avoid accumulating amendment prose or competing conclusions in the body.

When moving historical material out of an existing body, preserve useful evidence in a comment before removing it. For substantive updates, record the history first and then refresh the body so its references resolve. Incorporate intervening edits rather than overwriting another contributor's work from an old snapshot. If a write has an uncertain outcome, read back before retrying; stop and report uncertainty if success cannot be established.

## Connect decisions to implementation

Split out a child issue when work is independently reviewable or actionable, respecting the user's chosen phase and scope. Derive implementation tasks as decisions become sufficiently clear; keep unresolved design questions visible.

Each task should carry the relevant design decision or branch link, its purpose, observable completion criteria, appropriate verification, and dependencies that matter. Keep the parent issue's index useful for navigating the work. If an agreed decision is revised, identify affected tasks rather than leaving them tied to obsolete behavior.
