---
kind: concept
domain: education
title: Common discrete distributions
course: "230-probability"
---

# Common discrete distributions

A family of named distributions for counting successes in independent trials, each with a probability
mass function and known [[expectation-and-variance|mean and SD]].

## Binomial

The number of successes in $n$ independent trials each with success probability $p$: ^[[sources/notion-230-probability-course-normal-approx-to-binomial]]

$$P(X=k) = \binom{n}{k}p^k(1-p)^{n-k}, \qquad E[X] = np$$

For large $n$ it is well approximated by the [[normal-distribution]]. The **hypergeometric**
distribution (sampling *without* replacement) shares the same mean $E[X]=np$ and approaches the
binomial when the population $N$ is large relative to the sample. ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]

## Geometric

The waiting time for the *first* success, in one of two conventions ^[[sources/notion-230-probability-mid-2-discrete-distributions]]:

- **Trial of first success** ($Y \in \{1,2,\dots\}$): $P(Y=k) = (1-p)^{k-1}p$, $E[Y] = 1/p$.
- **Failures before first success** ($Y \in \{0,1,\dots\}$): $P(Y=k) = (1-p)^{k}p$, $E[Y] = (1-p)/p$.

Both have $SD(Y) = \sqrt{1-p}/p$.

## Negative binomial

Generalizes the geometric to the $r$-th success/failure, with four variants depending on what you
count (successes before $r$ failures, failures before $r$ successes, trials until $r$ successes, or
trials until $r$ failures) — e.g. the number of trials until $r$ successes is ^[[sources/notion-230-probability-mid-2-discrete-distributions]]

$$P(X=n) = \binom{n-1}{r-1}p^r(1-p)^{n-r}, \qquad E[X] = \frac{r}{p}$$

Part of [[230-probability]]. The [[poisson-distribution]] is a separate counting model (events per
interval, as a limit of the binomial), and all of these are built on [[expectation-and-variance]].
