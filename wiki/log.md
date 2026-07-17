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
