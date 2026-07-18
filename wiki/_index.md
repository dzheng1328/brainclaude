# Index

Catalog of every wiki page. Maintained by `/ingest`. Grouped by kind, sliced by domain.

**Status:** `raw/` holds 95 Notion snapshots, 16 Drive snapshots, 3 repo-doc snapshots
(`raw/repos/ev-firmware/`), 124 assets. **Concept/source graph still unpopulated** — no `/ingest`
run yet. The one populated area is project pointer cards (below), indexed by hand, not ingested.

## Domains

- **education** — coursework, exam notes, academic history (`uni/`, Notion/Drive course pulls)
- **projects** — code & hardware repos (indexed by pointer, see below)
- **career** — resume drafts, cover letters, job/offer docs *(not yet pulled)*
- **personal** — private context *(not yet pulled)*

## Concepts

*Ingested from [[316]] (2026-07-17):*
- [[relational-algebra]] · [[functional-dependencies]] · [[database-normalization]]
- [[entity-relationship-model]] · [[database-transactions]] · [[sql]]

*(more arrive as `/ingest` processes each course)*

## Entities

### Projects (`entities/projects/` — pointer cards, repos stay external)

- [[hw-cnn-accelerator]] — solo systolic-array GEMM accelerator (Verilog), runs an MLP on MNIST
- [[imgsic]] — image → ambient music web app (Vite + Tone.js + Claude vision)
- [[gohelpme]] — real-time volunteer dispatch, 1st place CUHackIt (résumé; no local repo)
- [[itm]] — "Image to Music" React/Tone.js prototype, dead; superseded by imgsic
- [[synth]] — pure-C real-time software synthesizer (miniaudio + Soundpipe, CoreMIDI)
- [[gkweb]] — Next.js 16 bilingual marketing site for Green-Keen Consulting (client work)
- [[hacknc]] — Moneta, AI financial-literacy platform (hackathon, Next.js + FastAPI + Gemini)
- [[daily-tickers]] — daily automated market-report email (Python + Finnhub + `claude -p`)
- [[ev-firmware]] — Duke Electric Vehicles club firmware (PlatformIO + CANbus, team-owned)
- [[dave-zheng-pcb]] — KiCad PCB project, "331"-prefixed (course? unconfirmed)

### Courses (`entities/courses/` — academic spine, from `uni/`)

- Fall 2024: [[cs-201]], [[egr-101]], [[ethics-189]], [[math-218]], [[writing-101]]
- Spring 2025: [[ece-110]], [[ece-250]], [[egr-102]], [[math-219]]
- Fall 2025: [[univ-104]], [[230-probability]], [[280]], [[316]], [[353]]
- Spring 2026: [[216]], [[230-semiconductors]], [[270]], [[350]]

### Other entities

- [[data-plus]] — Duke Data+ summer research program (flood modeling, summer 2025)
- [[jones-seel-lab]] — Duke research lab, embedded/IoT flood-mapping firmware (career)
- [[catalyst-tech-society]] — Duke student tech org, Dave = Professional Chair (career)
- [[rtx-internship]] — RTX (Raytheon) internship w/ housing, ~summer 2026 (career)

## Sources

- [[sources/uni-flood-modeling]] — Automating Flood Modeling, Data+ 2025 research poster
- [[sources/uni-350-cheat-sheets]] — ECE/CS 350 midterm cheat sheets (topic map for digital systems)
- **One source card per raw file — 114 total.** Each course card is the hub linking its own cards:
  [[316]] (deep-ingested, 6 concepts) · [[350]] · [[270]] · [[353]] · [[230-semiconductors]] ·
  [[280]] · [[230-probability]] · [[ev-firmware]]. All except 316 are **catalog-level**
  (provenance + title; bodies not re-read) — deep concept promotion available per course on request.
- `raw/notion/misc/` (4 cards) — not class material (`janet`, `technical-interview`, `roudy-notes`,
  index); need a career/personal home, see open items.

## Synthesis

- [[academic-timeline]] — Dave's full course/research history by semester (the education backbone)
- [[professional-profile]] — Dave's professional profile & recruiting trajectory (career backbone)

## Open items

- [[contradictions#RESOLVED-pending-Dave-s-confirmation-230-is-two-different-courses]] —
  `230` labels two unrelated courses (probability vs. semiconductor devices).
- **[[dave-zheng-pcb]]** — probably a [[230-semiconductors]] lab PCB (Dave, tentative); the
  `331` prefix is still unexplained.
- **[[230-probability]]** — the only course still lacking a confirmed department code.
- **Not yet pulled:** personal domain (nothing identified/requested yet).

*Resolved 2026-07-17:* [[itm]] confirmed a dead prototype superseded by [[imgsic]] (Dave).
`uni/` academic spine built (timeline + 18 course cards + flood-research & 350-cheatsheet sources).
The two `230`s confirmed as different semesters; **ECE230L link now confirmed**, see [[contradictions]].
