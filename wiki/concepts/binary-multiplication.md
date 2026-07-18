---
kind: concept
domain: education
title: Binary multiplication (Booth's algorithm)
course: "350"
---

# Binary multiplication (Booth's algorithm)

Hardware multiplies via **shift-and-add** over HI/LO registers. The **naive** algorithm is unsigned:
load LO with the multiplier Q, HI with 0; for each bit, if LO's LSB is 1 add the multiplicand M to
HI, then shift the HI:LO pair right; combine into the double-width answer. Negative multipliers are
handled clumsily — negate Q up front, multiply, and negate the result at the end. ^[[sources/notion-350-mid-1-multiplication-booths]]

## Booth's algorithm

**Booth's** multiplies signed numbers natively, never flipping inputs. Append a **ghost 0** to the
right of Q and scan overlapping bit pairs (bit $i$, bit $i-1$) from the LSB up; each pair triggers an
action on M shifted left by the current position ^[[sources/notion-350-mid-1-multiplication-booths]]:

- `00`, `11` (middle of a run): do nothing
- `01` (end of a run of 1s): **add** M
- `10` (start of a run of 1s): **subtract** M

Sum the shifted partial terms, sign-extending each to the full width. The insight: a run of 1s is
one add and one subtract at its ends rather than an add per bit — it recodes runs into cheaper
operations, and negative numbers fall out for free from two's-complement sign extension.

**Modified Booth's (radix-4)** scans 3 bits at a time (a pair plus a helper bit) and shifts by 2,
halving the number of partial products, at the cost of also needing $\pm 2M$ terms. ^[[sources/notion-350-mid-1-multiplication-booths]]
An n×n product needs its top n+1 bits to be a valid sign extension for the result to fit.

Part of [[350]]; built on [[twos-complement-arithmetic]]. The multiply step of every processing
element in [[hw-cnn-accelerator]]'s systolic array.
