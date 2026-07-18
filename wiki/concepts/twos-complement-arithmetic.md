---
kind: concept
domain: education
title: Two's complement arithmetic
course: "350"
---

# Two's complement arithmetic

Three schemes represent signed integers in binary ^[[sources/notion-350-mid-1-arithmetic]]:
- **Sign-magnitude** — leading bit is the sign, rest is magnitude.
- **One's complement** — negate by flipping all bits. Has two zeros (+0 and −0) and needs an
  **end-around carry**: on addition, an overflow carry-out is added back into the low bit.
- **Two's complement** — negate by flipping all bits and adding 1. This is the scheme real hardware
  uses, because addition/subtraction "just work" with ordinary binary addition and any carry-out is
  simply discarded.

## Why two's complement wins

It has a **unique zero** (so $2^n$ bit patterns cover an odd count of nonzero values), which makes
the range **asymmetric**: for n bits, $-(2^{n-1})$ to $2^{n-1}-1$. Two patterns are special: all-0s
is its own negation (−0 = 0), and the most-negative value $100\ldots0$ is its own two's complement
(it has no positive counterpart). ^[[sources/notion-350-mid-1-arithmetic]] (One's complement, by
contrast, is symmetric: $-(2^{n-1}-1)$ to $2^{n-1}-1$.)

Subtraction becomes addition of the negation: $x - y = x + (-y)$.

## Overflow detection

Convert everything to addition first. Then: **if the two operands share a sign but the result's sign
differs, overflow occurred; if the operands' signs differ, overflow is impossible.** ^[[sources/notion-350-mid-1-arithmetic]]

Part of [[350]]; the number system underlying [[binary-multiplication]] and the multiply-accumulate
datapath of [[hw-cnn-accelerator]].
