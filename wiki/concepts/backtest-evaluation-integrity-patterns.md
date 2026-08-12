---
kind: concept
domain: projects
title: Backtest evaluation integrity patterns
course: "tradefabe"
---

# Backtest evaluation integrity patterns

Three related disciplines keep an iterative backtesting/evaluation process from quietly
undermining its own record as the methodology and roster evolve over time.

**Advisory-only kill criteria.** A rule that flags a live strategy as a likely loser (e.g. a
drawdown threshold or an age rule) should log a *recommendation*, never trigger an automatic
retirement. Auto-killing losers filters the forward-going record on results — manufacturing
survivorship bias in exactly the dataset that's supposed to be free of it. A human executes the
retirement decision; the system only surfaces the finding. ^[[sources/repos-tradefabe-doctrine]]

**Align the benchmark window to the candidate's own out-of-sample start.** Slicing a candidate and
its benchmark from the same flat start date silently miscompares them whenever the candidate's own
usable data begins later than the benchmark's — the benchmark ends up covering a different market
regime than the candidate actually traded through, understating or overstating the edge depending
on which extra regime the benchmark window picks up. The fix only ever *narrows* the benchmark
window to match the candidate's actual OOS start, never widens it. ^[[sources/repos-tradefabe-doctrine]]

**Forward-only amendments: a changed methodology or data source produces a new verdict row, never
edits the old one.** When a strategy is re-evaluated after the evaluation code changes (a corrected
gate) or the input data changes (a longer/different-provider price history), the right response is
to log a *new* row under the new conditions and leave the original frozen verdict untouched —
never silently re-score history. This preserves the append-only record's honesty: anyone reading it
later can see exactly what changed and when, rather than a record that quietly reflects only the
latest methodology as if it had always been true. ^[[sources/repos-tradefabe-strategies]]

Generalizable to any research or ML pipeline that renders repeated verdicts on a changing roster
under an evolving methodology: automatic actions on statistical findings, benchmark/candidate
window mismatches, and silent re-scoring of history are the same three integrity failure modes
regardless of domain.
