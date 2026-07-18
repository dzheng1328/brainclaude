---
kind: concept
domain: education
title: Law of large numbers and central limit theorem
course: "230-probability"
---

# Law of large numbers and central limit theorem

Two theorems about what happens to sums and averages of many i.i.d. random variables — the theoretical
justification for the whole [[normal-distribution|normal approximation]] machinery.

## Law of large numbers

For an i.i.d. sequence $X_1, X_2, \dots$ with mean $\mu$, the **sample mean** converges in probability
to $\mu$: for every $\epsilon > 0$, ^[[sources/notion-230-probability-mid-2-law-of-large-numbers-clt]]

$$P\!\left(\,\lvert \bar{X}_n - \mu \rvert < \epsilon\,\right) \to 1 \quad\text{as } n \to \infty$$

The convergence is of the **average** $\bar{X}_n = \tfrac{1}{n}\sum X_i$ — "the average of the average
is the average." A single term $X_n$ does *not* converge to $\mu$ for non-degenerate variables.

> **Source divergence (from [[contradictions]]):** Dave's course-level page states this without the
> bar, as $P(\lvert X_n - \mu\rvert < \epsilon)\to 1$, which is the false single-term claim. The
> **exam page is correct** and is cited here; the course page's omission of the bar is the error.

## Central limit theorem

For the sum $S_n = X_1 + \dots + X_n$, ^[[sources/notion-230-probability-course-lln-clt]]

$$E[S_n] = n\mu, \qquad SD(S_n) = \sqrt{n}\,\sigma$$

and for large $n$ the distribution of $S_n$ is approximately normal, $S_n \approx \mathcal{N}(n\mu,
\sqrt{n}\,\sigma)$. Standardizing, $P\!\left(a \leq \frac{S_n - n\mu}{\sqrt{n}\,\sigma} \leq b\right)
\approx \Phi(b) - \Phi(a)$. This is *why* a [[common-discrete-distributions|binomial]] (a sum of
Bernoulli indicators) goes normal.

> **Source divergence (from [[contradictions]]):** the exam page's standardization writes the
> denominator as $\sqrt{n}\,\textbf{-}\,SD(X_i)$ (a minus sign) — a typo, since the same file four
> lines earlier gives the correct $\sqrt{n}\,SD(X_i)$. The **course page is correct** and consistent,
> and is cited here for the CLT.

The resolution in the ledger is **link, don't merge**: each of Dave's two pages is authoritative on
exactly the half the other gets wrong. Note the course page parameterizes the normal by SD, not
variance — legitimate but will collide with any $\mathcal{N}(\mu,\sigma^2)$ convention.

Part of [[230-probability]], built on [[expectation-and-variance]] and underpinning the
[[normal-distribution]].
