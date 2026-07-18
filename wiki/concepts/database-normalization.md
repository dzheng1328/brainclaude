---
kind: concept
domain: education
title: Database normalization
course: "316"
---

# Database normalization

Normalization removes redundancy from a schema by **decomposing** a relation into smaller ones. A
decomposition of R into S and T is **lossless-join** if the natural join $S \bowtie T$ always
reconstructs exactly R (given the constraints). Any decomposition guarantees $R \subseteq S \bowtie
T$; a **lossy** one has $R \subset S \bowtie T$ — the join manufactures spurious tuples. ^[[sources/notion-316-er-design]]

## BCNF

A schema is in **Boyce–Codd Normal Form** when every non-trivial [[functional-dependencies|FD]] $X
\rightarrow Y$ has X a superkey — i.e. no non-key FDs, hence no FD-induced redundancy. The BCNF
decomposition algorithm repeatedly finds a violating FD $X \rightarrow Y$ (X not a superkey) and
splits R into $R_1 = X \cup Y$ and $R_2 = X \cup (R - Y)$, until every relation is in BCNF. This
decomposition is always lossless (the proof uses the violating FD itself). ^[[sources/notion-316-er-design]]

## Multivalued dependencies and 4NF

FDs don't capture all redundancy. A **multivalued dependency** $X \twoheadrightarrow Y$ holds when,
for any two tuples agreeing on X, swapping their Y-components yields tuples also in R — i.e. Y and
the rest are independent given X. ^[[sources/notion-316-er-design]] **Fourth Normal Form (4NF)**
requires every non-trivial MVD to have a superkey left-hand side; its decomposition algorithm is
essentially BCNF's applied to a violating MVD ($R_1 = X\cup Y$, $R_2 = X\cup Z$), and any
decomposition on a 4NF violation is lossless. Whether an FD or MVD follows from a dependency set is
decided by the **chase** procedure. ^[[sources/notion-316-er-design]]

Part of [[316]]; the payoff of [[functional-dependencies]] and the target of [[entity-relationship-model]]
schema design.
