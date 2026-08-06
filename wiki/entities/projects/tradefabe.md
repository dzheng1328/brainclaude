---
kind: project
domain: projects
title: tradefabe
repo: https://github.com/dzheng1328/tradefabe.git
path: /Users/dzheng/tradefabe
stack: [Python, Streamlit, Plotly, pytest, Hyperliquid API]
status: active
last_commit: 2026-08-04 (content-derived — git access blocked this session, see Flagged section)
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
- 2026-07-27 sync: `CLAUDE.md`/`DOCTRINE.md`/`STRATEGIES.md` re-synced (commit `6b1a843`, was
  `6ab7c04`); `README.md` unchanged. **Note (not a concept, operational only): the repo's real
  location moved from `~/Documents/tradefabe` to `~/tradefabe` on 2026-07-26** — iCloud sync
  in `~/Documents` was corrupting the venv and writing conflict copies of tracked files, the
  same failure mode that motivated moving this vault itself out of iCloud sync. A
  compatibility symlink remains at the old path (this card's `path:` still resolves), but new
  tooling should prefer the real path — worth a manual `path:` update if a human wants the
  card to reflect it directly. Candidate concepts from this sync: DOCTRINE v1.5's
  **origin-segregated multiple-testing correction** (correcting an automated-search
  candidate only against other search-origin trials, not against the full all-time roster,
  because a draw nobody would act on isn't the same statistical event as a hand-picked
  hypothesis — extends rather than replaces the existing DSR/CPCV flag above) and the
  **duty-cycle-matched noise floor as the default gate**, not opt-in (an unmatched random
  null under-trades a real signal and pays no turnover cost for it, making the gate lenient
  by construction). Also a general git/GitHub gotcha, reusable outside this repo: **never
  chain a branch delete after a merge in the same command** — a silently-failed `gh pr merge`
  still lets a chained delete run, closing an unmerged PR whose branch is now gone (cost three
  recoveries here, #65/#80/#92). See ^[[sources/repos-tradefabe-claude]]
  ^[[sources/repos-tradefabe-doctrine]] ^[[sources/repos-tradefabe-strategies]].
- 2026-07-31 sync: all four repo docs re-synced (commit `36050ce`, was `6b1a843`/`6ab7c04`).
  DOCTRINE advanced through **v1.6, v1.7, and v1.8** (all 2026-07-29) since the last sync;
  Family M (Kronos strategies) went live, and Alpaca paper-trading broker connectivity was
  added. Candidate concepts from this batch: **advisory-only kill criteria** (v1.6 — a
  book's retirement stopped being an automatic action on hitting the kill rule and became a
  logged recommendation a human still has to execute, because an automated kill compounds
  the same multiple-testing risk the doctrine already corrects for on entry but not on
  exit); **aligning the benchmark window to the candidate's own out-of-sample start** (v1.7
  — a general backtesting-evaluation gotcha: a candidate and its benchmark sliced from a
  flat start date silently miscompare whenever the candidate's own data begins later,
  understating or overstating its edge depending on which regime the extra benchmark window
  covers); **requiring the candidate's own OOS Sharpe be positive as an explicit gate-1
  floor** (v1.8 — a genuinely reusable DSR gotcha: the Deflated Sharpe Ratio alone has no
  such floor and can saturate near 1.0 next to a candidate that is still net losing, since
  DSR measures "beats what n_tested random draws would produce," not "is profitable"). See
  ^[[sources/repos-tradefabe-claude]] ^[[sources/repos-tradefabe-doctrine]]
  ^[[sources/repos-tradefabe-readme]] ^[[sources/repos-tradefabe-strategies]].
- 2026-07-31 (scheduled) sync: `CLAUDE.md`/`README.md` re-synced (commit `5de0ecc`, was
  `36050ce`) — both changes are a stale-count fix in the `pytest` command comment ("433
  tests, ~8s" → "worksteal, ~3-4s") from a test-suite speed-up (#160/#162). Not a concept,
  not even worth a candidate flag — purely a doc-comment correction. `DOCTRINE.md`/
  `STRATEGIES.md` unchanged.
- **Action item for next /ingest, not just a candidate concept**: `/lint`'s 2026-07-31 run
  found `sources/repos-tradefabe-claude`, `-readme`, `-doctrine`, and `-strategies` all have
  stale body summaries — the 2026-07-31 re-sync (v1.6-v1.8, Family M/Kronos live, Alpaca
  broker connectivity) landed in `raw/repos/tradefabe/` correctly, but only this pointer
  card's "Flagged" bullets were updated, not the source cards' own summary text. **A plain
  `/ingest` diff will silently skip these** — `.manifest.json`'s hashes were already updated
  during the re-sync, so they read as "unchanged." Rewrite the four source-card bodies to
  match current raw content (`raw/repos/tradefabe/DOCTRINE.md:45+`, `STRATEGIES.md:369+`,
  `CLAUDE.md:124,223`) as an explicit step, not by waiting on the normal diff worklist.
- 2026-07-31 sync (2): `CLAUDE.md`, `README.md`, `STRATEGIES.md` re-synced (commit `634efbf`,
  was `5de0ecc`); `DOCTRINE.md` unchanged. `CLAUDE.md`/`README.md` both document the `run`
  cron moving from 22:07 UTC to ~02:00 UTC (#158 — kronos's yfinance daily bar was a day
  stale at 22:07, silently skipping `kronos_wick_agg`'s rebalance) and the `factory` cron
  resuming daily at 21:06 UTC (#163) now that DOCTRINE v1.5 ledger segregation and
  `MAX_FACTORY_PROMOTED` (#147) bound its growth. `STRATEGIES.md` gained a pre-registered
  amendment (#156): `equity_tsmom_1h` swaps its data source from yfinance (730-day window) to
  Alpaca (~2016+), re-run as a new graveyard row (not an edit to the frozen 2026-07-26
  verdict) per DOCTRINE's forward-only rule — still DEAD, more decisively (Sharpe −3.64 vs.
  −1.93, MaxDD −100.0% vs. −40.7%) once the longer window includes 2018's vol spike, COVID,
  and the 2022 bear. Candidate concept from this batch: **pre-registering a data-source/depth
  swap as a forward-only amendment that produces a new verdict row rather than editing the
  original** — generalizes the existing methodology-amendment pattern above (v1.6-v1.8) to
  data provenance changes specifically, distinct because the spec/gates/thresholds are
  unchanged and only the input data's depth differs. `last_commit` bumped to 2026-07-31 (this
  commit's own authored date). See ^[[sources/repos-tradefabe-claude]]
  ^[[sources/repos-tradefabe-readme]] ^[[sources/repos-tradefabe-strategies]].
- 2026-08-04 (scheduled) sync: `CLAUDE.md`/`DOCTRINE.md`/`STRATEGIES.md` re-synced;
  `README.md` unchanged. **Git access (`git -C`, `git log`, even reading `.git/HEAD`) was
  blocked in this session for every path outside the vault itself** — unlike the 2026-08-01
  through 08-03 runs, plain file reads (`shasum`, direct file open) through the
  `~/Documents/tradefabe` symlink worked fine this time, so the content-diff comparison
  itself is trustworthy, but no real commit hash could be captured. The three raw snapshots'
  `commit:` frontmatter now reads `unknown (git access blocked...)` instead of a hash;
  `fetched`/`last_commit` were set to 2026-08-04 on internal evidence only (DOCTRINE.md's own
  "Current state" section headers itself "as of v1.16, 2026-08-04") — **not git-confirmed,
  flagging honestly rather than fabricating a hash.** DOCTRINE.md gained **v1.9 through
  v1.16** (a calibration-only prelim-screen firewall; a third origin bucket for
  research-pipeline `n_tested`; a fully-automatic pre-registration checkpoint; the same OOS
  gate extended to pipeline candidates with a `MAX_PIPELINE_PROMOTED=10` pool; a fixed
  10/day proposal rate; the corpus's first **compositional** primitive
  (`asset_class_trend_hedge`) with two mechanical guards; a retroactive safety review; and a
  follow-up review that found and fixed a missing `concurrency:` guard on
  `pipeline-daily.yml`). STRATEGIES.md gained **family N (pairs/cointegration, #172)** — DEAD
  — and a **primitive-vocabulary section** for the automated research pipeline. CLAUDE.md
  gained two automation-table entries (`cost-check.yml` weekly, `pipeline-daily.yml` daily).
  **Candidate concepts from this batch:** the **Engle-Granger two-step cointegration test for
  pairs trading** (economically-motivated pair selection *before* testing, so the
  cointegration check is a pass/fail filter rather than a p-hacked scan over all pair
  combinations — a genuinely reusable quant-methodology idea, distinct from every prior
  flagged concept here since it's about *pair* selection/testing rather than single-asset
  signals or multiple-testing correction) — see family N above; and **the missing-
  `concurrency:`-guard finding itself (v1.16)** — two GitHub Actions workflows sharing an
  identical schedule + `workflow_dispatch` combination can silently run concurrently unless
  a `concurrency:` block says otherwise, which matters for any cron-triggered automation, not
  just trading (this vault's own scheduled `/lint`/`/sync-projects` runs and daily-tickers'
  cron are the same shape). See ^[[sources/repos-tradefabe-claude]]
  ^[[sources/repos-tradefabe-doctrine]] ^[[sources/repos-tradefabe-strategies]].
- 2026-08-04 (second scheduled) sync: `README.md`, `DOCTRINE.md`, `STRATEGIES.md` confirmed
  still matching the same-day sync above (byte-identical body diff). **`CLAUDE.md` has
  drifted again since that sync ran, but this run could only prove the drift, not read it**:
  `shasum` on the live file succeeded and disagrees with the raw snapshot's body hash, while
  every content-revealing read on this repo's paths (`Read`, `cat`, `tail`, `diff`, `awk`,
  `git log`/`git diff`) was sandbox-blocked this session — a narrower failure mode than the
  entry above (that run could read content but not git metadata; this run can checksum but
  not read content at all). Left `CLAUDE.md`'s raw snapshot and source card un-synced rather
  than guess at the new content — re-sync deferred to a session where the file is actually
  readable. Not a concept.
- 2026-08-05: `path:` repointed straight at `/Users/dzheng/tradefabe`, resolving the
  compatibility-symlink block that had left every sync since 2026-08-01 unable to fully
  verify this project (flagged above on 2026-07-27, actioned now). Not a concept.
