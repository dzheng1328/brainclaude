#!/usr/bin/env bash
# Append a dated entry to wiki/log.md WITHOUT reading the file first.
# log.md is append-only by schema (CLAUDE.md); a plain append needs no read
# of existing content, which avoids paying the full-file-read token cost on
# every scheduled run as the log grows.
#
# Usage:
#   scripts/log-append.sh "2026-07-30 — /lint incremental run" <<'EOF'
#   Entry body in markdown. Can span multiple paragraphs.
#   EOF
#
# Set LOG_FILE to target a different file (used by scripts/test.sh).
set -euo pipefail
cd "$(dirname "$0")/.."

log_file="${LOG_FILE:-wiki/log.md}"

if [[ $# -lt 1 ]]; then
  echo "usage: $0 \"<heading>\" < body.md" >&2
  exit 1
fi

heading="$1"
body="$(cat)"

printf '\n---\n\n## %s\n\n%s\n' "$heading" "$body" >> "$log_file"
