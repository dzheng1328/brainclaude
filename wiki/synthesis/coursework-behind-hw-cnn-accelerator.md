---
kind: synthesis
domain: projects
title: Coursework behind hw-cnn-accelerator
question: "What coursework knowledge is relevant to building the hw-cnn-accelerator?"
built: 2026-07-17
---

# Coursework behind hw-cnn-accelerator

A map from Dave's coursework to the [[hw-cnn-accelerator]] — a systolic-array GEMM accelerator
running an MLP on MNIST, an 8×8 multiply-accumulate tile with Python-orchestrated tiling. What the
vault already knows that bears on building it:

## The arithmetic datapath (most direct)

Each processing element in the systolic array does a **multiply-accumulate**, so the two most
load-bearing concepts are:

- [[binary-multiplication]] — the multiply step. Booth's algorithm recodes runs of 1s into far
  fewer add/subtract operations and handles signed operands natively via sign extension, which is
  exactly what a hardware PE wants over a naive per-bit shift-add. ^[[binary-multiplication]]
- [[twos-complement-arithmetic]] — the number system the datapath runs on: signed representation
  where add/subtract "just work" and carry-out is discarded, plus the overflow rule (operands share
  a sign but the result's sign differs). Accumulation across K-chunks has to respect these ranges.
  ^[[twos-complement-arithmetic]]

Both come from [[350]] (digital systems).

## The matrix math

- [[math-218]] (linear algebra) is the theory the whole accelerator computes: GEMM is matrix
  multiplication, and the tiling scheme lowers larger matmuls onto the fixed 8×8 tile. Column
  spaces, matrix products, and the mechanics of decomposition are the mathematical content the
  hardware accelerates. ^[[math-218]]

## Control and dataflow

- [[finite-state-machines]] and [[fsm-state-minimization]] — the sequencing/control logic that
  drives loads, passes, and resets through the array is FSM work; minimizing it saves flip-flops.
  ^[[finite-state-machines]] ^[[fsm-state-minimization]]
- [[pipelining-and-hazards]] — a systolic array *is* a spatial pipeline; the K-chunk (accumulate,
  no reset) vs. N-block (reset) tiling in the accelerator is a dataflow-scheduling problem in the
  same family as pipeline data hazards and forwarding. ^[[pipelining-and-hazards]]

## If it goes to gate level

- [[boolean-algebra]] (minimization keeps the PE logic small) and [[cmos-logic]] (PUN/PDN
  transistor-level synthesis) are the substrate if the design is pushed below RTL. ^[[boolean-algebra]]
  ^[[cmos-logic]]

## Adjacent experience (not coursework concepts, but relevant)

The [[professional-profile]] shows hands-on embedded/FPGA-adjacent work ([[jones-seel-lab]],
[[ev-firmware]]), and [[ece-350-connect4]] is a *separate* FPGA project (pipelined CPU) sharing the
same Verilog/RTL skill area — distinct scope, do not conflate.

## The accelerator's own internals (gap now closed)

As of 2026-07-18 the repo's `docs/decisions.md` and `docs/learnings.md` are snapshotted into
`raw/repos/hw-cnn-accelerator/` (commit `abd00b2`), and the two genuinely reusable ideas earned there
are promoted: [[systolic-array-dataflow]] (output-stationary choice, skewed dataflow, the K/N tiling
non-contamination proof) and [[neural-network-quantization]] (hardware-forced symmetric int8,
requantization, argmax invariance). So the vault now answers questions about the accelerator's
*internals*, not just its coursework roots — the loop this page opened is closed. ^[[sources/repos-hw-cnn-decisions]]

The through-line: [[binary-multiplication]] + [[twos-complement-arithmetic]] (350) are the MAC math,
[[neural-network-quantization]] decides what integers flow through it, [[systolic-array-dataflow]]
arranges the tiles in space, and [[pipelining-and-hazards]] (350) is the scheduling family the K/N
tiling belongs to.
