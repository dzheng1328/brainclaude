---
kind: concept
domain: education
title: Bounce diagrams and transients
course: "270"
---

# Bounce diagrams and transients

The time-domain companion to [[transmission-line-theory]]: what happens in the moments *after* a
source switches on, before the line settles. A **bounce diagram** tracks each wave as it reflects
back and forth between source and load. ^[[sources/notion-270-mid-1-transients-bounce-diagrams-interconnects]]

The first step injected into the line is set by a voltage divider between the source resistance and
the line's characteristic impedance — *not* the load, which the source cannot yet "see":

$$V_1^+ = V_s\frac{Z_0}{R_s + Z_0}$$

Each end has its own reflection coefficient, $\Gamma_L = (Z_L - Z_0)/(Z_L + Z_0)$ and
$\Gamma_S = (R_s - Z_0)/(R_s + Z_0)$. A wave arriving at the load at $t = T = l/v_p$ reflects as
$V_1^- = \Gamma_L V_1^+$; that returns to the source at $t = 2T$ and re-reflects as
$V_2^+ = \Gamma_S V_1^-$, and so on. The load voltage steps at $t = T, 3T, 5T, \dots$, each step
adding the newest pair of waves, converging on the DC **steady state** $V_{steady} = V_s\,R_L/(R_s+R_L)$
— which, notably, does not depend on $Z_0$ at all. ^[[sources/notion-270-mid-1-transients-bounce-diagrams-interconnects]]

## Time-domain reflectometry

Run the bounce diagram backward: given a measured voltage-vs-time trace at the source, the first step
gives $Z_0$ (via the initial divider), the *timing* of the next step gives the line length (round
trip $2T$, times $v_p$), and the *size* of that step gives $\Gamma_L$ and hence the unknown load. ^[[sources/notion-270-mid-1-transients-bounce-diagrams-interconnects]]
This is how a cable fault is located without cutting the cable open.

Part of [[270]] (ECE 270, Fields & Waves). Same reflection coefficients as
[[transmission-line-theory]], viewed in time rather than frequency.
