#!/usr/bin/env nix-shell
#!nix-shell -i bash -p coreutils curl gawk gnugrep gnused nurl
#shellcheck shell=bash

set -eu -o pipefail

nixfile="$(dirname "$(readlink -f "$0")")/default.nix"

version=""

update_arch() {
  local arch="$1"

  local source_url
  source_url="$(curl -sL -I "https://orbstack.dev/download/stable/latest/$arch" | grep -i "location:" | awk '{print $2}' | tr -d '\r')"

  local arch_version
  arch_version="$(echo "$source_url" | grep -o '\([0-9]\+\.\)\{2\}[0-9]\+_[0-9]\+' | sed 's/_/-/')"

  if [ -z "$version" ]; then
    version="$arch_version"
  elif [ "$version" != "$arch_version" ]; then
    echo "version mismatch between arches: $version != $arch_version" >&2
    exit 1
  fi

  local hash
  hash=$(nurl --hash --expr "(import <nixpkgs> { }).fetchurl { url = \"$source_url\"; }")

  echo "$arch: version=$arch_version hash=$hash" >&2

  # Replace the hash line that immediately follows this arch's `arch = "..."` line.
  sed -i "/arch = \"$arch\";/{n;s|hash = \"[^\"]*\";|hash = \"$hash\";|}" "$nixfile"
}

update_arch "arm64"
update_arch "amd64"

# Update the shared version string.
sed -i "s|version = \"[^\"]*\";|version = \"$version\";|" "$nixfile"

echo "updated orbstack to $version" >&2
