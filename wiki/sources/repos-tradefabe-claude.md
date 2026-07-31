---
kind: source
domain: projects
course: "tradefabe"
title: "CLAUDE.md"
raw_file: raw/repos/tradefabe/CLAUDE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 5de0ecc
fetched: 2026-07-31
---

# CLAUDE.md

tradefabe repo doc "CLAUDE.md" — agent orientation. States the hard rule (never execute a
real trade, connect real credentials, or give personalized investment advice, without Dave
explicitly saying so in chat) and the git workflow (branch + PR, not direct pushes to
`main`). Since the 2026-07-25 snapshot: **the repo moved from `~/Documents/tradefabe` to
`~/tradefabe`** (2026-07-26) — iCloud sync in `~/Documents` was corrupting the venv and
writing conflict copies of tracked files, the same class of problem that motivated moving
this vault itself out of iCloud sync; a compatibility symlink remains at the old path, but
new config should use the real path. New standing rule: **never chain a branch delete after
a merge in the same command** — `gh pr merge` can fail silently on a bad flag, and anything
chained after it (`;`/`&&`) still runs, deleting the branch and closing the still-unmerged
PR (has cost three recoveries, #65/#80/#92, each needing a reflog dig and a fresh PR); merge,
verify `state=MERGED` as its own step, only then delete. This file also now states it is
"loaded into every session and re-injected after every compaction" and should stay short —
a fixed-and-guarded bug is a one-line rule plus its enforcing test, not a post-mortem. Since
the 2026-07-31 (morning) snapshot: the pytest command comment changed from a hardcoded "433
tests, ~8s" to "worksteal, ~3-4s" — a test-suite speed-up (#160/#162), not a count worth
citing. See [[tradefabe]].

Raw: `raw/repos/tradefabe/CLAUDE.md`.
