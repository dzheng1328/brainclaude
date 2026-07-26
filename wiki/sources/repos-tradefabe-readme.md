---
kind: source
domain: projects
course: "tradefabe"
title: "README.md"
raw_file: raw/repos/tradefabe/README.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 6ab7c04
fetched: 2026-07-25
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
17:00, an hour ahead of the 18:00 rebalance so a same-evening promotion opens its book). See
[[tradefabe]].

Raw: `raw/repos/tradefabe/README.md`.
