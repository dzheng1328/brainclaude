---
kind: concept
domain: education
title: Confidence intervals
course: "230-probability"
---

# Confidence intervals

After running $n$ independent trials and observing a success proportion $\hat{p}$, an **$x\%$
confidence interval** is an interval $(a,b)$ constructed so that there is an $x\%$ chance the true
parameter $p$ lies within it. ^[[sources/notion-230-probability-mid-2-confidence-intervals]]

The construction uses the [[normal-distribution|normal approximation]]. First find the multiplier $k$
from the standard normal CDF so that the central area equals the confidence level: ^[[sources/notion-230-probability-mid-2-confidence-intervals]]

$$\Phi(k) - \Phi(-k) = 2\Phi(k) - 1 = \frac{x}{100}$$

Then the interval is $\hat{p}$ plus or minus $k$ standard errors:

$$\hat{p} - k\frac{\sqrt{p(1-p)}}{\sqrt{n}} \;\leq\; p \;\leq\; \hat{p} + k\frac{\sqrt{p(1-p)}}{\sqrt{n}}$$

Since the true $p$ inside the standard error is unknown, it is estimated — either by the observed
$\hat{p}$, or by $p = \tfrac{1}{2}$, which **maximizes** $p(1-p)$ and so gives the widest, worst-case
interval. ^[[sources/notion-230-probability-mid-2-confidence-intervals]]

Part of [[230-probability]]. This is the inferential payoff of the [[law-of-large-numbers-and-clt|CLT]]:
the sampling distribution of $\hat{p}$ is approximately normal, which is what makes the $\Phi$-based
interval valid.
