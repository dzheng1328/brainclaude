---
kind: project
domain: projects
title: ece-350-connect4
course: "350"
partner: Faiz Ali
stack: [Verilog, FPGA, VGA, IR sensors]
status: complete
semester: spring 2026
---

# ece-350-connect4

Dave's **ECE 350 final project**: a playable **Connect 4 game running on a custom 5-stage pipelined
FPGA CPU**, built with a partner (Faiz Ali), with physical IR-sensor input and VGA video output. ^[[sources/drive-350-technical-report-connect4]] ^[[sources/drive-350-final-project-proposal-connect4]]

Distinct from the [[hw-cnn-accelerator]] in every way that matters for the graph: **same broad skill
area** (FPGA / Verilog / pipelined datapaths) but a **different project, different scope, and it has a
partner** — hw-cnn-accelerator is the solo accelerator. Do not conflate the two ([[CLAUDE]]).

Where it lives: the course archive `uni/spring 2026/350/project/`; there is no separate public repo.
The proposal, technical report, and the pipelined-processor source (`processor/`) are catalogued under
[[350]]. ^[[uni/]]

**Concepts it exercises:** [[finite-state-machines]] and [[fsm-state-minimization]] (game/controller
logic), [[pipelining-and-hazards]] (the 5-stage CPU — stalls, forwarding), [[boolean-algebra]] and
[[twos-complement-arithmetic]] (the datapath). Part of [[350]]; see the [[academic-timeline]].
