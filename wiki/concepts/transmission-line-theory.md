---
kind: concept
domain: education
title: Transmission line theory
course: "270"
---

# Transmission line theory

When a wire is long compared to the signal wavelength, it stops behaving like an ideal node and
becomes a **transmission line** where voltage and current are waves in space and time. Its two
defining parameters come from the per-unit-length inductance $L$ and capacitance $C$ ^[[sources/notion-270-mid-1-transmission-line-fundamentals]]:

$$Z_0 = \sqrt{\frac{L}{C}}, \qquad v_p = \frac{1}{\sqrt{LC}}, \qquad t_{prop} = \frac{l}{v_p}$$

A traveling wave is written $V(z,t) = V_0\cos(\omega t - \beta z + \phi)$ in the time domain (the
minus sign = travel in $+z$) or as a phasor $V(z) = V_0 e^{-j\beta z}$, where the **wavenumber**
$\beta = \omega/v_p = 2\pi/\lambda$. A wave that has reflected off a load gives a standing pattern
$V(z) = V_0 e^{-j\beta z} + \Gamma_L V_0 e^{j\beta z}$. ^[[sources/notion-270-mid-1-transmission-line-fundamentals]]

## When do line effects matter?

Only when the line is electrically long. The critical length is $l_{crit} = \lambda/4 = v_p/4f$ for
sinusoids, or $l_{crit} = t_{rise}\,v_p/2$ for digital edges; if the physical length exceeds it, the
line must be treated as a transmission line rather than a lumped wire. ^[[sources/notion-270-mid-1-critical-lengths-where-tl-effects-matter]]

## Reflection and input impedance

At a load $Z_L$ the **reflection coefficient** is

$$\Gamma_L = \frac{Z_L - Z_0}{Z_L + Z_0}$$

and the impedance seen looking into a line of length $l$ is the **master equation** ^[[sources/notion-270-mid-1-ac-steady-state-and-input-impedance]]

$$Z(l) = Z_0\frac{Z_L + jZ_0\tan(\beta l)}{Z_0 + jZ_L\tan(\beta l)}$$

Two shortcuts fall out: a **half-wave** line ($l = \lambda/2$) repeats the load, $Z_{in} = Z_L$; a
**quarter-wave** line inverts it, $Z_{in} = Z_0^2/Z_L$ — the basis of quarter-wave
[[impedance-matching]]. A shorted stub looks inductive ($Z_{in} = jZ_0\tan\beta l$) and an open stub
capacitive ($-jZ_0\cot\beta l$), so a length of line can *synthesize* a reactance. ^[[sources/notion-270-mid-1-ac-steady-state-and-input-impedance]]
For a lossless line the input power equals the load power, computed as $P_{avg} = \tfrac{1}{2}\text{Re}[VI^*]$. ^[[sources/notion-270-mid-1-power-delivery-and-phasors]]

Part of [[270]] (ECE 270, Fields & Waves). The steady-state picture here has a time-domain companion
in [[bounce-diagrams-and-transients]], and the reflection law $\Gamma = (Z_2-Z_1)/(Z_2+Z_1)$
generalizes to every wave system — see [[wave-impedance-analogy]].
