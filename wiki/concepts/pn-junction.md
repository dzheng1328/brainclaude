---
kind: concept
domain: education
title: PN junction
course: "230-semiconductors"
---

# PN junction

Press p-type and n-type silicon together and the huge concentration gradient drives electrons to
diffuse into the p-side and holes into the n-side, where they recombine. The mobile carriers that
leave uncover the *fixed* dopant ions they came from — positive donor ions on the n-side, negative
acceptor ions on the p-side — creating a carrier-free **depletion region** with a built-in electric
field. That field drives a drift current opposing the diffusion; equilibrium is where the two
exactly cancel, leaving a **built-in voltage** across the junction and no net current. ^[[sources/notion-230-semiconductors-mid-2-pn-junction-in-equilibrium]]
This is [[carrier-transport]]'s drift and diffusion reaching a standstill.

## Equilibrium

$$V_{bi} = \frac{kT}{e}\ln\!\left(\frac{N_a N_d}{n_i^2}\right), \qquad
W = \left[\frac{2\epsilon_s\epsilon_0}{e}\left(\frac{N_a + N_d}{N_a N_d}\right)V_{bi}\right]^{1/2}$$

The depletion width $W$ splits into $x_n$ and $x_p$, extending **further into the more lightly
doped side**. On an energy-band diagram the bands bend by exactly $eV_{bi}$ across the depletion
region and stay flat in the neutral regions on either side — and $eV_{bi}$ equals the total shift
needed to hold $E_F$ flat across the junction, which is why the [[semiconductor-carrier-statistics]]
Fermi-offset calculation on each side reproduces $V_{bi}$. ^[[sources/notion-230-semiconductors-mid-2-pn-junction-in-equilibrium]]

## Under bias

Applying a voltage tilts the balance ^[[sources/notion-230-semiconductors-mid-2-pn-junction-under-bias]]:

- **Forward bias** ($V_a > 0$, + to p-side) lowers the barrier, shrinks the depletion width, and
  lets majority carriers flood across as **minority-carrier injection** — an exponentially growing
  current.
- **Reverse bias** (+ to n-side) raises the barrier to $V_{bi} + V_R$, widens the depletion region
  ($W_{RB}$ takes the same formula with $V_{bi} + V_R$), and shuts majority flow off, leaving only a
  tiny **reverse saturation current**.

The junction is therefore a **diode**, captured by the ideal diode equation

$$J_{ID} = J_S\left(e^{V_a/kT} - 1\right)$$

where $J_S$ depends on the minority diffusion coefficients and [[carrier-transport|diffusion
lengths]]. Injected minority carriers decay exponentially into the neutral region over a diffusion
length $L$. Under bias, equilibrium is broken and the single Fermi level **splits into quasi-Fermi
levels** $E_{Fn}, E_{Fp}$ separated by $eV_a$. ^[[sources/notion-230-semiconductors-mid-2-pn-junction-under-bias]]

Part of [[230-semiconductors]] (ECE 230L). The junction's back-to-back appearance is exactly what a
[[mosfet-structure-and-energy-band-diagrams|MOSFET]]'s source and drain form with the body, and its
band-bending is the same mechanism at work in the [[mos-capacitor]].
