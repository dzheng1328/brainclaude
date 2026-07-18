# Log

Append-only. Never rewrite prior entries.

## 2026-07-15 — vault initialized

- Scaffolded `raw/`, `wiki/`, `output/` per Karpathy's llm-wiki pattern.
- Wrote schema layer (`CLAUDE.md`), commands `/ingest`, `/query`, `/lint`.
- Notion connected as Dave Zheng (davezheng1328@gmail.com), workspace "Dave Zheng's".
- Decisions: snapshot Notion into `raw/notion/` with `source_url` + `fetched` frontmatter;
  first pull scoped to class notes + midterm reviews; one vault; `Welcome.md` retained.
- `hw-cnn-accelerator` knowledge graph deliberately deferred.

## 2026-07-15 — Notion corpus surveyed (no ingest yet)

Enumerated `Midterm Review Notes` (db `275babf1-97c2-8016-b328-000b7419899e`): 16 exam
rows across courses 230, 270, 280, 316, 350, 353.

Structure found: exam pages are **thin containers** whose body is a list of child concept
pages (typically 5–8 each). A minority hold inline content instead (`230 mid 1` Fall 2025).
Notion therefore already encodes the artifact/knowledge split structurally — exam page →
source card, child page → concept.

Filed to [[contradictions]]: `230` labels two unrelated courses. Ingest of `230` material
blocked pending real course codes.

`raw/` still empty. Pull not started — corpus is ~90–110 pages, too large for a single
pass; batching decision pending with Dave.

## 2026-07-15 — first pull wave: 4 of 7 complete, 3 interrupted

Seven parallel agents, one per course identity. Scoped to the `Midterm Review Notes`
database only.

**Landed on disk: 66 snapshots (16 exam containers + 50 concept pages), 118 assets, 18MB.**
Every snapshot carries `fetched:`; zero broken image links; zero surviving S3 URLs.

| course | what it is (derived from content) | files | assets | state |
|---|---|---|---|---|
| `230-probability` | calculus-based intro probability | 7 | 14 | complete |
| `230-semiconductors` | semiconductor devices | 16 | 7 | complete |
| `270` | waves & transmission lines | 16 | 1 | complete |
| `280` | signals & systems | 3 | 0 | **thin — most content is outside the DB** |
| `316` | **intro database systems** (not ECE) | 6 | 30 | complete, but see underline defect |
| `350` | digital logic & computer architecture | 16 | 29 | complete |
| `353` | differential equations / linear algebra | 2 | 37 | **INCOMPLETE — killed mid-run** |

`230-semiconductors`, `350`, `353` were killed when the process exited. The first two had
already finished writing; `353` had downloaded 37 assets but written only 2 markdown files.
Its assets are orphaned on disk — harmless, and they'll be re-referenced on re-pull.

**Course identities are derived from page content, never from the tracker's `Topic` field**
(see [[contradictions]]). No department codes invented. `316` turning out to be databases
rather than an ECE course is the clearest vindication of that rule.

**Findings this wave** — all in [[contradictions]]:
- Real math errors in Dave's notes in **every course examined** (`280` distributive
  property, `270` radome formula, `230-probability` combinations + CLT, `316` monotonicity).
  Systemic, not incidental. Drove the standing rule: ingest promotes understanding, not
  transcription.
- **Pipeline defect (ours):** the `<span underline>` → bold instruction destroyed
  primary-key notation in `316`. Re-pull needed.
- The `Midterm Review Notes` DB is **not** the whole corpus — top-level course pages exist
  outside it (`280`, `353`, likely more). Dave approved a second wave.
- The "blank alias pages" are a **fetch-tool limitation**, not missing content — ≥14 real
  concept pages went unfetched.

**Blocked:** Notion MCP connector disconnected. No re-pull, no second wave, no alias
recovery until it's reauthorized.

## 2026-07-15 — the two unrecognized pages: benign, resolved

Dave didn't recognise two pages timestamped that morning; I flagged them as a possible
injection vector. **Fetched both. They're his own project tooling.**

`hw-cnn-accelerator — Project Command Center` (`394babf1-97c2-81fa-ac5b-f1a34edafdfd`) is a
top-level project page for the adjacent repo: phase roadmap, status, and an embedded
`Task Board` database. `📘 Lesson artifact deep-dive rewrite (Parts 3/5/6)`
(`39ebabf1-97c2-813d-b9c0-dc270725298d`) is a **card inside that Task Board** — status Done,
Phase 1, dated 2026-07-11.

The "54 pages in the user's own Midterm Review Notes database" line that looked like
surveillance is an earlier Claude session recording that it had studied Dave's notes **to
copy his note-taking style** into a lesson artifact. Third-person register because it's a
task log written by an agent, not by Dave. Same reason he didn't recognise it: he didn't
write it — a prior session did, on his behalf.

**Corroboration, not contradiction:** that page counts *"11 exam containers / 54 pages"*.
This pull found 16 exam rows and 50 concept pages, with ≥14 alias targets still unresolved.
Two independent surveys, four days apart, landing in the same range — and the gap points the
same direction as the alias finding: there is more material than the DB rows alone reveal.

Suspicion was the right default (unrecognised page, appears minutes before the task, narrates
the task in third person) and reading before acting was the right resolution. No action
needed. Not a contradiction — nothing here conflicts with anything. Recorded in the log,
kept out of the ledger.

## 2026-07-15 — connector restored, second wave launched

Notion reconnected on its own; nothing required from Dave. Verified as Dave Zheng
(davezheng1328@gmail.com), workspace "Dave Zheng's". Four outstanding jobs dispatched:
finish `353`, pull top-level course pages (Dave: "sure"), re-pull `316` preserving
primary-key underlines, and chase the unresolved alias targets.

## 2026-07-15 — workspace survey: the corpus is ~260 pages, but only ~19 are missing knowledge

A scout agent (read-only, wrote nothing) mapped the whole workspace. Headline: **~260 pages
exist vs. the 66 held — but ~157 are empty template stubs.** Real uncaptured knowledge is
~19 pages.

**The `todo` database** (`27ababf1-97c2-80ff-99b5-c3ae31168ecd`, 137 rows) parents nearly
every `hw`/`lab`/`prelab`/`project` page in the workspace. Every row sampled is an unfilled
Notion template: "Provide an overview of the task and related details", three empty
checkboxes, empty pdf/drive/figma embeds. It is a **deadline tracker, not notes**. Titles
like `316 final project` and `350 hw 1–6` promise substance and deliver boilerplate.

**Decision: do not snapshot the `todo` database.** 137 source cards of template default would
nearly triple `raw/` and add zero knowledge — precisely the flood the promotion rule exists
to prevent. Deadline history, if ever wanted, is one SQL query away; it needs no snapshot.

**This also deflates the alias count.** The `alt="drive"`/`alt="figma"` blocks in those stubs
are unfilled template placeholders pointing at nothing. Some fraction of the "≥14 missing
alias targets" are these. The real count must be re-derived against actual course pages
before chasing.

**Two unknown courses found — both hollow.** `216` (papers, annotated bib, forums) and `104`
(surveys) exist only as `todo` stub titles with zero content. Recorded in `CLAUDE.md` for
completeness; nothing to ingest.

**A behavioural fact worth keeping:** top-level course pages exist only for `316`, `280`,
`353`, `230-probability` — all **Fall 2025**. Dave stopped keeping course-page notes after
that semester and moved to exam-row notes. That's why `350` and `270` have none, and it
explains the whole two-shapes-of-filing puzzle.

**Schema drift found in my own file, now fixed:** `CLAUDE.md` described the adjacent project
as a "systolic-array CNN accelerator". Dave's own Notion project page states it is a GEMM
matmul engine running an **MLP** classifier — *explicitly not a CNN*, per his 2026-07-05
reframe. The directory name is legacy and misleading. Corrected. Worth noting the vault's own
schema layer was wrong about the thing it was describing, and only a content survey caught
it.

**Department-code evidence (not confirmation):** tracker titles `ece 350 alu`, `ece 280 -hw
5`, `ece 230 lab 1 orientation` leak real codes. The `230` one dates 2026-01-17 → Spring 2026
→ `230-semiconductors`. Filed as evidence in `CLAUDE.md`; content-derived names stand. One
lab title is thin support, and it says nothing about `230-probability`.

## 2026-07-15 — `280` course-level pull complete

8 snapshots written (`course___index` + 7 concepts), 2/2 images. Tree is flat — all 7
children are leaves. `improper integral & laplace transform` verified as a `353` child, not
`280`; left for that agent, no duplicate.

Findings → [[contradictions]]: a second error in `chat-review` (`r(t)*r(t)=q(t)`, should be
`t³/6`) making that file doubly unreliable; a sign-flipped inequality in
`course__lti-convolution.md` whose derived bounds are nonetheless correct; `course__nyquist.md`
is **blank upstream** — a real topic gap, not a pull failure. Underline on these pages is pure
decoration, no semantic load.

## 2026-07-15 — third wave dispatched

- `316` agent (in flight) given additional scope: the top-level `316` page and its **6 SQL
  concept pages** — the highest-value uncaptured material found. Same course, same underline
  defect class, so folded in rather than spawning a cold agent.
- New agent: top-level `230-probability` (4 concepts) + the `c` career subtree + `roudy
  notes`.
- Not pulled, deliberately: the `todo` database, `216`/`104`, `hw-cnn-accelerator` (~22 pages,
  out of scope, reserved for its own graph later).

## 2026-07-15 — `230-probability` course-level + misc pull complete

9 snapshots: 5 under `raw/notion/230-probability/` (`course___index` + expectation, normal
approx to binomial, lln-clt, random variable transformation), 4 under `raw/notion/misc/`
(`c___index`, `c__technical-interview`, `c__janet`, `roudy-notes`). No images anywhere in
scope. No children the survey missed.

**The headline: the first real source-vs-source conflict.** The two `lln, clt` pages disagree,
and each is correct where the other is wrong — exam page right on LLN, course page right on
CLT, and the exam page contradicts *itself* on CLT four lines apart. Filed in
[[contradictions]]. Resolution is link-don't-merge. This is the system doing the job it was
built for: it caught a real inconsistency in Dave's exam notes by cross-referencing his own
course notes, on the fourth wave, before a single concept page existed.

**Underline is semantic in `230-probability`** — it marks section headers *and*, nested
beneath them, example markers (`ex. roll a fair die`). On `course__expectation.md` the same
`<u>**...**</u>` wrapper does both, distinguished only by position. So the original
underline→bold instruction would have erased a structural distinction here too — the `316`
primary-key case was not a one-off. The fix generalizes; good that it was applied fleet-wide
rather than just to `316`.

**Provenance:** all seven substantive pages read as Dave's own — terse lowercase bullets,
inline LaTeX, asides ("dk why", "yada yada"), a `generall` typo. No paste seams like
`mid-2__poisson.md`. `course__expectation.md` is polished but stays in his voice; careful
notetaking, not pasted.

`c__janet.md` is **empty** — title only, no content. No privacy concern; the earlier worry
that it might hold personal details about a real person was unfounded. Kept as a
frontmatter-only stub so the index link resolves.

`roudy-notes.md` references a professor's "duke page" — an institution signal that
independently corroborates the `316` agent's Duke CompSci 316 read. Recorded in
[[contradictions]] as evidence; **still not licence to invent department codes**.

## 2026-07-15 — `353` complete; alias recovery closed as impossible-and-unnecessary

5 course-level snapshots written (variation of parameters, Laplace, matrices/eigenvalues,
Fourier, `11.17 review`). 20 images downloaded; **0 orphans remain** (37 assets ↔ 37 distinct
refs) — the interrupted run's assets were re-referenced exactly as predicted. Re-fetched
`mid-2` and confirmed it unchanged; no re-sync warranted.

`353` is **engineering differential equations**: first-order ODEs → variation of parameters →
Laplace → systems via eigenvalues → two-point BVPs → Fourier series.

**Alias recovery: closed.** The agent tested my recovery technique rather than assuming it, and
disproved it — alias target IDs are never exposed by the API; the `#fragment` blocks resolve to
themselves. The technique I gave three agents was built on a wrong premise. Closed as *probably
harmless*: the 4 `353` aliases almost certainly pointed at the 4 course-level pages we pulled
anyway. Browser rendering would work but needs a notion.so permission grant from Dave —
**not requesting it**; cost/benefit says stop unless ingest reveals a real gap. Full arc in
[[contradictions]].

**Underline is semantic in `353` too** — headings, defined terms (`repeated root`,
`multiplicity`, `piecewise continuous`), and instruction verbs in worked examples. That's
**three courses** (`316` keys, `230-probability` header/example nesting, `353` term
definitions). It is a systematic property of how Dave writes, not a per-course quirk. The
original underline→bold instruction would have silently degraded a third of the corpus.

**Errors found, including the corpus's worst:** `course__variation-of-parameters.md` swaps
`y_1`/`y_2` relative to its own theorem *one line later*, and uses the un-normalized `f = x⁴`
after correctly normalizing to `f = x²`. Not a typo — the method executed wrongly in the one
place it's demonstrated. Also: sign errors inverting the eigenvalue problem, a linear-dependence
definition missing "not all `c_i` zero", a malformed `\mathcal\{cost\}` that won't render, and a
Fourier master formula missing its `\sin`.

**The pattern that matters:** across all four `353` pages the *arithmetic* is consistently
correct (Wronskians, eigenvalues, every Fourier coefficient verified) while the *symbolic
statements* break. Dave computes reliably and transcribes carelessly. Promotion should trust his
worked results and check his formula statements.

**Two structural findings** → [[contradictions]]: `353 mid 2` is marked *Mastered / Done!* while
being structurally empty (tracker metadata certifies mastery of a page with no content — treat
tracker fields as intent, not description); and **Fourier spans `280` and `353`** — the first
genuine cross-course edge in the corpus, and a good early test of whether one vault earns its
keep. Link, don't merge: the framing differs and the framing is the point.

## 2026-07-16 — `316` re-pull complete; PULL PHASE DONE

13 snapshots (6 overwritten with underlines preserved, 7 new: `course___index` + 6 SQL
concepts). 34 images, 0 failed, 0 orphaned. 249 balanced `<u>` tags in this course alone.

**The underline defect is fixed and the recovered passage is the one that *defines the
notation*** — `address (<u>address</u>, city, state, <u>zip</u>)`, preceded by "underline all
its attributes". The old bold rule had flattened the page explaining *why underline means key*
into the same bold as its own prose. Scope was narrower than feared (5 of 6 SQL pages use
underline as pure emphasis; SQL keywords carry the keys there) but the fleet-wide fix was right
regardless — underline proved semantic in `230-probability` and `353` on different axes.

**Two inferences of mine, both refuted by agents reading actual pages:**
- FD/BCNF/MVD/4NF material was never missing — it's *inside* the E/R page. I had inferred a
  page's contents from its title.
- The 6 aliases aren't that material. They're probably the 6 top-level SQL pages (6 aliases, 6
  pages, SQL absent elsewhere under that exam, mirroring `353`). Recorded as inference, labelled
  as such.

**Monotonicity error is worse and now diagnosable:** Dave didn't just mislabel `difference` —
he **swapped the annotations between adjacent rows**. Union got difference's annotation verbatim.
One transposition, two wrong cells, understanding intact. Same signature as everything else.

**New class: SQL that won't execute** — missing `=`, unterminated strings, `SELET`. Mostly
low-risk (SQL fails loudly). One exception: `WHEN (n.age < 0.age)` should be `o.age` — a
single character that reads correct and silently breaks a guard. Plus an **inverted comment**:
`CHECK(age IS NULL OR age > 0), --ensures age is either NULL or not nonnegative`. The constraint
is right, the prose says the opposite — and a wiki would naturally promote the prose.

## 2026-07-16 — pull phase complete: final corpus + integrity audit

**95 snapshots** (16 exam containers, 4 course indexes, 75 concept pages), **124 assets**, 19MB.

| course | what it is | md | assets |
|---|---|---|---|
| `230-probability` | calculus-based intro probability | 12 | 14 |
| `230-semiconductors` | semiconductor devices | 16 | 7 |
| `270` | waves & transmission lines | 16 | 1 |
| `280` | signals & systems | 11 | 2 |
| `316` | database systems | 13 | 34 |
| `350` | digital logic & architecture | 16 | 29 |
| `353` | differential equations | 7 | 37 |
| `misc` | career hub, roudy notes | 4 | 0 |

Verified clean: all 95 carry `fetched:`; zero broken image links; zero orphaned assets; zero
live S3 URLs; zero unconverted `underline="true"`; 361 `<u>` tags across 23 files.

**Ten frontmatter-only stubs** — real holes in Dave's notes, not pull failures:
`230-probability/course__normal-approx-to-binomial` (title promises a normal approximation the
page never gives), `course__random-variable-transformation`, `230-semiconductors/final___exam`,
`280/course__nyquist`, `280/mid-1___exam`, `280/mid-2___exam`, `353/course__11-17-review`,
`misc/c___index`, `misc/c__janet`, `misc/roudy-notes` (last three are small-but-real, not empty).

**One defect found by the audit: every `fetched:` date is wrong** — all 95 say `2026-07-15`; the
pull ran 07-16. My hardcoded constant, propagated by obedient agents. Immaterial against a 90-day
staleness threshold, but it is a knowingly-false provenance field in a vault whose entire claim is
trustworthy provenance. **Blocked on a real schema gap**: the raw/ invariant doesn't distinguish
Dave's content (must never be touched) from our frontmatter (generated, correctable). Proposed
amendment + fix in [[contradictions]]; **not acting unilaterally on an invariant I wrote.**

**`raw/` is now believed complete for class notes.** Not pulled, deliberately: the `todo`
database (137 template stubs), `216`/`104` (no content), `hw-cnn-accelerator` (~22 pages,
reserved for its own graph).

`wiki/` still holds only this log, the ledger, and an empty `_index`. **No concept page exists
yet — correct.** The ledger moved substantially in all four waves; ingesting before it settled
would have baked in three of my own wrong conclusions.

## 2026-07-16 — two blocking rulings resolved; schema updated

Dave ruled on both items that were blocking `/ingest`:

1. **`fetched:` invariant amendment, approved.** `CLAUDE.md`'s raw/ invariant now
   distinguishes snapshot **body** (immutable, no exception, ever) from **frontmatter**
   (machine-generated provenance, correctable when demonstrably wrong, correction logged
   here). Applied immediately: all 95 `fetched: 2026-07-15` → `2026-07-16`, scripted with
   `sed`, verified 0 remaining wrong / 95 correct. See [[contradictions]].

2. **Error-handling policy for promotion, set.** When `/ingest` promotes material from a
   source with a known error: state the correct math/logic in the concept page, cite Dave's
   source anyway (the citation names the topic's origin, not a correctness claim), and
   explicitly flag the divergence next to the citation — not buried only in this ledger.
   Codified in `CLAUDE.md` under the promotion rule.

Also added to `CLAUDE.md`: a **"Lessons from the first pull"** section, consolidating the
pull-phase's operational findings into standing guidance — don't infer page contents from
titles, alias blocks are unresolvable via this MCP, underline is frequently semantic, tracker
metadata reflects intent not content, course material has two shapes, and the
arithmetic-right/formula-wrong error pattern. These were previously scattered across
[[contradictions]] entries; now they're load-bearing schema, not just history.

`wiki/_index.md` corrected — no longer claims `raw/` is empty.

**`/ingest` is now unblocked.** Nothing left standing between here and the first real
synthesis pass.

`wiki/` remains unwritten apart from this log and the ledger. No ingest yet — correct, given
how much the ledger has moved in one wave.

## 2026-07-16/17 — three deliverables: notion-puller agent, daily lint, Drive pull

Three items implemented in response to Dave's request to set up recurring workflows and pull
in a second raw source.

**`.claude/agents/notion-puller.md` created.** Consolidates every operational lesson from the
Notion pull wave (verbatim mirroring, underline-as-`<u>` always, image-download-timing,
alias-blocks-unresolvable, don't-infer-from-titles) into a reusable subagent definition. Future
Notion syncs invoke it by name instead of the instructions being hand-rewritten each time.

**Daily `/lint` scheduled.** `brainclaude-daily-lint`, 08:13 AM local, self-contained prompt
(doesn't depend on any conversation existing). Correctly expected to report "nothing to check"
until `/ingest` populates `wiki/`.

**Obsidian graph was empty — root cause found and it's not a vault problem.**
`~/Library/Application Support/obsidian/obsidian.json` had the vault registered at
`/Users/dzheng/Documents/brainclaude/brainclaude` — a doubled, nonexistent path. Obsidian was
never looking at the real vault. Fix is on Dave's side (repoint the vault via the app's
switcher); nothing wrong with the 103 files sitting untouched at the correct path.

**Google Drive pulled: 16 files, `raw/drive/`, light touch per Dave's instruction.** Course
folders in Drive (`230`, `280`, `316`, `353`) are an empty auto-generated scaffold — same
shape as Notion's `todo` database, verified empty three levels deep, not worth recursing
further. Real content was scattered as standalone files, found via `list_recent_files` and a
keyword `search_files` pass.

Pulled: 4 files under `316` (3 HW prompts + schedule, confirms **CompSci 316, Duke**), 3 under
`270` (two genuine lab reports + one two-author lab whose sections are suspiciously
near-identical, flagged not judged), 3 under `280` (lab handout + Dave's discussion answers +
his full report, confirms **ECE 280, Duke** via an explicit Community Standard citation), 1
under `353` (a practice midterm confirming **Math 353** — not ECE), 4 under `350` (Connect 4
technical report + its proposal + a superseded poker proposal + the course's own project
assignment, confirming **ECE/CS 350** cross-listing), 1 tentative under `230-semiconductors`
(a single CMOS-logic slide fragment, filed provisionally — see [[contradictions]]).

**Headline finding: Dave has two separate hardware/FPGA projects.** ECE 350's Connect 4 (with
a partner, custom pipelined CPU + sensors + VGA) is completely distinct from
`hw-cnn-accelerator` (solo, systolic-array GEMM/MNIST). Recorded explicitly in `CLAUDE.md` so
neither future graph conflates them.

**Four confirmed department codes**, from Dave's own file names/document headers — stronger
evidence than anything found in the Notion pull: `316`=CompSci 316 Duke, `280`=ECE 280 Duke,
`353`=Math 353 (not ECE), `350`=ECE/CS 350. `CLAUDE.md` updated. `230-probability` and `270`
remain unconfirmed; not inventing codes for them.

**Self-correction during this pull, worth recording as process, not just result:** an early
version of `raw/drive/353/practice-midterm-1.md` took genuinely garbled OCR text (problem 9
especially — two lines interleaved word-by-word) and silently reconstructed it into confident,
readable math, then mislabeled the result "verbatim." That's exactly the failure this vault's
provenance rule exists to prevent — a guess dressed as fact, with a citation that would have
made it look authoritative. Caught and fixed in the same turn: the file now shows the actual
raw extraction alongside an explicitly-labeled, explicitly-uncertain reading. Two other tool
limitations (thin extraction on `270/lab-4.md` and the `230` CMOS fragment) were flagged as
tool limitations rather than mirrored as if they were the source's true, complete content.

`wiki/` still holds no concept pages. `/ingest` remains the next real step whenever Dave wants
it.

## 2026-07-18 — daily `/lint` run

`wiki/` still holds no concept, entity, source, or synthesis pages — `/ingest` hasn't run
yet. All content-dependent checks (contradictions between wiki pages, orphans, uncited
claims, broken source-card provenance) have nothing to check. Not a failure; expected until
`/ingest`.

**Stale-snapshot check ran anyway** (applies to `raw/` regardless of wiki state): all 95
`raw/notion/` snapshots carry `fetched: 2026-07-16`; all 16 `raw/drive/` files carry fetched
dates from the same pull. Newest is 2 days old, oldest well under the 90-day threshold.
Nothing stale.

**Clean run. No findings.**

---

## 2026-07-17 — scope-up: domains + project-pointer model

Dave decided to bring his other `~/Documents` work into the brain. Established the architecture
before pulling content.

**Two kinds of things, opposite treatment (schema change in CLAUDE.md):**
- **Code/hardware projects are indexed, not ingested.** The named repos total ~3.5 GB / 100k+
  files (mostly node_modules, build output, venvs). The vault never copies repo source into
  `raw/`. Each project gets one pointer card in `wiki/entities/projects/` citing the repo's own
  docs by path. New schema sections: "Domains" and "Projects — indexed, not ingested."
- **Documents** (uni coursework, career PDFs) still flow through `raw/ → wiki/` normally. Not
  yet pulled.

**Domains introduced:** education / projects / career / personal, as a `domain:` frontmatter
field + `_index.md` view — NOT parallel folder trees (avoids recreating the course-code bucket
ambiguity). Global `~/.claude/CLAUDE.md` pointer also created so any Claude Code session
consults the vault when Dave's coursework/projects are relevant.

**9 project pointer cards written** (`wiki/entities/projects/`): hw-cnn-accelerator, imgsic,
itm, synth, gkweb, hacknc, daily-tickers, ev-firmware, dave-zheng-pcb. Each cites the repo's
README/CLAUDE.md by path. Facts gathered by reading each repo's primary doc + git remote — not
inferred.

**Discoveries worth flagging:**
- `itm` = "Image to Music" (per its own `APP_NAME`), a React/Tone.js sibling of `imgsic` — same
  idea, two codebases. Filed as an open question (which is canonical), not a contradiction.
- `dave_zheng` KiCad PCB has a `331_`-prefixed Gerber → maybe a course PCB (ECE 331?), unconfirmed.
- `ev/` is two **team-owned** repos under `github.com/dukeelectricvehicles-25-26`, not Dave's
  personal account — Duke Electric Vehicles club firmware. Contributor, not owner.
- `gkweb` is the only **client** project (Green-Keen Consulting), vs. Dave's self-directed builds.
- `uni/` (surveyed, not pulled) resolves course-code ambiguity: the two `230`s are different
  semesters (fall 2025 vs spring 2026), corroborating the probability-vs-semiconductors split.

**Sequencing (Dave's call): structure + project pointers first (this entry), then `uni/`
academic spine, then career docs, then a full `/ingest`.** Repos stay external and untouched.

## 2026-07-17 (cont.) — three clarifications resolved + ev docs pulled

Dave answered the three open project questions:
1. **itm is a dead prototype**, older than imgsic; imgsic is the separate, live successor. Updated
   [[itm]] (status: dead), removed the open question from [[_index]].
2. **dave_zheng PCB is probably a [[230-semiconductors]] lab** (Dave, tentative — "not sure,
   probably"). Linked as probable, not asserted; the `331_` Gerber prefix stays unexplained.
3. **ev knowledge pulled into the vault.** Because the DEV firmware repo is team-owned (external,
   Dave could lose access), snapshotted its three team-authored docs into `raw/repos/ev-firmware/`
   — README.md, AGENTS.md, docs/canlibrary.md — verbatim, docs-only, never code, per schema. This
   is the first use of `raw/repos/` and the `source: git_repo` snapshot type. The substantive
   knowledge is the CANbus shared-state architecture (`g_vehicle` global, `DevBoard` enum, per-board
   write-your-own-signals discipline, ESP32/Teensy timer setup) — flagged in [[ev-firmware]] as a
   reusable-pattern candidate for concept promotion at `/ingest`.

Manifest deliberately NOT hand-edited — it's `/ingest`-maintained and empty for all 114 raw files
(no ingest has run yet); adding only these three would be inconsistent and violate its own note.

## 2026-07-17 (cont.) — uni/ academic spine built (spine + selective docs)

Dave chose "spine + selective docs" for the `uni/` pull, and "index event, exclude docs" for
sensitive personal/financial material. Executed.

**The archive:** `uni/` is ~2,900 real files (the 33k count was stray `.venv`/site-packages).
Mapped the full academic history by semester. NOT ingested wholesale — 540 PDFs stay referenced
by path, not copied.

**Spine written:**
- [[academic-timeline]] (`wiki/synthesis/`) — the education backbone: every course by semester,
  freshman fall 2024 → junior fall 2026 (Yonsei study abroad), plus summer 2025 research.
- 18 course entity cards (`wiki/entities/courses/`): cs-201, egr-101, ethics-189, math-218,
  writing-101 (F24); ece-110, ece-250, egr-102, math-219 (S25); univ-104, 230-probability, 280,
  316, 353 (F25); 216, 230-semiconductors, 270, 350 (S26). Each cites the `uni/` folder structure.
  Department codes stated only where derivable; 270 and 216 flagged as unconfirmed, not guessed.

**Selective docs (real knowledge, read + source-carded):**
- [[sources/uni-flood-modeling]] — the Data+ 2025 "Automating Flood Modeling" poster (Will Lin,
  Keyan Miao, Dave; Nicholas Institute). HEC-RAS batch automation via synthetic scenario generation
  (Beta-dist fitting of friction/infiltration/inflow, NOAA Atlas 14 precip), NetCDF→GeoTIFF→Folium
  pipeline. Dave's first research. New [[data-plus]] entity created.
- [[sources/uni-350-cheat-sheets]] — the two ECE/CS 350 midterm cheat sheets. Handwritten scans;
  OCR of formulas is unreliable, so the card records *topic coverage* only (K-maps, Quine-McCluskey,
  FSM minimization, CMOS PUN/PDN, Hamming codes, pipeline hazards) and explicitly refuses to assert
  transcribed formulas — a deliberate guard against laundering garbled OCR (the same failure caught
  earlier on the 353 practice midterm). High value as a concept map for `/ingest`.

**Resolved:** the two `230`s are different *semesters* (F25 probability vs S26 semiconductors),
and `uni/spring 2026/230/` containing `FinalExam-Template-ECE230L.pdf` **confirms** the previously
tentative `230-semiconductors` = ECE 230L link — updated in [[contradictions]].

**Excluded per Dave (privacy):** `fall 2026/study abroad - duke/` and `css/2026/` hold a SoFi
statement, personal-info consent forms, and CSS Profile financial-aid docs. Recorded study-abroad
as a timeline fact only; **no sensitive/PII/financial document copied into the vault.**

**Course IDs newly established from `uni/`:** 104 = UNIV 104 (Art-Science Survey seminar);
CS 201 = data structures (Java); Math 218 = linear algebra; ECE 250 has C programming (comp
systems/arch, inferred); EGR 102 = embedded design (Arduino LoRa GPS/IMU). Dave's high school
appears as Diamond Bar HS (from a certificate); the "chuzel hs" folder meaning is unresolved.

## 2026-07-17 (cont.) — course-code fixes + career domain pulled

**Course codes confirmed by Dave:** 216 = **CINE 216 (Cinematic Authorship)**; 270 = **ECE 270
(Fields and Waves)**. Updated both course cards, the [[academic-timeline]], and [[CLAUDE]]. Only
`230-probability` now lacks a confirmed department code. Also **faded the high-school folder** per
Dave — removed the `chuzel hs` / Diamond Bar HS note from the timeline (not tracked).

**Career domain (`domain: career`) built** from `resume drafting/` + `cover letters/`, with the
same privacy rule as the uni study-abroad docs — sensitive material excluded, facts recorded:
- [[professional-profile]] (`wiki/synthesis/`) — synthesized from the current résumé (2026-01-20)
  and the Lockheed cover letter (2025-10-02). Phone + home address deliberately omitted (PII).
- New entities: [[jones-seel-lab]] (embedded/IoT flood-mapping firmware, Aug 2024–present),
  [[catalyst-tech-society]] (Professional Chair), [[rtx-internship]] (RTX/Raytheon intern w/ housing,
  ~summer 2026), and the [[gohelpme]] project (1st place CUHackIt, Mar 2025 — distinct from
  [[hacknc]]/Moneta).

**The résumé is a keystone — it wired the graph together:** "Data Engineer Intern (Pratt)" = the
[[data-plus]] flood work; "Mini-Amazon" = the [[316]] course project; "Duke Electric Vehicles" =
[[ev-firmware]]; Jones Seel Lab GPS/IMU firmware overlaps [[egr-102]]. One benign framing
difference noted, not filed as a contradiction: résumé says Latin Hypercube sampling, the research
poster says Beta-distribution fitting (same project, different emphasis).

**Excluded per privacy policy (NOT copied into the git repo):** Western Digital offer letter
(`job/WD Offers`), the RTX/Cartus relocation + lump-sum financials, the signed apartment lease +
leasing application + insurance (`job/apt/`), and the **Sterling background-check report**
(`job/sterling/`). The recruiting *facts* (Lockheed application, WD offer, RTX internship) are
recorded in [[professional-profile]]; the documents are not. `job/` was never read except by
filename for these facts — the sensitive PDFs were not opened.

## 2026-07-17 — /ingest run, batch 1 of 9: 316 (databases)

First real ingest. Worklist: 114 markdown sources (95 notion + 16 drive + 3 repos), 0 in the
manifest. Batching **by course** (aligns with the class-hub goal); assets (124 PNGs) are treated
as attachments to their parent source card, not read-and-promoted individually.

**316 batch — 17 files → 17 source cards + 6 concepts.** Manifest now tracks these 17.
- Concepts promoted: [[relational-algebra]], [[functional-dependencies]], [[database-normalization]],
  [[entity-relationship-model]], [[database-transactions]], [[sql]].
- Promotions **declined** (kept as source cards, flagged as candidates): fixed-point recursion
  (WITH RECURSIVE) and semi-structured data / XML-DTD-XPath-XQuery. When in doubt, don't promote.
- [[316]] course card rebuilt as the **class hub** — links every concept + all 17 source cards,
  so from the course you reach all its boards/docs. This is the class-centric view Dave wanted,
  built in wiki/ (not by moving raw files).
- **Dave's error filed** ([[contradictions]]): the relational-algebra monotonicity classification
  swaps union and difference (union is monotone in both args; difference is non-monotone in S).
  Stated correctly in [[relational-algebra]] with the divergence flagged inline; raw untouched.

Batches remaining (by course): 350, 270, 353, 230-semiconductors, 280, 230-probability, misc,
repos/ev. ~97 files to go.

## 2026-07-17 — /ingest batches 2–9: lightweight cataloging pass

Per Dave: don't re-read every file (token burn); we already know each file's class from the folder
structure. So instead of deep concept-extraction per course, ran a **cataloging pass** — build a
source card for every remaining raw file from its **frontmatter only** (title + provenance), and
wire each course card into a hub. No bodies re-read.

- **97 new source cards** generated (manifest now covers all 114 raw files). Every card is marked
  `catalog_level: true` and states honestly that the body was not re-read — provenance anchor, not a
  content summary. Naming: `<src>-<course>-<slug>`.
- **8 course/entity cards turned into hubs** (230-probability, 230-semiconductors, 270, 280, 350, 353
  got "Sources (class boards & docs)" sections grouped by exam; [[ev-firmware]] and [[316]] already
  had theirs). From any class you now reach all its Notion boards + Drive docs — the class-centric
  view, built by linking in wiki/, no raw files moved.
- **Concepts:** only 316 has promoted concepts (the earlier deep pass). All other courses are
  catalogued but not concept-extracted — a deeper pass can promote any course's concepts on request
  without re-pulling (the raw is already here). Existing gap-marker links ([[fsm-state-minimization]],
  [[carrier-transport]], [[mosfet-structure-and-energy-band-diagrams]]) remain as markers.
- **misc/ (4 files)** catalogued but flagged: not class material — `janet`, `technical-interview`,
  `roudy-notes`, an index. Domain defaulted to education by the script; needs reassignment to
  career/personal. Left for Dave.

Prior contradiction/error notes from the original pull (280 convolution errors, 270 garbled velocity
formula, 353 OCR) remain in [[contradictions]] as OPEN — they were flagged by the reading agents at
pull time and still apply; this cataloging pass did not re-verify them.

## 2026-07-17 — Goal A, deep-ingest 1: 350 (digital systems)

Started "Goal A" (make the brain usable in projects) by deep-ingesting the highest-leverage course:
350 feeds both hardware projects and is where most gap-marker links pointed. Read the 350 Notion
concept bodies (FSM cluster, arithmetic, Booth's, CMOS, Quine-McCluskey, truth tables) — the
expected token cost of a deep pass, scoped to concept-bearing pages only (skipped nav + verilog +
project docs already seen).

**7 concepts promoted:**
- [[finite-state-machines]], [[fsm-state-minimization]] (resolves the most-referenced gap-marker
  link — cited from [[hw-cnn-accelerator]], [[ece-350-connect4]], and elsewhere),
- [[boolean-algebra]], [[twos-complement-arithmetic]], [[binary-multiplication]] (Booth's),
  [[cmos-logic]] (shares PUN/PDN with [[230-semiconductors]]), [[pipelining-and-hazards]].

These wire directly into the projects: Booth's + two's-complement → the MAC datapath of
[[hw-cnn-accelerator]]; FSM + pipelining → the [[ece-350-connect4]] pipelined CPU; CMOS bridges to
the ECE 230L device-physics side.

**Bookkeeping:** 11 deep-read 350 source cards upgraded from catalog-level → promoted (dropped the
`catalog_level` flag, added Promotes links, manifest `derived` now lists the concepts). [[350]]
course card gained a Concepts hub section. Declined (candidates, left as source cards): Hamming
codes and combinational building blocks (mux/demux/encoders); Verilog tooling is course-specific.

Vault now has 13 concepts (6 from 316 + 7 from 350). Next Goal-A steps: /query test, then wire a
project's own CLAUDE.md at these concepts.

---

## 2026-07-18 — deep-ingest 230-semiconductors (ECE 230L)

Deep pass over the device-physics course, reading the 12 concept-bearing Notion bodies (mid-1
foundations + mid-2 devices). Continues the "do all the courses" sweep after 316 and 350; started
here because its CMOS/MOSFET material connects to the already-promoted [[cmos-logic]] and the
hardware theme.

**6 concepts promoted:**
- [[semiconductor-carrier-statistics]] — intrinsic/extrinsic doping, law of mass action, charge
  neutrality, Fermi-level positioning (merges "the semiconductor in equilibrium" + "semiconductor
  fundamentals and energy bands").
- [[carrier-transport]] — drift, diffusion, mobility, conductivity/resistivity, Einstein relation,
  diffusion length (resolves a long-standing gap-marker link; merges the mid-1 and mid-2 transport
  pages).
- [[pn-junction]] — depletion region, built-in voltage, forward/reverse bias, ideal diode equation,
  quasi-Fermi levels.
- [[mos-capacitor]] — accumulation/depletion/inversion, surface potential, C–V curve, threshold
  voltage, flat-band.
- [[mosfet-structure-and-energy-band-diagrams]] — NMOS/PMOS as switch, transconductance/subthreshold
  swing/cutoff frequency, the two cutlines (resolves another gap-marker link).
- [[electronic-band-structure]] — E–k diagrams, effective mass as curvature, density of states,
  direct vs. indirect gap.

These wire the device-physics substrate under the digital stack: [[mos-capacitor]] +
[[mosfet-structure-and-energy-band-diagrams]] are the transistor switches that [[cmos-logic]] (350)
composes into gates, which in turn underlie [[hw-cnn-accelerator]] and [[ece-350-connect4]].

**Bookkeeping:** 12 deep-read 230-semi source cards' manifest `derived` now list their concepts and
dropped `catalog_level`. [[230-semiconductors]] course card gained a Concepts hub section. **Fixed a
broken citation slug:** the course card and [[cmos-logic]] both cited `sources/drive-230-semi-cmos-template`,
which does not exist — the real card is `sources/drive-230-semiconductors-final-exam-template-cmos-logic`.
Declined (candidates, left as source cards): crystal structure & Miller indices, and the
infinite-potential-well quantum mechanics — foundational physics, not device concepts.

Minor source error noted inline in [[carrier-transport]] (a "$120$" for a stated "$1200$" mobility;
worked result is correct) — consistent with the known pattern, not filed as a contradiction.

Vault now has 19 concepts (6 from 316 + 7 from 350 + 6 from 230-semiconductors). Remaining courses
to deep-ingest: 270, 353, 280, 230-probability.

---

## 2026-07-18 — deep-ingest 230-probability

Deep pass over the fall-2025 probability/statistics course, reading the 8 concept-bearing Notion
bodies (course-level + mid-2). Second of the two 230s.

**6 concepts promoted:**
- [[expectation-and-variance]] — E[X] (discrete/continuous), linearity, indicator variables,
  tail-sum formula, variance, SD, standardization.
- [[common-discrete-distributions]] — binomial, geometric (both conventions), negative binomial
  (four variants), with the hypergeometric relation.
- [[poisson-distribution]] — rare-event counts, the mean = variance signature, binomial and normal
  limits.
- [[normal-distribution]] — Gaussian, standard-normal CDF $\Phi$, normal approximation to the
  binomial with continuity correction and the sampling-without-replacement correction factor.
- [[law-of-large-numbers-and-clt]] — sample-mean convergence (LLN) and CLT.
- [[confidence-intervals]] — interval estimation from a sample proportion via $\Phi$.

**Resolved a real source-vs-source conflict in the concept layer.** The long-standing OPEN conflict
(two of Dave's own pages state LLN and CLT differently, each right where the other is wrong) is now
implemented as "link, don't merge" in [[law-of-large-numbers-and-clt]]: LLN cites the exam page (has
the sample-mean bar), CLT cites the course page (consistent SD), and each source's error is flagged
inline. Contradiction entry updated with a pointer; left OPEN only for Dave to confirm the
SD-vs-variance normal-parameterization convention.

**Bookkeeping:** 8 deep-read 230-probability source cards' manifest `derived` now list their concepts
and dropped `catalog_level`. [[230-probability]] course card gained a Concepts hub section. Declined:
the `random-variable-transformation` and `normal-approx-to-binomial` course pages are stubs (already
noted in [[contradictions]]); mid-1's combinatorics error kept as a flagged source card, not promoted.

Vault now has 25 concepts (6 × 316, 7 × 350, 6 × 230-semiconductors, 6 × 230-probability). Remaining
courses to deep-ingest: 270, 353, 280.
