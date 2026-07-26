---
kind: project
domain: projects
title: tradefabe
repo: https://github.com/dzheng1328/tradefabe.git
path: /Users/dzheng/Documents/tradefabe
stack: [Python, Streamlit, Plotly, pytest, Hyperliquid API]
status: active
last_commit: 2026-07-25
---

# tradefabe

A **doctrine-governed lab for testing trading strategies honestly**, plus an autonomous
**paper-trading engine** that runs the survivors as simulated books. **Paper only — no
real money is connected, and nothing here is investment advice.** A `launchd` agent
(`com.dzheng.tradefabe`) runs one paper cycle daily at 18:00 local. ^[[sources/repos-tradefabe-readme]]

**The headline finding:** 12+ retail strategies were tested against a pre-registered kill
rule — every predictive or copy-based approach (price patterns, congressional-purchase
copying, insider-buying copying, thematic picking, candlestick wicks) came out dead or
overfit. Two things survived: **diversified buy-and-hold**, and **delta-neutral crypto
funding carry** (long spot + short perp, collecting funding — ~12%/yr net on Hyperliquid,
2023-26, market-neutral, +1.3% through a −53% BTC crash), which is compensation for
bearing real crypto-infrastructure tail risk the backtest window (which excludes the 2022
FTX collapse) cannot see. ^[[sources/repos-tradefabe-readme]] ^[[sources/repos-tradefabe-strategies]]

## The evaluation doctrine

Every verdict runs through a **pre-registered, out-of-sample methodology** (`DOCTRINE.md`,
frozen v1.0, 2026-07-21) designed specifically to prevent p-hacking the doctrine itself to
fit results already seen: thresholds are frozen and timestamped before the strategy zoo
runs; design/calibration uses 2007-2017 and every verdict is rendered on 2018-present data
the design never touched; the pass bar is a **data-derived noise floor** — 500 random
strategies run through the identical machinery, judged against the 95th percentile of
their out-of-sample Sharpe (matched by rebalance frequency, v1.0.1) — rather than an
arbitrary number; and candidates are compared to a fair 60/40 passive benchmark, not the
best asset in hindsight. A strategy is ALIVE only if it beats the noise floor, earns its
place (better Calmar than the benchmark, or genuinely diversifies), and isn't more
painful (drawdown ≤ 1.5× benchmark) — otherwise it's DEAD and logged to `graveyard.csv`,
the append-only multiple-testing record. ^[[sources/repos-tradefabe-doctrine]]

**v1.3 (2026-07-24)** activated a Bonferroni multiple-testing correction on the noise
floor that had been flagged as owed since v1.0. Applied retroactively, it flips 3 of 4
"piggyback" constructions (DEAD strategies re-tried as a diversifying sleeve on the 60/40
core) from ALIVE back to DEAD — not a formula artifact, but a structural consequence: a
piggyback already holds 70% of the benchmark by construction, so its random-sleeve null
Sharpe clusters tightly around the benchmark's own, leaving little room for any real
sleeve to clear a properly corrected bar. ^[[sources/repos-tradefabe-doctrine]]
^[[sources/repos-tradefabe-strategies]]

**Paper-testing (v1.2)** is a second gate for strategies that already passed the
backtest: a statistical-power argument (`T_required = max(2 years, (2/SR_bt)² years)`)
sets how long a book must run before its live Sharpe can actually confirm the backtested
edge, with an explicit caveat that the formula breaks for low-noise, regime-driven return
streams — `carry_btc_eth`'s daily Sharpe of 10.85 would otherwise imply confirmation in
~12 days, which is absurd, so carry-type books are floored at the 2-year minimum instead
of trusting the formula. ^[[sources/repos-tradefabe-doctrine]]

## Engine and principles

`src/tradefabe/` is the single-source-of-truth engine (data/sizing/returns core, signals,
books, live carry + risk monitoring); `harness.py` (research evaluation) and the
Streamlit dashboard (`app.py`) both import from it rather than duplicating the math.
Strategies are **deterministic — no LLM in the trade loop** (LLMs are used for research,
reporting, and auditing, not trading decisions, since a nondeterministic trader can't be
honestly evaluated). ^[[sources/repos-tradefabe-readme]] ^[[sources/repos-tradefabe-claude]]

**Hard rule, standing:** never execute a real trade, never connect real money or
credentials, never give personalized investment advice — state the boundary instead.
Applies to any assistant working in this repo, not just a per-task instruction.
^[[sources/repos-tradefabe-claude]]

Not a concept promotion (project-scoped detail, not yet linked into the graph): the
statistical noise-floor / Bonferroni-correction methodology here is a genuinely reusable
idea (honest multiple-testing correction for a strategy search) — a candidate for a future
`[[statistical-multiple-testing-correction]]`-type concept page if a `/query` or `/ingest`
pass ever wants to generalize it beyond this project.

## Flagged for /ingest review

- 2026-07-25 sync: all four repo docs re-synced (commit `6ab7c04`, was `1591b9b`). Headline
  finding grew from 12+ to 49+ tested strategies via a new automated **strategy factory**
  (`factory.py`/`factory_run.py`) that generates parametrized variants and logs each one to
  `generated_templates.csv` before its verdict is known. DOCTRINE.md gained **v1.4**,
  replacing the v1.3 Bonferroni correction with the **Deflated Sharpe Ratio** (Bailey &
  López de Prado 2014) + **Combinatorial Purged Cross-Validation** (López de Prado 2017) as
  gate 1's active decision rule. Candidate concepts: DSR/CPCV as a general resampling-based
  alternative to Bonferroni for high-volume multiple-testing correction (broader than the
  existing flagged Bonferroni idea above — may supersede or extend it); the
  pre-register-the-search-space-not-just-the-candidate pattern the factory's
  `GENERATION_RANGES` uses to avoid meta-level p-hacking while still allowing live parameter
  draws. See ^[[sources/repos-tradefabe-doctrine]] ^[[sources/repos-tradefabe-strategies]].
