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

### Other entities

*(none yet — courses, people, tools)*

## Sources

*(none yet — one card per raw file)*

## Synthesis

*(none yet — earned from `/query`, not auto-generated)*

## Open items

- [[contradictions#RESOLVED-pending-Dave-s-confirmation-230-is-two-different-courses]] —
  `230` labels two unrelated courses (probability vs. semiconductor devices).
- **[[dave-zheng-pcb]]** — probably a [[230-semiconductors]] lab PCB (Dave, tentative); the
  `331` prefix is still unexplained.
- **Not yet pulled:** `uni/` academic spine (education), career docs (resume/cover/job).

*Resolved 2026-07-17:* [[itm]] confirmed a dead prototype superseded by [[imgsic]] (Dave).
