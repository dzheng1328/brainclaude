# Log

Append-only. Never rewrite prior entries. Holds the current month only — completed past
months are rotated out verbatim to `wiki/log-archive/YYYY-MM.md` by `scripts/log-rotate.sh`
(run automatically from `/ingest`'s finalize step).

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

---

## 2026-07-18 — deep-ingest 270 (ECE 270, Fields & Waves)

Deep pass over the fields-and-waves course, reading the 13 concept-bearing Notion bodies (mid-1
transmission lines, mid-2 EM waves, final acoustics + quantum). The richest course so far.

**8 concepts promoted:**
- [[transmission-line-theory]] — $Z_0=\sqrt{L/C}$, $v_p$, phasor/time-domain wave expressions,
  critical length, reflection coefficient, the input-impedance master equation, quarter/half-wave
  transforms, stub reactances (merges 4 mid-1 pages).
- [[bounce-diagrams-and-transients]] — step injection, source/load reflections, steady state,
  time-domain reflectometry.
- [[impedance-matching]] — single shunt-stub match analytically and on the Smith chart, quarter-wave
  transformer.
- [[electromagnetic-plane-waves]] — E/H fields, intrinsic impedance $\eta$, polarization, Poynting
  power density, inverse-square law.
- [[wave-reflection-at-boundaries]] — normal-incidence $\Gamma$/$\tau$, $|\Gamma|^2$ energy split,
  AR coatings and radomes.
- [[waves-in-lossy-media]] — complex permittivity, loss tangent, attenuation constant, skin depth,
  nepers/dB.
- [[oblique-incidence-and-antennas]] — parallel/perp reflection, Brewster angle, Snell's law, dipole
  radiation, efficiency/gain/directivity, the Friis equation (merges the two oblique-incidence pages).
- [[wave-impedance-analogy]] — **the course's unifying idea**: transmission lines, EM waves, sound,
  and quantum particles all obey $\Gamma=(Z_2-Z_1)/(Z_2+Z_1)$ with $|\Gamma|^2$ reflected power. Folds
  the acoustics and quantum finals in as instances rather than thin standalone pages, and links out to
  [[electronic-band-structure]] ([[230-semiconductors]]) via de Broglie / infinite-well / tunneling.

**Resolved the 270 radome source error in the concept layer.** [[wave-reflection-at-boundaries]]
states the correct $v=c/\sqrt{\epsilon_r}$, cites the source, and flags the garbled-formula /
correct-answer divergence inline (the "promote understanding, not transcription" rule). Contradiction
entry updated; verified at ingest as the pull agent predicted.

**Bookkeeping:** 13 deep-read 270 source cards' manifest `derived` now list their concepts and dropped
`catalog_level`. [[270]] course card gained a Concepts hub section. Drive lab reports (`raw/drive/270/`)
left as source cards, not promoted.

Vault now has 33 concepts (6×316, 7×350, 6×230-semi, 6×230-prob, 8×270). Remaining courses to
deep-ingest: 353, 280.

---

## 2026-07-18 — deep-ingest 353 (Math 353, Diff Eq & Linear Algebra)

Deep pass over the differential-equations course. This course carries the corpus's densest cluster of
flagged source errors, so the promotion decisions were as much about what to *withhold* as what to
promote — verified each of the four OPEN 353 flags in [[contradictions]] by reading the bodies.

**3 concepts promoted (from the clean, verified-correct material):**
- [[laplace-transform]] — improper-integral definition, transform table, differentiation property,
  solving ODEs by partial fractions, unit-step/time-shift, convolution, Dirac delta. (Malformed
  $\mathcal{L}\{\cos t\}$ and the skipped sifting property not reproduced.)
- [[fourier-series]] — period-$2\pi$ and general period-$2L$ coefficients, even/odd symmetry, midpoint
  convergence at jumps. The source's master formula drops the $\sin$ from the $b_n$ term; corrected and
  flagged inline.
- [[linear-systems-eigenvalue-method]] — $\mathbf{x}'=A\mathbf{x}$ via eigenvalues (distinct real,
  complex, defective/generalized), Wronskian test, two-tank worked problem, and the *correct* matrix
  variation-of-parameters ($\mathbf{x}_p=\Phi\int\Phi^{-1}\mathbf{f}$).

**Withheld by the "promote understanding, not transcription" rule:**
- **variation-of-parameters** (scalar) — the method is executed incorrectly ($y_1$/$y_2$ swapped
  relative to its own theorem; normalized then used un-normalized $f$). **Blocked entirely**, no concept,
  left catalog-level in the manifest.
- **Two-point BVP eigenvalue problem** — operator-sign errors ($\mathcal{L}y=y''$, $=-\lambda y$) and the
  $\lambda>0$ case (the $\lambda_n=(n\pi/L)^2$, $\sin(n\pi x/L)$ payoff) is simply absent. Not promoted;
  the result is referenced only as a gap-marker in [[fourier-series]], never asserted with this citation
  (provenance discipline — can't cite a source for something it doesn't contain).

Contradiction entries updated with the ingest decisions. [[353]] course card gained a Concepts hub
section noting the withheld material.

Vault now has 36 concepts (6×316, 7×350, 6×230-semi, 6×230-prob, 8×270, 3×353). Remaining: 280
(signals & systems) — the last course, and it carries the 280 convolution error-note to resolve.

---

## 2026-07-18 — deep-ingest 280 (ECE 280, Signals & Systems) — coursework sweep complete

Deep pass over the last course. Read all clean 280 course bodies; the two flagged trouble spots were
verified and handled as the ledger recommended.

**3 concepts promoted:**
- [[lti-systems-and-convolution]] — impulse response, $y=x*h$, causality, BIBO stability, sifting /
  commutativity / associativity, flip-and-slide, worked step response. Promoted from the correct
  `course__lti-convolution` page.
- [[fourier-series-signals]] — Dirichlet conditions, complex-exponential harmonic decomposition,
  reading $X[k]$ (fundamental frequency as GCD; pulse-train coefficients).
- [[fourier-transform-and-filtering]] — rect↔sinc pairs, graphical time↔freq with duality, the
  convolution theorem ($\mathcal{F}\{x*h\}=X\cdot H$), ideal LTI filters.

**Synthesis page created:** [[convolution-and-transforms]] — convolution-in-time = multiplication-in-
transform-domain, the one idea shared by [[laplace-transform]] (353) and [[fourier-transform-and-filtering]]
(280). Earned by a genuine cross-course link, not auto-generated. Linked into `_index.md`.

**Withheld / gaps (verified, per standing rule):**
- `mid-1__chat-review` — **not promoted at all** (two independent convolution errors: $r*r$ stated as
  $\tfrac12 t^2$ not $t^3/6$, plus a garbled distributive identity). Convolution came from the correct
  course page instead. Noted inline in the concept and in [[contradictions]].
- **Nyquist / sampling** — `course__nyquist` is blank upstream; a real hole in Dave's notes, stated
  explicitly in [[fourier-transform-and-filtering]] rather than papered over.

**Milestone:** all seven coursework courses (316, 350, 230-semiconductors, 230-probability, 270, 353,
280) are now deep-ingested. **39 concepts** total (6+7+6+6+8+3+3) plus 3 synthesis pages. The remaining
catalog-level source cards are labs, exams, and non-course material — provenance anchors by design, not
pending work. Fourier now has three lenses in the graph: [[fourier-series]] (353, ODE/BVP),
[[fourier-series-signals]] + [[fourier-transform-and-filtering]] (280, signals/filters).

---

## 2026-07-18 — /lint health check (report only, no auto-fix)

First full lint after the coursework deep-ingest sweep. Scope: entire vault (39 concepts, 116 source
cards, 32 entities, 4 synthesis). **Findings, by severity:**

**Broken provenance (2):**
1. `wiki/entities/courses/350.md:15` cites `^[[sources/drive-350-assignment]]` — no such card. Correct
   slug: `drive-350-final-project-assignment`. (Same bug class as the 230-semi slug fixed 2026-07-18.)
2. `wiki/entities/projects/hw-cnn-accelerator.md:23` cites `^[[sources/notion-hw-cnn-accelerator]]` —
   no such card, and no raw snapshot of the Notion project page exists. The 2026-07-05 GEMM/MLP reframe
   claim is effectively uncited. Fix: snapshot the Notion project page into `raw/` (as done for
   ev-firmware docs), or re-cite.

**Missing referenced page (1):**
3. `[[ece-350-connect4]]` is referenced by 5 pages (`350`, `academic-timeline`,
   `coursework-behind-hw-cnn-accelerator`, `dave-zheng-pcb`, `ev-firmware`) but has no card. It is a
   distinct, substantial hardware project per [[CLAUDE]]. Should get a pointer card in
   `wiki/entities/projects/`.

**Broken internal link (1):**
4. `[[ev]]` used in `sources/repos-ev-readme.md:17`, `repos-ev-agents.md:17`, `repos-ev-canlibrary.md:17`
   — resolves to nothing; the project card is `ev-firmware`. Should be `[[ev-firmware]]`.

**Uncited claims:** none beyond the two dangling citations above — every concept carries source
citations; cross-course "same idea as X" sentences are wikilink navigation, not uncited assertions.

**Contradictions:** no new ones. Existing OPEN ledger items are handled/awaiting-Dave by design (LLN
convention resolved, variation-of-parameters blocked, Nyquist hole documented).

**Stale snapshots:** none — all 95 `raw/notion/` files fetched 2026-07-15/16, within 90 days.

**Orphans:** none — every concept/entity/synthesis page has an inbound link.

**Checked-and-clean (not findings, recorded so they aren't re-investigated):** citations to the `uni/`
external archive (PDFs), repo-doc citations (`README.md`, `CLAUDE.md`, `App.tsx`, `canlibrary.md`,
etc.), the `[[CLAUDE]]` schema-file convention, and `[[230]]` disambiguation are all intentional
external/file references per the project schema, not broken wiki links.

Net: vault is in good health. 4 concrete fixes queued for Dave's decision (2 provenance, 1 missing
project card, 1 link slug); none touch concept correctness.

---

## 2026-07-18 — wire hw-cnn-accelerator's own docs into the vault (Goal-A step 2) + lint fixes

Closed the loop the earlier /query opened: snapshotted the accelerator repo's knowledge docs and
promoted the reusable ideas, so the vault now answers questions about the project's *internals*, not
just its coursework roots.

**Repo docs snapshotted** (docs only, never code — per the projects schema, commit `abd00b2`):
- `raw/repos/hw-cnn-accelerator/decisions.md` (verbatim) → [[sources/repos-hw-cnn-decisions]]
- `raw/repos/hw-cnn-accelerator/learnings.md` (verbatim) → [[sources/repos-hw-cnn-learnings]]

**2 concepts promoted** (genuinely reusable ideas earned building the project):
- [[systolic-array-dataflow]] — output-stationary vs. weight-stationary, skewed dataflow, K/N tiling
  with the algebraic non-contamination proof ($3N-2=22>2(N-1)=14$).
- [[neural-network-quantization]] — hardware-forced symmetric per-tensor int8, requantization, argmax
  invariance (chosen so the test oracle is bit-exact integer arithmetic).
Both wire back to the 350 concepts ([[binary-multiplication]], [[twos-complement-arithmetic]],
[[pipelining-and-hazards]]) and forward into [[coursework-behind-hw-cnn-accelerator]], whose "gap
noted" section is now marked closed. Learnings (make -C / cocotb NBA-read gotchas) left as a source
card — tooling-specific, not concept-worthy.

**Lint fixes applied (from the same-day /lint report):**
1. `350.md` — broken citation `sources/drive-350-assignment` → `sources/drive-350-final-project-assignment`.
2. `hw-cnn-accelerator.md` — dangling `sources/notion-hw-cnn-accelerator` citation replaced with the
   real `sources/repos-hw-cnn-decisions` (the reframe decision is in the repo's decision log). Provenance
   finding resolved.
3. Created [[ece-350-connect4]] project card — was referenced by 5 pages with no card (lint's missing-page
   finding). Connect 4 on a 5-stage pipelined FPGA CPU, 350 final w/ Faiz Ali; distinct from the solo
   accelerator.
4. `repos-ev-*` source cards — `[[ev]]` → `[[ev-firmware]]` (broken internal link).

All four /lint findings now closed. Stale top-of-`_index` status line ("graph still unpopulated")
refreshed. Vault: 41 concepts, 118 source cards, 4 synthesis, 33 entities.

---

## 2026-07-18 — Google Drive ingest: survey + personal domain seeded

Connected the Google Drive MCP and surveyed the whole Drive (metadata only) before pulling content.

**Key reconciliation finding (so future ingests don't redo work):** ~80% of the Drive is coursework —
a nested `uni/` tree (`fall 2025`, `spring 2025`, `spring 2026`) plus root-level course docs (270 labs,
`FinalExam-Template-ECE230L`, `ECE350 Technical Report`, 350 cheat sheets, `proc-toolchain.zip`). **This
Drive is the origin of the vault's existing `drive-*` source cards**, and the courses are already
deep-ingested (41 concepts). The Drive coursework tree therefore maps onto the existing course hubs —
**do not re-mirror it**; it would burn tokens and add homework/lab artifacts as noise. The genuinely new
material is personal, plus a couple project/career docs.

**Personal domain seeded — but kept git-private (see below).** First personal-domain content was created
from a Drive doc; per Dave's decision it now lives in the gitignored `wiki/personal/` and is intentionally
not described here. (This committed log stays clean of personal specifics per the amended CLAUDE.md rule.)

**Privacy policy change (Dave, 2026-07-18):** keep personal info *in* the vault (it's a private brain) but
**never commit it**. Implemented by gitignoring `wiki/personal/` (path-based, since git can't filter on the
`domain:` tag) alongside the already-gitignored `raw/`. Credentials are the one hard exclusion — never
stored anywhere, gitignored or not; they belong in a password manager. CLAUDE.md's Domains section amended
with the full rule.

**Noise policy (Dave, 2026-07-18):** skip childhood docs (5th/6th-grade essays), loose screenshots/photos,
and duplicate file versions. Focus personal ingest on travel + study-abroad; ingest new project/career docs.

**Still queued from Drive:** the "2026 Accounting Firm Platform" spec (likely [[gkweb]]-related → project),
the `j*b` job tracker + old resume drafts (→ career). Coursework tree: reconciled as already-covered, not
re-pulled. Personal Drive material continues into `wiki/personal/`, off the record here.

Counts: 41 concepts, 119 source cards, 34 entities, 4 synthesis. Personal domain: 0 → 2 pages.

---

## 2026-07-18 — Google Drive ingest, batch 2: gkweb spec + job-search aggregate

Continuing the Drive ingest (the two items queued after the personal-domain seed).

**Ingested — [[gkweb]] (projects domain):** a 6-phase "2026 Accounting Firm Platform" technical spec
found at Drive root matches Green-Keen Consulting (an accounting firm) — snapshotted to
`raw/drive/gkweb/2026-accounting-firm-platform-spec.md`, source card added
([[sources/drive-gkweb-2026-accounting-firm-platform-spec]]), and the project card enriched with the
planned stack (Next.js 15/React 19, Shadcn+Aceternity+Magic UI, Zod server actions, WCAG 2.2/schema.org
checklist) — explicitly flagged as **roadmap/research, not confirmed as-built** (the live repo, Next.js
16, is the as-built source of truth). A near-identical duplicate Doc (1 min older, same size) was
skipped per the noise policy. Not promoted to a concept — project-scoped planning, not a generalizable
idea.

**Ingested — job search (career domain, aggregate only):** found `j*b`, a ~200-row internship
application tracker (Oct 2024–Nov 2025, targeting Summer 2026). Consistent with the "sensitive docs
excluded" precedent already in [[professional-profile]] (which excludes offer letters, relocation
docs, background-check reports), **the company-by-company list was not copied into the vault** —
only aggregate signal (rough scope ~200 companies, target industries: hardware/silicon, aerospace &
defense, quant trading, software; timeframe) was added to the existing "Recruiting trajectory"
section. Source card [[sources/drive-jb-tracker]] added with `snapshotted: false`.

**Checked and correctly skipped:** the six root-level "Dave Zheng" Google Docs (2017–2019), originally
queued as a guess ("old resume drafts") based on filename. **Read one before promoting anything** —
per [[CLAUDE]]'s own lesson ("do not infer a page's contents from its title") — and it turned out to be
a 9th-grade English essay ("How is Technology Good or Bad"), not resume material. Same noise category
Dave already flagged (5th/6th-grade essays); all six skipped, no card created.

Counts: 41 concepts (unchanged), 120 source cards (+3 vs. last commit — 2 new + duplicate check),
33 entities. Coursework tree remains reconciled, not re-pulled. Drive ingest continues on request.

---

## 2026-07-18 — Google Drive ingest, batch 3: 270 lab 8 + remaining root-level survey

Finished triaging the remaining root-level Drive items. `270 lab 1`, `270 lab 4` (+ a duplicate "Copy
of"), and `270 Optics Lab` are duplicates of already-catalogued `raw/drive/270/` files — skipped.
`lab 8` (Slides) was new; added as `raw/drive/270/lab-8.md` + [[sources/drive-270-lab-8]] and wired into
the [[270]] course card. Text extraction returned no usable content (image/diagram-heavy deck) —
logged per the unreadable-source guardrail rather than silently dropped.

**Personal domain (local only, not described further here):** one new entry added, parallel in
character to [[taiwan-seoul-trip]]. Distinguished from noise correctly — read before judging by title,
per [[CLAUDE]]'s own lesson, rather than assumed.

**Skipped as out of scope / noise:** `proc-toolchain.zip` (97MB binary archive, not text-readable via
this tool); the remaining loose screenshots/`IMG_*.jpeg` photos; generic "Untitled document/spreadsheet/
presentation" entries too small to be substantive.

Counts: 41 concepts, 121 source cards, 33 entities (committed graph). Drive survey is now essentially
exhausted for non-coursework material — remaining unexplored items are photos/screenshots/binary
archives, none of which carry ingestible knowledge.

**Also this session:** diagnosed why Obsidian required manual "reload without saving" for every vault
change — the vault sits under macOS's iCloud "Desktop & Documents Folders" sync
(`FXICloudDriveDocuments=1`), which is a known source of file-watcher lag/misses in Obsidian. Recommended
relocating the vault out of the synced path as the real fix; flagged the `.obsidian/graph.json`/`app.json`
caveat separately (those specific files need a pane reopen regardless of iCloud, since Obsidian reads
them at pane-open time, not live).

---

## 2026-07-18 — Project repo doc snapshots (gkweb, synth, imgsic) + uni/ sweep declined

Closed out the last real ingestion item: snapshotting the four remaining projects' own docs, matching
the pattern already proven for ev-firmware and hw-cnn-accelerator.

**Surveyed `uni/` first — Dave's instinct was right, more so than I gave credit for.** File-type
counts across the 9 courses with no deep concepts (fall 2024 + spring 2025) showed 143 files for
CS 201 (mostly `.java`/`.class`), 79 PDFs for Math 218, `.stl`/`.ino` project artifacts for EGR 101,
etc. — homework, lecture slides, and code, with **no equivalent of the synthesized Notion
exam-review notes** that made the 7-course sweep efficient. This isn't "repeats of Notion," it's a
worse trade: no pre-synthesized layer at all, so promoting concepts would mean reading dozens of raw
PDFs/code files for a handful of maybe-promotable ideas. **Decision: skip the `uni/` sweep entirely,
including the cheap EGR 102 peek** (Dave's call, 2026-07-18). This is not a gap to revisit casually —
it would need someone to actually sit down and write synthesized notes first (the way Notion has for
the other 7 courses) before a deep-ingest pass would be worth the tokens.

**Read `itm`'s README before snapshotting it — turned out to be generic, unedited Vite/React
boilerplate** (not even a git repo). Confirms and hardens the existing "dead, superseded by imgsic"
verdict; skipped, no snapshot.

**Snapshotted (docs only, verbatim, per the projects schema):**
- `raw/repos/gkweb/{README,CLAUDE}.md` (commit `99e0424`)
- `raw/repos/synth/README.md` (commit `303c44e`)
- `raw/repos/imgsic/{README,CLAUDE}.md` (commit `e5175b5`)

**Real finding — the gkweb Drive spec was substantially implemented.** Reading the repo's own
`CLAUDE.md` directly confirms it: the exact brand-color hex values from the earlier Drive planning
doc ([[sources/drive-gkweb-2026-accounting-firm-platform-spec]]) — `ledger-navy #101585`,
`mocha-mousse #A47864`, `copper-audit #B87333`, `champagne-gold #F7E7CE` — are literally in the
codebase, along with an Aceternity hero component and Zod-validated POST-redirect-GET forms matching
the spec's requirements. Resolves the "roadmap vs. as-built" uncertainty flagged when that spec was
first found.

**synth** enriched with a feature not previously captured: `synth_pro`'s sample loader + offline WAV
export (`sample_io.c`). **imgsic** enriched with its full architecture (uploader → api → composer →
engine), the exact Claude-vision JSON schema contract, and confirms `itm` is dead (not just
superseded) — resolving the "worth reconciling which is canonical" note from its own card.

No new concepts promoted from any of the four — all genuinely project-scoped stack/architecture
detail, consistent with the earlier gkweb-spec decision (enrich the card, don't manufacture a
concept from planning/architecture docs).

**This closes out ingestion for real.** Vault: 41 concepts, 126 source cards, 4 synthesis pages,
33 entities (committed graph). Next phase per the original roadmap is Goal B — making the vault
self-maintaining (scheduled re-sync + periodic `/lint`) — not further source-hunting.

---

## 2026-07-25 — /sync-projects run (scheduled, mechanical-only)

Checked all 7 `status: active` project pointer cards (daily-tickers, synth, ev-firmware,
gkweb, imgsic, hw-cnn-accelerator, tradefabe); all 7 `path:` targets exist on disk. Compared
every previously-snapshotted `raw/repos/<project>/` doc against its live file (frontmatter
stripped, or git commit sha where the repo is a git checkout).

**Unchanged, skipped:** ev-firmware (AGENTS.md/README.md/canlibrary.md — live mtime predates
its 2026-07-17 fetch, one stray trailing `#` in AGENTS.md is a pre-existing snapshot artifact,
not a new edit), gkweb (README.md/CLAUDE.md, commit `99e0424` matches), synth (README.md,
commit `303c44e` matches), imgsic (README.md/CLAUDE.md, commit `e5175b5` matches).
daily-tickers has no `raw/repos/` snapshot to compare (never snapshotted) and its live commit
(`35f2353`) already matches the pointer card's `last_commit` — nothing to do.

**Re-synced (real content changes):**
- **hw-cnn-accelerator** — `docs/decisions.md` and `docs/learnings.md` re-snapshotted at
  commit `8827a96` (was `abd00b2`). New content: the entire Phase 2 NoC build (skew feeder
  and sequencer FSM moved into RTL, a real operand-memory read/write port, a 2D-mesh router
  with XY routing + round-robin arbitration, registered link buffers, a working 1x2 pair and
  2x2 mesh, GO/RESULT flit packetization for compute kickoff and result readout) plus a first
  real sky130 synthesis pass quantifying that the operand-memory flop array costs ~42.5% of a
  tile's silicon area — almost as much as the 64-PE compute array itself. Two new
  `learnings.md` entries: a Verilog-parameter-vs-cocotb-testbench divergence gotcha, and a
  non-blocking-assignment reasoning note on shift-register pipeline delay. Source cards and
  `.manifest.json` updated; pointer card `last_commit` → `2026-07-20`; flagged for `/ingest`
  review (NoC router as a general design pattern, the cocotb-parameter gotcha, NBA-semantics
  reasoning) — not promoted, per this workflow's mechanical-only rule.
- **tradefabe** — all 4 docs (`README.md`, `CLAUDE.md`, `DOCTRINE.md`, `STRATEGIES.md`)
  re-snapshotted at commit `6ab7c04` (was `1591b9b`, one day old but Dave is iterating daily
  on this project). Headline finding grew from 12+ to 49+ tested strategies via a new
  **strategy factory** (`factory.py`/`factory_run.py`) that generates and doctrine-gates
  parametrized variants automatically, logging each to `generated_templates.csv` before its
  verdict. `DOCTRINE.md` gained **v1.4**: replaces the v1.3 Bonferroni correction with the
  Deflated Sharpe Ratio + Combinatorial Purged Cross-Validation as gate 1's active decision
  rule (re-running the full roster under v1.4 changed no verdicts, validated before merge).
  `CLAUDE.md` documents the paper engine moving off the Mac onto GitHub Actions (launchd
  doesn't fire while asleep) and the Python 3.14 `.pth`-hidden bug being root-caused to
  iCloud Desktop/Documents sync (fixed by relocating the venv outside the synced tree).
  `STRATEGIES.md` grew from 8 to 11 strategy families (breakout/channel, ICT/Smart-Money-
  Concepts, contribution-schedule overlays — all new candidates DEAD). Source cards and
  `.manifest.json` updated; pointer card `last_commit` → `2026-07-25`; flagged for `/ingest`
  review (DSR/CPCV as a general multiple-testing-correction concept, possibly superseding the
  Bonferroni candidate already flagged 2026-07-24; the pre-register-the-search-range pattern
  the factory uses) — not promoted.

No unregistered project directories spotted under `~/Documents` (everything with a
`CLAUDE.md`/`README.md` already has a pointer card; the rest — `job`, `cover letters`,
`resume drafting`, etc. — are non-code personal/career docs, out of scope for this workflow).
No non-active (`dead`/`shipped`/`complete`) pointer cards touched.

---

## 2026-07-24 — new project: tradefabe, plus Goal B lands (daily project sync)

Two things, prompted by the same conversation: Dave is actively building on a new project
(`tradefabe`) day-to-day and wants the vault to actually keep up with that, not just log a
one-time snapshot that goes stale.

**tradefabe indexed.** A doctrine-governed trading-strategy research lab + autonomous
paper-trading engine (paper only, no real money/credentials — hard rule stated in its own
`CLAUDE.md`). Snapshotted its 4 top-level docs (`README.md`, `CLAUDE.md`, `DOCTRINE.md`,
`STRATEGIES.md`, commit `1591b9b`) into `raw/repos/tradefabe/`, one source card each, and a
pointer card at [[tradefabe]] — same pattern as the other project repos. Headline finding
worth carrying: 12+ retail strategies tested, only diversified buy-and-hold and delta-neutral
crypto funding carry survived a pre-registered out-of-sample kill rule; a same-day doctrine
amendment (v1.3, Bonferroni correction) retroactively flipped 3 of 4 "piggyback" constructions
from ALIVE to DEAD. Not promoted to a concept this pass — flagged in the pointer card as a
candidate (the noise-floor/multiple-testing methodology is genuinely reusable beyond this
project) for a future `/ingest` or `/query` to judge, per the "when in doubt, do not promote"
rule.

**Root-caused why the daily `/lint` task looked like it stopped running.** It hadn't run
2026-07-19 through 2026-07-23 — five silent days. Cause: the vault moved from
`~/Documents/brainclaude` to `~/brainclaude` on 2026-07-18 (see the entry above), but
`brainclaude-daily-lint`'s own `SKILL.md` still hardcoded the old path three times. That
directory no longer exists at all, which lines up with the task producing no session in that
window. Fixed by repointing the three references to `~/brainclaude`. This is the same failure
shape as the [[CLAUDE]]-documented `fetched:` date bug from the first pull: an agent
faithfully executing a stale literal, not a logic error.

**Goal B (scheduled re-sync) actually implemented, not just deferred.** Added
`.claude/commands/sync-projects.md`: a **mechanical-only** re-sync — diff each `status:
active` project's on-disk docs against its `raw/repos/<project>/` snapshot, re-sync on
change, refresh only mechanical pointer-card frontmatter (status/stack/last_commit), and
*flag* (never auto-write) anything that reads as concept-worthy for a real `/ingest` pass.
Explicitly never touches `dead`/`shipped`/`complete` projects, never writes to a project's own
repo, never auto-creates a pointer card for an unregistered project directory. Wired to a new
scheduled task, `brainclaude-daily-project-sync`, running daily at 08:25 local (12 min after
`/lint`'s 08:13, so lint's own provenance checks see any doc changes this task made) — see
[[log]] entry timestamps going forward for its output.

**Why mechanical-only, not full auto-ingest:** concept promotion is a judgment call by this
vault's own rule (artifacts vs. knowledge, "when in doubt, do not promote") — automating it
daily would risk exactly the kind of unreviewed, confidently-cited synthesis the provenance
rule exists to prevent. A daily cron is fine for "did the docs change, update the facts about
that"; it is not fine for "did the docs change, therefore write a concept page."

Counts: 41 concepts, 130 source cards, 4 synthesis pages, 34 entities, 12 project pointer
cards (committed graph).

---

## 2026-07-27 — /sync-projects run (scheduled, mechanical-only)

Checked all 7 `status: active` project pointer cards (daily-tickers, synth, ev-firmware,
gkweb, imgsic, hw-cnn-accelerator, tradefabe); all 7 `path:` targets still exist on disk.
Compared every previously-snapshotted `raw/repos/<project>/` doc against its live file
(frontmatter stripped, or git commit sha where the repo is a git checkout).

**Unchanged, skipped:** ev-firmware (AGENTS.md/README.md/canlibrary.md, still commit
`c056be5`), hw-cnn-accelerator (docs/decisions.md, docs/learnings.md, still commit
`8827a96` — no change since the 2026-07-25 sync), gkweb (README.md/CLAUDE.md, commit
`99e0424` matches), imgsic (README.md/CLAUDE.md, commit `e5175b5` matches), synth
(README.md, commit `303c44e` matches), tradefabe/`README.md` (content identical despite
the repo advancing — only the other three docs changed). daily-tickers still has no
`raw/repos/` snapshot to compare (never snapshotted, out of scope for this mechanical
workflow — an initial snapshot is a judgment call, same bar as first-time `/ingest`) and
its live commit (`35f2353`) still matches the pointer card's `last_commit` — nothing to do
either way.

**Re-synced (real content changes):**
- **tradefabe** — `CLAUDE.md`, `DOCTRINE.md`, `STRATEGIES.md` re-snapshotted at commit
  `6b1a843` (was `6ab7c04`, two days old — Dave is iterating daily on this project);
  `README.md` unchanged. **Operational note, not a doc change:** the repo's real location
  moved from `~/Documents/tradefabe` to `~/tradefabe` on 2026-07-26 (iCloud sync in
  `~/Documents` was corrupting the venv and writing conflict copies of tracked files — the
  same failure mode that already forced this vault itself out of iCloud sync). A
  compatibility symlink remains at the old path, so the pointer card's `path:` still
  resolves and was left untouched (not one of this workflow's mechanical fields); a human
  may want to repoint it to the real path directly. Content changes: `CLAUDE.md` documents
  the new repo location and a standing git-workflow rule — never chain a branch delete
  after a merge in the same command, since a silently-failed `gh pr merge` still lets a
  chained delete run and closes an unmerged PR whose branch is now gone (cost three
  recoveries, #65/#80/#92). `DOCTRINE.md` gained **v1.5** (pre-registered 2026-07-28, no
  verdict computed under it yet): the multiple-testing family is now segregated by
  candidate origin (factory-generated vs. hand-picked, 121 vs. 15 of 139 all-time rows,
  recorded before any verdict), and the duty-cycle-matched noise floor becomes the default
  gate rather than opt-in. `STRATEGIES.md` gained family L (intraday/hourly, #86,
  pre-registered before any run) — all three hourly strategies DEAD, and the family's
  2023+-only data means an ALIVE verdict there would carry less weight than elsewhere in
  the roster, a limitation Dave chose to accept rather than bend doctrine to fit. Source
  cards and `.manifest.json` updated; pointer card `last_commit` → `2026-07-27`; flagged
  for `/ingest` review — origin-segregated multiple-testing correction (extends the
  existing DSR/CPCV flag, doesn't replace it), duty-cycle-matched noise floor as a default
  gate, and the branch-delete-after-merge git gotcha (generalizable beyond this repo) — not
  promoted, per this workflow's mechanical-only rule.

No unregistered project directories spotted under `~/Documents` (everything with a
`CLAUDE.md`/`README.md` already has a pointer card; the rest — `job`, `cover letters`,
`resume drafting`, app-data folders like `Adobe`/`Image-Line`/`KiCad`, etc. — are non-code
personal/app-data folders, out of scope for this workflow). No non-active
(`dead`/`shipped`/`complete`/`unknown`) pointer cards touched.

---

## 2026-07-29 — /sync-projects run (scheduled, mechanical-only)

Checked all 7 `status: active` pointer cards; all `path:` targets exist on disk. No project
doc changes since last sync (2026-07-27) — every previously-snapshotted `raw/repos/<project>/`
doc still matches its live source, and every `last_commit` already agrees with the repo.

One nuance worth recording: `~/Documents/tradefabe` (a symlink to the relocated
`~/tradefabe`) is currently checked out on `kronos-study`, an in-progress feature branch with
uncommitted edits to `STRATEGIES.md` — comparing the raw snapshot against that dirty working
tree would have falsely flagged `CLAUDE.md`/`DOCTRINE.md`/`STRATEGIES.md` as changed (the
feature branch predates `main`'s v1.5-doctrine-removal commit and diverges further with
Dave's uncommitted Kronos-study work). Compared against `main` (`6b1a843`, same commit the
existing snapshot was fetched at) instead, which matches exactly — no real drift. Future runs
of this workflow should prefer the repo's default branch over its checked-out `HEAD` when
they differ, since a dirty feature branch isn't the vault's snapshot target.

No unregistered project directories spotted under `~/Documents`. No non-active
(`dead`/`shipped`/`complete`/`unknown`) pointer cards touched. `.manifest.json` unchanged (no
re-snapshots).

---

## 2026-07-31 — /lint incremental run

Manually triggered (not the scheduled 08:13 run) to exercise the new `scripts/log-append.sh`
after merging #2 (token-cost fixes + monthly log rotation). Ran with working directory
`/Users/dzheng/brainclaude`.

**Mechanical, full-vault (cheap regardless of scope):**
- Stale snapshots: 0. Checked 95 `raw/notion/` files with `fetched:` frontmatter — all
  within 90 days (vault is 16 days old).
- Broken provenance: 0. Every manifest entry's `raw/` file exists; every manifest
  `derived` entry's wiki page exists on disk.
- Orphans: **8** source cards with no inbound `[[links]]` — `sources/repos-ev-agents`,
  `sources/repos-ev-canlibrary`, `sources/repos-ev-readme`, `sources/repos-imgsic-readme`,
  `sources/notion-misc-c-index`, `sources/notion-misc-c-janet`,
  `sources/notion-misc-c-technical-interview`, `sources/notion-misc-roudy-notes`. All are
  legitimately-manifest-tracked source cards for raw material that was never promoted to a
  concept page — consistent with "when in doubt, do not promote" (career-context Notion
  notes and project docs that may just be artifact-only, not necessarily wrong). Not
  auto-fixed; Dave decides whether any of these merit a concept page.

**Judgment checks (scoped to pages changed since last_incremental_check 2026-07-28):**
0 `wiki/` content pages (concepts/entities/sources/synthesis) changed since the last
check — only `wiki/log.md` itself and non-wiki tooling files (`CLAUDE.md`,
`.claude/commands/*.md`, `scripts/*`) changed via #2's merge. Contradictions, uncited
claims, and missing cross-refs checks had nothing new to run against; not manufacturing
findings against unchanged pages.

Clean otherwise. `.lint-state.json` `last_incremental_check` bumped to
2026-07-31T05:53:16Z; `last_full_sweep` unchanged (this was not a `--full` run).

---

## 2026-07-31 — /sync-projects run

Manually triggered (not the scheduled 08:25 run) right after merging #2, to exercise
`scripts/manifest-update.sh` and `scripts/log-append.sh` on real project docs. Checked all 7
`status: active` pointer cards (daily-tickers, ev-firmware, gkweb, hw-cnn-accelerator, imgsic,
synth, tradefabe); all `path:` targets exist on disk.

**Real doc changes, re-synced:**
- **tradefabe**: `CLAUDE.md`, `DOCTRINE.md`, `README.md`, `STRATEGIES.md` all genuinely
  changed (commit `36050ce`, was `6b1a843`/`6ab7c04`) — DOCTRINE advanced through v1.6, v1.7,
  v1.8 (2026-07-29), Family M (Kronos) went live, Alpaca paper-broker connectivity added.
  Three candidate concepts flagged on the pointer card (advisory-only kill criteria,
  benchmark-window alignment to candidate OOS start, DSR needs an explicit positive-Sharpe
  floor). `last_commit` bumped to 2026-07-31.
- **ev-firmware/AGENTS.md**: re-synced, but **not a live change** — confirmed via `git log`/
  `git diff` that the file hasn't changed since commit `c056be5` (2026-02-28) and the working
  tree is clean. The 2026-07-17 snapshot was simply missing the file's trailing two lines (a
  completeness gap in the original capture). Corrected; `commit:` stays `c056be5`. Noted on
  the pointer card under a new "Flagged for /ingest review" section (operational, not a
  concept). `README.md` and `canlibrary.md` confirmed unchanged.

**Unchanged, skipped silently:** gkweb (`CLAUDE.md`/`README.md`), hw-cnn-accelerator
(`docs/decisions.md`/`docs/learnings.md`), imgsic (`CLAUDE.md`/`README.md`), synth
(`README.md`).

**Flagged, not acted on (mechanical scope only):**
- `daily-tickers` has a live `CLAUDE.md` that has never been snapshotted into
  `raw/repos/daily-tickers/` — no baseline exists to compare against. Out of scope for this
  mechanical run (first-time snapshotting is an `/ingest`/manual-session judgment call per
  `CLAUDE.md`'s Projects section); flagging for a human or a future `/ingest` pass.
- `gkweb`'s live repo now has an `AGENTS.md` that was never snapshotted (only
  `CLAUDE.md`/`README.md` are tracked). Same reasoning — flagged, not auto-added.

No unregistered project directories spotted under `~/Documents` (cross-checked every
top-level dir with a `CLAUDE.md`/`README.md` against existing pointer cards — all already
have one). No non-active (`dead`/`shipped`/`complete`/`unknown`) pointer cards touched.

**Also fixed** (found while doing the tradefabe/ev-firmware manifest updates above):
`scripts/manifest-update.sh` was doing a full replace of a manifest entry rather than a
merge, which would silently drop the `catalog_level` flag present on 42 entries (hit in
practice on `raw/repos/ev-firmware/AGENTS.md`). Fixed to merge; added a regression test.
Filed as #4 for the record rather than a full branch/PR cycle, since it was small, already
covered by `scripts/test.sh`, and blocking this run. 26/26 tests passing.

---

## 2026-07-31 — /sync-projects run (scheduled, mechanical-only)

Checked all 7 `status: active` pointer cards (daily-tickers, ev-firmware, gkweb,
hw-cnn-accelerator, imgsic, synth, tradefabe); all `path:` targets exist on disk. Ran 12
minutes after the scheduled `/lint` run per the task's ordering.

**Real doc change, re-synced:**
- **tradefabe**: `CLAUDE.md` and `README.md` re-synced (commit `5de0ecc`, was `36050ce` from
  this morning's manual run). Both changes are the same stale-count fix in the `pytest`
  command comment ("433 tests, ~8s" → "worksteal, ~3-4s"), from a test-suite speed-up
  (#160/#162). Not concept-worthy — a doc-comment correction, not flagged. `DOCTRINE.md` and
  `STRATEGIES.md` unchanged. Pointer card `last_commit` updated to 2026-07-30 (the commit's
  own authored date, matching this vault's established convention — the prior value of
  2026-07-31 recorded this morning was off by a day).

**Unchanged, skipped silently:** ev-firmware (`README.md`/`AGENTS.md`/`docs/canlibrary.md`,
repo HEAD still `c056be5`), gkweb (`CLAUDE.md`/`README.md` — the repo's git HEAD is stale at
`99e0424` with an uncommitted local edit to `CLAUDE.md`, but that uncommitted content is
byte-identical to what's already snapshotted, so no re-sync needed), hw-cnn-accelerator
(`docs/decisions.md`/`docs/learnings.md`, repo HEAD still `8827a96`), imgsic (`README.md`/
`CLAUDE.md`, repo clean at `e5175b5`), synth (`README.md`; repo has uncommitted C-source
edits but its only tracked doc is untouched).

**Flagged, not acted on (mechanical scope only, both already flagged in prior runs):**
- `daily-tickers` still has a live `CLAUDE.md` never snapshotted into
  `raw/repos/daily-tickers/` — no baseline to diff against.
- `gkweb` still has a live `AGENTS.md` never snapshotted (only `CLAUDE.md`/`README.md`
  tracked).

No unregistered project directories spotted under `~/Documents` (every top-level dir with a
`CLAUDE.md`/`README.md` already has a pointer card). No non-active (`dead`/`shipped`/
`complete`/`unknown`) pointer cards touched.

---

## 2026-07-31 — /lint incremental run (2)

Incremental mode. 7 pages changed since the last check (2026-07-31T05:53:16Z): `tradefabe.md`,
`ev-firmware.md`, and source cards `repos-tradefabe-claude`, `repos-tradefabe-readme`,
`repos-tradefabe-doctrine`, `repos-tradefabe-strategies`, `repos-ev-agents`. Judgment checks
(contradictions, uncited claims, cross-refs) ran only against these; mechanical checks ran
full-vault as always.

**Uncited / mismatched claims (highest severity) — 3 found:**
1. `tradefabe.md:113-129` (the "2026-07-31 sync, commit `36050ce`" bullet) asserts DOCTRINE
   v1.6/v1.7/v1.8 content, Family M/Kronos going live, and Alpaca paper-broker connectivity,
   citing all four `repos-tradefabe-*` source cards — but none of those four cards actually
   contain this material. `sources/repos-tradefabe-doctrine.md` stops at v1.5;
   `sources/repos-tradefabe-strategies.md` only covers through family L; neither
   `repos-tradefabe-claude.md` nor `repos-tradefabe-readme.md` mention Alpaca. Verified this
   isn't a hallucination — the raw files themselves (`raw/repos/tradefabe/DOCTRINE.md:45+`,
   `STRATEGIES.md:369+`, `CLAUDE.md:124,223`) do contain v1.6-v1.8/Kronos/Alpaca — so the raw
   re-sync landed correctly but the source-card summaries were never rewritten to match. Fix:
   refresh the doctrine/strategies/claude/readme source-card bodies against current raw content.
2. `tradefabe.md:130-134` (final "2026-07-31 scheduled sync" bullet) has no citation at all,
   unlike the three preceding sync bullets which each end "See ^[[sources/...]]".
3. `ev-firmware.md:46-53` ("2026-07-31 sync" bullet on the AGENTS.md re-sync) has no citation,
   unlike the page's own established per-file `^[[repos/ev-firmware/X.md]]` citation style.

**Broken provenance:**
- The `uni/` local archive (Dave's ~2,900-file academic archive, cited since 2026-07-17 via
  `^[[uni/]]` in 20+ course entity pages, plus exact file paths in two source cards) **does not
  exist on disk** — confirmed absent at `/Users/dzheng/brainclaude/uni/` (no such directory;
  direct file reads for both cited PDFs fail). Concretely breaks `sources/uni-flood-modeling.md`
  and `sources/uni-350-cheat-sheets.md`. Not caught by prior runs because those only checked
  manifest-tracked (`raw_file`) entries, not `source_path`-style local-archive cards. Needs
  Dave to confirm where `uni/` currently lives (moved? disconnected drive?) — not auto-fixed.

**Contradictions:** none among the 7 in-scope pages or against the rest of the vault.

**Stale snapshots:** 0. All 130 source cards' `fetched:` dates checked full-vault (95 at
2026-07-16, 20 at 07-17, 8 at 07-18, 2 at 07-25, 5 at 07-31) — all within 90 days.

**Orphans:** 8, unchanged from the prior run (`repos-ev-agents`, `repos-ev-canlibrary`,
`repos-ev-readme`, `repos-imgsic-readme`, `notion-misc-c-index`, `notion-misc-c-janet`,
`notion-misc-c-technical-interview`, `notion-misc-roudy-notes`) — legitimate per project-doc
citation convention (project pages cite raw paths directly, not the `sources/` card).

**Missing/broken cross-refs:** `wiki/personal/china-trip-2019.md:15` and
`wiki/personal/taiwan-seoul-trip.md:16` cite `^[[sources/drive-personal-china-2019]]` /
`^[[sources/drive-personal-taiwan-seoul-itinerary]]`, but those source cards actually live at
`wiki/personal/drive-personal-*` (private-domain path rule), not under `sources/` — dangling
link, local-only (both files are gitignored, no git-remote exposure).

`.lint-state.json` `last_incremental_check` bumped to 2026-07-31T22:39:46Z; `last_full_sweep`
unchanged (not a `--full` run).
