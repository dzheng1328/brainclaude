---
kind: concept
domain: education
title: The wave-impedance analogy
course: "270"
---

# The wave-impedance analogy

The organizing idea of [[270]]: transmission lines, electromagnetic waves, sound, and quantum
particles are all **waves**, and every one of them obeys the *same* impedance-mismatch mathematics.
Learn the reflection law once and it transfers across all four domains. The universal pattern: each
medium has a characteristic impedance, a boundary between two impedances reflects a fraction

$$\Gamma = \frac{Z_2 - Z_1}{Z_2 + Z_1}, \qquad \text{reflected power} = |\Gamma|^2, \qquad \text{transmitted} = 1 - |\Gamma|^2$$

and the same quarter/half-wave tricks and boundary conditions apply throughout.

| Domain | "Impedance" | Source |
|---|---|---|
| Transmission line | characteristic $Z_0 = \sqrt{L/C}$ | [[transmission-line-theory]] |
| EM wave in matter | intrinsic $\eta = \sqrt{\mu/\epsilon}$ | [[electromagnetic-plane-waves]], [[wave-reflection-at-boundaries]] |
| Acoustic wave | acoustic $Z = \rho c$ | acoustics final |
| Quantum particle | phase constant $\beta = p/\hbar$ | quantum final |

## Acoustics

Sound reflects at a media boundary with $\Gamma = (Z_2 - Z_1)/(Z_2 + Z_1)$ using **acoustic
impedance** $Z = \rho c$ (density × sound speed, $c = \sqrt{K/\rho}$). An acoustic anti-reflection
coating is $\lambda/4$ thick with impedance the geometric mean $\sqrt{Z_{air}Z_{water}}$ — the exact
[[impedance-matching]] recipe. Organ-pipe boundaries map onto transmission-line terminations: a closed
end (velocity node) is a short circuit with $\Gamma \approx +1$; an open end (pressure node) is an open
circuit with $\Gamma \approx -1$. ^[[sources/notion-270-final-acoustics]]

## Quantum mechanics

A particle's [[electronic-band-structure|de Broglie wave]] has wavenumber $\beta = p/\hbar \propto
\sqrt{E}$. At a **potential step** the kinetic energy — and thus $\beta$ — changes, creating an
impedance mismatch that reflects the wave with $\Gamma = (\beta_1 - \beta_2)/(\beta_1 + \beta_2)$;
$|\Gamma|^2$ is the literal probability the particle bounces back. A particle in an infinite box is an
organ pipe with two closed ends (quantized standing waves), and **tunneling** through a barrier is the
same exponential decay as an EM wave dying inside a [[waves-in-lossy-media|conductor]] — if the barrier
is thin, the wave emerges with nonzero amplitude. ^[[sources/notion-270-final-quantum]]

Part of [[270]] (ECE 270, Fields & Waves). This analogy is why the [[wave-reflection-at-boundaries]]
formulas look identical to [[transmission-line-theory]]'s, and it links directly to the quantum
foundations in [[electronic-band-structure]] ([[230-semiconductors]]).
