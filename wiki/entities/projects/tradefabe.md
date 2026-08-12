---
kind: project
domain: projects
title: tradefabe
repo: https://github.com/dzheng1328/tradefabe.git
path: /Users/dzheng/tradefabe
stack: [Python, Streamlit, Plotly, pytest, Hyperliquid API, FastAPI, React, TypeScript, Vite, Tailwind CSS]
status: active
last_commit: 2026-08-11 (content-derived — git access blocked this session, see Flagged section)
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

The statistical noise-floor / multiple-testing-correction methodology here is promoted as
[[pre-registered-multiple-testing-correction]] (2026-08-11 weekly /ingest) — see that page for
the full DSR/CPCV, origin-segregation, and duty-cycle-matching detail. Also promoted from this
project: [[backtest-evaluation-integrity-patterns]], [[hedge-effectiveness-guard]],
[[engle-granger-cointegration-pairs-trading]], [[no-chained-branch-delete-after-merge]],
[[github-actions-concurrency-guard]], [[pre-merge-review-gate-high-consequence-files]], and
[[strangler-fig-ui-migration]].

## Flagged for /ingest review

(none — 2026-08-11 weekly /ingest reviewed the full backlog below and resolved it: promoted
[[pre-registered-multiple-testing-correction]] (DSR/CPCV, origin-segregation, duty-cycle-matched
noise floor, positive-OOS-Sharpe floor, search-space pre-registration — 2026-07-25/27/31/08-04
entries), [[backtest-evaluation-integrity-patterns]] (advisory-only kill criteria, benchmark-window
alignment, forward-only amendments), [[hedge-effectiveness-guard]] and
[[engle-granger-cointegration-pairs-trading]] (2026-08-04/06), [[no-chained-branch-delete-after-merge]]
and [[github-actions-concurrency-guard]] (2026-07-27/08-04), [[pre-merge-review-gate-high-consequence-files]]
(2026-08-06), and [[strangler-fig-ui-migration]] (2026-08-07). Declined: entries the daily sync
itself had already logged as "not a concept" (operational/provenance-only syncs, project-scoped
strategy instances with no new pattern). See ^[[sources/repos-tradefabe-doctrine]] ^[[sources/repos-tradefabe-strategies]]
^[[sources/repos-tradefabe-claude]] ^[[sources/repos-tradefabe-readme]] for the current source-card
state; the full sync-by-sync history that justified each promotion is preserved in
wiki/log-archive/ and this card's git history rather than kept live here.
