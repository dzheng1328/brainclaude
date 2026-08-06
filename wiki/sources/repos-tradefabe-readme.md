---
kind: source
domain: projects
course: "tradefabe"
title: "README.md"
raw_file: raw/repos/tradefabe/README.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 634efbf
fetched: 2026-07-31
---

# README.md

tradefabe repo doc "README.md" — the user-facing overview: what the project is (a
doctrine-governed strategy-testing lab plus an autonomous paper-trading engine, paper only),
the headline finding (now 49+ strategies dead, up from 12+, since a strategy factory —
`src/tradefabe/factory.py` + `research/factory_run.py` — started generating parametrized
variants; buy-and-hold and crypto funding carry remain the only survivors), the repo layout
(new: `piggyback.py`, `factory.py`, `generated_templates.csv`), quickstart commands, the
growing set of paper books (5 hand-picked plus a factory promotion accumulating one per daily
cycle), and three launchd agents (`tradefabe`, `.mark`, `.factory` — the factory runs daily at
17:00, an hour ahead of the 18:00 rebalance so a same-evening promotion opens its book). Since
the 2026-07-31 (morning) snapshot: the `tests/` layout line dropped its hardcoded "433 tests"
count in favor of "parallel by default" (test-suite speed-up, #160/#162). Since that snapshot:
the automation table's `run` cron entry moved from "daily 22:07 UTC" to "daily ~02:00 UTC",
and `factory` flipped from "paused since 2026-07-27" to "daily 21:06 UTC" — **resumed
2026-07-31 (#163)** now that ledger segregation (DOCTRINE v1.5) and `MAX_FACTORY_PROMOTED`
(#147) cap the factory-owned pool. See [[tradefabe]].

Raw: `raw/repos/tradefabe/README.md`.
