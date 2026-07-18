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

*(none yet — this becomes the graph)*

## Entities

### Projects (`entities/projects/` — pointer cards, repos stay external)

- [[hw-cnn-accelerator]] — solo systolic-array GEMM accelerator (Verilog), runs an MLP on MNIST
- [[imgsic]] — image → ambient music web app (Vite + Tone.js + Claude vision)
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

## Sources

- [[sources/uni-flood-modeling]] — Automating Flood Modeling, Data+ 2025 research poster
- [[sources/uni-350-cheat-sheets]] — ECE/CS 350 midterm cheat sheets (topic map for digital systems)

## Synthesis

- [[academic-timeline]] — Dave's full course/research history by semester (the education backbone)

## Open items

- [[contradictions#RESOLVED-pending-Dave-s-confirmation-230-is-two-different-courses]] —
  `230` labels two unrelated courses (probability vs. semiconductor devices).
- **[[dave-zheng-pcb]]** — probably a [[230-semiconductors]] lab PCB (Dave, tentative); the
  `331` prefix is still unexplained.
- **Not yet pulled:** career docs (resume/cover/job).
- **[[216]]** — writing-intensive course, subject/department unidentified from the archive.

*Resolved 2026-07-17:* [[itm]] confirmed a dead prototype superseded by [[imgsic]] (Dave).
`uni/` academic spine built (timeline + 18 course cards + flood-research & 350-cheatsheet sources).
The two `230`s confirmed as different semesters; **ECE230L link now confirmed**, see [[contradictions]].
