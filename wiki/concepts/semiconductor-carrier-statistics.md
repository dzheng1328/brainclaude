---
kind: concept
domain: education
title: Semiconductor carrier statistics
course: "230-semiconductors"
---

# Semiconductor carrier statistics

A semiconductor conducts because thermal energy lifts electrons from the **valence band**
($E_V$, bound states) across the **band gap** into the **conduction band** ($E_C$, mobile
states), each departure leaving a positively-charged **hole** behind. ^[[sources/notion-230-semiconductors-mid-2-semiconductor-fundamentals-and-energy-bands]]
In pure (**intrinsic**) silicon every freed electron leaves exactly one hole, so $n = p = n_i$,
with $n_i \approx 1.5\times10^{10}\ \text{cm}^{-3}$ for Si at 300 K. ^[[sources/notion-230-semiconductors-mid-1-the-semiconductor-in-equilibrium]]

## Doping makes it useful

Intrinsic carrier density is far too low for devices, so silicon is **doped**:
**donors** (group V — phosphorus, arsenic) each contribute a spare electron, making **n-type**
material where electrons are the majority carrier; **acceptors** (group III — boron) each accept
an electron, creating a hole, making **p-type** material. At 300 K one assumes **complete
ionization**: every dopant yields one carrier, so $n_0 \approx N_d$ or $p_0 \approx N_a$. ^[[sources/notion-230-semiconductors-mid-1-the-semiconductor-in-equilibrium]]

Two equations pin down the rest:

- **Law of mass action** — in thermal equilibrium the carrier product is fixed regardless of
  doping: $n_0 p_0 = n_i^2$. Knowing the majority carrier immediately gives the minority one
  (n-type: $p_0 = n_i^2/N_d$; p-type: $n_0 = n_i^2/N_a$). ^[[sources/notion-230-semiconductors-mid-1-the-semiconductor-in-equilibrium]]
- **Charge neutrality** — $n_0 + N_a^- = p_0 + N_d^+$; in a **compensated** sample the larger
  doping wins and the effective doping is $|N_d - N_a|$. ^[[sources/notion-230-semiconductors-mid-1-the-semiconductor-in-equilibrium]]

## The Fermi level is the readout

The **Fermi level** $E_F$ is the "water level" of electron occupancy; the **intrinsic Fermi
level** $E_{Fi}$ sits near mid-gap. Doping moves $E_F$: up toward $E_C$ for n-type, down toward
$E_V$ for p-type. Its position and the carrier density are the same fact, related by ^[[sources/notion-230-semiconductors-mid-2-semiconductor-fundamentals-and-energy-bands]]

$$n_0 = n_i e^{(E_F - E_{Fi})/kT}, \qquad p_0 = n_i e^{(E_{Fi} - E_F)/kT}$$

with $kT \approx 0.026\ \text{eV}$ at 300 K. Rearranged as $E_F - E_{Fi} = kT\ln(n_0/n_i)$, this
is what lets you read doping type and density straight off an energy-band diagram, or draw the
diagram from the doping — the same computation used to bend the bands across a [[pn-junction]].

Part of [[230-semiconductors]] (ECE 230L). This equilibrium picture is the foundation the
[[pn-junction]], [[mos-capacitor]], and [[mosfet-structure-and-energy-band-diagrams]] all build
on; [[carrier-transport]] then describes how these carriers move.
