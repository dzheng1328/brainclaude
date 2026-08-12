---
kind: concept
domain: projects
title: Engle-Granger cointegration test for pairs trading
course: "tradefabe"
---

# Engle-Granger cointegration test for pairs trading

**Pairs trading** bets on the *spread* between two economically-linked assets reverting to its
historical relationship, rather than on either asset's own direction — a distinct mechanism from a
single-asset mean-reversion or trend signal. ^[[sources/repos-tradefabe-strategies]]

**Pair selection must precede testing, or it's a p-hacked scan.** Blindly cointegration-testing
every possible pair combination in a universe would select pairs *because* they cointegrate
in-sample — the same meta-level p-hacking that a search-space [[pre-registered-multiple-testing-correction|
pre-registration discipline]] exists to prevent. The correct order: choose candidate pairs first,
for an independent economic reason to co-move (e.g. two treasury-duration ETFs, or investment-grade
vs. high-yield credit), *then* run the cointegration test on that fixed list as a pass/fail filter —
never as the selection criterion itself. A pair that fails the filter doesn't trade out-of-sample at
all; it isn't retried with a different window. ^[[sources/repos-tradefabe-strategies]]

**Method — Engle & Granger (1987), the standard two-step test:**
1. On a calibration window (never the out-of-sample window a verdict will be rendered on), regress
   `log(price_A)` on `log(price_B)` (OLS with intercept) to get a hedge ratio and intercept. This
   fit is frozen — never re-estimated during the out-of-sample period, the same
   no-re-fitting-during-OOS discipline any properly pre-registered strategy follows.
2. Run an Augmented Dickey-Fuller (ADF) test on the calibration-window residual
   (`log(A) - β·log(B) - α`) for stationarity. The pair clears the filter at a standard significance
   level (not tuned per pair). ^[[sources/repos-tradefabe-strategies]]

**Signal construction (Gatev, Goetzmann & Rouwenhorst, 2006 convention).** The frozen spread is
z-scored against its own trailing rolling mean/std — a live normalization of the *current* spread
level, not a re-fit of the cointegrating relationship itself, which stays frozen from calibration.
Enter long-the-spread/short-the-spread at the z-score crossing entry thresholds, exit at z crossing
zero (mean reversion realized), and force-flat at an extreme z-score as a structural-break stop —
treating an extreme divergence as evidence the cointegrating relationship itself broke, rather than
more reversion still to come. ^[[sources/repos-tradefabe-strategies]]

Generalizable to any relative-value strategy between two related instruments (equity pairs, ETF
pairs, futures spreads) — the general quant-methodology pattern is choose-the-pair-for-a-reason,
test-don't-search, freeze-the-fit, and treat an extreme break as a stop rather than a bigger
opportunity.
