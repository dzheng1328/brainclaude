---
kind: concept
domain: education
title: Relational algebra
course: "316"
---

# Relational algebra

Relational algebra is a formal query language over the **relational data model**, where a database
is a set of relations (tables), each relation a set of tuples (rows) over named, typed attributes
(columns); duplicate tuples and set-valued attributes are disallowed, and row/column order carries
no meaning. ^[[sources/notion-316-relational-model-algebra]] Queries are built by composing
operators, each taking relations in and producing a relation out — so operators nest arbitrarily.

**Core operators** ^[[sources/notion-316-relational-model-algebra]]:
- **Selection** ($\sigma_p R$) — keep the rows of R satisfying predicate $p$; same columns.
- **Projection** ($\pi_L R$) — keep only columns $L$; duplicate result rows are removed by definition.
- **Cross product** ($R \times S$) — every row of R concatenated with every row of S.
- **Union** ($R \cup S$) and **difference** ($R - S$) — require identical schemas.
- **Renaming** ($\rho$) — rename a relation and/or its columns, chiefly to set up natural joins or
  avoid name clashes; like every operator it returns a copy and never mutates the input.

**Derived operators** are shorthands over the core: **theta-join** $R \bowtie_p S = \sigma_p(R\times
S)$; **natural join** equijoins on shared column names and drops the duplicate columns; **intersection**
$R \cap S = R \bowtie S$. ^[[sources/notion-316-relational-model-algebra]]

## Monotonicity

An operator is **monotone** if adding rows to its input never forces removal of a previously
correct output row — formally $R \subseteq R'$ implies $op(R) \subseteq op(R')$. This matters
because monotone operators support incremental evaluation and bound what relational algebra can
express. ^[[sources/notion-316-relational-model-algebra]]

Selection, projection, cross product, join, natural join, and intersection are monotone. **Union
is monotone in *both* arguments.** **Difference $R-S$ is monotone in R but NON-monotone in S** —
adding a row to S can delete a row from the output.

> **Divergence from Dave's source.** The 316 note ^[[sources/notion-316-relational-model-algebra]]
> classifies union as "monotone wrt R, non-monotone wrt S" and difference as simply "monotone."
> Both are wrong: union is monotone in both arguments, and it is *difference* that is non-monotone
> in its second argument. The note appears to have swapped the two. Filed in [[contradictions]].

Relational algebra is simple and largely declarative, but has **no recursion** (see the `WITH
RECURSIVE` extension under [[sql]]) and general query optimization over it is undecidable.
^[[sources/notion-316-relational-model-algebra]] Part of [[316]].
