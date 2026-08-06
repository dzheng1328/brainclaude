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

# Cheap duplicate guard: warn (don't block) if a heading for today's date already
# exists. This is what would have caught the Aug 1-5 same-day duplicate/contradictory
# entries early instead of letting them silently pile up for days -- a loud stderr
# warning here lands in watchdog.log where the next run (or a human) will actually see it.
today_prefix="$(date '+%Y-%m-%d')"
if [[ "$heading" == "$today_prefix"* ]] && grep -qF "## $today_prefix" "$log_file" 2>/dev/null; then
  echo "WARNING: wiki/log.md already has a heading dated $today_prefix -- appending anyway (log.md is append-only), but check whether this is a genuine follow-up or a forced re-run that should be squashed later." >&2
fi

printf '\n---\n\n## %s\n\n%s\n' "$heading" "$body" >> "$log_file"
