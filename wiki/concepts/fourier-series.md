---
kind: concept
domain: education
title: Fourier series
course: "353"
---

# Fourier series

A periodic function ($f(t+p) = f(t)$) can be written as a sum of sines and cosines. For a function of
period $2\pi$ ^[[sources/notion-353-course-periodic-functions-trigonometric-series-fourier-series]]:

$$f(t) \sim \frac{a_0}{2} + \sum_{n=1}^\infty \left(a_n\cos nt + b_n\sin nt\right), \quad
a_n = \frac{1}{\pi}\int_{-\pi}^\pi f(t)\cos nt\,dt, \quad b_n = \frac{1}{\pi}\int_{-\pi}^\pi f(t)\sin nt\,dt$$

For a general period $2L$, substitute $nt \to n\pi t/L$ and average over $[-L, L]$ ^[[sources/notion-353-course-periodic-functions-trigonometric-series-fourier-series]]:

$$f(t) \sim \frac{a_0}{2} + \sum_{n=1}^\infty \left(a_n\cos\tfrac{n\pi t}{L} + b_n\sin\tfrac{n\pi t}{L}\right), \quad
a_n = \frac{1}{L}\int_{-L}^L f\cos\tfrac{n\pi t}{L}\,dt, \quad b_n = \frac{1}{L}\int_{-L}^L f\sin\tfrac{n\pi t}{L}\,dt$$

Symmetry helps: an **even** function has all $b_n = 0$ (cosine series only), an **odd** function has
all $a_n = 0$. A square wave gives $b_n = 4/(n\pi)$ for odd $n$; a triangle wave gives
$a_n = 4/(n\pi)^2$ for odd $n$ — the smoother the function, the faster the coefficients decay. ^[[sources/notion-353-course-periodic-functions-trigonometric-series-fourier-series]]

> **Source note (from [[contradictions]]):** the general period-$2L$ master formula on Dave's page
> drops the $\sin$ from the $b_n$ term, writing $b_n(\tfrac{n\pi t}{L})$ instead of
> $b_n\sin(\tfrac{n\pi t}{L})$ — a transcription slip in the one formula that matters most. The
> correct form (with $\sin$) is stated above; every worked coefficient on the page is correct.

## Convergence

For a **piecewise smooth** $f$ (its derivative is piecewise continuous) the series converges
everywhere: to $f(t)$ where $f$ is continuous, and to the midpoint $\tfrac{1}{2}[f(t^+) + f(t^-)]$ at a
jump discontinuity. ^[[sources/notion-353-course-periodic-functions-trigonometric-series-fourier-series]]

Part of [[353]] (Math 353). The eigenfunctions $\sin(n\pi x/L)$ come from the boundary-value problem
$y'' + \lambda y = 0$, $y(0)=y(L)=0$ (whose $\lambda_n = (n\pi/L)^2$ payoff Dave's BVP page stops just
short of — see [[contradictions]]). Fourier analysis is shared with [[280]] (signals & systems), which
approaches it from the filtering side.
