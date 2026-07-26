---
kind: source
domain: projects
course: "tradefabe"
title: "STRATEGIES.md"
raw_file: raw/repos/tradefabe/STRATEGIES.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 6ab7c04
fetched: 2026-07-25
---

# STRATEGIES.md

tradefabe repo doc "STRATEGIES.md" — the pre-registered strategy roster, now organized into
11 families (up from 8) by edge source: trend, mean reversion, calendar, defensive/low-vol,
carry, volatility risk premium, information-following, piggyback constructions, plus three
new families since the last snapshot — breakout/channel (I), ICT/Smart-Money-Concepts (J,
all six DEAD), and contribution-schedule overlays (K, dip-buy timing loses to plain
dollar-cost-averaging in every tested window). New section documents the **strategy factory**
(`factory.py`/`factory_run.py`): a pre-registered template library plus live parameter-range
generation, each candidate logged to `generated_templates.csv` before its verdict, with the
best-DSR candidate promoted to a live paper book every cycle regardless of verdict. Still only
one real survivor: delta-neutral crypto funding carry (~12%/yr net on Hyperliquid, 2023-26).
Everything else — now 49+ tested specs — is DEAD. See [[tradefabe]].

Raw: `raw/repos/tradefabe/STRATEGIES.md`.
