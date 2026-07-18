---
kind: source
domain: projects
course: "hw-cnn-accelerator"
title: "Design decisions (hw-cnn-accelerator)"
raw_file: raw/repos/hw-cnn-accelerator/decisions.md
source_kind: repos
repo_url: https://github.com/dzheng1328/hw-cnn-accelerator
commit: abd00b2
fetched: 2026-07-18
---

# Design decisions (hw-cnn-accelerator)

Architectural decision log from the [[hw-cnn-accelerator]] repo (`docs/decisions.md`), snapshotted
at commit `abd00b2`. Records the *why* behind each design choice — the systolic dataflow, the K/N
tiling scheme with its non-contamination proof, the hardware-forced quantization scheme, the
CNN→GEMM reframe, and several verification gotchas.

Promotes: [[systolic-array-dataflow]], [[neural-network-quantization]]. Raw:
`raw/repos/hw-cnn-accelerator/decisions.md`.
