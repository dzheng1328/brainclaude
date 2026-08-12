---
kind: concept
domain: projects
title: NoC router design (mesh, XY routing, round-robin)
course: "hw-cnn-accelerator"
---

# NoC router design (mesh, XY routing, round-robin)

A **network-on-chip (NoC) router** is the block, replicated once per node, that moves fixed-format
packets ("flits") between neighbors and into/out of a local compute tile. Three design axes recur
in the simplest correct form of this block, distinct from the [[systolic-array-dataflow]] the NoC
carries operands for. ^[[sources/repos-hw-cnn-decisions]]

**Topology: 2D mesh.** Each router talks to N/E/S/W neighbors plus its local tile, versus a ring
or crossbar. A mesh is the standard teaching-stack choice because it composes cleanly out of
identical, unmodified router instances — a 2x2 mesh is just four `noc_node`s wired together, no
per-node customization beyond tied-off coordinates. ^[[sources/repos-hw-cnn-decisions]]

**Routing: XY dimension-order.** Route fully along X, then fully along Y (versus adaptive or
table-based routing). XY routing is *provably deadlock- and starvation-free* and single-path per
source-destination pair — the property that lets an integration test assert bit-exact delivery
end-to-end without reasoning about alternate paths. ^[[sources/repos-hw-cnn-decisions]]

**Arbitration: round-robin.** One round-robin arbiter per output port ensures no input can starve
another under contention, paired with valid/ready backpressure. ^[[sources/repos-hw-cnn-decisions]]

**Crossbar: combinational, single-cycle** is the simplest correct starting point (no internal
buffering) — but it creates combinational cycles across multiple mesh hops, which is why a real
multi-hop mesh needs registered buffers on router inputs (a small skid FIFO) to break the cycle
before the design can compose past a single hop. ^[[sources/repos-hw-cnn-decisions]]

**Router coordinates as ports, not parameters** is a deliberate choice tied to a verification
gotcha — see [[cocotb-parameter-override-gotcha]]. Exposing `my_x`/`my_y` as input ports (tied off
per instance) rather than Verilog `parameter`s sidesteps a silent divergence between the RTL
default and whatever a cocotb testbench assumes. ^[[sources/repos-hw-cnn-decisions]]

Generalizable beyond this one accelerator to any multi-tile hardware design that needs simple,
provably-correct on-chip interconnect rather than a custom high-performance router.
