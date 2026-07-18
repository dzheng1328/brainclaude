---
kind: concept
domain: education
title: FSM state minimization
course: "350"
---

# FSM state minimization

A finite-state machine's initial state diagram usually has **redundant states** that behave
identically. Two states are **equivalent** if, for every possible input sequence, they produce the
same output sequence. ^[[sources/notion-350-mid-2-fsm-state-minimization]] Merging equivalent states
shrinks the number of flip-flops and gates the circuit needs — the direct hardware-cost payoff of
minimization. This is upstream of any FSM-bearing design, including the [[ece-350-connect4]]
controller and the sequencing in [[hw-cnn-accelerator]].

Three methods, increasing in power:

**State partitioning (Moore-friendly).** Repeatedly refine a partition until stable: start with all
states in one block; split by output; then, for each block, follow every state's successors under
each input — if two states' successors fall in different blocks, split them out; repeat until no
block splits further. Whatever still shares a block is equivalent. ^[[sources/notion-350-mid-2-state-partitioning-the-moore-friendly-method]]

**Row matching (Mealy-friendly).** Merge two rows only if they transition to the *exact same* next
states and produce the *exact same* outputs for every input. Fast, but **incomplete** — it misses
states that are equivalent only because their differing successors are themselves equivalent. ^[[sources/notion-350-mid-2-row-matching-mealy-friendly-method]]

**Implication charts (preferred — complete).** Build a triangular grid of all state pairs; cross out
pairs with differing outputs; for each surviving pair, record the successor pairs it *implies* — the
pair is equivalent only if all its implied pairs are; then iteratively cross out any cell whose
implied pair has already been crossed out, until stable. A pair that "implies itself" is a match.
The surviving pairs are the equivalences to merge. ^[[sources/notion-350-mid-2-implication-charts]]
This catches the transitive equivalences row matching misses.

Part of [[350]]; presupposes [[finite-state-machines]].
