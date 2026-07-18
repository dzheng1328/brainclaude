---
kind: concept
domain: education
title: CMOS logic
course: "350"
---

# CMOS logic

CMOS builds gates by treating transistors as electrically-controlled switches, in two complementary
halves ^[[sources/notion-350-mid-2-cmos-logic]]:
- **Pull-up network (PUN)** — PMOS transistors connecting the output to VDD (logic 1). PMOS is
  **active-low**: it conducts when its gate sees a 0.
- **Pull-down network (PDN)** — NMOS transistors connecting the output to GND (logic 0). NMOS is
  **active-high**: it conducts when its gate sees a 1.

Because of this complementarity a single CMOS stage is naturally **inverting** — you build a NAND or
NOR directly, and get AND/OR only by adding an inverter.

## Synthesis method

Each literal costs one transistor, so minimize first (factor out common terms). Then ^[[sources/notion-350-mid-2-cmos-logic]]:
1. **Derive the PDN from $\bar f$** — the PDN must conduct when $f=0$, so express $\bar f$ via De
   Morgan's; ANDed terms become **series** transistors, ORed terms become **parallel** ones.
2. **Derive the PUN as the dual of the PDN** — series↔parallel swapped, same input variables on the
   gates. (The PUN drives the output high when $f=1$.)

So the PUN and PDN are structural duals sharing inputs, one pulling toward VDD and the other toward
GND, exactly one conducting for any input. Minimizing literals ([[boolean-algebra]]) directly reduces
transistor count.

Part of [[350]]; the same PUN/PDN gate-design material also appears in [[230-semiconductors]]
(ECE 230L), which approaches it from the device-physics side (see [[sources/drive-230-semi-cmos-template]]).
