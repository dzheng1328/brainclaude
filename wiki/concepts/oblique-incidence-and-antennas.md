---
kind: concept
domain: education
title: Oblique incidence and antennas
course: "270"
---

# Oblique incidence and antennas

## Oblique incidence and the Brewster angle

When a wave strikes a boundary at an angle, the reflection coefficient splits by **polarization** —
whether $\mathbf{E}$ is parallel or perpendicular to the plane of incidence ^[[sources/notion-270-mid-2-oblique-incidence-antennas]]:

$$\Gamma_\perp = \frac{\eta_2\cos\theta_i - \eta_1\cos\theta_t}{\eta_2\cos\theta_i + \eta_1\cos\theta_t}, \qquad
\Gamma_\parallel = \frac{\eta_2\cos\theta_t - \eta_1\cos\theta_i}{\eta_2\cos\theta_t + \eta_1\cos\theta_i}$$

The transmitted angle follows **Snell's law**, $\sqrt{\epsilon_{r1}}\sin\theta_i =
\sqrt{\epsilon_{r2}}\sin\theta_t$. At the **Brewster angle** $\theta_B = \tan^{-1}\sqrt{\epsilon_{r2}/\epsilon_{r1}}$
the *parallel* reflection vanishes — all parallel-polarized light transmits, so glare off water is
almost purely perpendicular, which is exactly what polarized sunglasses block. ^[[sources/notion-270-mid-2-oblique-incidence-antennas]]
(The plane of incidence contains the surface normal and the incoming ray; polarization is defined
relative to it. ^[[sources/notion-270-mid-2-oblique-incidence-parallel-vs-perp]])

## Antennas

Real antennas radiate directionally, not isotropically. A **dipole** radiates maximally broadside to
the wire and nothing off its tips. Key quantities ^[[sources/notion-270-mid-2-oblique-incidence-antennas]]:

- **Radiated power** $P_{rad} = \tfrac{1}{2}I_0^2 R_{rad}$, with radiation resistance $R_{rad}$.
- **Radiation efficiency** $e = R_{rad}/(R_{rad} + R_{loss})$ — the fraction not lost to ohmic heating.
- **Directivity** $D = 4\pi/\Omega_A$ (from the beam solid angle $\Omega_A$) and **gain** $G = eD$;
  **half-power beamwidth** measures the main lobe's angular width.

The **Friis equation** ties a link together — received power from a transmitter miles away:

$$P_r = P_t\frac{G_t G_r \lambda^2}{(4\pi r)^2}$$

with gains as linear ratios (not dB), and effective aperture $A_e = \tfrac{\lambda^2}{4\pi}G$.

Part of [[270]] (ECE 270, Fields & Waves). Builds on [[wave-reflection-at-boundaries]] and
[[electromagnetic-plane-waves]].
