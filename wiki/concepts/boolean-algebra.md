---
kind: concept
domain: education
title: Boolean algebra and logic minimization
course: "350"
---

# Boolean algebra and logic minimization

A combinational function is fully specified by its **truth table** (every input/output combination).
From the table, two canonical algebraic forms: **sum of products (SOP)** — OR together one product
(**minterm**) per input row where $f=1$; and **product of sums (POS)** — AND together one sum
(**maxterm**) per row where $f=0$. ^[[sources/notion-350-mid-1-truth-tables-the-works]] Operator
precedence is NOT → AND → OR.

**Don't-cares** — input combinations that never occur — may be assigned 0 or 1 freely to help
minimize. ^[[sources/notion-350-mid-1-truth-tables-the-works]]

## The algebra

The identities that drive simplification: annihilation/identity ($x\cdot0=0$, $x+1=1$), idempotence
($x+x=x$), complement ($x+x'=1$), **De Morgan's** ($(xy)'=x'+y'$, $(x+y)'=x'y'$), absorption
($x+xy=x$), **consensus** ($xy+yz+x'z = xy+x'z$), and the "unnamed" rule $x+x'y = x+y$. ^[[sources/notion-350-mid-1-truth-tables-the-works]]

## Minimization

Manual minimization uses **Karnaugh maps** (visual grouping of adjacent 1s into power-of-2
rectangles, with wrap-around adjacency). The systematic, computer-friendly equivalent is the
**Quine–McCluskey** algorithm, in two phases ^[[sources/notion-350-mid-2-quine-mccluskey-algorithm]]:

1. **Find all prime implicants.** List minterms (and don't-cares) in binary, grouped by number of
   1s; repeatedly combine terms from adjacent groups that differ in exactly one bit, marking that bit
   `x`; any term never combined further is a prime implicant.
2. **Cover table.** Rows = prime implicants, columns = the *required* minterms (don't-cares dropped).
   A column with a single mark forces an **essential** prime implicant. Remove essentials and their
   covered columns, then reduce the rest by **row/column dominance**. The minimal cover is **not
   necessarily unique** — equal-cost choices are fine.

Part of [[350]]; the substrate for [[finite-state-machines]] next-state logic and [[cmos-logic]]
circuit synthesis.
