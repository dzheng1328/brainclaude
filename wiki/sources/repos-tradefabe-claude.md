---
kind: source
domain: projects
course: "tradefabe"
title: "CLAUDE.md"
raw_file: raw/repos/tradefabe/CLAUDE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: unknown (git access blocked this session; re-sync verified via content diff, not git log)
fetched: 2026-08-11
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
tests, ~8s" to "worksteal, ~3-4s" — a test-suite speed-up (#160/#162). Since that snapshot:
the automation table's `run` cron moved from 22:07 UTC to ~02:00 UTC (#158, kronos's yfinance
daily bar was a day stale at 22:07, silently skipping `kronos_wick_agg`'s rebalance) and the
`factory` cron resumed daily at 21:06 UTC (#163, after pausing 2026-07-27–31 for #98) now that
ledger segregation (DOCTRINE v1.5) and `MAX_FACTORY_PROMOTED` (#147) bound its growth. Since
that snapshot, two more scheduled workflows joined the automation table: **cost check**
(`cost-check.yml`, #155) — weekly, Mondays ~9:37am ET, Alpaca PAPER secrets, same paper-only
gates as a local run — and **pipeline daily** (`pipeline-daily.yml`, #177-181) — daily,
~10:42am ET, screening (#175) then auto-pre-registering on a pass (#179) then OOS-testing
pending candidates, promoting ALIVE ones capped at 10 (#180, its own pool, separate from
`MAX_FACTORY_PROMOTED`); proposal itself isn't in this workflow — a scheduled Claude Code
Routine writes candidate rows directly, up to 10/day fixed, under Dave's Pro plan. Since that
snapshot (2026-08-06 re-sync): two new standing rules. **Two skills are
`disable-model-invocation: true`** — `.claude/skills/ship` (`/ship`) and
`.claude/skills/new-strategy` (`/new-strategy`) — an agent can't discover or invoke either any
other way, so Dave should be asked to run the matching one instead of hand-running the
branch/PR/CI/merge sequence or the pre-register-before-results sequence. **The
`doctrine-auditor` subagent must run before merging any PR touching `STRATEGIES.md`/
`graveyard.csv`** — added after it was skipped once already (#195, 2026-08-04), letting a new
primitive merge with no doctrine review, caught only in retrospect. Since that snapshot
(2026-08-11 re-sync): the Layout section gained a note on the dashboard rebuild (#203/#204
merged 2026-08-06) — moving off Streamlit to React/FastAPI, `app.py` still the only live UI,
`src/tradefabe/dashboard.py` the shared Streamlit-free data/chart layer, `src/tradefabe/api/`
a thin FastAPI read layer over it, `frontend/` one placeholder screen so far — and the
Commands block gained an optional dashboard-rebuild section (`pip install -e
".[dev,desktop,api]"`, `tradefabe-api` on localhost:8000, `npm run dev` on localhost:5173).
See [[tradefabe]].

Promotes: [[no-chained-branch-delete-after-merge]], [[pre-merge-review-gate-high-consequence-files]].

Raw: `raw/repos/tradefabe/CLAUDE.md`.
