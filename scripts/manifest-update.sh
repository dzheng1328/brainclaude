#!/usr/bin/env bash
# Patch one entry in .manifest.json's sources map via jq, WITHOUT reading or
# rewriting the whole file through the model. Recomputes the sha256 itself.
#
# Usage:
#   scripts/manifest-update.sh <raw-relative-path> '<json-array-of-derived-pages>'
#   scripts/manifest-update.sh raw/repos/imgsic/README.md '["sources/repos-imgsic-readme"]'
#
# <json-array-of-derived-pages>: wiki pages this source produced/updated,
# paths relative to wiki/ with no .md extension (matches the existing
# `derived` field convention).
#
# Set MANIFEST_FILE to target a different file (used by scripts/test.sh).
set -euo pipefail
cd "$(dirname "$0")/.."

manifest="${MANIFEST_FILE:-.manifest.json}"

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <raw-relative-path> '<json-array-of-derived-pages>'" >&2
  exit 1
fi

path="$1"
derived="$2"

if [[ ! -f "$path" ]]; then
  echo "error: $path does not exist" >&2
  exit 1
fi

sha=$(shasum -a 256 "$path" | awk '{print $1}')

tmp=$(mktemp)
jq --arg p "$path" --arg h "$sha" --argjson d "$derived" \
  '.sources[$p] = ((.sources[$p] // {}) + {sha256: $h, derived: $d})' \
  "$manifest" > "$tmp"
mv "$tmp" "$manifest"
