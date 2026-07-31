#!/usr/bin/env bash
# Diff raw/ against .manifest.json WITHOUT loading the manifest into the
# caller's context. Prints one line per new/changed file:
#   NEW <path>
#   CHANGED <path>
# Unchanged files (the overwhelming majority once the vault is caught up)
# are never printed and never need to be reasoned about.
#
# Set MANIFEST_FILE / RAW_DIR to target different paths (used by scripts/test.sh).
set -euo pipefail
cd "$(dirname "$0")/.."

manifest="${MANIFEST_FILE:-.manifest.json}"
raw_dir="${RAW_DIR:-raw}"

# Avoid bash4-only associative arrays (macOS ships bash 3.2 by default) — use
# a flat "path<TAB>hash" lookup file + awk instead.
known_tmp="$(mktemp)"
trap 'rm -f "$known_tmp"' EXIT
jq -r '.sources | to_entries[] | "\(.key)\t\(.value.sha256)"' "$manifest" > "$known_tmp"

find "$raw_dir" -type f ! -name '.DS_Store' -print0 | while IFS= read -r -d '' f; do
  actual=$(shasum -a 256 "$f" | awk '{print $1}')
  existing=$(awk -F'\t' -v p="$f" '$1 == p { print $2; exit }' "$known_tmp")
  if [[ -z "$existing" ]]; then
    echo "NEW $f"
  elif [[ "$existing" != "$actual" ]]; then
    echo "CHANGED $f"
  fi
done
