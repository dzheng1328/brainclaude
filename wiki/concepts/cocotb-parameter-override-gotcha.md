---
kind: concept
domain: projects
title: cocotb Makefile flow can't override Verilog parameters
course: "hw-cnn-accelerator"
---

# cocotb Makefile flow can't override Verilog parameters

Any RTL `parameter` that a [cocotb](https://www.cocotb.org/) testbench also encodes as a Python
constant is a silent-divergence risk: cocotb's standard Makefile flow does not reliably override
Verilog `parameter`s from the testbench side, so the RTL's compiled-in default silently wins in
simulation even when the Python side assumes a different value. In one case a router's `MY_X`/`MY_Y`
coordinate parameters stayed at their default because the Makefile flow couldn't override them; in
a second, separate case the same class of bug hit a payload-width (`PW`) constant that the RTL
default and a testbench constant disagreed on. ^[[sources/repos-hw-cnn-learnings]]

**Fix pattern:** keep the value in exactly one place — either drive it as an input *port* the
testbench sets explicitly (not a `parameter`), or pass it explicitly via `-P`/`COMPILE_ARGS` — and
comment the coupling so a future edit to one side doesn't silently desync from the other.
^[[sources/repos-hw-cnn-learnings]]

**Debugging pattern:** when a DUT behaves impossibly (output looks correct-shaped but wrong), dump
the DUT's *inputs as it actually sees them* early rather than trusting the testbench's intended
values — the misplaced-offset symptom here pointed straight at the width mismatch once the actual
DUT-side values were inspected. ^[[sources/repos-hw-cnn-learnings]]

Generalizable to any cocotb-based Verilog/SystemVerilog verification flow, not specific to NoC
routers — see [[noc-router-design]] for the design context this was found in.
