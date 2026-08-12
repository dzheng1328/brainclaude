---
kind: concept
domain: projects
title: Hedge-effectiveness guard
course: "tradefabe"
---

# Hedge-effectiveness guard

A **hedge-effectiveness guard** verifies that a multi-leg position's hedge actually cancels the
risk it's constructed to cancel — a distinct check from validating the strategy's statistical edge
(the noise-floor/[[pre-registered-multiple-testing-correction|multiple-testing]] machinery). It
answers "does the hedge work," not "is the signal real."

**Mechanism.** On a fixed calibration window (never the out-of-sample window a verdict is later
rendered on), check that the position's own calibration-window daily returns decorrelate below a
pre-registered correlation cap from the specific risk factor the position is meant to be neutral
to. For a DV01-neutral duration position, that means the position's own returns decorrelating from
the underlying rate's own daily change — confirming the hedge cancelled *level* risk in real
calibration data, not just by construction on paper. ^[[sources/repos-tradefabe-strategies]]

**Why it's a distinct pattern from cross-primitive divergence checks.** A related but different
guard checks that two legs' own trend signals decorrelate from *each other* (avoiding a disguised
single bet). The hedge-effectiveness guard instead checks decorrelation from the external risk
factor the hedge exists to neutralize — validating the construction's internal hedge, not its
relationship to any other strategy in the roster. ^[[sources/repos-tradefabe-strategies]]

**Placement.** Runs before the comparatively expensive statistical-significance screening steps,
so a construction whose hedge doesn't actually hold in calibration data is rejected cheaply and
doesn't resurface repeatedly. ^[[sources/repos-tradefabe-strategies]]

Generalizable to any multi-leg or paired-position strategy (pairs trading, market-neutral
constructions, duration-hedged trades) where "the two legs are supposed to cancel a specific risk"
is a claim that needs its own empirical check, separate from whether the resulting position is
statistically profitable.
