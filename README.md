# ag-rig

My personal setup for AI coding tools: reusable skills, standing instructions,
and tool configuration, versioned together and installed across machines with
[Skul](https://github.com/sjquant/skul).

## What's inside

- `skills/`: reusable workflows with their references, scripts, and templates.
- `instructions/engineering.md`: shared engineering principles. Skul installs these as each
  tool's native instruction file, such as `AGENTS.md` or `CLAUDE.md`.
- `manifest.json`: explicit Codex and Claude Code targets. The instruction
  source lives under `instructions/` because Skul excludes repository-root
  instruction files from its source cache by default.

The current skills were written for Codex. Some reference Codex-specific tools
or other skills; installing them for another tool does not translate those
dependencies. MCP and subagent configuration can be added when needed.

`run-staging-qa` and the integrated `feature-qa` workflow require a separately
installed `ego-browser` skill and ego lite CLI for browser execution.

## Install

Requires Node.js 20+, Git, and access to this repository. While the repository
is private, authenticate Git over HTTPS first (for example, with
`gh auth login` and `gh auth setup-git`), or use Skul's `--ssh` option with an
authorized SSH key.

```sh
npm install --global @solaqua/skul@0.4.3

# Preview the files and instructions to install.
skul add mingi3314/ag-rig --global --agent codex --dry-run

# Install for Codex across projects on this machine.
skul add mingi3314/ag-rig --global --agent codex
skul status --global
```

To target Claude Code instead, use `--agent claude-code`. Repeat `--agent` to
target both tools in one command. Codex skills go under `~/.agents/skills` and
its instructions go to `~/.codex/AGENTS.md`; Claude Code uses
`~/.claude/skills` and `~/.claude/CLAUDE.md`.

Skul appends root instructions by default. If the same principles are already
in your global instruction file, review the preview to avoid duplicating them.
Use `--root-instruction-mode replace` only when this bundle should replace the
entire instruction file.

To install only skills, add one `--include skills/<name>` per selected skill.
Inspect and back up existing skill directories or links before allowing Skul
to replace them. Restart the coding tool if new skills do not appear.

## Update and edit

```sh
# Fetch the latest source and reinstall for Codex.
skul add mingi3314/ag-rig --global --agent codex
skul status --global
```

Skul 0.4.3's `update` command only updates project-scoped installations.
Repeating `add` fetches the latest source and reapplies it globally. Use the
same `--agent` choices as your initial installation (for both tools, pass
`--agent codex --agent claude-code`). Run it after committing and pushing source
changes.

Clone the source repository to edit it:

```sh
git clone https://github.com/mingi3314/ag-rig.git ~/workspace/ag-rig
cd ~/workspace/ag-rig
```

Skul installs copies. Editing an installed skill does not update this repository;
bring intentional local changes back to the source before applying updates.
The previous symlink-based `install.sh` has been replaced by Skul.

## Sharing and scope

People with repository access can use the same installation commands. A public
repository allows others to reuse or fork the setup without being collaborators.

Keep reusable instructions, workflows, and non-secret configuration here.
Keep credentials, API tokens, authenticated configuration, and machine-specific
paths outside the repository. Keep project-specific rules in their projects.
