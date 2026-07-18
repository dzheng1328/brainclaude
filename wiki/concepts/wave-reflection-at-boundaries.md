---
kind: concept
domain: education
title: Wave reflection at boundaries (normal incidence)
course: "270"
---

# Wave reflection at boundaries (normal incidence)

When a plane wave hits a boundary between two media head-on, it behaves exactly like a signal meeting
a new impedance on a transmission line — with the [[electromagnetic-plane-waves|intrinsic impedance]]
$\eta$ playing the role of $Z_0$. ^[[sources/notion-270-mid-2-wave-reflection-and-transmission-at-normal-indicdence]]

$$\Gamma = \frac{\eta_2 - \eta_1}{\eta_2 + \eta_1}, \qquad \tau = \frac{2\eta_2}{\eta_2 + \eta_1}, \qquad \tau = 1 + \Gamma$$

The last identity holds because the total electric field must be continuous across the boundary. One
trap: because the wave reverses direction, the magnetic field reflects with the *opposite* sign,
$H_{ref} = -\Gamma H_{inc}$. ^[[sources/notion-270-mid-2-wave-reflection-and-transmission-at-normal-indicdence]]

## Conservation of energy

Since power density goes as the *square* of field amplitude, the reflected power fraction is exactly
$|\Gamma|^2$ and the transmitted fraction is $1 - |\Gamma|^2$ — identical to transmission lines. ^[[sources/notion-270-mid-2-wave-reflection-and-transmission-at-normal-indicdence]]

## Coatings and radomes

Two quarter/half-wave tricks, the optical cousins of [[impedance-matching]] ^[[sources/notion-270-mid-2-wave-reflection-and-transmission-at-normal-indicdence]]:

- **Anti-reflection coating** (e.g. air→glass): a $\lambda/4$ layer bridges a low-to-high impedance
  step, cancelling reflection.
- **Radome** (air→wall→air): a $\lambda/2$ layer rotates a full turn on the Smith chart, returning
  the impedance to its input value and making the wall "invisible."

> **Source error (from [[contradictions]]):** the radome worked example writes the wave speed as
> $v = c/\epsilon_r$. The correct relation is $v = c/\sqrt{\epsilon_r}$. Dave's *numeric* answer,
> $3\times10^8/\sqrt{2} \approx 2.12\times10^8\ \text{m/s}$, uses the correct $\sqrt{\epsilon_r}$ — so
> the arithmetic is right and only the written formula is garbled (the same page also writes
> "$9,4\times10^9$" with a comma for a decimal point). The correct formula is stated here.

Part of [[270]] (ECE 270, Fields & Waves). This is one instance of a law that recurs across every
wave system — see [[wave-impedance-analogy]]. For angled incidence, see [[oblique-incidence-and-antennas]].
