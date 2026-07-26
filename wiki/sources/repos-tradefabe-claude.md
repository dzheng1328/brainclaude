---
kind: source
domain: projects
course: "tradefabe"
title: "CLAUDE.md"
raw_file: raw/repos/tradefabe/CLAUDE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/tradefabe.git
commit: 6ab7c04
fetched: 2026-07-25
---

# CLAUDE.md

tradefabe repo doc "CLAUDE.md" — agent orientation. States the hard rule (never execute a
real trade, connect real credentials, or give personalized investment advice, without Dave
explicitly saying so in chat) and the git workflow (branch + PR, not direct pushes to
`main` — course-corrected 2026-07-23 after earlier work was pushed straight to main).
Substantially expanded since the 2026-07-24 snapshot: the paper engine moved off the Mac
entirely onto GitHub Actions (`.github/workflows/paper-engine.yml`, since launchd doesn't
fire while the machine sleeps — the local plists are retired to `*.plist.disabled`), the
Python 3.14 `.pth`-hidden bug was root-caused to iCloud Desktop/Documents sync flagging
files `hidden` (fixed by moving the venv to `~/.venvs/tradefabe`, outside the synced tree —
`chflags`/`PYTHONPATH` workarounds are now belt-and-braces, not load-bearing), and a new
"Strategy factory (#28/#28b)" section documents the automated candidate generator (live
parameter ranges logged to `generated_templates.csv` before verdicts are known, best-DSR
candidate promoted each cycle regardless of verdict). Roadmap now tracked entirely on the
GitHub Projects board rather than enumerated in this file. See [[tradefabe]].

Raw: `raw/repos/tradefabe/CLAUDE.md`.
