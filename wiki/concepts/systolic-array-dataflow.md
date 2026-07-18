---
kind: concept
domain: projects
title: Systolic array dataflow
course: "hw-cnn-accelerator"
---

# Systolic array dataflow

A **systolic array** computes a matrix multiply by streaming operands through a grid of
multiply-accumulate cells, each doing one [[binary-multiplication|multiply]] per cycle and adding it
to a local running sum — a spatial pipeline ([[pipelining-and-hazards]]) where data marches through in
lockstep. Two design axes matter, both decided in [[hw-cnn-accelerator]].

## Output-stationary vs. weight-stationary

- **Output-stationary** — each cell holds a stationary *accumulator* while both operands stream
  through; the partial sum stays put. ^[[sources/repos-hw-cnn-decisions]]
- **Weight-stationary** — each cell holds a persistent *weight* loaded in a separate phase and reused
  across many inputs; what TPUs do for fixed-weight, many-image inference.

The accelerator chose output-stationary because it needed *zero* change to already-verified MAC logic
(only added the operand-forwarding ports), whereas weight-stationary's weight-reuse advantage — real
for a fixed-weights MNIST workload — is a later-phase performance concern. ^[[sources/repos-hw-cnn-decisions]]

## Skewed dataflow and correctness by timing

Inputs are **skewed** (row/column $i$/$j$ delayed by $i$/$j$ cycles) and zero-padded so that cell
$(i,j)$'s two operands are simultaneously nonzero *only* during the window $t \in [i+j, i+j+N-1]$.
Outside it at least one operand is zero, so stray $0\times0$ accumulations are harmless — which is
*why* a single broadcast `valid_in` is correct, not merely simpler. An $8\times8$ tile fully computes
in $3N-2 = 22$ cycles. ^[[sources/repos-hw-cnn-decisions]]

## Tiling a big matmul onto a small tile

Larger matmuls are decomposed into $8\times8$ blocks: the **K (reduction) dimension** is tiled by
feeding waves back-to-back *without* resetting (the accumulator keeps summing), while each independent
**N-block** of output columns gets a fresh reset. A timing argument proves K-chunks can't
cross-contaminate — because $\text{TOTAL\_CYCLES} = 3N-2 = 22 > 2(N-1) = 14$, the chunk-index equation
$22(c_1 - c_2) \in [-7,7]$ forces $c_1 = c_2$ whenever both operands are nonzero, so contamination is
algebraically impossible. Since integer accumulation is exact and associative, an untiled NumPy matmul
is bit-exactly equal to the chunked hardware result. ^[[sources/repos-hw-cnn-decisions]]

Part of [[hw-cnn-accelerator]]. This is the dataflow the [[coursework-behind-hw-cnn-accelerator|coursework]]
feeds into: the MAC is [[binary-multiplication]] + [[twos-complement-arithmetic]], the tiling schedule
is a [[pipelining-and-hazards]] cousin, and the operands are quantized per [[neural-network-quantization]].
