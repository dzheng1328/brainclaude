---
kind: concept
domain: education
title: Waves in lossy media
course: "270"
---

# Waves in lossy media

Real materials absorb electromagnetic energy and turn it into heat, so a wave's amplitude decays
exponentially as it penetrates: $|E(z)| = E_0 e^{-\alpha z}$. Two loss mechanisms feed this — ohmic
loss from **conductivity** $\sigma$ (free electrons driven into resistive currents) and **dielectric
damping** (dipole molecules heated as they flip with the field), bundled into a **complex
permittivity** $\epsilon_c = \epsilon' - j\epsilon''$. ^[[sources/notion-270-mid-2-waves-in-conducting-and-lossy-materials]]

## Loss tangent classifies the material

$$\tan\delta = \frac{\epsilon''}{\epsilon'} = \frac{\sigma}{\omega\epsilon}$$

If $\tan\delta \ll 1$ the material is a **low-loss dielectric** (glass, alumina) and waves pass
easily; if $\tan\delta \gg 1$ it is a **good conductor** (copper) and waves die almost instantly. ^[[sources/notion-270-mid-2-waves-in-conducting-and-lossy-materials]]

## Attenuation, phase, skin depth

The **complex propagation constant** $\gamma = \alpha + j\beta$ splits into the **attenuation
constant** $\alpha$ (Np/m — how fast amplitude dies) and the **phase constant** $\beta$ (rad/m — which
sets speed $v = \omega/\beta$). For a good conductor both simplify to $\alpha = \beta \approx
\sqrt{\pi f\mu\sigma}$. ^[[sources/notion-270-mid-2-waves-in-conducting-and-lossy-materials]]

The **skin depth** is where amplitude falls to $1/e \approx 37\%$:

$$\delta_s = \frac{1}{\alpha} \approx \sqrt{\frac{2}{\omega\mu\sigma}} \text{ (good conductor)}$$

Since $\alpha$ rises with frequency, high frequencies barely penetrate — current rides the outer
"skin" of a conductor, and submarines must use extremely low frequencies to reach any depth in
seawater. Absorbed power becomes heat at $P_d(z) = \tfrac{1}{2}\sigma_{eff}|E(z)|^2$, and attenuation
converts between nepers and decibels at $1\ \text{Np} \approx 8.686\ \text{dB}$. ^[[sources/notion-270-mid-2-waves-in-conducting-and-lossy-materials]]

Part of [[270]] (ECE 270, Fields & Waves). The exponential decay inside a conductor is the same
mathematics as quantum **tunneling** through a barrier — see [[wave-impedance-analogy]].
