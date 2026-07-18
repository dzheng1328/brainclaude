---
kind: concept
domain: education
title: Carrier transport (drift & diffusion)
course: "230-semiconductors"
---

# Carrier transport (drift & diffusion)

Once a semiconductor has free electrons and holes ([[semiconductor-carrier-statistics]]), current
flows by two mechanisms. ^[[sources/notion-230-semiconductors-mid-2-carrier-transport]]

## Drift — motion from a field

An applied electric field $E$ sweeps carriers along. They don't accelerate forever; collisions with
the lattice give an average **drift velocity** $v_d = \mu E$, where **mobility** $\mu$
($\text{cm}^2/\text{V·s}$) measures how easily a carrier moves. Mobility *falls* as doping rises
(more impurities to scatter off) and as temperature rises (more lattice vibration); electrons
generally out-run holes because they are lighter. ^[[sources/notion-230-semiconductors-mid-1-carrier-transport-drift-diffusion]]
The resulting current is

$$J_{\text{drift}} = q(n\mu_n + p\mu_p)E = \sigma E$$

defining **conductivity** $\sigma = q(n\mu_n + p\mu_p)$ and **resistivity** $\rho = 1/\sigma$. This
is the whole content of a **resistor-design** problem: geometry $R = \rho L/A$, physics
$\rho = 1/(q\mu_n N_d)$ for n-type, operation $V = IR$. ^[[sources/notion-230-semiconductors-mid-1-carrier-transport-drift-diffusion]]

## Diffusion — motion from a gradient

A concentration gradient drives carriers from crowded to empty regions with no field required
(Fick's law). The current is proportional to the gradient via the **diffusion coefficient** $D$: ^[[sources/notion-230-semiconductors-mid-2-carrier-transport]]

$$J_{\text{diff}} = qD_n\frac{dn}{dx} - qD_p\frac{dp}{dx}$$

## The Einstein relation ties them together

Because drift and diffusion are the *same* carriers bouncing through the *same* lattice, mobility
and diffusion coefficient are locked together by thermal energy: ^[[sources/notion-230-semiconductors-mid-2-carrier-transport]]

$$\frac{D}{\mu} = \frac{kT}{q} = V_T \approx 0.026\ \text{V at 300 K}$$

so given one you have the other — multiply or divide by 0.026. Paired with a **carrier lifetime**
$\tau$, the diffusion coefficient sets the **diffusion length** $L = \sqrt{D\tau}$, the distance an
injected minority carrier travels before recombining — the length scale that governs current in a
biased [[pn-junction]]. ^[[sources/notion-230-semiconductors-mid-2-carrier-transport]]

Part of [[230-semiconductors]] (ECE 230L). The competition between drift and diffusion is exactly
what forms the depletion region in a [[pn-junction]], and device transport is upstream of the
transistors used in [[hw-cnn-accelerator]]. *(One worked example writes "$D_n = 120 \times 0.026$"
for a stated $\mu_n = 1200$, a transcription slip; the result $31.2$ uses the correct $1200$, per
the pattern that Dave's worked answers are trustworthy even when an intermediate symbol slips —
see [[CLAUDE]].)*
