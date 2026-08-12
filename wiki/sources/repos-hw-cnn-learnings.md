---
kind: source
domain: projects
course: "hw-cnn-accelerator"
title: "Learnings log (hw-cnn-accelerator)"
raw_file: raw/repos/hw-cnn-accelerator/learnings.md
source_kind: repos
repo_url: https://github.com/dzheng1328/hw-cnn-accelerator
commit: 8827a96
fetched: 2026-07-25
---

# Learnings log (hw-cnn-accelerator)

Running problem/fix log from the [[hw-cnn-accelerator]] repo (`docs/learnings.md`), snapshotted at
commit `8827a96`. Two verification-flow lessons: `make -C <dir>` breaks Makefiles that rely on
`$(PWD)` (use `cd <dir> && make`), and reading a `reg` immediately after `await RisingEdge(clk)` in
cocotb sees a stale pre-NBA value (wait past the edge with a small `Timer`). Two new entries since
the 2026-07-18 snapshot: a Verilog `parameter` (`MY_X`/`MY_Y`) silently diverged from what a cocotb
testbench assumed because the Makefile flow can't cleanly override parameters (fix: make them input
ports instead) — compounded by a second, separate payload-width (`PW`) mismatch between RTL default
and testbench constant; and a skew shift-register's delay lined up exactly right "for free" once
reasoned through via Verilog non-blocking-assignment (`<=`) old-value semantics, no off-by-one fight
needed. Promotes: [[cocotb-parameter-override-gotcha]], [[verilog-nba-old-value-semantics]]. Raw:
`raw/repos/hw-cnn-accelerator/learnings.md`.
