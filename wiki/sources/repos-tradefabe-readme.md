---
kind: source
domain: projects
course: "tradefabe"
title: "README.md"
raw_file: raw/repos/tradefabe/README.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 5de0ecc
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
count in favor of "parallel by default" (test-suite speed-up, #160/#162) — operational, not
a content change. See [[tradefabe]].

Raw: `raw/repos/tradefabe/README.md`.
