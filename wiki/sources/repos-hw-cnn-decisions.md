---
kind: source
domain: projects
course: "hw-cnn-accelerator"
title: "Design decisions (hw-cnn-accelerator)"
raw_file: raw/repos/hw-cnn-accelerator/decisions.md
source_kind: repos
repo_url: https://github.com/dzheng1328/hw-cnn-accelerator
commit: 8827a96
fetched: 2026-07-25
---

# Design decisions (hw-cnn-accelerator)

Architectural decision log from the [[hw-cnn-accelerator]] repo (`docs/decisions.md`), snapshotted
at commit `8827a96`. Records the *why* behind each design choice — the systolic dataflow, the K/N
tiling scheme with its non-contamination proof, the hardware-forced quantization scheme, the
CNN→GEMM reframe, and several verification gotchas. Substantially expanded since the 2026-07-18
snapshot with the entire Phase 2 NoC (network-on-chip) build: `skew_feeder.v` and
`gemm_sequencer.v` (moving tile control from Python into RTL), `operand_mem.v` (a real load/read
port), a 2D-mesh router (`router.v`, XY routing, round-robin arbitration, combinational crossbar),
registered link buffers to break combinational cycles (`flit_buf.v`), a working 1x2 pair and then
a 2x2 mesh (`noc_pair.v`/`noc_mesh2x2.v`), and GO/RESULT flits that packetize compute kickoff and
result readout so the tile's whole life cycle rides the network. Also new: a first real sky130
standard-cell synthesis pass (Phase 3 kickoff) quantifying that `operand_mem`'s flop array costs
almost as much silicon area as the entire 64-PE compute array (42.5% of a tile).

Promotes: [[systolic-array-dataflow]], [[neural-network-quantization]], [[noc-router-design]],
[[cocotb-parameter-override-gotcha]]. Raw: `raw/repos/hw-cnn-accelerator/decisions.md`.
