---
kind: project
domain: projects
title: hw-cnn-accelerator
repo: https://github.com/dzheng1328/hw-cnn-accelerator
path: /Users/dzheng/Documents/hw-cnn-accelerator
stack: [Verilog, Python, iverilog, yosys]
status: active
last_commit: 2026-07-15
---

# hw-cnn-accelerator

A systolic-array **GEMM (matrix-multiply) accelerator** designed in Verilog and verified in
simulation, running a real trained network to classify MNIST digits. Built as a portfolio
project for RTL/logic-design internship recruiting. ^[[hw-cnn-accelerator/README.md]]

Despite the directory name, **this is not a CNN** — the network currently running on the array
is a bias-free MLP, and no convolution op is implemented. GEMM is the compute core that
CNN/TPU-style accelerators are built around (convolutions get lowered to matrix multiplies via
im2col before hitting hardware like this), which is the design rationale for building the matmul
tile rather than a conv unit. ^[[hw-cnn-accelerator/README.md]] The reframe from "CNN" to
"GEMM/MLP" was Dave's explicit decision on 2026-07-05, logged in the repo's own decision record. ^[[sources/repos-hw-cnn-decisions]]

The core is an 8×8 systolic tile (`rtl/systolic_array.v`) that computes one 8×8×8 matmul per
pass; `tb/mnist/test_mnist.py` tiles each MLP layer into repeated passes, accumulating K-chunks
back-to-back with no reset and resetting between independent N-blocks. ^[[sources/repos-hw-cnn-decisions]]

## Concepts (from the repo's own docs, snapshotted 2026-07-18)

- [[systolic-array-dataflow]] — output-stationary vs. weight-stationary, skewed dataflow, K/N tiling with the non-contamination proof
- [[neural-network-quantization]] — hardware-forced symmetric int8, requantization, argmax invariance

The repo's decision log and learnings are snapshotted at commit `abd00b2`:
^[[sources/repos-hw-cnn-decisions]] ^[[sources/repos-hw-cnn-learnings]]. See also the coursework map
[[coursework-behind-hw-cnn-accelerator]].

**Relationship to other work:** this is the **solo** hardware project. Do not conflate it with
the [[ece-350-connect4]] FPGA project (different scope, has a partner). Upstream concepts:
[[fsm-state-minimization]], [[twos-complement-arithmetic]], [[binary-multiplication]],
[[pipelining-and-hazards]], and the digital-logic material under [[350]].

Latest work (2026-07): a `yosys` generic-synthesis path merged (PR #12).
