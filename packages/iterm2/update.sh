#!/usr/bin/env nix-shell
#!nix-shell -i bash -p coreutils curl gnused jq nurl
#shellcheck shell=bash

# Pins the shell integration scripts in module.nix to a commit of
# gnachman/iTerm2-shell-integration: the given one, or else the latest that
# touched shell_integration/.

set -eu -o pipefail

nixfile="$(dirname "$(readlink -f "$0")")/module.nix"
repo="gnachman/iTerm2-shell-integration"

rev="${1:-}"
if [ -z "$rev" ]; then
  rev="$(curl -fsSL "https://api.github.com/repos/$repo/commits?path=shell_integration&per_page=1" | jq -r '.[0].sha')"
fi

old_rev="$(sed -n 's|.*rev = "\([0-9a-f]*\)";.*|\1|p' "$nixfile")"
if [ "$rev" = "$old_rev" ]; then
  echo "iterm2 shell integration already at $rev" >&2
  exit 0
fi

for shell in bash fish zsh; do
  url="https://raw.githubusercontent.com/$repo/$rev/shell_integration/$shell"
  hash="$(nurl --hash --expr "(import <nixpkgs> { }).fetchurl { url = \"$url\"; }")"

  echo "$shell: hash=$hash" >&2

  # Replace the hash on this shell's `fetch "<shell>" "<hash>"` line.
  sed -i "s|fetch \"$shell\" \"[^\"]*\";|fetch \"$shell\" \"$hash\";|" "$nixfile"
done

sed -i "s|rev = \"$old_rev\";|rev = \"$rev\";|" "$nixfile"

echo "updated iterm2 shell integration $old_rev -> $rev" >&2
