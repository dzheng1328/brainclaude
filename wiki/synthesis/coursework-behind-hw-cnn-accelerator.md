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

**Gap noted:** the accelerator's own design decisions (im2col lowering, the K/N tiling rationale)
live in the repo's `docs/decisions.md`, not the vault — see [[hw-cnn-accelerator]]. Snapshotting
those docs into `raw/repos/` (as was done for [[ev-firmware]]) would let the vault answer questions
about the accelerator's internals, not just its coursework roots.
