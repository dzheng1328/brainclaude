---
kind: source
domain: projects
course: "tradefabe"
title: "DOCTRINE.md"
raw_file: raw/repos/tradefabe/DOCTRINE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: unknown (git access blocked this session; re-sync verified via content diff, not git log)
fetched: 2026-08-04
---

# DOCTRINE.md

tradefabe repo doc "DOCTRINE.md" — the pre-registered evaluation methodology that governs
every strategy verdict. v1.0 (frozen 2026-07-21): pre-registration, out-of-sample-only
verdicts (design on 2007-2017, evaluate on 2018-present), a data-derived noise floor (500
random strategies, judged against the 95th percentile of their OOS Sharpe, matched by
rebalance frequency per the v1.0.1 amendment), a fair 60/40 benchmark, and a 3-part kill
rule (beats luck / earns its place / not more painful). v1.2 (2026-07-23) adds paper-testing
promote/kill criteria with a statistical-power argument for why confirmation takes years,
not weeks. v1.3 (2026-07-24) activates a Bonferroni multiple-testing correction on the noise
floor. v1.4 (2026-07-25) replaces Bonferroni with the Deflated Sharpe Ratio + Combinatorial
Purged Cross-Validation as gate 1's active decision rule. **New: v1.5 (PRE-REGISTERED
2026-07-28, no verdict computed under it yet)** makes two calibration changes together,
deliberately, because they pull the bar in opposite directions: **(a)** the multiple-testing
family is now **segregated by origin** — a factory-generated candidate (121 of 139 all-time
rows) is corrected only against other factory-origin rows, a hand-picked candidate only
against hand-picked rows, and a promoted factory candidate joins the hand-picked family
because promotion is itself selection-on-result; origin is recorded at generation time,
before any verdict, so it can't be assigned to flatter a result. **(b)** the duty-cycle-
matched noise floor (`noise_floor(..., like=)`, opt-in since v1.0.1/#101) becomes the
**default** — re-drawing a random signal every bar trades far more than a real monthly
signal and was paying no turnover cost for it, making gate 1 systematically lenient; under
the match, the monthly noise-floor bar moves from p95 0.293 to 1.532, and `tsmom_12m`
(Sharpe 0.499) flips from passing to failing gate 1. Existing `graveyard.csv` rows keep
their original verdicts — v1.5 is forward-only, never a silent re-score. Since that snapshot,
**eight more amendments (v1.9 through v1.16)** landed, all summarized in a new "Current
state" reading-aid section at the top of the file (frozen v1.0 text below it untouched, per
the doctrine's own rule): v1.9 adds a calibration-only `prelim_screen()` firewall upstream of
the three gates for research-pipeline candidates; v1.10 segregates `n_tested` into a third
bucket (pipeline-origin, separate from factory and hand-picked); v1.11 makes the
pre-registration checkpoint for a pipeline candidate that clears prelim screen fully
automatic (no human review); v1.12 runs the same OOS gate on pre-registered pipeline
candidates as every other family, capped at its own promotion pool
(`MAX_PIPELINE_PROMOTED = 10`); v1.13 fixes the pipeline's proposal rate at up to 10/day
(not "until one passes"); v1.14 adds the corpus's first **compositional** primitive
(`asset_class_trend_hedge`, two trend legs from different asset classes), guarded by an
asset-class-difference check and a calibration-window correlation cap; v1.15 records a
retroactive pre-launch safety review of `pipeline-daily.yml` that found it had failed both
times it had run; v1.16 records a follow-up council review that found and fixed a missing
`concurrency:` guard on `pipeline-daily.yml` — an identical schedule+`workflow_dispatch`
combination `paper-engine.yml` already guarded against double-running, without the guard
itself. See [[tradefabe]].

Promotes: [[pre-registered-multiple-testing-correction]], [[backtest-evaluation-integrity-patterns]],
[[github-actions-concurrency-guard]].

Raw: `raw/repos/tradefabe/DOCTRINE.md`.
