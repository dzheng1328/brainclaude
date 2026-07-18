---
kind: concept
domain: education
title: Electronic band structure and effective mass
course: "230-semiconductors"
---

# Electronic band structure and effective mass

Why does a solid have bands at all? Because electrons are waves (de Broglie, $\lambda = h/p$), and a
periodic crystal lattice modifies the free-electron parabola $E = \hbar^2 k^2 / 2m$ into allowed
energy bands separated by forbidden gaps. ^[[sources/notion-230-semiconductors-mid-1-quantum-mechanics]] ^[[sources/notion-230-semiconductors-mid-1-quantum-theory-of-solids]]
An **E–k diagram** plots allowed electron energy against crystal momentum: the **conduction band**
$E_C$ opens upward, the **valence band** $E_V$ opens downward, and the **band gap** $E_g$ between
them holds no states — the same $E_C$/$E_V$/$E_g$ used throughout [[semiconductor-carrier-statistics]].

## Effective mass is curvature

An electron in a crystal responds to force as if it had an **effective mass** set by the band's
curvature ^[[sources/notion-230-semiconductors-mid-1-quantum-theory-of-solids]]:

$$m^* = \hbar^2\left(\frac{d^2E}{dk^2}\right)^{-1}$$

Mass is *inversely* proportional to curvature: a sharp, steep band means a light, nimble carrier; a
flat, wide band means a heavy, sluggish one. Hence when a problem states holes are heavier than
electrons, the valence band is drawn flatter than the conduction band. Effective mass is what feeds
[[carrier-transport|mobility]].

## Density of states, direct vs. indirect

The **density of states** $g(E)$ — how many states exist per energy per volume — is derived by
counting allowed $k$-states (spacing $\pi/L$ or $2\pi/L$, times 2 for spin), converting to energy
via the dispersion relation, and differentiating. ^[[sources/notion-230-semiconductors-mid-1-quantum-theory-of-solids]]
Whether the band edges line up in $k$ decides optics ^[[sources/notion-230-semiconductors-mid-1-quantum-theory-of-solids]]:

- **Direct gap** (e.g. GaAs) — $E_C$ minimum sits directly above the $E_V$ maximum, so an electron
  can drop and emit a photon. Good for LEDs.
- **Indirect gap** (e.g. Si) — the extrema are offset in $k$, so a transition needs a phonon to
  supply momentum. Bad for light emission, but the basis of silicon transistors.

Part of [[230-semiconductors]] (ECE 230L). Band structure is the quantum foundation under the whole
device stack — [[semiconductor-carrier-statistics]], the [[pn-junction]], and the
[[mosfet-structure-and-energy-band-diagrams|MOSFET]].
