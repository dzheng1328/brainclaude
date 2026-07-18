---
kind: concept
domain: education
title: Expectation and variance
course: "230-probability"
---

# Expectation and variance

The **expected value** $E[X]$ is the long-run average of a random variable — the probability-weighted
mean, or the "center of mass" of its distribution. For a discrete $X$ it is $E[X] = \sum_i x_i\,p_i$;
for a continuous $X$ with density $f$, $E[X] = \int_{-\infty}^{\infty} x f(x)\,dx$. ^[[sources/notion-230-probability-course-expectation]]
A fair die has $E[X] = 3.5$ — a value it never actually rolls, but the average over many rolls.

## Linearity is the workhorse

$$E[aX + bY] = aE[X] + bE[Y]$$

This holds **even when $X$ and $Y$ are dependent**, which is what lets messy problems decompose — the
expected number of heads in 10 flips is just $10 \times 0.5 = 5$. ^[[sources/notion-230-probability-course-expectation]]
Related identities: $E[c] = c$, $E[g(X)] = \sum_x g(x)P(X=x)$, and $E[XY] = E[X]E[Y]$ **only if
independent**. ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]

Two techniques recur:

- **Indicator variables** — $\mathbb{I}_A = 1$ on event $A$, else $0$, so $E[\mathbb{I}_A] = P(A)$.
  Writing a count as a sum of indicators and applying linearity is how $E[X] = np$ falls out for a
  binomial. ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]
- **Tail-sum formula** — for $X$ on $\{0,1,\dots,n\}$, $E[X] = \sum_{j=1}^{n} P(X \geq j)$, often far
  easier than summing $x\,P(X=x)$ (e.g. the expected minimum of three dice). ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]

## Variance and standard deviation

**Variance** measures spread as the average squared deviation from the mean: ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]

$$\text{Var}(X) = E[(X-\mu)^2] = E[X^2] - (E[X])^2$$

Variances add for **independent** variables: $\text{Var}(X+Y) = \text{Var}(X) + \text{Var}(Y)$ (with
a covariance term $2E[(X-\mu_X)(Y-\mu_Y)]$ otherwise). **Standard deviation** $SD(X) = \sqrt{\text{Var}(X)}$
puts spread back in the original units, and **standardization** rescales any variable to mean 0,
SD 1: $X^* = (X-\mu)/\sigma$ — the step that makes the [[normal-distribution]] tables usable.

Part of [[230-probability]]. These operators are the foundation for every distribution in
[[common-discrete-distributions]], the [[poisson-distribution]], and the limit theorems in
[[law-of-large-numbers-and-clt]].
