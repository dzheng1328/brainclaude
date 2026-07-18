# Index

Catalog of every wiki page. Maintained by `/ingest`. Grouped by kind, sliced by domain.

**Status:** `raw/` holds 95 Notion snapshots, 16 Drive snapshots, 5 repo-doc snapshots
(`raw/repos/ev-firmware/`, `raw/repos/hw-cnn-accelerator/`), 124 assets. **Graph populated:** all
7 coursework courses deep-ingested — **41 concepts**, 120 source cards, 4 synthesis pages, 33 entities
(committed graph). The **personal** domain is kept locally in gitignored `wiki/personal/` + `raw/` and is
not counted here. Google Drive ingest ongoing since 2026-07-18. Last updated 2026-07-18.

## By domain

The vault's backbone is **kind** (concepts / entities / sources), so the folders don't split by
domain — instead every page carries a `domain:` tag and this section is the view that slices by it.
The same four domains color the Obsidian graph (education = blue, projects = green, career = amber,
personal = purple). Current split (committed graph): **education 169 · projects 19 · career 8.** The **personal** domain is
gitignored (local only), so its pages aren't part of the pushed repo.

### 🎓 education — coursework, concepts, academic history
- **Courses (18):** [[316]] · [[350]] · [[353]] · [[280]] · [[270]] · [[230-probability]] ·
  [[230-semiconductors]] · [[216]] · [[univ-104]] · [[math-218]] · [[math-219]] · [[cs-201]] ·
  [[ece-110]] · [[ece-250]] · [[egr-101]] · [[egr-102]] · [[ethics-189]] · [[writing-101]]
- **Concepts (39):** the full graph — see [Concepts](#concepts) below, grouped by course.
- **Synthesis:** [[academic-timeline]] · [[convolution-and-transforms]]
- **Research:** [[data-plus]]
- 109 source cards (provenance anchors).

### 🔧 projects — code & hardware (indexed by pointer, repos stay external)
- **Project cards (11):** [[hw-cnn-accelerator]] · [[ece-350-connect4]] · [[synth]] · [[imgsic]] ·
  [[gohelpme]] · [[gkweb]] · [[hacknc]] · [[daily-tickers]] · [[ev-firmware]] · [[dave-zheng-pcb]] ·
  [[itm]]
- **Concepts (2):** [[systolic-array-dataflow]] · [[neural-network-quantization]]
- **Synthesis:** [[coursework-behind-hw-cnn-accelerator]]

### 💼 career — profile, research labs, recruiting
- [[professional-profile]] · [[jones-seel-lab]] · [[catalyst-tech-society]] · [[rtx-internship]]
- 4 source cards (résumé, CV — sensitive docs recorded as facts, not copied).

### 🌱 personal — private context (local only)
- **Lives in the gitignored `wiki/personal/` and `raw/`** — never committed or pushed. Visible in
  Obsidian on this machine, but intentionally absent from the git remote. Full personal detail is kept
  there; the only thing excluded outright is plaintext credentials (those belong in a password manager).
- This committed index does not enumerate personal entries by design.

## Concepts

*From [[316]] databases:*
- [[relational-algebra]] · [[functional-dependencies]] · [[database-normalization]]
- [[entity-relationship-model]] · [[database-transactions]] · [[sql]]

*From [[350]] digital systems (feeds the hardware projects):*
- [[finite-state-machines]] · [[fsm-state-minimization]] · [[boolean-algebra]]
- [[twos-complement-arithmetic]] · [[binary-multiplication]] · [[cmos-logic]] · [[pipelining-and-hazards]]

*From [[230-semiconductors]] device physics (ECE 230L — the substrate under the hardware):*
- [[semiconductor-carrier-statistics]] · [[carrier-transport]] · [[pn-junction]]
- [[mos-capacitor]] · [[mosfet-structure-and-energy-band-diagrams]] · [[electronic-band-structure]]

*From [[230-probability]] (probability & statistics):*
- [[expectation-and-variance]] · [[common-discrete-distributions]] · [[poisson-distribution]]
- [[normal-distribution]] · [[law-of-large-numbers-and-clt]] · [[confidence-intervals]]

*From [[270]] fields & waves (ECE 270 — transmission lines & electromagnetics):*
- [[transmission-line-theory]] · [[bounce-diagrams-and-transients]] · [[impedance-matching]]
- [[electromagnetic-plane-waves]] · [[wave-reflection-at-boundaries]] · [[waves-in-lossy-media]]
- [[oblique-incidence-and-antennas]] · [[wave-impedance-analogy]] (the unifying idea)

*From [[353]] diff eq & linear algebra (Math 353):*
- [[laplace-transform]] · [[fourier-series]] · [[linear-systems-eigenvalue-method]]

*From [[280]] signals & systems (ECE 280):*
- [[lti-systems-and-convolution]] · [[fourier-series-signals]] · [[fourier-transform-and-filtering]]

*From [[hw-cnn-accelerator]]'s own repo docs (project knowledge, snapshotted):*
- [[systolic-array-dataflow]] · [[neural-network-quantization]]

*All coursework now deep-ingested. New concepts arrive when new raw material is pulled.*

## Entities

### Projects (`entities/projects/` — pointer cards, repos stay external)

- [[hw-cnn-accelerator]] — solo systolic-array GEMM accelerator (Verilog), runs an MLP on MNIST
- [[ece-350-connect4]] — Connect 4 on a custom 5-stage pipelined FPGA CPU (350 final, w/ partner)
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
  [[316]] (deep, 6 concepts) · [[350]] (deep, 7) · [[230-semiconductors]] (deep, 6) ·
  [[230-probability]] (deep, 6) · [[270]] (deep, 8) · [[353]] (deep, 3) · [[280]] (deep, 3) ·
  [[ev-firmware]]. **All coursework courses now deep-ingested** (39 concepts). Non-course source
  cards (labs, exams, misc) remain provenance anchors by design.
- `raw/notion/misc/` (4 cards) — not class material (`janet`, `technical-interview`, `roudy-notes`,
  index); need a career/personal home, see open items.

## Synthesis

- [[academic-timeline]] — Dave's full course/research history by semester (the education backbone)
- [[professional-profile]] — Dave's professional profile & recruiting trajectory (career backbone)
- [[coursework-behind-hw-cnn-accelerator]] — /query answer: which concepts feed the accelerator
- [[convolution-and-transforms]] — one theorem across [[353]] (Laplace) and [[280]] (Fourier)

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
