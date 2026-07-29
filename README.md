# Personal Codex Skills

Version-controlled personal skills for Codex. Each folder under `skills/` is a
standalone skill and may include references, scripts, or templates alongside
its `SKILL.md`.

## Install on this machine

```sh
./install.sh
```

The installer links every skill into `~/.agents/skills`, Codex's user-level
skill directory. It never overwrites an existing skill path.

## Install on a new machine

```sh
git clone https://github.com/mingi3314/codex-skills.git ~/workspace/codex-skills
cd ~/workspace/codex-skills
./install.sh
```

Use `git pull --ff-only` in this repository to receive skill updates. Restart
Codex if a newly added skill does not appear automatically.

## Scope and safety

- Keep reusable workflows, references, templates, and non-secret helper scripts here.
- Do not commit API keys, tokens, authenticated configuration, or machine-specific paths.
- Keep project-specific skills in that project's `.agents/skills` directory instead.
