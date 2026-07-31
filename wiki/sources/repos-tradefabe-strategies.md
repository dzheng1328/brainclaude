---
kind: source
domain: projects
course: "tradefabe"
title: "STRATEGIES.md"
raw_file: raw/repos/tradefabe/STRATEGIES.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 36050ce
fetched: 2026-07-31
---

# STRATEGIES.md

tradefabe repo doc "STRATEGIES.md" — the pre-registered strategy roster. Since the
2026-07-25 snapshot, a new **family L (intraday/hourly, #86)** was pre-registered
2026-07-26 with specs frozen before any run: `funding_timing_1h`, `crypto_reversal_1h`,
`equity_tsmom_1h` — all three DEAD (funding-timing loses to just holding always-on carry;
the two directional ones lose outright to turnover drag). Every hourly data source only
reaches back to 2023-2024, so family L's OOS window can't span 2018's vol spike, COVID, or
the 2022 bear — Dave's explicit call was to accept the regime limitation and label an ALIVE
verdict here as weaker evidence than elsewhere in this file, rather than bend doctrine to
fit the data. All three now run as live monitor-only paper books regardless (backtest-DEAD
strategies can never become paper-confirmed under DOCTRINE v1.2, same status as any factory
promotion) — their signals live in `src/tradefabe/hourly.py`, imported by both the backtest
study and the live book so the two can't silently drift apart. Still only one real
survivor: delta-neutral crypto funding carry (~12%/yr net on Hyperliquid, 2023-26).
Everything else is DEAD. See [[tradefabe]].

Raw: `raw/repos/tradefabe/STRATEGIES.md`.
