---
kind: concept
domain: education
title: Normal distribution and approximation
course: "230-probability"
---

# Normal distribution and approximation

The normal (Gaussian) distribution $\mathcal{N}(\mu, \sigma)$ is the bell curve: symmetric about its
mean $\mu$ (which is also its peak), with spread set by $\sigma$, and total area 1 so that areas *are*
probabilities. ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]] Because
the density has no elementary antiderivative, probabilities are read from the **standard normal CDF**

$$\Phi(z) = \int_{-\infty}^{z}\frac{1}{\sqrt{2\pi}}e^{-x^2/2}\,dx$$

Any normal is reduced to the standard one by [[expectation-and-variance|standardization]], so an
interval probability is $P(a \leq X \leq b) = \Phi\!\left(\frac{b-\mu}{\sigma}\right) -
\Phi\!\left(\frac{a-\mu}{\sigma}\right)$. ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]

## Approximating the binomial

The normal is most useful as an approximation. A [[common-discrete-distributions|binomial]] with large
$n$ is approximated by $\mathcal{N}(np, \sqrt{np(1-p)})$. Because a continuous curve is standing in for
a discrete count, a **continuity correction** of $\pm\tfrac{1}{2}$ is applied to the endpoints ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]:

$$P(x \leq X \leq y) \approx \Phi\!\left(\frac{y+\tfrac{1}{2}-\mu}{\sigma}\right) -
\Phi\!\left(\frac{x-\tfrac{1}{2}-\mu}{\sigma}\right)$$

which matters most when $\sigma$ is small. Sampling **without** replacement (hypergeometric) uses the
same approximation with a population correction factor $\sigma = \sqrt{\tfrac{N-n}{n-1}}\sqrt{np(1-p)}$. ^[[sources/notion-230-probability-mid-2-expected-value-normal-distributions]]

Part of [[230-probability]]. The reason this approximation works at all is the [[law-of-large-numbers-and-clt|central
limit theorem]], and $\Phi$ is the same tool used to build [[confidence-intervals]].
