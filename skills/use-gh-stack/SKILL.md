---
name: use-gh-stack
description: Manage stacked pull requests with GitHub CLI's gh stack extension. Use when splitting dependent changes into PRs or linking, publishing, rebasing, and syncing a stack.
---

# Use gh stack

Use `gh stack`; check unfamiliar options with `--help`. Supply branches or PRs in dependency order, bottom to top.

| Task | Command |
|---|---|
| Inspect the local stack | `gh stack view --json` |
| Link existing PRs on GitHub | `gh stack link <bottom-pr> <next-pr>` |
| Initialize a local stack | `gh stack init --base <trunk> <bottom-branch> <next-branch>` |
| Add a branch on top | `gh stack add <branch>` |
| Publish or update PRs | `gh stack submit --auto` |
| Rebase the stack | `gh stack rebase` |
| Synchronize the stack with the remote | `gh stack sync` |

- `link` needs no local stack tracking. Prefer PR numbers/URLs for existing PRs; branch arguments are pushed and can create PRs.
- `submit --auto` uses generated titles and creates new PRs as drafts. Set the intended titles and descriptions when publishing.
- `sync` fetches, rebases, and pushes; it does not create new PRs.
- After resolving and staging rebase conflicts, use `gh stack rebase --continue`; `--abort` restores the stack.
- Check `git worktree list` when a command needs to check out branches: another worktree may already hold them.
