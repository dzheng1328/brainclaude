#!/usr/bin/env bash
# Cheap, non-LLM gate for /sync-projects: for every `status: active` project
# pointer card, compare each already-snapshotted raw/repos/<project>/<doc>
# (per .manifest.json) against the live file at <path>/<doc> by sha256. This
# is exactly the check /sync-projects itself does per-project when it runs --
# doing it here in Python first means a day with zero drift costs no LLM
# tokens at all, instead of paying for the LLM to rediscover "nothing changed"
# via its own file reads.
#
# Exit 0 + "CLEAN" if every active project's live docs match their snapshot.
# Exit 1 + "CHANGED" plus a list of what differs otherwise.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 2

python3 <<'PYEOF'
import json, hashlib, glob, re, os, sys

manifest = json.load(open(".manifest.json"))["sources"]
changed = []

for card_path in glob.glob("wiki/entities/projects/*.md"):
    text = open(card_path, encoding="utf-8").read()
    if not text.startswith("---\n"):
        continue
    fm_end = text.find("\n---\n", 4)
    if fm_end == -1:
        continue
    fm = text[4:fm_end]
    status_m = re.search(r'^status:\s*(\S+)', fm, re.M)
    path_m = re.search(r'^path:\s*(.+)$', fm, re.M)
    if not status_m or status_m.group(1) != "active":
        continue
    if not path_m or path_m.group(1).strip() == "null":
        continue
    live_root = path_m.group(1).strip()
    project = os.path.splitext(os.path.basename(card_path))[0]
    prefix = f"raw/repos/{project}/"

    for raw_path, meta in manifest.items():
        if not raw_path.startswith(prefix):
            continue
        doc_name = raw_path[len(prefix):]
        live_path = os.path.join(live_root, doc_name)
        if not os.path.isfile(live_path):
            changed.append(f"{project}/{doc_name}: live file missing at {live_path}")
            continue
        live_hash = hashlib.sha256(open(live_path, "rb").read()).hexdigest()
        if live_hash != meta.get("sha256"):
            changed.append(f"{project}/{doc_name}: live file differs from snapshot")

if changed:
    print("CHANGED")
    for c in changed:
        print(" -", c)
    sys.exit(1)
else:
    print("CLEAN")
    sys.exit(0)
PYEOF
