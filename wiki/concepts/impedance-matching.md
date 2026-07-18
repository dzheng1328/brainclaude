---
kind: concept
domain: education
title: Impedance matching
course: "270"
---

# Impedance matching

Matching cancels reflections by making the impedance seen by the source equal to $Z_0$, so all power
reaches the load. A **single shunt stub** match places a reactive element a chosen distance $l$ from
the load. ^[[sources/notion-270-mid-1-impedance-matching]]

## Analytical method

Find the load reflection coefficient $\Gamma_L$ in polar form (magnitude $\rho$, angle $\psi$). The
distance to the matching point is

$$l = \frac{\lambda}{4\pi}\left(\psi - \cos^{-1}(-\rho)\right)$$

which has two solutions in one wavelength; take the smaller positive one. The matching element's
normalized susceptance is $B = \pm 2\rho/\sqrt{1-\rho^2}$, denormalized by $Y_0 = 1/Z_0$. A positive
$B_{actual}$ needs a **capacitor** ($B = \omega C$), a negative one an **inductor** ($B = -1/\omega L$). ^[[sources/notion-270-mid-1-impedance-matching]]

## Smith chart method

The same match, done graphically: plot the normalized load $z_L = Z_L/Z_0$, reflect through the
center to get the admittance $y_L$ (because a shunt match works in admittance), then rotate clockwise
("toward generator") along the constant-$|\Gamma|$ circle until hitting the $g=1$ circle. The distance
traveled in wavelengths is $l$; the residual susceptance read there is what the stub must cancel with
its opposite. ^[[sources/notion-270-mid-1-impedance-matching]]

A **quarter-wave transformer** is the other classic match, exploiting $Z_{in} = Z_0^2/Z_L$ from
[[transmission-line-theory]] to bridge two real impedances with a $\lambda/4$ section of intermediate
$Z_0$.

Part of [[270]] (ECE 270, Fields & Waves). The optical analogue — a $\lambda/4$ anti-reflection
coating — is the same idea for [[wave-reflection-at-boundaries|waves at a material boundary]].
