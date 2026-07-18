# brainclaude — schema

This vault is an LLM-maintained personal wiki following Karpathy's llm-wiki pattern.
This file is the **schema layer**: it defines the rules you follow when maintaining it.
Read it fully before touching anything.

## The invariant

**The body of every file in `raw/` is immutable. You never edit, rename, or delete it.**

`raw/` is Dave's memory of record. `wiki/` is your *interpretation* of that memory. If you
edit a snapshot's body, your interpretation overwrites the source and the source of truth is
gone forever. There is no exception to this rule for body content. If a raw file's content is
wrong, note it in `wiki/contradictions.md` — do not fix it.

**Narrow exception: frontmatter is machine-generated provenance, not Dave's content, and may
be corrected when demonstrably wrong.** (Amended 2026-07-16, after every snapshot in the
first pull was written with the same incorrect `fetched:` date — a hardcoded error, not
Dave's data, propagated by agents faithfully doing what they were told.) A frontmatter
correction must:
- touch only frontmatter fields, never the body
- be logged in `wiki/log.md` with what changed and why
- exist because the field is *demonstrably* wrong (e.g. the pull's actual run date is known)
  — never because a field is merely inconvenient or looks stale

The other exception to "never write to raw/": syncing a new snapshot from an external system
(see Snapshots below). That is Dave's data arriving, not your synthesis.

## Layout

```
raw/              immutable sources. Dave owns this.
  notion/         snapshots mirrored from Notion (see Snapshots)
  drive/          snapshots mirrored from Google Drive
  assets/         PDFs, images, binaries
wiki/             you own this entirely
  _index.md       catalog of every page, grouped by kind
  log.md          append-only audit trail. Never rewrite history here.
  contradictions.md  the ledger. Surfaced, never silently resolved.
  sources/        one card per raw file. The provenance anchor.
  concepts/       ideas. THIS IS THE GRAPH.
  entities/       people, orgs, tools, courses
    projects/     one pointer card per external repo/project (see Projects)
  synthesis/      cross-cutting notes. Earned, not auto-generated.
output/           only artifacts that LEAVE the vault (decks, reports to send)
.manifest.json    sha256 per raw file -> derived wiki pages. Makes ingest incremental.
```

## Domains

Every wiki page carries a `domain:` frontmatter field so the graph can be sliced by area
of life. Four domains, fixed for now:

- **education** — coursework, exam notes, academic history (`uni/`, Notion/Drive course pulls)
- **projects** — code and hardware projects (see Projects below)
- **career** — resume drafts, cover letters, job/offer/relocation docs
- **personal** — everything else that's genuinely Dave's private context

A page may legitimately touch two domains (an ECE course project is both `education` and
`projects`); pick the *primary* one for the field and link across with `[[wikilinks]]`. Don't
fork the `concepts/`/`entities/` folders per domain — the kind-based folders stay the
backbone; `domain:` is a tag on top, and `_index.md` groups by it as a view.

**Exception — the `personal` domain is path-separated and git-private (amended 2026-07-18, Dave's
call).** Dave's private context (travel, study-abroad logistics, etc.) is kept *in* the vault so it's
usable locally, but it must **never** reach the git remote. Since git filters by path — not by the
`domain:` tag — every `personal`-domain wiki page lives under **`wiki/personal/`**, which is
**gitignored** (as is `raw/` for personal raw snapshots). Rules:
- Write personal pages to `wiki/personal/` (any kind — entity, source, note), never to the committed
  `wiki/concepts|entities|sources/`. Mark them `private: true` in frontmatter.
- **Committed files must not enumerate or embed personal specifics** — `_index.md`, `log.md`,
  `.manifest.json`, and any committed page stay clean of personal content (no personal titles, links,
  or details). `_index.md`'s personal section is a generic "local only" pointer, not a list.
- **Credentials are never stored anywhere in the vault**, gitignored or not — passwords/tokens/keys go
  in a password manager. Everything else personal may be kept in full under `wiki/personal/`.
- Personal content is not tracked in the committed `.manifest.json`.

## Projects — indexed, not ingested

Dave's code and hardware projects are **living repositories**, most with their own git remote
and several with their own `CLAUDE.md`. **The vault never copies a repo's source into `raw/`.**
The code is already the source of truth in its own repo; snapshotting `node_modules` and build
output as markdown is pure noise and massive token waste (the named repos are ~3.5 GB, 100k+
files, mostly dependencies).

Instead each project gets **exactly one pointer card** in `wiki/entities/projects/`:

- what it is, in one honest sentence (not the repo's aspirational README tagline)
- where it lives: absolute path on disk + git remote URL
- stack, current status, last-touched date
- key decisions/learnings worth remembering across projects
- `[[wikilinks]]` to the concepts it exercises (e.g. a systolic-array project links
  [[fsm-state-minimization]])

The pointer card **is** the source card for a project — its citations point at the repo's own
docs (`README.md`, `CLAUDE.md`, `docs/`) by path, e.g. `^[[gkweb/CLAUDE.md]]`. If a repo's own
knowledge is worth preserving against the repo moving or dying, snapshot *only its docs* into
`raw/` — never its code. Concepts still get promoted normally: a genuinely reusable idea learned
while building a project earns a concept page like any other.

## Artifacts vs. knowledge — the promotion rule

Most of `raw/` is **artifacts** (Dave's own work: homework, exam reviews, class projects),
not **knowledge** (ideas worth knowing independent of the artifact).

- Every raw file gets exactly one **source card** in `wiki/sources/`. Always.
- Only *ideas* get promoted to `wiki/concepts/`. A concept page must be meaningful to
  someone who never took the course.
- `CS-350-Midterm-2` is **not** a concept. `FSM state minimization` **is**.
- When in doubt, do not promote. An under-promoted wiki is recoverable; a wiki flooded
  with course-scoped noise is not.

Concepts are the graph. Artifacts hang off it via source cards.

### Handling Dave's own errors when promoting

Dave's notes contain real errors — see "Lessons from the first pull" below for the pattern.
When a source you're promoting from is wrong:

- **State the mathematically/logically correct version in the concept page.** The wiki should
  teach right, not launder an error into something that reads as authoritative because it's
  cited.
- **Cite Dave's page as the source anyway** — the citation says where the *topic* came from,
  not that every symbol in the source is correct.
- **Explicitly flag the divergence in the concept page**, close to the citation: what Dave's
  source actually says, and how it differs. Not buried only in `contradictions.md` — a reader
  of the concept page should see it without cross-referencing the ledger.
- This is not "fixing raw/." The snapshot stays wrong forever, untouched. Only the concept
  page states the correction.
- If you can't tell whether something is an error or you're missing context, don't guess —
  file it in `contradictions.md` and promote the concept without asserting either version.

## Provenance — non-negotiable

Every claim in a concept page cites where it came from, inline:

```markdown
The Hamming distance of a code determines how many bit errors it can
correct. ^[[[sources/notion-316-mid-1]]]
```

If you cannot cite it, do not write it. A concept page with uncited claims is
indistinguishable from a hallucination — to Dave, and to your own lint pass later.

Prefer `file:line` precision where the source has stable lines.

## Snapshots (external sources)

Notion is **live and mutable**; `raw/` is immutable. Reconcile as follows:

- Snapshot Notion pages into `raw/notion/` as markdown.
- Every snapshot carries frontmatter:

```yaml
---
source: notion
source_url: https://app.notion.com/p/<id>
notion_id: <uuid>
fetched: 2026-07-15
---
```

- A snapshot is immutable *until Dave asks for a re-sync*. On re-sync, overwrite the file
  and log the diff.
- `fetched` is what lets lint say "this is 90 days old, upstream may have moved" instead
  of guessing. Never omit it.
- **A stale snapshot is not a contradiction.** Do not file drift-vs-Notion in
  `contradictions.md` unless you have actually re-fetched and confirmed the change.

## Workflows

**`/ingest`** — for each raw file whose sha256 is absent from or differs from
`.manifest.json`: read it, write/update its source card, update or create affected concept
and entity pages, update `_index.md`, append to `log.md`, update the manifest. Skip
unchanged files silently. Never re-read the whole vault.

**`/query`** — search the wiki, answer with citations. If the answer is durable and
non-obvious, it becomes a new page in `wiki/synthesis/`. Answers compound; they do not go
in `output/`.

**`/lint`** — health check. Report, do not auto-fix:
- contradictions between pages
- stale snapshots (`fetched` older than 90 days)
- orphan pages (no inbound links)
- concept pages with uncited claims
- source cards whose raw file no longer exists

## Contradictions

When new information conflicts with existing wiki content: **do not silently overwrite.**
Append to `wiki/contradictions.md` with both claims, both sources, and the date. Surface it
to Dave. He resolves; you record the resolution.

Distinguish carefully:
- **Real conflict** — two sources assert incompatible facts. File it.
- **Supersession** — newer source updates older. Note it, prefer the newer, keep the old
  citation.
- **Overlap** — two notes cover the same ground. Not a contradiction. Merge or link.

## Style

- Lowercase-kebab filenames: `fsm-state-minimization.md`
- Atomic notes: one concept per page
- Link liberally with `[[wikilinks]]`. A link to a page that doesn't exist yet is a
  feature — it marks a gap worth filling.
- Prose over bullets in concept pages. Bullets fragment reasoning.
- No hedging. If a source is uncertain, say what the uncertainty is and cite it.

## Lessons from the first pull (2026-07-15/16) — read before running `/ingest`

These cost real effort to learn. Don't re-learn them.

- **Do not infer a page's contents from its title.** Twice this pull, an inferred content
  guess (FD/BCNF material "must be" under a given page; a page titled "normal approx to
  binomial" assumed to contain one) was wrong when someone actually read the page. Fetch
  before concluding.
- **Notion "alias" (link-to-page) blocks are unresolvable via this MCP.** They surface as
  `<unknown alt="alias">` with a `#fragment` on the *parent's* URL; the fragment is a block
  ID, and fetching it returns a blank untitled shell. **The target page ID is never exposed.**
  Don't spend a wave trying to recover them by searching-and-verifying-ancestry — that was
  tried and disproven. If a real gap is later suspected, the only route is browser rendering
  of notion.so, which needs a one-time interactive permission grant from Dave.
- **Underline (`<span underline="true">`) is frequently semantic, not decorative** — it has
  marked primary keys (`316`), header/example nesting (`230-probability`), and defined terms
  (`353`). Never collapse it to bold. Preserve as `<u>...</u>` in every snapshot, always,
  even when a given page looks like it's only using it for emphasis.
- **Notion tracker metadata describes intent, not content.** `353 mid 2` is marked
  Status: Mastered / Priority: Done! while being a structurally empty page (all its content
  lives on a separate top-level course page). Treat `Status`/`Priority` as what Dave meant to
  have done, never as confirmation that content exists or is correct.
- **Course-level material lives in two shapes.** Some courses have real content only in
  per-exam rows in the `Midterm Review Notes` database; others (`316`, `280`, `353`,
  `230-probability` — all Fall 2025) have a separate top-level, non-database course page with
  its own children instead. Both shapes need checking; neither implies the other is absent.
- **Dave's errors are systemic and follow a pattern worth knowing before you promote
  anything.** Every course pulled contains real math/logic errors. But overwhelmingly his
  *arithmetic and worked results are correct*; it's his *symbolic/formulaic statements* that
  break — a theorem stated right, then a variable swapped one line later; a value computed
  correctly, then the wrong version of it reused. Treat a correct worked answer as reasonably
  trustworthy even when the formula above it is garbled; treat every bare formula as needing
  a check.

## Context

Dave is an ECE student. Courses seen so far: 230, 270, 280, 316, 350, 353.

**Course numbers are not unique keys.** `230` labels two unrelated courses — a probability
course (Fall 2025) and a semiconductor devices course (Spring 2026). The vault
disambiguates by content: `230-probability`, `230-semiconductors`. Real department codes
are unknown; **do not invent them**. Derive course identity from page content, never from
the tracker's bare `Topic` field. See [[contradictions]].

Known courses, from a workspace survey plus the `uni/` archive: `230-probability`,
`230-semiconductors`, `270` (fields and waves), `280` (signals & systems), `316` (databases —
**not** an ECE course), `350` (digital logic/architecture), `353` (differential equations/linear
algebra), plus the full academic history in [[academic-timeline]].

**Department codes — most now confirmed** (2026-07-17, via Dave's own Drive file names + the
`uni/` folder structure + Dave's direct confirmation — not inference): `316` = **CompSci 316,
Duke**. `280` = **ECE 280**, Duke (a lab report invokes the Duke Community Standard). `353` =
**Math 353** — not ECE, despite living alongside ECE courses here. `350` = **ECE/CS 350**,
cross-listed. `270` = **ECE 270, Fields and Waves** (Dave, 2026-07-17). `216` = **CINE 216,
Cinematic Authorship** (Dave, 2026-07-17). `104` = **UNIV 104**, Art-Science Survey seminar.
`230-semiconductors` = **ECE 230L** — confirmed: `uni/spring 2026/230/` contains
`FinalExam-Template-ECE230L.pdf` (see [[contradictions]]).

**Still unconfirmed, still do not invent:** `230-probability` has no department code from any
source (the fall-2025 folder is just `230`). When in doubt, the vault's own content-derived slug
stands.

Adjacent project: `~/Documents/hw-cnn-accelerator` — deliberately **not** part of this vault
yet. It is a **systolic-array GEMM (matmul) accelerator currently running an MLP digit
classifier — explicitly not a CNN**, per Dave's own 2026-07-05 reframe decision recorded in
his Notion project page. The directory name is legacy and misleads; do not propagate it.
Concepts like [[fsm-state-minimization]], [[mosfet-structure-and-energy-band-diagrams]], and
[[carrier-transport]] are upstream of it. Expect those edges to matter later.

**A second, separate hardware project exists: Dave's ECE 350 final project** — a Connect 4
game on a custom 5-stage pipelined FPGA CPU, built with a partner (Faiz Ali), with physical IR
sensors and VGA output (`raw/drive/350/`). Same broad skill area as hw-cnn-accelerator
(FPGA/Verilog/pipelined processors), same student, **different project, different scope, has
a partner.** Do not conflate the two when either gets its own graph.
