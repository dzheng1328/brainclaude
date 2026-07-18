---
kind: concept
domain: education
title: Functional dependencies
course: "316"
---

# Functional dependencies

A **functional dependency** (FD) $X \rightarrow Y$ on a relation R asserts that whenever two tuples
of R agree on all attributes in X, they also agree on all attributes in Y. ^[[sources/notion-316-er-design]]
FDs generalize the notion of a **key**: K is a **superkey** if $K \rightarrow$ all attributes of R,
and a **key** if it is a superkey with no proper subset that is also a superkey (i.e. minimal).
^[[sources/notion-316-er-design]] A relation may have several keys; one is chosen primary.

An FD is **trivial** when $Y \subseteq X$, and non-trivial otherwise.

## Attribute closure

The **closure** $X^+$ of an attribute set X under a set of FDs $\mathcal{F}$ is every attribute
functionally determined by X. It is computed by a fixpoint: start with $X^+ = X$; whenever $A
\rightarrow B \in \mathcal{F}$ with $A \subseteq X^+$, add B; repeat until nothing new is added.
^[[sources/notion-316-er-design]] Closure answers the two core questions:
- **Does $X \rightarrow Y$ follow from $\mathcal{F}$?** Yes iff $Y \subseteq X^+$.
- **Is K a (super)key?** Yes iff $K^+$ contains all attributes of R (then check minimality).

## Armstrong's axioms

FD inference is captured completely by three axioms: **reflexivity** ($Y \subseteq X \Rightarrow X
\rightarrow Y$), **augmentation** ($X \rightarrow Y \Rightarrow XZ \rightarrow YZ$), and
**transitivity** ($X \rightarrow Y, Y \rightarrow Z \Rightarrow X \rightarrow Z$). Two useful derived
rules follow: **splitting/combining** between $X \rightarrow YZ$ and the pair $X \rightarrow Y$, $X
\rightarrow Z$. ^[[sources/notion-316-er-design]]

A **non-key FD** — a non-trivial $X \rightarrow Y$ where X is not a superkey — is the formal source
of redundancy that [[database-normalization]] exists to remove. Part of [[316]]; underpins
[[entity-relationship-model]] key translation.
