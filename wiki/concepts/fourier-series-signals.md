---
kind: concept
domain: education
title: Fourier series of signals (harmonic decomposition)
course: "280"
---

# Fourier series of signals (harmonic decomposition)

The signals-and-systems view of the [[fourier-series]]: a periodic signal is a sum of **complex
exponential harmonics** $e^{jk\omega_0 t}$, each weighted by a Fourier coefficient $X[k]$

$$X[k] = \frac{1}{T_0}\int_{\langle T_0\rangle} x(t)\,e^{-jk\omega_0 t}\,dt, \qquad \omega_0 = \frac{2\pi}{T_0}$$

A Fourier series exists when the signal meets the **Dirichlet conditions**: periodic and absolutely
integrable over a period, with finitely many extrema and finitely many discontinuities per period (it
can't be "infinitely wiggly" or "infinitely broken"). ^[[sources/notion-280-course-fourier-series]] ^[[sources/notion-280-course-fourier-series-comp-filters]]

## Decomposition by inspection

When a signal is a product of sinusoids, trig identities plus Euler's formula reveal its harmonics
directly, no integral needed. For $x(t) = 3\sin(\tfrac{4\pi}{3}t)\cos(\tfrac{8\pi}{3}t)$, the
product-to-sum identity gives two sinusoids at $\omega = 4\pi$ and $\tfrac{4\pi}{3}$; the **fundamental
frequency** is their greatest common divisor $\omega_0 = \tfrac{4\pi}{3}$ (period $T = 2\pi/\omega_0 =
\tfrac{3}{2}$), and rewriting in exponentials shows only harmonics $k = \pm1, \pm3$ are present, with
coefficients read straight off each $e^{jk\omega_0 t}$ term. ^[[sources/notion-280-course-fourier-series-decomp]]

For a pulse train (e.g. $x=1$ on $[0,1]$, $0$ on $[1,4]$, period 4) the coefficients come from the
defining integral, $X[k] = \frac{1 - e^{-jk\pi/2}}{jk2\pi}$ with $X[0] = \tfrac{1}{4}$ the average. ^[[sources/notion-280-course-fourier-series-comp-filters]]

Part of [[280]] (ECE 280). Same mathematics as [[fourier-series]] ([[353]]) approached from the
ODE/BVP side — overlap, not conflict ([[contradictions]]). Passing the harmonics through a filter or
into the continuous-frequency domain is [[fourier-transform-and-filtering]].
