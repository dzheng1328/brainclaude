---
kind: source
domain: projects
course: "hw-cnn-accelerator"
title: "Learnings log (hw-cnn-accelerator)"
raw_file: raw/repos/hw-cnn-accelerator/learnings.md
source_kind: repos
repo_url: https://github.com/dzheng1328/hw-cnn-accelerator
commit: abd00b2
fetched: 2026-07-18
---

# Learnings log (hw-cnn-accelerator)

Running problem/fix log from the [[hw-cnn-accelerator]] repo (`docs/learnings.md`), snapshotted at
commit `abd00b2`. Two verification-flow lessons: `make -C <dir>` breaks Makefiles that rely on
`$(PWD)` (use `cd <dir> && make`), and reading a `reg` immediately after `await RisingEdge(clk)` in
cocotb sees a stale pre-NBA value (wait past the edge with a small `Timer`). Tooling-specific, not
promoted to concepts. Raw: `raw/repos/hw-cnn-accelerator/learnings.md`.
