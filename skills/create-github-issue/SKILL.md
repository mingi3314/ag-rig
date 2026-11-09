---
name: create-github-issue
description: Draft or file concise GitHub issues when the user wants to record a bug or engineering task for later, leaving implementation design to the eventual implementer.
---

# Create GitHub Issue

Capture enough context for a later implementer to understand and assess the problem independently. Keep registration lightweight so recording deferred work does not expand the active task.

## Describe the problem concisely

Use the conversation and evidence already available. Inspect only what is needed to make the issue accurate and understandable; registration does not require a root-cause investigation or solution design. Distinguish observations from hypotheses and material unknowns.

Give the issue a concrete title describing the problem or desired outcome. Prefer a short body covering:

- What happens, or what capability is needed, and under what conditions.
- Why it matters and what a successful outcome would mean, where known.
- Essential evidence or constraints, such as a reproduction, code link, or established requirement, when useful.

Write for someone who did not participate in the conversation. A short paragraph or a few bullets often suffice; omit empty sections, speculative checklists, and repetition. Follow applicable repository templates without padding optional sections.

## Leave solution design with the implementer

Do not make an implementation plan, choose an architecture, or prescribe code changes as part of registration. Frame success through observable behavior or concrete effects on understanding and maintaining the code, rather than a preferred implementation shape.

Preserve explicit user requirements and agreed design decisions, including material reasons. Retain existing technical clues or possible approaches only when useful; distinguish confirmed facts from hypotheses and optional ideas from requirements. Do not invent approaches to fill out an issue. If the user explicitly requests implementation guidance, honor that scope and distinguish proposals from settled decisions.

## Draft or file within scope

Keep each issue focused on a coherent problem. Recording it does not authorize fixing it or changing the current PR. Draft when asked for a draft; create on GitHub when creation is requested or already authorized. Discovery alone does not authorize filing.

Resolve the target repository from the request and context; ask if still ambiguous. Use available GitHub tools or `gh`. Make a focused check for an existing issue covering the same work; return a clear match instead of creating a duplicate. Do not update existing issues unless authorized.

With `gh`, preserve the exact body using a temporary file and `--body-file`. If creation has an uncertain outcome, check whether it succeeded before retrying; if that cannot be established, report the uncertainty and stop. Return the issue link, or the title and body for a draft.
