---
kind: source
domain: projects
course: "tradefabe"
title: "README.md"
raw_file: raw/repos/tradefabe/README.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: unknown (git access blocked this session; re-sync verified via content diff, not git log)
fetched: 2026-08-11
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
(#147) cap the factory-owned pool. Since that snapshot (2026-08-07 re-sync): the repo layout
section gained three new entries documenting a dashboard rebuild in progress —
`src/tradefabe/dashboard.py` (a Streamlit-free data/chart-shaping layer `app.py` now imports
from, the single source of truth for the rebuild), `src/tradefabe/api/` (a thin FastAPI read
layer over `dashboard.py`, one endpoint so far, not wired into the desktop app yet), and
`frontend/` (Vite/React/TypeScript/Tailwind/Framer Motion — dark/lime/26px-radius theme
landed, currently one placeholder screen, not a real page). `app.py` itself is noted as
"still the only LIVE UI" — the new layer is additive, not a cutover. Since that snapshot
(2026-08-11 re-sync): the `src/tradefabe/api/` layout line now lists two more endpoints
(`GET /api/books/up_for_review`, `GET /api/books/{name}/detail`) alongside the existing
`GET /api/books/summary` — small addition, same "not wired into the desktop app yet" state.
See [[tradefabe]].

Promotes: [[strangler-fig-ui-migration]].

Raw: `raw/repos/tradefabe/README.md`.
