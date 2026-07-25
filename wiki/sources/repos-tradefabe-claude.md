---
kind: source
domain: projects
course: "tradefabe"
title: "CLAUDE.md"
raw_file: raw/repos/tradefabe/CLAUDE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 1591b9b
fetched: 2026-07-24
---

# CLAUDE.md

tradefabe repo doc "CLAUDE.md" — agent orientation. States the hard rule (never execute a
real trade, connect real credentials, or give personalized investment advice, without Dave
explicitly saying so in chat) and the git workflow (branch + PR, not direct pushes to
`main` — course-corrected 2026-07-23 after earlier work was pushed straight to main).
Documents the recurring Python 3.14 + macOS sandbox `.pth`-hidden-flag bug and its fix
(`chflags nohidden` or `PYTHONPATH=<repo root>/src`; a venv `sitecustomize.py` does NOT
work, Homebrew's own shadows it). Lists the 4 open / 6 closed roadmap issues (milestone
Engine v1) and one explicit off-limits: `~/Documents/daily tickers`, a separate stopped
project not to be integrated here. See [[tradefabe]].

Raw: `raw/repos/tradefabe/CLAUDE.md`.
