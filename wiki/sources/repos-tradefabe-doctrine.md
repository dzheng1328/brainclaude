---
kind: source
domain: projects
course: "tradefabe"
title: "DOCTRINE.md"
raw_file: raw/repos/tradefabe/DOCTRINE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 36050ce
fetched: 2026-07-31
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
their original verdicts — v1.5 is forward-only, never a silent re-score. See [[tradefabe]].

Raw: `raw/repos/tradefabe/DOCTRINE.md`.
