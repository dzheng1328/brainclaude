#!/usr/bin/env bash
# Archive completed past months out of wiki/log.md into wiki/log-archive/YYYY-MM.md,
# keeping only the current calendar month's entries (plus anything unparseable, as a
# safety default) in the live file. Entry heading+body text is relocated verbatim,
# byte-for-byte -- never reworded -- so this doesn't violate the append-only/never-
# rewrite rule, it only bounds how much of the log every scheduled run has to read.
# (The "---" separator lines between entries get normalized to a single consistent
# style when the file is re-serialized, since the source file was never consistent
# about them either -- a purely cosmetic whitespace change, not a content change.)
#
# Safe to call on every /ingest run (weekly): most calls are a no-op, since everything
# already in the live log is normally from the current month. It only actually moves
# data on the first call after a new month has started.
#
# Set LOG_FILE / ARCHIVE_DIR to target different paths (used by scripts/test.sh).
set -euo pipefail
cd "$(dirname "$0")/.."

log_file="${LOG_FILE:-wiki/log.md}"
archive_dir="${ARCHIVE_DIR:-wiki/log-archive}"
current_month="$(date +%Y-%m)"

if [[ ! -f "$log_file" ]]; then
  echo "no $log_file to rotate" >&2
  exit 0
fi

LOG_FILE="$log_file" ARCHIVE_DIR="$archive_dir" CURRENT_MONTH="$current_month" python3 - <<'PYEOF'
import os
import re

log_file = os.environ["LOG_FILE"]
archive_dir = os.environ["ARCHIVE_DIR"]
current_month = os.environ["CURRENT_MONTH"]

with open(log_file, encoding="utf-8") as f:
    text = f.read()

# Preamble = everything before the first "## " heading (the "# Log" title + note).
parts = re.split(r"(?m)^(?=## )", text)
preamble, raw_entries = parts[0], parts[1:]

# Splitting right before "## " glues the *next* entry's leading "---" separator
# onto the end of the *previous* chunk. Strip that artifact so each entry is a
# clean, self-contained unit; a uniform separator is re-inserted on write below.
sep_tail = re.compile(r"\n\n-{3,}\n\n\Z")
entries = [sep_tail.sub("\n", e).rstrip("\n") + "\n" for e in raw_entries]

date_re = re.compile(r"^## (\d{4}-\d{2})-\d{2}\b")

kept = []
archived = {}  # month -> list[entry_text], in original order

for entry in entries:
    m = date_re.match(entry)
    month = m.group(1) if m else None
    if month is None or month == current_month:
        kept.append(entry)  # unparseable or current month: leave in place
    else:
        archived.setdefault(month, []).append(entry)

if not archived:
    print("nothing to archive (all entries are in the current month)")
    raise SystemExit(0)

os.makedirs(archive_dir, exist_ok=True)

for month in sorted(archived):
    month_entries = archived[month]
    path = os.path.join(archive_dir, f"{month}.md")
    existing = ""
    if os.path.exists(path):
        with open(path, encoding="utf-8") as f:
            existing = f.read()
    with open(path, "w", encoding="utf-8") as f:
        if not existing:
            f.write(
                f"# Log archive — {month}\n\n"
                f"Archived from `wiki/log.md` by `scripts/log-rotate.sh`. "
                f"Entries are moved verbatim — never edited.\n\n"
            )
        else:
            f.write(existing.rstrip("\n") + "\n\n---\n\n")
        f.write("\n---\n\n".join(month_entries))
    n = len(month_entries)
    print(f"archived {n} entr{'y' if n == 1 else 'ies'} -> {path}")

with open(log_file, "w", encoding="utf-8") as f:
    f.write(preamble.rstrip("\n") + "\n\n")
    f.write("\n---\n\n".join(kept))

n = len(kept)
print(f"live {log_file} now holds {n} entr{'y' if n == 1 else 'ies'} (current month + unparseable)")
PYEOF
