---
kind: concept
domain: education
title: MOS capacitor
course: "230-semiconductors"
---

# MOS capacitor

A **metal–oxide–semiconductor** stack — gate metal, a thin $\text{SiO}_2$ insulator, and doped
bulk silicon — is a voltage-controlled capacitor. No DC current crosses the oxide; instead the gate
voltage $V_G$ projects a field that pushes or pulls carriers in the silicon. For a p-type bulk there
are three modes ^[[sources/notion-230-semiconductors-mid-2-mos-capacitor-core-concepts]]:

- **Accumulation** ($V_G < 0$): the negative gate attracts majority holes to the surface.
- **Depletion** ($V_G > 0$, small): holes are pushed down, leaving fixed negative acceptor ions — a
  carrier-free layer just like a one-sided [[pn-junction]].
- **Inversion** ($V_G \gg 0$): a large positive gate pulls the *minority* electrons up to the
  surface, which "inverts" from p-type to n-type. **That inversion layer is the conductive channel
  of a [[mosfet-structure-and-energy-band-diagrams|MOSFET]].**

**Surface potential** $\phi_s$ measures how far the bands bend at the surface ($e\phi_s =
E_{Fi,\text{bulk}} - E_{Fi,\text{surf}}$). **Strong inversion** requires bending to *twice* the bulk
potential, $\phi_s \geq 2\phi_{fp}$. ^[[sources/notion-230-semiconductors-mid-2-mos-capacitor-core-concepts]]

## C–V curve

Sweeping $V_G$ traces a characteristic capacitance curve because the plate separation effectively
changes ($C \propto 1/d$) ^[[sources/notion-230-semiconductors-mid-2-mos-capacitor-cv-curves-math]]:

- **Accumulation** — carriers sit against the oxide, so $C = C_{ox}' = \epsilon_{ox}\epsilon_0/t_{ox}$
  (maximum).
- **Depletion** — the depletion layer adds a silicon capacitance in series, so $C$ falls.
- **Inversion** — depends on **frequency**: at low frequency minority carriers keep up and $C$
  recovers to $C_{ox}$; at high frequency they cannot, and $C$ stays pinned at $C_{min}$ (set by
  $t_{ox} + x_{dT}$).

## Threshold voltage and non-idealities

The gate voltage that turns on an n-channel device is ^[[sources/notion-230-semiconductors-mid-2-mos-capacitor-cv-curves-math]]

$$V_{TN} = \frac{|Q_{SD}'(\max)|}{C_{ox}'} + V_{FB} + 2\phi_{fp}$$

— enough voltage to cancel manufacturing defects ($V_{FB}$), bend the bands to strong inversion
($2\phi_{fp}$), and hold back the uncovered depletion charge. Even at $V_G = 0$ the bands may be
bent by the **work-function difference** $\phi_{ms}$ and by **fixed oxide charge** $Q_{ss}$; the
**flat-band voltage** $V_{FB}$ is the correction that flattens them, and adding negative oxide charge
shifts the whole C–V curve toward $+V_G$. ^[[sources/notion-230-semiconductors-mid-2-mos-capacitor-core-concepts]]

Part of [[230-semiconductors]] (ECE 230L). The MOS capacitor *is* the gate stack of a
[[mosfet-structure-and-energy-band-diagrams|MOSFET]], and its inversion-mode switching is the
device-physics substrate under [[cmos-logic]] (350).
