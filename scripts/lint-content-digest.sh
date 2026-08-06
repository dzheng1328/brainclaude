#!/usr/bin/env bash
# Prints a single sha256 digest over every tracked file under wiki/ and raw/
# plus .manifest.json (excluding the gitignored, private wiki/personal/ tree).
# The mechanical /lint checks (staleness, orphans, broken provenance) are pure
# functions of this content -- an identical digest guarantees an identical
# result, so watchdog.sh uses this to skip invoking the LLM for /lint entirely
# on a day nothing changed anywhere, instead of paying tokens to re-derive the
# same "nothing to report" finding.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 2

find wiki raw .manifest.json -type f -not -path 'wiki/personal/*' 2>/dev/null \
  | LC_ALL=C sort \
  | xargs shasum -a 256 \
  | shasum -a 256 \
  | awk '{print $1}'
