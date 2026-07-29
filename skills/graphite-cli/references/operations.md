# Graphite CLI Operations

Use this file before routine Graphite stack operations. It centralizes the Graphite command behavior used by workflow skills and direct Graphite-based sessions.

When a branch or PR action should stay stack-aware, prefer Graphite over plain git branch management or manual GitHub PR creation.

Source snapshot: April 1, 2026.
Sources:
- [Graphite CLI](https://graphite.com/docs/graphite-cli)
- [Command Reference](https://graphite.com/docs/command-reference)
- [Configure The CLI](https://graphite.com/docs/configure-cli)

## Trust order

- If this file conflicts with the installed CLI, trust `gt <command> --help`.
- If Graphite is unavailable, uninitialized, or clearly broken, stop and report the blocker instead of improvising with plain git stack commands.

## Global execution rules

- The Graphite command reference documents `--no-interactive` as the global way to disable prompts and other interactive features.
- `--quiet` implies `--no-interactive`, but use it only when the reduced output still leaves enough evidence for the parent workflow.
- Prefer explicit branch names. `gt checkout` without a branch opens an interactive selector.

## Preflight

- `gt auth --token <token>` adds the auth token Graphite uses to create and update PRs.
- `GRAPHITE_AUTH_TOKEN=<token>` overrides config-file and profile tokens. This is useful in CI or other non-interactive environments.
- `gt init --trunk <branch>` initializes Graphite in the current repository and selects the trunk branch. If `--trunk` is omitted, Graphite prompts interactively.
- Repository-level configuration is stored in the repository's `.git` directory.
- `gt log`, `gt log short`, and `gt ls` show tracked branches and dependency relationships.
- `gt trunk` shows the current trunk.

Use these checks before mutating stack state:

- `gt` exists on `PATH`.
- The repo is already initialized for Graphite workflows unless initialization is the explicit task.
- The working tree is suitable for the planned command.
- The current branch and stack position match the intended PR lane.

## Branch activation and creation

- `gt checkout <branch>` switches to a known branch.
- `gt checkout --trunk` switches to the current trunk branch.
- `gt create <name>` creates a new branch stacked on top of the current branch and commits staged changes.
- If there are no working tree changes, `gt create <name>` can still create an empty branch.
- If there are unstaged changes, `gt create` may prompt to stage them, so a clean tree or explicit staging policy is safer in agentic flows.
- `gt track <branch> --parent <parent>` can adopt an existing branch into Graphite tracking or repair corrupted parent metadata.

Use `gt create <name>` only after verifying that the current branch is the intended parent branch in the stack.

## Restack and conflict handling

- `gt restack` ensures each branch in the current stack has its parent in Git history and rebases when needed.
- `gt restack --upstack` limits the operation to the current branch and its descendants.
- If `gt restack` hits conflicts, Graphite pauses for interactive rebase conflict resolution.
- `gt add [args..]` is a passthrough to `git add` and can be used to stage conflict resolutions.
- `gt continue` resumes the most recent Graphite command halted by a rebase conflict.
- `gt abort` aborts the most recent Graphite command halted by a rebase conflict.

When conflicts appear:

1. Resolve the conflicts in the worktree.
2. Stage the resolution with `gt add -A` or the narrower `gt add` form you actually need.
3. Run `gt continue`.
4. If the operation should be abandoned, run `gt abort`.

## Submission

- `gt submit` force-pushes branches from trunk through the current branch and creates or updates distinct PRs.
- Graphite validates that branches are properly restacked before submitting and fails if there are conflicts.
- Graphite blocks force pushes when the remote branch changed since the last submit or get.
- `gt ss` is a default alias for `gt submit --stack`.
- `gt submit --dry-run` reports what would be submitted and stops before restacking, pushing, or opening PRs.
- `gt submit --stack` includes descendants of the current branch.
- `gt submit --draft` creates new PRs as drafts.
- `gt submit --no-edit` suppresses inline metadata editing.
- `gt submit --restack` restacks before submitting.
- `gt submit --update-only` updates existing PRs only.
- `gt submit --cli` edits metadata in the CLI.
- `gt submit --web` opens the browser for metadata editing.

Default agentic submission flow:

1. Run a non-interactive dry run first, usually `gt submit --stack --dry-run --no-interactive`.
2. If the dry run is correct, run the real submission command, usually `gt submit --stack --draft --no-interactive --no-edit --no-web`.
3. If Graphite reports auth failures, restack conflicts, remote drift, or unexpected descendants, stop and surface the exact blocker before changing workflow status.

## Remediation commands to use carefully

- `gt sync` syncs branches with remote, restacks branches it can restack, and can overwrite trunk with the remote version when trunk is not fast-forwardable.

Do not use `gt sync` as the default first step for branch activation or submission. Keep it as an explicit remediation step when broader synchronization is actually intended.

## What callers should report

- The Graphite command actually used.
- Whether the command only inspected state or mutated stack state.
- The affected branch or PR lane.
- Any blocker such as missing auth, missing initialization, restack conflicts, or remote drift.
