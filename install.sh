#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_root="$repo_root/skills"
target_root="$HOME/.agents/skills"

mkdir -p "$target_root"

for source in "$source_root"/*; do
  [ -d "$source" ] || continue
  target="$target_root/$(basename "$source")"

  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$(readlink -f "$target")" = "$(readlink -f "$source")" ]; then
      printf 'Already linked: %s\n' "$target"
      continue
    fi

    printf 'Refusing to replace existing path: %s\n' "$target" >&2
    exit 1
  fi

  ln -s "$source" "$target"
  printf 'Linked: %s -> %s\n' "$target" "$source"
done

printf '\nRestart Codex if the skills list does not refresh automatically.\n'
