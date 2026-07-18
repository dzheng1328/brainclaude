---
kind: synthesis
domain: education
title: Convolution and transforms
built: 2026-07-18
---

# Convolution and transforms

A single idea shows up in two of Dave's courses under two names, and seeing it once explains both:
**convolution in the time domain is multiplication in a transform domain.** Whenever a problem
convolves two signals, transforming turns the hard integral into an easy product.

| Course | Transform | The theorem |
|---|---|---|
| [[353]] (Math 353) | Laplace $\mathcal{L}$ | $\mathcal{L}\{f * g\} = F(s)\,G(s)$ — see [[laplace-transform]] |
| [[280]] (ECE 280) | Fourier $\mathcal{F}$ | $\mathcal{F}\{x * h\} = X(\omega)\,H(\omega)$ — see [[fourier-transform-and-filtering]] |

In both, convolution is defined the same way — $(f*g)(t) = \int f(\tau)g(t-\tau)\,d\tau$ — and in both
the payoff is identical: to compute $y = x * h$, transform each factor, multiply, and invert.

## Why it matters across the two courses

- In **353** it is how you solve an ODE with an arbitrary forcing function: the response is the forcing
  convolved with the system's impulse response, and Laplace turns that into algebra plus partial
  fractions.
- In **280** it is how an [[lti-systems-and-convolution|LTI system]] processes a signal: the output
  spectrum is the input spectrum times the system's frequency response $H(\omega)$ — and **filtering
  is exactly this multiplication**, keeping or killing frequency bands.

The same duality runs the other way too (multiplication in time ↔ convolution in frequency), and the
shared cast — the impulse $\delta$, the step $u$, the exponential $e^{at}$ — appears in both courses'
transform tables. Two courses, one theorem: the transform trades convolution for multiplication, and
that trade is why transforms are worth learning at all.

Anchored in [[laplace-transform]], [[fourier-transform-and-filtering]], and
[[lti-systems-and-convolution]].
