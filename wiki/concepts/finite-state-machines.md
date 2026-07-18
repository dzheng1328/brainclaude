---
kind: concept
domain: education
title: Finite-state machines
course: "350"
---

# Finite-state machines

A finite-state machine (FSM) is sequential logic: state held in flip-flops, plus combinational logic
computing the next state and output. Two flavors differ in how the output is formed:

- **Moore** — output is a function of the **present state only**.
- **Mealy** — output is a function of **present state *and* current input**. Because outputs are
  produced on transitions, Mealy machines almost always need **fewer states** than a Moore machine
  for the same task. ^[[sources/notion-350-mid-2-mealy-fsms-sequence-detectors]]

## Design: sequence detectors

The canonical FSM design problem. To detect an **overlapping** sequence on a serial input: define a
base state (empty prefix); build a success path, one state per correctly-seen bit; for a Mealy
machine hold the output at 0 on every transition except the final one that completes the sequence;
and on a mismatch **don't reset to start** — jump to the state for the *longest valid prefix* still
consistent with the bits just seen. That prefix-fallback is exactly what makes overlaps detectable.
^[[sources/notion-350-mid-2-mealy-fsms-sequence-detectors]] (E.g. after detecting `1011`, return to
the "got 1" state, since the trailing `1` may begin the next match.)

## Analysis (the inverse problem)

Given a built circuit, recover what it does: count the flip-flops (n flip-flops ⇒ at most $2^n$
states); read the logic feeding the flip-flop inputs and output wire as boolean **next-state
equations**; plug in every state/input combination to fill a state table; then rename binary states
to letters and read off the behavior. ^[[sources/notion-350-mid-2-fsm-analysis]] This is FSM
synthesis run backwards.

Part of [[350]]; minimized via [[fsm-state-minimization]]; next-state logic built with
[[boolean-algebra]]. FSMs are the control backbone of the [[ece-350-connect4]] CPU.
