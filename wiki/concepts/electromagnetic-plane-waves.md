---
kind: concept
domain: education
title: Electromagnetic plane waves
course: "270"
---

# Electromagnetic plane waves

Far from a source, an electromagnetic wave looks like a **uniform plane wave**: oscillating electric
$\mathbf{E}$ and magnetic $\mathbf{H}$ fields, each perpendicular to the other and both perpendicular
to the propagation direction (which points along $\mathbf{E}\times\mathbf{H}$ by the right-hand rule). ^[[sources/notion-270-mid-2-electromagnetic-plane-waves-and-power]]

The medium sets three quantities ^[[sources/notion-270-mid-2-electromagnetic-plane-waves-and-power]]:

$$v = \frac{1}{\sqrt{\mu\epsilon}}, \qquad \eta = \sqrt{\frac{\mu}{\epsilon}}, \qquad
\beta = \omega\sqrt{\mu\epsilon} = \frac{\omega}{v}$$

— the wave **speed** $v$ (a fraction of $c$ set by relative permittivity in non-magnetic media), the
**intrinsic impedance** $\eta$ (the fixed ratio $|E|/|H|$, the field-world analogue of a line's
$Z_0$), and the **phase constant** $\beta$.

## Polarization and power

**Polarization** is the shape the $\mathbf{E}$ vector traces: a single oscillating plane is *linear*;
two perpendicular components out of phase make the tip rotate, giving *circular* (or elliptical)
polarization. ^[[sources/notion-270-mid-2-electromagnetic-plane-waves-and-power]]

Waves carry power. The time-averaged **power density** (a Poynting quantity, $W/m^2$) is

$$S_{avg} = \frac{|E|^2}{2\eta}$$

An isotropic source spreads $P_{rad}$ over an expanding sphere, so $S_{avg} = P_{rad}/(4\pi r^2)$ —
the **inverse-square law** — and a receiver of area $A$ captures $P_{received} = S_{avg}\cdot A$. ^[[sources/notion-270-mid-2-electromagnetic-plane-waves-and-power]]

Part of [[270]] (ECE 270, Fields & Waves). $\eta$ plays exactly the role $Z_0$ plays in
[[transmission-line-theory]], which is why [[wave-reflection-at-boundaries|reflection at a material
boundary]] reuses the transmission-line formulas verbatim.
