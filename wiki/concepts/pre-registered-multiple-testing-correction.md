---
kind: concept
domain: projects
title: Pre-registered multiple-testing correction for strategy search
course: "tradefabe"
---

# Pre-registered multiple-testing correction for strategy search

When many candidate hypotheses (trading strategies, model variants, A/B arms) are tested against
the same historical data, the naive "did it beat a benchmark" question is the wrong question — the
right one is "does it beat what pure luck would produce as the *best of the many draws already
tried*." A data-derived **noise floor** (many random strategies run through the identical
evaluation machinery, judged against a high percentile of their own out-of-sample performance)
answers that honestly instead of using an arbitrary fixed threshold. ^[[sources/repos-tradefabe-doctrine]]

**Bonferroni is a starting point, not the endpoint.** A flat `alpha / n_tested` correction is
simple but crude: it ignores how correlated or dispersed the actual null distribution is, and gets
crushingly strict at high search volume. The **Deflated Sharpe Ratio** (Bailey & López de Prado,
2014) tests a candidate against the *expected maximum* value luck would produce as the best of
`n_tested` random draws from the empirical null — correcting for the null's real spread, not just
its count, and for the candidate's own return skew/kurtosis via the underlying Probabilistic Sharpe
Ratio test. Paired with **Combinatorial Purged Cross-Validation** (López de Prado, 2017) — averaging
several purged, embargoed, resampled out-of-sample paths instead of trusting one fixed window — a
candidate has to hold up across multiple slices of history, not just the one the evaluation happens
to use. Both are closed-form/resampling methods needing no new dependency. ^[[sources/repos-tradefabe-doctrine]]

**DSR alone still has a blind spot: it has no profitability floor.** It measures "beats what
`n_tested` random draws would produce," not "is actually profitable" — a losing candidate can
saturate DSR near 1.0 next to random noise. The fix is an explicit, separate gate: the candidate's
own out-of-sample Sharpe must be positive before DSR is even consulted. ^[[sources/repos-tradefabe-doctrine]]

**The correction family should be segregated by origin, not pooled globally.** Family-wise
correction implicitly assumes every tested hypothesis is one you would have accepted if it had won
— true for a hand-picked candidate, false for a step in an automated search. An automated-search
draw is closer to one step of gradient descent than to a hypothesis anyone would trade; correcting
every future hand-picked candidate against the ever-growing count of automated draws permanently
inflates the bar for no reason. The fix: correct a search-origin candidate only against other
search-origin trials, a hand-picked candidate only against hand-picked trials, and treat a
*promoted* search candidate as joining the hand-picked family — because promotion is itself
selection-on-result, exactly what the correction exists to price. Origin must be recorded at
generation time, before any verdict, so it can never be assigned after the fact to flatter a result.
^[[sources/repos-tradefabe-doctrine]]

**The random null must be duty-cycle-matched to the candidate, or the noise floor is
miscalibrated.** Matching the null's clock/rebalance frequency isn't enough if the null still
re-draws a random signal every bar — that trades far more often than a real low-frequency signal
and pays no turnover cost for it, making the floor systematically too lenient. Matching the null's
actual trading frequency (not just its calendar) to the candidate's is what makes the comparison
fair; leaving it opt-in rather than default silently under-corrects every candidate that doesn't
happen to enable it. ^[[sources/repos-tradefabe-doctrine]]

**Pre-register the search space, not just the specific candidate, when the search itself is
automated and open-ended.** Freezing a fixed list of candidates before testing doesn't scale once a
process generates new candidates continuously. The compromise that avoids reopening meta-level
p-hacking: fix and review the *parameter range* per generator once, in code, ahead of time, then log
each specific drawn value at generation time — before its verdict is known — to an append-only
record. The generation process is pre-registered even though the specific values it produces are
not enumerated in advance. ^[[sources/repos-tradefabe-strategies]]

Generalizable to any repeated-hypothesis-testing pipeline — trading strategy search, ML
hyperparameter/architecture search, or A/B testing at scale — wherever "how many things did we
effectively try, and were they all equally 'a thing we'd act on'" needs an honest, evolvable answer
rather than a single static threshold.
