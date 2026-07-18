---
kind: concept
domain: education
title: Pipelining and hazards
course: "350"
---

# Pipelining and hazards

Pipelining overlaps the execution of successive instructions so a new one can start each cycle
before earlier ones finish. This raises throughput but introduces **hazards** — situations where an
instruction can't proceed correctly because it depends on something not yet ready. Three kinds ^[[sources/uni-350-cheat-sheets]]:

- **Structural** — two instructions need the same hardware in the same cycle.
- **Data** — an instruction needs a value an earlier, still-in-flight instruction hasn't written yet.
- **Control** — a branch's outcome isn't known when the next fetch must happen, so the pipeline
  doesn't yet know which instruction to run.

## Detecting and fixing data hazards

A **data hazard** is detected by comparing the **source register** names of the instruction now
decoding against the **destination register** names of older instructions still moving through the
later pipeline stages; a match means the needed value isn't in the register file yet. ^[[sources/uni-350-cheat-sheets]]

Three fixes:
- **Software interlocks** — the compiler inserts independent instructions (or NOPs) so the dependency
  has resolved by the time the value is needed.
- **Hardware interlocks (stalling)** — the pipeline freezes the dependent instruction until the value
  is available. Correct, but costs cycles.
- **Bypassing / forwarding** — route the computed value directly from a later stage back to where a
  younger instruction needs it, without waiting for it to be written to the register file. The fastest
  fix, and the standard one.

Part of [[350]]. This is the machinery behind the 5-stage pipelined CPU in [[ece-350-connect4]], and
the dataflow-scheduling concerns are cousins of the K-chunk/N-block tiling in [[hw-cnn-accelerator]].
*(Sourced from the 350 midterm cheat sheet, a handwritten topic map — the concept is standard; the
cheat sheet's OCR'd formulas were not transcribed. See [[sources/uni-350-cheat-sheets]].)*
