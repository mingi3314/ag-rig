# Lower-stack Update Playbook

Use this when a branch that is already submitted as part of a stack needs more changes.

Read [operations.md](../../graphite-cli/references/operations.md) before running the Graphite commands in this process. That shared reference owns Graphite command semantics and failure handling.

## When to use

- A lower PR in the stack needs code changes after later PRs already exist.
- An assumption changed and a lower branch owns the correct fix.
- You need to restack descendants onto the updated lower branch.

## Goal

Apply the fix at the right layer, propagate it up the stack safely, and refresh any stale reviewer-facing metadata.

## Process

1. Switch to the correct lower PR branch.
2. Make the change there and rerun the relevant part of `$pr-loop` for that lower PR so its checks and review approval are fresh again.
3. Run:

```bash
gt restack --upstack --no-interactive
```

4. If Graphite stops on conflicts:

```bash
gt add -A
gt continue
```

5. After the restack completes, if an upper PR's diff or semantics changed, rerun the relevant part of `$pr-loop` for that PR before resubmitting it.
6. Refresh any affected PR body that is now stale because the stack changed.
7. Re-run the normal Graphite submit flow from [operations.md](../../graphite-cli/references/operations.md).

## Notes

- Do not patch a lower-branch concern in an upper PR just to avoid restacking.
- Restack conflicts are normal when lower branches touch shared files used by upper branches.
- If no clear non-overlapping work remains, waiting for the restack/conflict result is acceptable.
