---
kind: concept
domain: education
title: Fourier transform and filtering
course: "280"
---

# Fourier transform and filtering

The Fourier transform extends [[fourier-series-signals|harmonic decomposition]] to non-periodic
signals, mapping a time signal $x(t)$ to a continuous frequency spectrum $X(\omega)$. The workhorse
pair is the rectangular pulse and the sinc ^[[sources/notion-280-course-time-to-freq-domain-and-back-graphically]]:

$$\text{rect}(t/\tau) \;\xleftrightarrow{\,\mathcal{F}\,}\; \frac{2\sin(\omega\tau)}{\omega}$$

## Working graphically, both directions

The practical recipe is decompose-and-add: break the waveform into simple blocks, apply known
transform pairs to each, and sum. Time→frequency uses forward pairs; frequency→time uses inverse
pairs. **Duality** means the two directions look almost identical — to invert, reuse the forward pair
with $\omega$ and $t$ swapped and a $1/2\pi$ factor. So $\text{rect}(\omega/\tau)
\xleftrightarrow{\mathcal{F}^{-1}} \frac{1}{\pi t}\sin(\tau t)$. ^[[sources/notion-280-course-time-to-freq-domain-and-back-graphically]]

## The convolution theorem

The reason the frequency domain is worth the trip: **convolution in time becomes multiplication in
frequency**. ^[[sources/notion-280-course-convolution-in-fourier]]

$$y(t) = x(t) * h(t) \quad\Longleftrightarrow\quad Y(\omega) = X(\omega)\,H(\omega)$$

So an [[lti-systems-and-convolution|LTI]] output is found by transforming $x$ and $h$, multiplying,
and inverting — turning a convolution integral into a product and a partial-fraction inversion. This
is the Fourier twin of the Laplace convolution property; both are collected in
[[convolution-and-transforms]].

## Ideal filters

An LTI system whose $H(\omega)$ is a passband is a **filter**. An ideal lowpass filter with gain 30
over $0 \le |\omega| \le 10$ simply keeps harmonics inside the band and scales them: $Y[k] = 30\,X[k]$
for the passing $k$, zero otherwise. ^[[sources/notion-280-course-fourier-series-comp-filters]] Filtering is
multiplication by $H(\omega)$ — the convolution theorem doing useful work.

Part of [[280]] (ECE 280). **Gap:** sampling / the Nyquist theorem is a genuine hole — Dave's
`course__nyquist` page is blank upstream, so the vault has no sampling content by design (see
[[contradictions]]).
