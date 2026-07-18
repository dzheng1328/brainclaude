---
kind: source
domain: education
title: "ECE/CS 350 midterm cheat sheets (I & II)"
source_type: local_archive
source_path: "uni/spring 2026/350/Midterm I Cheat Sheet.pdf, Midterm II Cheat Sheet.pdf"
course: "350"
term: spring 2026
fetched: 2026-07-17
---

# ECE/CS 350 — Midterm cheat sheets (I & II)

Dave's two handwritten [[350]] midterm cheat sheets. **These are handwritten scans — OCR of the
specific formulas is unreliable, so this card records topic *coverage* and points to the PDFs for
the actual math. Do not treat any transcribed formula here as authoritative.** ^[[uni/spring 2026/350/Midterm I Cheat Sheet.pdf]] ^[[uni/spring 2026/350/Midterm II Cheat Sheet.pdf]]
This makes the cheat sheets a reliable **map of what the course covers** — high value for deciding
what concepts to promote at `/ingest` — without asserting the details.

**Midterm I coverage:**
- SOP simplification via the algebra "power tools": adjacency, idempotency, consensus theorems;
  minterm-pairing.
- POS simplification (group the 0's; De Morgan's to convert).
- Karnaugh maps: grouping rules (rectangles only, powers of 2, wrap-around "the map is a donut").
- Number representations & addition: unsigned, 1's complement, 2's complement, sign-magnitude.
- Binary multiplication: **Booth's algorithm vs. the naive method**.

**Midterm II coverage:**
- **Quine–McCluskey**: finding prime implicants (with don't-cares), building the cover table,
  identifying essential PIs, table reduction by row/column dominance.
- **FSM state minimization**: state partitioning (Moore), implication charts, Mealy sequence
  detectors — directly the [[fsm-state-minimization]] concept.
- Flip-flop excitation tables: DFF, TFF, JKFF.
- **CMOS logic**: transistors as switches, PUN (PMOS→VDD) / PDN (NMOS→GND), deriving the PDN from
  the function's inverse via De Morgan's (ANDed→series, ORed→parallel), PUN as the PDN flipped.
  Overlaps the CMOS material in [[230-semiconductors]].
- **Hamming codes**: SEC/SED vs. SECDED, the parity-bit count bound (2^k ≥ m+k+1), parity-position
  assignment. Connects to the error-correction / Hamming-distance idea.
- **Pipelining & data hazards**: detecting hazards by comparing source vs. destination register
  names across pipeline stages; fixing via software interlocks, hardware interlocks (stalling),
  and bypassing/forwarding. Directly relevant to [[ece-350-connect4]] (pipelined CPU) and
  [[hw-cnn-accelerator]].
- Circuit testing: fault vs. failure vs. error; transient vs. permanent faults.

**Concept candidates** (for `/ingest`, formulas to be verified against the PDF, not this card):
[[fsm-state-minimization]] (already seeded), Quine–McCluskey minimization, CMOS PUN/PDN synthesis,
Booth's multiplication, two's-complement arithmetic, Hamming codes, pipeline hazards & forwarding.
