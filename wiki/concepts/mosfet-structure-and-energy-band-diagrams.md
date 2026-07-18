---
kind: concept
domain: education
title: MOSFET structure and energy-band diagrams
course: "230-semiconductors"
---

# MOSFET structure and energy-band diagrams

A **MOSFET** is a [[mos-capacitor]] with two heavily-doped regions — **source** and **drain** —
embedded in the silicon on either side of the gate. An **NMOS** puts n+ source/drain in a p-type
body; a **PMOS** puts p+ source/drain in an n-type body. ^[[sources/notion-230-semiconductors-mid-2-mosfet-fundamentals-structure]]

## As a switch

With no gate voltage the n+ source and n+ drain of an NMOS are separated by the p-type body — two
back-to-back [[pn-junction]]s that block current: the switch is **OFF**. Raise the gate above the
**threshold voltage** ($V_G > V_T$) and the surface inverts into a conductive electron channel
bridging source to drain; now a drain–source voltage $V_{DS}$ drives current and the switch is
**ON**. ^[[sources/notion-230-semiconductors-mid-2-mosfet-fundamentals-structure]] This gate-controlled
switching is the physical event underneath every [[cmos-logic]] gate (350).

## Performance metrics

Extracted from the device's measured curves ^[[sources/notion-230-semiconductors-mid-2-mosfet-fundamentals-structure]]:

- **Transconductance** $g_m = \partial I_D / \partial V_{GS}$ — how strongly the gate controls the
  channel (read from the *output* characteristics).
- **Subthreshold swing** $SS = (\partial \log I_D / \partial V_{GS})^{-1}$, in mV/decade — how
  abruptly the device shuts off (read from the log-scale *subthreshold* characteristics); smaller is
  better.
- $I_{ON}$ / $I_{OFF}$ — the on-current at full drive versus the leakage that sneaks through at
  $V_{GS}=0$.
- **Cutoff frequency** $f_T = g_m / (2\pi C_{gs})$ — the switching-speed limit, set by the gate
  capacitance. **Parasitic gate–source/drain overlap capacitances** from imperfect gate alignment
  are the real bottleneck that caps $f_T$.

## Energy-band diagrams (the two cutlines)

The device is read along two slices ^[[sources/notion-230-semiconductors-mid-2-mosfet-structure-and-energy-band-diagrams]]:

- **Vertical** (gate → substrate) reproduces exactly the [[mos-capacitor]] band diagram; an ON
  transistor is that capacitor in strong inversion.
- **Horizontal** (source → channel → drain) shows a potential barrier — a hill for electrons — that
  the gate voltage lowers to let carriers flood across.

Part of [[230-semiconductors]] (ECE 230L). The MOSFET is the atom of digital hardware: it is the
switch [[cmos-logic]] composes into gates, and thus lies under the FPGA/RTL work in
[[hw-cnn-accelerator]] and [[ece-350-connect4]]. Likely also the device studied in the
[[dave-zheng-pcb]] lab.
