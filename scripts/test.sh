#!/usr/bin/env bash
# Sanity checks for log-append.sh / manifest-diff.sh / manifest-update.sh.
# Non-destructive: everything runs against a temp copy of the vault's real
# data, and the real wiki/log.md and .manifest.json are never written to.
set -euo pipefail
cd "$(dirname "$0")/.."

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

pass=0
fail=0
check() {
  if [[ "$1" == "$2" ]]; then
    echo "  ok: $3"
    pass=$((pass + 1))
  else
    echo "  FAIL: $3"
    echo "    expected: $2"
    echo "    actual:   $1"
    fail=$((fail + 1))
  fi
}

echo "== log-append.sh: pure append, no corruption =="
cp wiki/log.md "$tmp/log.md"
before_bytes=$(wc -c < "$tmp/log.md")
LOG_FILE="$tmp/log.md" ./scripts/log-append.sh "TEST-ENTRY — scripted check" <<'EOF'
line one
line two
EOF
after_bytes=$(wc -c < "$tmp/log.md")
check "$( [[ $after_bytes -gt $before_bytes ]] && echo yes)" "yes" "file grew"
check "$(head -c "$before_bytes" "$tmp/log.md" | shasum -a 256 | awk '{print $1}')" \
      "$(head -c "$before_bytes" wiki/log.md | shasum -a 256 | awk '{print $1}')" \
      "existing content untouched (prefix hash matches original)"
check "$(tail -1 "$tmp/log.md")" "line two" "new entry body present at EOF"
check "$(grep -c '^## TEST-ENTRY — scripted check$' "$tmp/log.md")" "1" "heading appended once"

echo
echo "== manifest-update.sh + manifest-diff.sh: round trip on a fixture =="
# manifest-diff.sh / manifest-update.sh always cd to the real repo root (so
# they work regardless of the caller's cwd in real/scheduled use), so
# fixtures must live under a relative repo path. raw/ is entirely gitignored,
# so a throwaway subfolder there is safe and gets removed below.
fixtures="raw/.test-fixtures"
mkdir -p "$fixtures"
trap 'rm -rf "$tmp" "$fixtures"' EXIT
echo "fixture v1" > "$fixtures/a.md"
echo '{"version":1,"note":"test","sources":{}}' > "$tmp/manifest.json"

# fresh file should show as NEW
out="$(MANIFEST_FILE="$tmp/manifest.json" RAW_DIR="$fixtures" ./scripts/manifest-diff.sh)"
check "$out" "NEW $fixtures/a.md" "new fixture file detected"

# record it
MANIFEST_FILE="$tmp/manifest.json" ./scripts/manifest-update.sh "$fixtures/a.md" '["sources/fixture-a"]'
recorded_sha=$(jq -r --arg p "$fixtures/a.md" '.sources[$p].sha256' "$tmp/manifest.json")
actual_sha=$(shasum -a 256 "$fixtures/a.md" | awk '{print $1}')
check "$recorded_sha" "$actual_sha" "manifest-update recorded correct sha256"
check "$(jq -r --arg p "$fixtures/a.md" '.sources[$p].derived[0]' "$tmp/manifest.json")" "sources/fixture-a" "derived array recorded"

# unchanged now -> no output from diff
out="$(MANIFEST_FILE="$tmp/manifest.json" RAW_DIR="$fixtures" ./scripts/manifest-diff.sh)"
check "$out" "" "unchanged fixture produces no diff output"

# modify it -> CHANGED
echo "fixture v2" > "$fixtures/a.md"
out="$(MANIFEST_FILE="$tmp/manifest.json" RAW_DIR="$fixtures" ./scripts/manifest-diff.sh)"
check "$out" "CHANGED $fixtures/a.md" "modified fixture detected as CHANGED"

# other pre-existing manifest entries must be untouched by manifest-update.sh
echo "fixture b" > "$fixtures/b.md"
MANIFEST_FILE="$tmp/manifest.json" ./scripts/manifest-update.sh "$fixtures/b.md" '["sources/fixture-b"]'
check "$(jq -r --arg p "$fixtures/a.md" '.sources[$p].derived[0]' "$tmp/manifest.json")" "sources/fixture-a" "unrelated existing entry survives a second update"

echo
echo "== manifest-diff.sh: real (read-only) dry run against the actual vault backlog =="
real_new=$(./scripts/manifest-diff.sh | grep -c '^NEW ' || true)
echo "  NEW files reported against the real raw/ + .manifest.json: $real_new"
check "$( [[ $real_new -ge 100 ]] && echo yes)" "yes" "matches the known ~124-file pending /ingest backlog (>=100)"

echo
echo "== log-rotate.sh: archives past months, keeps current month + unparseable =="
current_month="$(date +%Y-%m)"
rot_log="$tmp/rotate-log.md"
rot_archive="$tmp/archive"
cat > "$rot_log" <<EOF
# Log

Append-only. Never rewrite prior entries.

## 2020-01-05 — old entry

old body text, line one.
old body text, line two.

---

## no-date-here — weird heading, no leading date

should be kept (unparseable, safety default).

---

## ${current_month}-15 — current entry

current body text.
EOF

LOG_FILE="$rot_log" ARCHIVE_DIR="$rot_archive" ./scripts/log-rotate.sh > "$tmp/rotate-out-1.txt"
check "$(cat "$tmp/rotate-out-1.txt" | grep -c '^archived 1 entry')" "1" "reports archiving exactly 1 entry"
check "$(test -f "$rot_archive/2020-01.md" && echo yes)" "yes" "archive file for 2020-01 created"
check "$(grep -c '^## 2020-01-05 — old entry$' "$rot_archive/2020-01.md")" "1" "archived entry heading present in archive file"
check "$(grep -c 'old body text, line two.' "$rot_archive/2020-01.md")" "1" "archived entry body preserved"
check "$(grep -c '^## 2020-01-05 — old entry$' "$rot_log")" "0" "archived entry removed from live log"
check "$(grep -c '^## no-date-here' "$rot_log")" "1" "unparseable entry stays in live log (safety default)"
check "$(grep -c "^## ${current_month}-15 — current entry\$" "$rot_log")" "1" "current-month entry stays in live log"

echo
echo "== log-rotate.sh: idempotent (second run with nothing new to archive) =="
before_hash="$(shasum -a 256 "$rot_log" | awk '{print $1}')"
out2="$(LOG_FILE="$rot_log" ARCHIVE_DIR="$rot_archive" ./scripts/log-rotate.sh)"
after_hash="$(shasum -a 256 "$rot_log" | awk '{print $1}')"
check "$out2" "nothing to archive (all entries are in the current month)" "second run reports nothing to archive"
check "$after_hash" "$before_hash" "live log byte-identical after no-op run"

echo
echo "== log-rotate.sh: appends to an already-existing archive file for the same month =="
cat >> "$rot_log" <<'EOF'

---

## 2020-01-20 — second old entry

a second entry landing in the same already-archived month.
EOF
LOG_FILE="$rot_log" ARCHIVE_DIR="$rot_archive" ./scripts/log-rotate.sh > "$tmp/rotate-out-3.txt"
check "$(grep -c '^# Log archive — 2020-01$' "$rot_archive/2020-01.md")" "1" "archive file header written only once, not duplicated"
check "$(grep -c '^## 2020-01-05 — old entry$' "$rot_archive/2020-01.md")" "1" "first archived entry still present"
check "$(grep -c '^## 2020-01-20 — second old entry$' "$rot_archive/2020-01.md")" "1" "second archived entry appended"
check "$(grep -c "^## ${current_month}-15 — current entry\$" "$rot_log")" "1" "current-month entry still untouched after second rotation"

echo
echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
