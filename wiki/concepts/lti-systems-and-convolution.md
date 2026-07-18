---
kind: concept
domain: education
title: LTI systems and convolution
course: "280"
---

# LTI systems and convolution

A **linear time-invariant** system is completely characterized by its **impulse response** $h(t)$:
once you know $h$, the output for *any* input is the **convolution** ^[[sources/notion-280-course-lti-convolution]]

$$y(t) = x(t) * h(t) = \int_{-\infty}^{\infty} x(\tau)\,h(t-\tau)\,d\tau$$

Two properties are read straight off $h$: the system is **causal** iff $h(t) = 0$ for $t < 0$ (no
output before input), and **BIBO stable** iff $h$ is absolutely integrable, $\int_{-\infty}^\infty
|h(t)|\,dt < \infty$. ^[[sources/notion-280-course-lti-convolution]]

## Convolution identities

- **Sifting**: $x(t) * \delta(t - t_0) = x(t - t_0)$ — convolving with a shifted impulse just shifts
  the signal. (Same $\delta$ as in the [[laplace-transform]].)
- **Commutative and associative**: $x*h = h*x$ and $(x*h)*g = x*(h*g)$.
- Building-block results: $u*u = r(t)$ (unit ramp), and $r(t)*u(t) = \tfrac{1}{2}t^2\,u(t)$.

For piecewise signals the practical method is **flip and slide**: reflect one signal, slide it across
the other, and integrate over the overlap interval. E.g. $h(t) = 2e^{-3t}u(t)$ convolved with $u(t)$
has overlap $\tau \in [0,t]$, giving $y(t) = \tfrac{2}{3}(1 - e^{-3t})u(t)$ — a step response rising
from 0 to $\tfrac{2}{3}$. ^[[sources/notion-280-course-lti-convolution]]

Part of [[280]] (ECE 280). Convolution is easier in a transform domain, where it becomes plain
multiplication ([[fourier-transform-and-filtering]], and the Laplace version in [[laplace-transform]]) —
the shared idea collected in [[convolution-and-transforms]].

*(Provenance: promoted from the course LTI page, which is correct. The separate `mid-1__chat-review`
source is **withheld** — it contains two independent convolution errors, e.g. $r*r$ stated as
$\tfrac{1}{2}t^2$ instead of $t^3/6$, and a garbled distributive identity; see [[contradictions]].)*
