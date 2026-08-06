---
kind: source
domain: projects
course: "tradefabe"
title: "STRATEGIES.md"
raw_file: raw/repos/tradefabe/STRATEGIES.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: unknown (git access blocked this session; re-sync verified via content diff, not git log)
fetched: 2026-08-04
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
Everything else is DEAD. Since that snapshot: an **amendment, pre-registered 2026-07-31
(#156)**, swaps `equity_tsmom_1h`'s data source from yfinance (730-day window) to Alpaca
(hourly equity bars back to ~2016) — `crypto_reversal_1h`/`funding_timing_1h` are not
re-run, since Alpaca's own crypto history doesn't reach further back than what's already
covered. Same spec, gates, and thresholds; per DOCTRINE's forward-only rule this is a new
graveyard row, not an edit to the original 2026-07-26 verdict. Re-run result: still DEAD,
more decisively — Sharpe **−3.64** (was −1.93), MaxDD **−100.0%** (was −40.7%) once the
longer window correctly includes 2018's vol spike, COVID, and the 2022 bear. Since that
snapshot, two more sections landed. **Family N (pairs/cointegration, #172), pre-registered
2026-08-01, result DEAD (2026-07-31 run).** Six pairs were chosen for an economic reason to
co-move (precious metals, treasury duration, developed-vs-emerging equities, broad-vs-tech
equities, oil-vs-commodities, IG-vs-HY credit) *before* any cointegration test ran, so the
selection itself isn't a p-hacked scan; each pair is then Engle-Granger tested (OLS hedge
ratio + intercept on 2007-2017 calibration data, ADF test the residual for stationarity,
p<0.05 to trade). Only `LQD`/`HYG` cleared (p=0.037); the other five never traded OOS. The
one tradeable spread showed no edge (Sharpe 0.00, DSR 0.150, fails gate 1 outright). Two real
bugs were found and fixed while building it: `sized_weights()` was silently diluting a
sparse pairs signal by dividing across the full 12-ticker universe instead of just the
pairs that cleared the filter, and the z-score entry condition allowed entering a position
already past the force-flat stop. **A new "Research pipeline — primitive vocabulary"
section (#174/#177)** documents the fixed vocabulary (`pair_zscore`, `cross_sectional_rank`,
`single_asset_trend`, `static_spread_carry`, plus the new compositional
`asset_class_trend_hedge`) the automated research routine picks from rather than writing its
own code, and records the proposal pipeline moving from an in-process, budget-capped Haiku
call to a scheduled Claude Code Routine writing up to 10 proposals/day directly. See
[[tradefabe]].

Raw: `raw/repos/tradefabe/STRATEGIES.md`.
