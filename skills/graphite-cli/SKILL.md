---
name: graphite-cli
description: Use when stack-aware branch creation, branch switching, restacking, or PR submission should go through Graphite instead of plain git or GitHub commands. This skill is workflow-agnostic.
---

# Graphite CLI

Use this as the shared command skill for Graphite-based stacked PR work. It owns how to operate `gt` safely and consistently. It does not own product or workflow decisions such as which PR is active, whether a diff is approved, or what PR metadata should say.

## Use this skill when

- Another skill or direct session needs reusable Graphite CLI guidance.
- The session needs to inspect stack topology, activate or create a branch, restack, or submit through Graphite.
- A user or workflow would otherwise reach for plain git branch commands or GitHub PR creation for stack-aware work.
- The agent needs one shared policy for preflight checks, failure handling, and non-interactive command selection.

## Do not use this skill when

- The main problem is choosing the current PR from `handoff.md` or other workflow state.
- The main problem is implementation or review rather than Graphite operations.
- The main problem is PR title or body writing in GitHub.

## Reference

Read `references/operations.md` before non-trivial Graphite work.

- Use that file as the default command cookbook for this skill.
- If the reference conflicts with the installed CLI, trust `gt <command> --help`.
- Prefer non-interactive forms in agentic execution.
- Do not improvise with plain git when stack topology or submission should stay Graphite-managed.

## Responsibilities

- Preflight: verify `gt` availability, repository initialization, auth inputs, current branch context, and working tree suitability.
- Inspect stack state with commands such as `gt log`, `gt log short`, `gt ls`, and `gt trunk`.
- Activate or create tracked branches with `gt checkout`, `gt create`, and `gt track`.
- Repair stack state with `gt restack`, `gt continue`, `gt abort`, and `gt add`.
- Submit branches with the appropriate `gt submit` flow.
- Surface exact blockers instead of hiding them behind workflow-state guesses.

## Quality rules

- Prefer the smallest command that answers the question or fixes the stack.
- Avoid interactive selectors in agentic flows; pass explicit branch names or non-interactive flags when the CLI supports them.
- Treat `gt sync` as a deliberate remediation step, not an automatic first step.
- If Graphite is unavailable, uninitialized, or auth-broken, stop and surface the blocker instead of falling back to manual git stack management.
- Report the exact Graphite command used and any residual risk such as descendant inclusion, remote drift, or unresolved conflicts.
