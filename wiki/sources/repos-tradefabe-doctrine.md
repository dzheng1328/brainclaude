---
kind: source
domain: projects
course: "tradefabe"
title: "DOCTRINE.md"
raw_file: raw/repos/tradefabe/DOCTRINE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 6ab7c04
fetched: 2026-07-25
---

# DOCTRINE.md

tradefabe repo doc "DOCTRINE.md" — the pre-registered evaluation methodology that governs
every strategy verdict. v1.0 (frozen 2026-07-21): pre-registration, out-of-sample-only
verdicts (design on 2007-2017, evaluate on 2018-present), a data-derived noise floor (500
random strategies, judged against the 95th percentile of their OOS Sharpe, matched by
rebalance frequency per the v1.0.1 amendment), a fair 60/40 benchmark, and a 3-part kill
rule (beats luck / earns its place / not more painful). v1.2 (2026-07-23) adds paper-testing
promote/kill criteria with a statistical-power argument for why confirmation takes years,
not weeks (`T_required = max(2 years, (2/SR_bt)² years)`), including a caveat that the
formula breaks for low-noise regime-driven returns like the carry book's (daily Sharpe
10.85) — hence the 2-year floor. v1.3 (2026-07-24) activates a Bonferroni multiple-testing
correction on the noise floor, which retroactively flips 3 of 4 "piggyback" constructions
from ALIVE to DEAD. **New: v1.4 (2026-07-25)** replaces Bonferroni as gate 1's active
decision with the **Deflated Sharpe Ratio** (Bailey & López de Prado 2014) combined with
**Combinatorial Purged Cross-Validation** (López de Prado 2017), motivated by the strategy
factory's high-volume automated search making Bonferroni's flat correction both too strict
and too crude. Re-running the full roster under v1.4 changed no verdicts (validated before
merge). Bonferroni stays computed and logged, no longer deciding. See [[tradefabe]].

Raw: `raw/repos/tradefabe/DOCTRINE.md`.
