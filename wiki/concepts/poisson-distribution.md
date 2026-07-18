---
kind: concept
domain: education
title: Poisson distribution
course: "230-probability"
---

# Poisson distribution

The Poisson distribution models the count of independent events in a fixed interval of time or space
when they occur at a constant average rate $\mu$ (often written $\lambda$). Its probability mass
function is ^[[sources/notion-230-probability-mid-2-poisson]]

$$P(X=k) = \frac{\mu^k e^{-\mu}}{k!}$$

Its defining peculiarity: **the mean equals the variance**, $E[X] = \text{Var}(X) = \mu$ (so
$SD = \sqrt{\mu}$) — a property unique among the standard distributions and a fast sanity check for
whether data is Poisson. ^[[sources/notion-230-probability-mid-2-poisson]]

## When it applies, and its limits

Use it for independent, non-simultaneous events at a constant rate whose chance in a small interval is
proportional to the interval length — arrivals at an ER, calls per hour, defects per batch. It sits
between the other counting models ^[[sources/notion-230-probability-mid-2-poisson]]:

- It **approximates the [[common-discrete-distributions|binomial]]** when $n$ is large and $p$ small,
  with $\mu = np$ — the "law of rare events."
- For large $\mu$ (roughly $> 20$) it is itself **approximated by the [[normal-distribution]]** with
  mean and variance $\mu$.

Sums of independent Poisson variables are again Poisson.

Part of [[230-probability]]. *(Provenance note: this source snapshot and the tail-sum example are
written in polished textbook prose unlike the terse LaTeX of the rest of the corpus — flagged in
[[contradictions]] as possibly not Dave's own writing. The content is standard and correct; the flag
concerns authorship of the snapshot, not the math.)*
