---
kind: project
domain: projects
title: daily-tickers
repo: https://github.com/dzheng1328/daily-tickers
path: /Users/dzheng/Documents/daily tickers
stack: [Python 3, Finnhub API, Gmail SMTP, claude -p, cron]
status: active
last_commit: 2026-06-18
---

# daily-tickers

A **daily automated market report**: a Python script runs before market open, pulls quotes/news
for a ~15-stock watchlist plus VIX from the Finnhub API, summarizes it with a single `claude -p`
call, and emails the result via Gmail SMTP using an app password. ^[[daily tickers/CLAUDE.md]]

**Scheduling:** cron + `pmset` (wake-from-sleep) on macOS. **Watchlist** lives in `tickers.txt`
(one per line, `#` comments ignored); current set is NVDA, AMD, TSM, MU, MSFT, GOOGL, META, ORCL,
VST, CEG, NRG, NBIS, ANET + VIX. The CLAUDE.md notes a ~20-ticker cap to avoid token bloat in the
`claude -p` call, and that Gmail auth uses an app password (not OAuth, not the account password). ^[[daily tickers/CLAUDE.md]]

Note: not investment advice tooling — it's a summarization/notification pipeline. Latest work
(2026-06): added a "FORWARD LOOK" section for next-session setups. This is the same
scheduled-automation pattern as the vault's own daily `/lint` task.
