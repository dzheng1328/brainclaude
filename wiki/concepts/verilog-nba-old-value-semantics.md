---
kind: concept
domain: projects
title: Verilog non-blocking assignment (NBA) old-value semantics
course: "hw-cnn-accelerator"
---

# Verilog non-blocking assignment (NBA) old-value semantics

When a producer register and a consumer register are both updated with a non-blocking assignment
(`<=`) on the *same* clock edge, the consumer's right-hand side reads the producer's **pre-edge
(old) value**, not the value the producer is simultaneously updating to. This single rule explains
two otherwise-surprising results.

**Pipeline timing composes for free.** A skew-feeder built from shift-register lanes of different
depths (lane 0 combinational/delay-0, lane $i$ a depth-$i$ shift register) feeding a downstream
array that samples on the same `posedge` looked like it should need an off-by-one fix. It didn't:
because both the feeder's shift-register stages and the array's input registers use `<=` on the
same edge, the array reads the feeder's *old* last-stage value — so a depth-$i$ register presents,
at the edge ending step $t$, exactly the value fed at step $(t-i)$. Combinational and registered
lanes compose into the correct diagonal with zero extra latency, reasoned through NBA semantics
rather than discovered by trial-and-error timing fixes. ^[[sources/repos-hw-cnn-learnings]]

**Simulation reads can catch the pre-edge value too.** In cocotb, `await RisingEdge(dut.clk)`
resumes the test coroutine in the simulator's *Active* region, which runs *before* the RTL's own
`<=` assignments settle in the *NBA* region for that same edge — so a register read immediately
after `RisingEdge` sees the stale, pre-edge value. `await ReadOnly()` fixes the stale read but then
forbids scheduling any new signal writes in that same phase (VPI read-only-phase restriction); the
robust fix is `await Timer(1, units="ns")` (well under the clock period) after `RisingEdge`, which
advances real simulation time, settles the NBA update, and leaves writes allowed again.
^[[sources/repos-hw-cnn-learnings]]

**Takeaway, generalizable to any synchronous Verilog/SystemVerilog design or its testbench:** when a
producer and consumer register share a clock edge and both use `<=`, reason about delay and read
timing via NBA old-value semantics first, before assuming an off-by-one bug or reaching for
trial-and-error fixes. Relevant wherever [[pipelining-and-hazards]] reasoning applies to RTL.
