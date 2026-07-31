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
echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
