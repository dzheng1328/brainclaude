# Contradictions

Surfaced, never silently resolved. Dave resolves; the wiki records the resolution.

Distinguish **real conflict** (incompatible facts) from **supersession** (newer updates
older) from **overlap** (same ground, no conflict — not a contradiction).

---

## RESOLVED (pending Dave's confirmation) — `230` is two different courses

**Flagged because:** the Midterm Review Notes tracker has two `230 mid 1` rows and two
`230 mid 2` rows. Every other course appears in exactly one term. Initially looked like a
duplicate or a retake.

**It is neither.** The child pages make it unambiguous — `230` labels two unrelated
courses:

| | Fall 2025 (Mastered, Done!) | Spring 2026 (In Progress) |
|---|---|---|
| `230 mid 1` | probability: outcome spaces, Bayes' rule, binomial, random variables, joint/marginal distributions | semiconductor physics: crystal structure, quantum mechanics, quantum theory of solids, semiconductor in equilibrium, carrier transport |
| `230 mid 2` | expected value, normal distributions, LLN/CLT, confidence intervals, discrete distributions, poisson | semiconductor fundamentals & energy bands, carrier transport, pn junctions, MOS capacitor, MOSFET structure |

Fall 2025 `230` = a **probability/statistics** course.
Spring 2026 `230` = a **semiconductor devices** course.

Same number, different departments (e.g. `STAT 230` vs `ECE 230`) — Dave labeled both by
bare number.

**Why this mattered:** ingesting on the tracker's `Topic` field alone would have created a
single `[[230]]` entity page fusing Bayes' rule with MOSFET band diagrams, and merged two
distinct `carrier transport` lineages. Silent, and very hard to notice later.

**Resolution (Dave, 2026-07-15):** confirmed — one `230` is probability, the other is
semiconductors.

**Naming decision:** disambiguate by content, not by department code. Dave confirmed the
split but did not supply the real codes, so the vault uses `230-probability` and
`230-semiconductors`. Do **not** guess at `STAT 230` / `ECE 230` — the actual department
prefixes are unknown, and a fabricated code would be indistinguishable from a real one to
every later reader, including future ingests.

If Dave supplies real codes, rename the entity pages and update this entry. Unblocked.

**Standing rule this establishes:** the tracker's `Topic` field is an unreliable key.
Course identity comes from **content**, not from the bare number. Any future collision gets
the same treatment.

---

## OPEN — errors in Dave's own `280` source notes

Flagged by the pull agent while snapshotting `raw/notion/280/mid-1__chat-review.md`.
**Not verified independently — confirm during ingest before acting.** Per the raw/
invariant these were mirrored verbatim, not corrected.

1. **Distributive property is wrong.** Source reads `x*(h_1*h_2) = x*h_1 + x*h_2`. The left
   side should be `x*(h_1+h_2)`. As written it duplicates the associative line above it.
2. **Unbalanced paren** on the associative line: `x*(h_1*h_2)=(x*h_1)*h_2)`.
3. **Suspect problem premise.** Practice 2 #2 calls `x(t) = tu(t) - (t-2)u(t-2)` a
   "triangular pulse". It's a ramp that saturates at 2 and stays there, so its energy
   diverges. The stated answer `8/3` integrates only over `0..2` and silently drops the
   infinite tail. Premise and answer both suspect.

**Why this matters more than typos:** these are notes Dave *studies from*. If the wiki
synthesizes #1 into a concept page, the vault teaches a false identity forever, with a
citation making it look authoritative. **Do not promote convolution algebra from this
source until Dave rules on it.**

Cosmetic, mirrored as-is, no action: "unit quadrativ", "LTI properies", "usuall",
`N: y(t) = x(t=1)` (probably `x(t+1)`), `\infin` for `\infty` throughout.

**Needs Dave.**

---

## OPEN — the Midterm Review Notes database is not the whole corpus

The `Midterm Review Notes` DB was assumed to hold all class material. It does not.

There are **top-level course pages outside the database** with their own concept children:

- `280` (`282babf1-97c2-807a-ae3c-f3087d5c1458`, no ancestors) → 7 children: LTI/convolution,
  fourier series, fourier series decomp, fourier series comp/filters, convolution in
  fourier, time↔freq graphically, nyquist
- `353` (`283babf1-97c2-80df-8d23-c085793ba4e0`) → at least "periodic functions,
  trigonometric series, fourier series"

Meanwhile `280 mid 2` in the DB is **completely blank** and `280 mid 1` has exactly one
child. So for `280`, nearly all real content lives *outside* the tracker — the Nov 2025
timestamps line up with the `280 mid 2` row's creation date, suggesting Dave filed by course
rather than by exam.

**Consequence:** the current pull (scoped to the DB) captures a small fraction of `280` and
an unknown fraction of the rest. The `<exam-slug>__<concept-slug>` naming scheme has no slot
for course-level concepts.

**Needs Dave:** scope decision + naming convention for non-exam material.

---

## OPEN — garbled formula in `270` source notes

Flagged by the pull agent in
`raw/notion/270/mid-2__wave-reflection-and-transmission-at-normal-indicdence.md`.
**Not independently verified — confirm at ingest.** Mirrored verbatim per the raw/ invariant.

The radome example writes $v=\frac{c}{\epsilon_r}=\frac{3\times10^8}{2}\approx2.12\times10^8$.

The formula is wrong — it should be $v = c/\sqrt{\epsilon_r}$. But the **numeric answer is
correct**: $3\times10^8/\sqrt{2} \approx 2.12\times10^8$. So Dave did the right arithmetic
and wrote the wrong symbol. The reasoning is sound; the notation is garbled.

**Promotion guidance:** the *concept* here is fine and worth promoting. The *formula as
written* must not be transcribed into a concept page. This is the inverse of the `280`
convolution defect (where the reasoning itself was wrong) — worth keeping the distinction
visible, because a lint pass that only pattern-matches "source contains an error" would
treat them identically and be wrong about one of them.

Same page: `9,4\times10^9` (comma for decimal point).

**Implemented 2026-07-18 in [[wave-reflection-at-boundaries]]:** concept states the correct
$v = c/\sqrt{\epsilon_r}$, cites the source, and flags the divergence inline (formula garbled,
numeric answer correct) per the "promote understanding, not transcription" rule. Verified at ingest
as predicted. Nothing left open.

---

## CLOSED (probably harmless) — aliases are unresolvable via the API, and probably point at content we already have

**Third and final revision of this entry. Read the arc — it's instructive.**

1. Three agents reported "blank pages." Accurate description of what the API returned.
2. A fourth realised the observation was an artifact: aliases are link-to-page blocks whose
   `#fragment` is a *block* id, so fetching it yields an empty shell. I concluded ~14 real
   concept pages were missing and told agents to recover them by searching by subject and
   verifying via `ancestor-path`.
3. **That technique cannot work, and the `353` agent proved it rather than assuming it.** The
   block IDs *do* resolve and *do* name the correct parent exam page — but they are the alias
   blocks themselves, surfaced as pages parented where the block sits. **The target page ID is
   never exposed anywhere in the MCP response.** Scoped search (`page_url`) on the parent
   returns zero results. My recovery instruction was built on a wrong premise.

**Why it probably doesn't matter.** On `353`, the 4 aliases under `mid 2` date 11/10–11/13 and
the top-level `353` page holds exactly 4 substantive concept pages matching the mid-2 syllabus
(variation of parameters, Laplace, matrices/eigenvalues, Fourier). The aliases were almost
certainly **pointers to those pages** — which we pulled by going at the course page directly.
The content was never missing; only the pointer was unreadable.

Combine with the scout's finding that `alt="drive"`/`alt="figma"` blocks in `todo` stubs are
unfilled template placeholders pointing at nothing, and the "≥14 missing pages" alarm largely
dissolves: some were template noise, the rest were probably duplicate pointers to course-level
pages now captured.

**Unblock, if ever needed:** browser rendering of notion.so. The `353` agent tried; Chrome
returned "Permission denied for reading page content on this domain" — a per-domain grant Dave
must approve interactively. **Not worth requesting** unless a `/query` later reveals a real
gap. Cost/benefit says stop.

**Status: closed as probably-harmless.** Reopen only if ingest finds a topic the syllabus
implies but no snapshot covers.

Worth noting what the ledger did here: it held a wrong conclusion of mine for two waves, and
an agent that actually tested the premise overturned it. Had I "fixed" the entry silently at
step 2, the correction at step 3 would have had nothing to correct.

---

## SUPERSEDED — the "blank alias pages" are a fetch-tool limitation, not missing notes

**Supersedes the entry below.** The `353` agent worked out what the aliases actually are:

> the body of this page consists solely of Notion "alias" (link-to-page) blocks. The fetch
> returns them as block references under this page's own URL with a `#fragment`, not as
> resolvable target page IDs. Fetching each fragment ID returns a blank, untitled page.

So the aliases are **not** blank pages. They are links whose *targets the API did not
resolve* — the `#fragment` is a block ID, and fetching a block ID yields an empty shell. The
real pages exist; the tool handed back the pointer instead of the destination.

**This inverts the earlier conclusion.** The entry below reads ten blank pages as possible
deleted content. They're more likely **ten real, unfetched concept pages** — a hole in the
corpus, not a hole in Dave's notes. Affected: `230 final` (2), `270 final` (2),
`316 mid 1` (6), `353 mid 2` (4). At least fourteen.

Note how close this came to being recorded as fact. Three agents independently reported
"blank pages," which is exactly what the API showed them; the fourth had the context to see
that the *observation* was an artifact. The ledger held both and let the later evidence win
— which is the whole point of not silently resolving.

**Recovery:** resolve alias targets by title via `notion-search`, or query the parent data
source for pages whose ancestor is the exam page. Needs the Notion connector back.

**Do not treat these exams as complete until this is chased down.**

---

## SUPERSEDED — blank alias pages, recurring pattern

`270 final` has two children that are **untitled, genuinely blank pages** rendering as
`<unknown alt="alias">`: `34dbabf197c28076911ef253d46e0403` and
`34dbabf197c280d489bfcd0f4adf0557`. Agent fetched both to confirm; nothing there. Recorded
as HTML comments in `final___exam.md` rather than inventing slugs for titleless pages.

`230 final` shows the **same shape** — two alias blocks, no real content.

**Updated after `316`:** the pattern is broader than finals. `316 mid 1` has **six** blank
untitled aliases alongside its two real children. So: `230 final` (2), `270 final` (2),
`316 mid 1` (6). Blank aliases appear under midterms too, which kills the tidy "finals were
never started" theory.

Ten blank pages across three exams is a lot of deliberate-looking emptiness. Candidates:
deleted content leaving alias stubs behind, a Notion sync artifact, or a template Dave
populated inconsistently. **Do not assume benign.** If these were once real notes, the
corpus has holes exactly where the ledger can't see them.

Also: `raw/notion/270/mid-2__oblique-incidence-parallel-vs-perp.md` is a 4-line stub with no
equations, while its siblings run 3–6KB. Material appears largely covered by
`oblique-incidence-antennas`. Candidate for source-card-only, no concept promotion.

**Needs Dave:** what are the ten blank alias pages — deleted content, or never written?

---

## OPEN — some `raw/` pages may not be Dave's own notes

**This is the most consequential item in this ledger. It challenges an assumption the whole
vault rests on.**

`CLAUDE.md` calls `raw/` "Dave's memory of record" and treats it as the source of truth.
The `230-probability` pull found that assumption may not hold uniformly.

`raw/notion/230-probability/mid-2__poisson.md`, and the "example: tail sum formula" section
inside `mid-2__expected-value-normal-distributions.md`, are written in **polished textbook
prose** — full sentences, "Solution:" headers, bolded structure, application lists (call
centres, earthquakes). Every other page in the corpus is terse lowercase bullets, heavy
LaTeX, and frequent typos.

Corroborating evidence *inside* `poisson`: the PMF and moments use $\mu$, but the Key
Characteristics, Conditions, and worked example use $\lambda$ — and the example says
"Given: λ = 3" while applying a formula written in $\mu$. **One page, one quantity, two
symbols.** That is what a paste-seam looks like. The rest of mid-2 uses $\mu$.

**Why this matters:** the vault's value proposition is that `raw/` is *Dave's* — his recall,
his framing, his errors. If some pages are LLM-generated or pasted, then:
- they carry no signal about what Dave actually knows
- they may contain errors Dave never reviewed and would not recognise as his
- a concept page citing them says "per Dave's notes" when it means "per something Dave
  pasted into Notion once"

The citation looks identical either way. **Provenance-to-file is not provenance-to-Dave.**

**Resolution (Dave, 2026-07-15):** "as long as it's in the notion we'll add." Inclusion bar
is presence in Dave's Notion, not authorship. Reasonable — it's his vault and he put the
pages there.

**Adjusted handling (cheap, non-blocking):** do not gate ingest on authorship. Where the
seam is obvious (the μ/λ split in `poisson`), record `authored_by: uncertain` in the source
card — not the snapshot, since `raw/` is immutable. Costs nothing, blocks nothing, and keeps
the signal recoverable if a `/query` answer ever turns on whether Dave actually knew
something versus pasted it. Closed unless it bites.

---

## OPEN — math errors in `230-probability` source notes

Agent-flagged, **not independently verified — confirm at ingest.** Mirrored verbatim.

1. **Combinations formula transposed.** `mid-1` writes
   `n(n-1)...(n-k+1) = \frac{n!}{(n-k)!k!}`. The left side equals `n!/(n-k)!`. The very next
   line ("get rid of `k!` in the denominator") suggests the permutation and combination
   formulas got swapped.
2. **CLT denominator wrong operator.** `law-of-large-numbers-clt` writes `\sqrt{n}-SD(X_i)`
   — should be multiplication.
3. **Tail sum index mismatch.** `expected-value`: sums over `i` but the summand uses `j`
   (`\sum_{i=1}^{n}P(X\geq j)`).
4. **Blood test typo** (harmless): `0.02*0/99` for `0.02*0.99`. Stated answer `95/293` is
   consistent with `0.99`, so arithmetic was right.

(1) and (2) are the dangerous ones — wrong as written and plausible enough to be transcribed
into a concept page without anyone blinking. **Block promotion of the combinations formula
and the CLT statement until ruled on.**

Spelling, preserved, no action: "joing distribution", "transate", "baye's rule",
"distributon", "succeses".

---

## OPEN — errors in `316` source notes

Agent-flagged, **not independently verified — confirm at ingest.** Mirrored verbatim.

1. **Monotonicity table contradicts itself.** `difference: R-S` is listed as plain
   "monotone", while `union` gets the nuanced "monotone wrt R, non-monotone wrt S".
   Difference is the textbook **non-monotone** operator (wrt S). Exam-relevant and wrong.
2. **Prose and example table disagree.** Text says
   `user: {<142, Bart, 10, 0.9>, <857, Milhouse, 10, 0.2>}` but the table has 857 = Lisa,
   123 = Milhouse. Similarly `member: {<142, dps>, <123, gov>}` — the Member table has no
   `142/dps` row at all. The worked example doesn't match the data it works on.
3. **Second BCNF example is garbled.** States "violation: twitterid → uid", then repeats
   "violation: twitterid is not a superkey" as a second distinct violation. Reasoning
   doesn't track.
4. **4NF definition broken mid-sentence:** "all FD's and MVD's follow from 'key → other
   attributes' (i.e., of MVD's and no FD's besides key functional dependencies)".
5. Cross-product typo: `$R \times X$` should be `R × S`.

(1) is the dangerous one — a confident, wrong, exam-relevant claim in a table format that
invites transcription. **Block promotion of relational-algebra monotonicity until ruled on.**

**UPDATED after re-pull — it's worse, and now diagnosable.** The first pull was right that
`difference: R−S` is wrongly called monotone, but understated it. Dave **swapped the
annotations between adjacent rows**:

| row | his annotation | truth |
|---|---|---|
| `union: R∪S` | "monotone wrt R, non-monotone wrt S" | **wrong** — union is monotone in both |
| `difference: R−S` | "monotone" | **wrong** — monotone wrt R, non-monotone wrt S |

The union annotation is verbatim the one that belongs on difference. **One transposition, two
wrong cells** — and it fits the corpus-wide pattern exactly: the *understanding* is intact (he
wrote the correct annotation, just on the wrong row), the *transcription* failed.

Also confirmed by re-pull: the Bart/Milhouse/Lisa prose-vs-table mismatch (857 = Lisa in the
live table, Milhouse = 123; `<142, dps>` absent from Member) — though the cross-product table
itself verified correct row-by-row. And the 2nd BCNF example is garbled because **the FD itself
is missing**: it reads "violation: twitterid is not a superkey — doesn't determine gid,
fromDate" with no FD stated. From the decomposition it must be `twitterid → uname`.

Not defects: two different `User` databases exist (5-row capitalized, 2-row lowercase) for
different examples — distinct, do not merge. `XPath/XQuery` covers only XPath and ends
mid-topic — genuinely unfinished upstream, not truncated by the pull.

Spelling, preserved: `tranlsates`, `sublcasses`, `stte`, `adress`, `symboles`, `uniquey`,
`standalong`, `cotents`, `folows`, `bibliogrpahy`, `elemnts`, `prie="80.00"`.

---

## NOTE — `316` inline databases (handled, no action)

The relational-model page embeds **live Notion databases**, not `<table>` blocks — the fetch
returned bare `<database>` references with no rows. The pull instruction didn't cover this
shape. The agent queried each data source and inlined the rows as markdown so the snapshot
isn't a dead pointer. Good call.

Two judgment calls recorded for provenance: rows are ordered by `createdTime` because
Notion's display order isn't exposed (the page itself states row order is immaterial, and
this happens to sort Dave's `…` continuation rows last); and the middle cross-product table
is actually a *"View of Member"* — a view over the same data source — labeled as such.

Flagging the general lesson: **`raw/` can contain live queries, not just text.** A Notion
database that changes upstream makes its snapshot stale in a way `fetched:` alone doesn't
capture, since the *page* may be untouched while its embedded data moves.

---

## OPEN — **pipeline defect**: the snapshot destroyed semantic information (`316`)

**This one is our fault, not Dave's.** Every other item in this ledger is a source problem
faithfully mirrored. This is the mirror itself losing data.

In `316`, Notion's `<span underline="true">` served **two different purposes**:
1. ordinary emphasis (headers, "ex.")
2. **semantic primary-key marking** — e.g. `address(address, city, state, zip)`, where the
   underline *is* the notation for which attributes form the key

Markdown has no underline, so the pull instruction ("keep `<span underline>` as markdown
bold/italic") collapsed both into bold. **The primary-key marking is now inferable only from
context.** In a databases course, primary keys are not decoration — they're the content. Any
later synthesis reading key definitions off these pages will be guessing.

This was my instruction, and it was wrong. Underlining is load-bearing notation in at least
this course and possibly others (`350` FSM state tables are a candidate).

**RESOLVED 2026-07-16 — re-pulled, notation recovered.** 249 balanced `<u>` tags across 11
files; zero `underline="true"` remaining.

The recovered passage is the one that **defines the notation**:

```
- typically pick one as the "primary" key, and <u>underline</u> all its attributes
- <u>e.g.</u>
    - address (<u>address</u>, city, state, <u>zip</u>)
```

Under the old rule this rendered `address (**address**, city, state, **zip**)` —
indistinguishable from the emphasis-bold used everywhere else on the page. So
"primary key = {address, zip}" was **unrecoverable**, and the page explaining *why* underline
means "key" had been flattened into the same bold as its own prose. Also restored:
`User(<u>uid</u>, name)` / `PaidUser(<u>uid</u>, avatar)` in the ISA translations.

**Scope was narrower than feared, and the fix generalizes anyway.** On 5 of 6 SQL pages
underline is pure emphasis — keys there are carried by SQL keywords (`PRIMARY KEY`, `UNIQUE`,
`REFERENCES`), not typography. The semantic load concentrates in the relational-design
material. But underline turned out to be semantic in `230-probability` and `353` too, on
different axes, so the fleet-wide `<u>` fix was right for reasons beyond this bug.

---

## RESOLVED — page-count discrepancy was a growing database, not a conflict

An earlier Claude session's task card (2026-07-11) counted *"11 exam containers / 54 pages"*
in `Midterm Review Notes`. This pull found 16 rows. Looked like a discrepancy.

It isn't. The DB has exactly 16 rows today (verified by SQL). The earlier session saw 11
because five rows — `230 final`, `270 final`, `270 mid 2`, `350 mid 2`, `230 mid 2` — were
created in 2026-03/04, *after* that card's source material. **Two correct observations of a
database at different times.** Textbook supersession, not conflict. All 16 rows are on disk;
the tracker is fully captured.

Worth noting the ledger's own rule earned its keep here: "a stale snapshot is not a
contradiction." Had this been filed as a conflict, it would have sat open forever with
nothing to resolve.

---

## OPEN — `mid-1__chat-review.md` (`280`) is unreliable, and now doubly so

Adds to the distributive-property error already filed above. The `280` course-page pull
found a **second** error in the same file:

`r(t)*r(t) = q(t)` is **wrong** — ramp convolved with ramp is `t³/6`, not `½t²`. The same
shortcut table also asserts `u(t)*r(t) = q(t)`, which **is** correct. So the table claims two
different convolutions produce the same result.

Meanwhile `course__lti-convolution.md` gives only the correct `r(t)*u(t) = ½t²u(t)` and omits
`r*r` entirely.

**Two independent errors in one file** moves this from "typo" to "this source is not
trustworthy." Recommend: source card only, **no concept promotion from `chat-review` at
all**, pending Dave. The course page covers the same material correctly and should be
preferred as the citation for convolution.

---

## NOT a contradiction — the distributive property, resolved by absence

Checked specifically: does `course__lti-convolution.md` state the distributive property
correctly, contradicting `chat-review`?

**It doesn't state it at all.** The course page gives only commutativity and associativity,
both correct: `x*h=h*x`, `(x*h)*g=x*(h*g)`.

So the `chat-review` error is uncorroborated and uncontradicted — the other source is silent.
Per the schema's distinction this is neither conflict nor supersession. If anything it
*strengthens* the read that it's a transcription slip rather than something Dave believes,
since he never repeats it where he writes the topic up properly.

Recorded because "we checked and found nothing" is worth keeping. Otherwise someone re-runs
this check in six months.

---

## OPEN — `280` topic gaps: `nyquist` and `280 mid 2` are blank upstream

`course__nyquist.md` is **completely blank in Notion** — mirrored as frontmatter only. Same
failure mode as the blank `280 mid 2` exam row.

This is not a pull failure and not an alias artifact. Sampling/Nyquist is a **real hole in
Dave's notes**, and the vault will have a correspondingly real hole. `/query` on sampling
will return nothing, correctly.

Flagging because it's the kind of gap that looks like a bug later. It isn't. **Needs Dave
only if he wants to fill it.**

---

## OPEN — **real conflict**: two `230-probability` sources disagree on LLN and CLT

**The first genuine source-vs-source conflict in the corpus.** Everything prior was a single
source being wrong. Here two of Dave's own pages state the same theorems differently, and
**each is correct exactly where the other is wrong.**

### LLN — exam page right, course page wrong

| source | statement | verdict |
|---|---|---|
| `mid-2__law-of-large-numbers-clt.md:14` | `P(\|\bar{X_n}-\mu\|<\epsilon)\rightarrow1` | **correct** — sample mean |
| `course__lln-clt.md` | `P(\|X_n-\mu\|<\epsilon)\rightarrow1` | **wrong** — no bar |

Without the bar this claims a *single term* $X_n$ converges to $\mu$ — false for i.i.d.
non-degenerate variables. Only the sample mean converges.

### CLT — course page right, exam page wrong, **and the exam page contradicts itself**

| source | statement | verdict |
|---|---|---|
| `mid-2...:21` | `SD(S_n)=\sqrt{n}SD(X_i)` | **correct** |
| `mid-2...:25` | `\frac{S_n-nE(X_i)}{\sqrt{n}-SD(X_i)}` | **wrong** — minus in denominator |
| `course__lln-clt.md` | `SD(S_n)=\sqrt{n}\sigma`, `Y\sim N(n\mu,\sqrt{n}\sigma)` | **correct**, consistently |

This **narrows the earlier finding**. The ledger recorded "CLT denominator wrong" as a flat
error. It's confined to the standardization denominator on line 25 — contradicted by line 21
of the *same file* four lines earlier, and by the course page. That pattern reads as a typo
(`-` for implicit multiplication), not a misunderstanding. Materially different: Dave knows
this, his notes don't.

**Resolution: link, do not merge.** Two distinct sources, each authoritative on different
halves. A concept page on LLN cites the exam page; CLT cites the course page. Merging would
force a choice between two sources that are each right about something.

**Convention note, not an error:** `course__lln-clt.md` parameterizes the normal by **SD** —
`N(n\mu, \sqrt{n}\sigma)` — not variance. Legitimate, but it will collide with any page using
`N(\mu,\sigma^2)`. Flag at ingest; do not "fix".

**Needs Dave** — but this is the good kind of finding. The vault caught a real inconsistency
in his exam notes by cross-referencing his own course notes. That is the entire point of the
system, working on the fourth wave.

**Implemented 2026-07-18 in [[law-of-large-numbers-and-clt]]:** the concept states both theorems
correctly, cites the exam page for LLN and the course page for CLT (link, don't merge), and flags
each source's error inline.

**RESOLVED 2026-07-18 (Dave: "not important, do whatever is more suitable").** Vault convention is
the **SD parameterization $\mathcal{N}(\mu, \sigma)$** — it matches Dave's own course page and every
formula already written in [[normal-distribution]], [[law-of-large-numbers-and-clt]], and
[[confidence-intervals]] uses $\sigma$ (SD) explicitly, so no rewrites and no ambiguity. Any future
page using $\mathcal{N}(\mu, \sigma^2)$ should be normalized to SD or state its variance convention
explicitly. Nothing left open here.

---

## NOTE — `230-probability` stubs (no action)

- `course__normal-approx-to-binomial.md` — **contains no normal approximation** despite the
  title. Three lines of binomial basics ($E(X)=np$, the pmf), all correct. A stub.
- `course__random-variable-transformation.md` — ends mid-thought on a bare `-`.

Neither is an error; both are gaps. Source cards only, no promotion. Same category as the
blank `nyquist` page: real holes in Dave's notes, which the vault should reflect rather than
paper over.

---

## NOTE — institution signal (two independent sources, still not a department code)

`raw/notion/misc/roudy-notes.md` references a professor's **"duke page"**.

Independently, the `316` pull found its running examples are Simpsons-themed (Bart, Milhouse,
Lisa; groups "dead putting society", "student government") over a `User`/`Group`/`Member`
schema — which that agent flagged as the distinctive example set from **Duke CompSci 316**,
while explicitly declining to assert the code.

Two unrelated sources — a cold-email note and a databases example set — both point at Duke.
That is meaningful corroboration of *institution*.

It is **still not licence to write department codes.** It does not tell us the prefix for
`230-probability`, `270`, `353`, or `350`; the `ece` evidence is separate and partial; and a
plausible inference is exactly the kind of thing that becomes indistinguishable from fact once
written into a concept page with a citation. Content-derived names stand until Dave states the
codes himself.

Recorded because it's the strongest identity evidence yet and someone will re-derive it
otherwise.

---

## OPEN — `353` source errors, including one that would cost exam points

Agent-flagged, **not independently verified — confirm at ingest.** Mirrored verbatim.

### `course__variation-of-parameters.md` — the worst found in the corpus

Two compounding errors in a single worked example:

1. The theorem is stated **correctly** one line above:
   `y_p = -y_1∫(y_2·f/W) + y_2∫(y_1·f/W)`. The example then computes
   `u_1 = -∫(y_1·f/W)` and `u_2 = ∫(y_2·f/W)` — **`y_1` and `y_2` swapped relative to his own
   theorem, one line later.**
2. He correctly divides through by `x²` to normalize (giving `f = x²`), then **uses the
   un-normalized `f = x⁴`** in both integrals. Normalizing and then ignoring it is the classic
   trap of this exact method.

Correct: `u_1 = -∫x·ln x dx`, `u_2 = ∫x dx = x²/2`. He gets `u_1 = -x⁴/4`. The Wronskian
`W = x³` is right. Example is left unfinished (`...`).

**This is the most consequential error in the corpus so far** — not a typo, a method executed
wrongly, in the one place the method is demonstrated. **Block promotion of variation of
parameters entirely** pending Dave.

### `course__matrices-eigenvalues-two-point.md`

- **Operator sign errors invert the eigenvalue problem.** Defines `𝓛 = -d²/dx²`, then writes
  `𝓛y = y''` (should be `-y''`) and `𝓛y = -λy` (should be `+λy`, since `y''+λy=0 ⟹ -y'' = λy`).
- **Linear dependence defined without "not all `c_i` zero"** — as written, *every* set of
  functions is dependent.
- Eigenvector solve written `[A][a;b] = v⃗`; should be `= 0⃗`.
- **The `λ>0` BVP case is never done.** Page says "consider 3 cases: λ>0, λ=0, λ<0", does the
  two trivial ones, stops. `λ>0` is the case yielding `λ_n = (nπ/L)²` and `sin(nπx/L)` — the
  entire payoff, and the bridge to the Fourier page. A gap exactly where the content matters.
- BVP posed in `x`, solved in `t`. Dave's own marker: "nonhomogeneous linear systems
  **(TODO)**".
- Verified **correct**: `W = 7e^{-3t}`; two-tank eigenvalues `0, -13/20`; `c_1 = 15/13,
  c_2 = 120/13` (salt conserves to 15 ✓).

### `course__improper-integral-laplace-transform.md`

- `\mathcal\{cost\}` — malformed, **will not render**. Should be `\mathcal{L}\{cost\}`.
- Unbalanced brace in the `(3s+5)/(s²-6s+25)` example.
- "if we take `g(t)=e^{-st}` in our definition of `δ_a(t)`" — **refers to a definition never
  given**; the sifting property is skipped entirely.
- Heading says "transforms for 0, 1, c" but the list covers `0, 1, e^{at}, e^{zt}, t^n`.
- Verified **correct**: both ODE examples, `u_2(t)(t-2)²`, the `e^{-3s}` shift,
  `cos πt(1-u(t-3))`, `3e^{3t}cos4t + (7/2)e^{3t}sin4t`, `cos*sin = ½t·sin t`.

### `course__periodic-functions-trigonometric-series-fourier-series.md`

- **`b_n(\frac{n\pi t}{L})` is missing `\sin`** — and this is the *master formula* for the
  general period-2L series.
- `a_0` step writes `1/2 ∫` where it should be `1/π ∫` (final answer 0 unaffected).
- Verified **correct**: square wave `b_n = 2[1-cos nπ]/(nπ) → 4/(nπ)`; triangle `a_0=1`,
  `a_n=4/(nπ)²` odd; final example `a_0=1/2`, constant `1/4`, `a_n=-2/(nπ)²` odd,
  `b_n=(-1)^{n+1}/(nπ)`. All Fourier arithmetic checks out.

**Pattern across all four:** the *arithmetic* is consistently right; the *symbolic statements*
are where things break. Dave computes correctly and transcribes carelessly. That distinction
should drive promotion decisions — his worked results are trustworthy, his formula statements
need checking.

---

## OPEN — `353 mid 2` is marked "Mastered / Done!" but is structurally empty

The tracker row for `353 mid 2` has Status **Mastered**, Priority **Done!**. The page itself
contains **no content** — it is 4 alias links and nothing else. The real mid-2 material lives
under the top-level `353` page, outside the database.

Not a contradiction in the notes; a **contradiction between the tracker's metadata and the
page it describes**. Worth surfacing because the tracker's Status field is the obvious thing to
reach for when answering "what does Dave know?" — and here it certifies mastery of an empty
page.

Combined with the earlier finding that `Topic` is an unreliable key, the conclusion generalizes:
**treat the tracker's metadata as Dave's intent, not as a description of the content.** It says
what he meant to have done, not what is written down.

---

## NOTE — Fourier spans `280` and `353` (overlap, not conflict)

`fourier series`, `fourier series decomp`, `fourier series comp, filters`, and `convolution in
fourier` all have parent **`280`** (verified by ancestor-path), while `353` has its own
`periodic functions, trigonometric series, fourier series`.

**Overlap, not contradiction** — two courses legitimately teaching the same mathematics from
different angles (`280` for signals/filters with Dirichlet conditions; `353` as an ODE/BVP
capstone). Per the schema: merge or link, don't file as conflict.

**Link, don't merge.** They're near-duplicates in content but different in framing, and the
framing is the point. This is also the first genuine **cross-course edge** in the corpus — the
kind of connection that justifies one vault over two, and a good early test of whether the graph
actually earns its keep.

Note the `353` BVP page stops before `λ_n = (nπ/L)²` / `sin(nπx/L)`, which is precisely the
bridge *to* Fourier series. The edge exists in the material even though Dave's notes never close
it.

---

## OPEN — `316` SQL that will not execute

From the course-level SQL pages. Agent-flagged, **verify at ingest.** Mirrored verbatim.

These differ in kind from the math errors: SQL either runs or it doesn't, so these are
checkable mechanically, and a reader who copies them gets an immediate error rather than a
silently wrong answer. Lower risk — but `sql-triggers` has an exception, below.

- `sql-querying`: `UPDATE User SET pop (SELECT AVG(pop) FROM User);` — **missing `=`**;
  `SELECT uid, name, age. pop` — period for comma; trailing comma before `FROM`;
  `WHERE gid = 'dps));` — unterminated string; `ORDER BY output_column [ASC|DESC}` —
  mismatched brace
- `sql-constraints`: `CREATE ASSERTION` body missing an opening paren (3 closers, 2 openers)
- `sql-recursion`: `SELET anc`; mutual-recursion Even/Odd query unterminated

**The dangerous one — `sql-triggers`:** `WHEN (n.age < 0.age)` should be `o.age`. This
**parses**. `0.age` is a syntax error in most engines, but the failure mode is a
never-decrease-age trigger that silently doesn't guard — and unlike the others, the typo is a
single character that reads as correct at a glance. Also `SELECT ui` for `uid`, and an
unbalanced `WHEN (` in the first `PickyCKS` trigger.

**Inverted comment — `sql-constraints`:** `CHECK(age IS NULL OR age > 0), --ensures age is
either NULL or not nonnegative`. "Not nonnegative" means ≤ 0 — **the comment states the exact
opposite of the constraint it annotates.** The constraint is right; the explanation is
inverted. Worth flagging because a wiki page would naturally promote the *prose*, not the code.

**Data inconsistency:** `sql-querying` outerjoin example — Member table lists `857 | giv`, all
three join results show `gov`. Plus "stuent government" twice.

**Verified correct, not errors:** linear-vs-nonlinear step counts (4 vs 3 for `a→b→c→d→e` —
doubling vs increment); the `INSTEAD OF` average-pop trigger arithmetic; MVD complementation /
augmentation / transitivity / coalescence; the ANSI isolation-level table. The write-skew
example is sound but mis-states the violated constraint as `A+B-200 < 0` (should be `A+B < 0`).

---

## RESOLVED — the FD/BCNF/MVD/4NF material was never missing

I inferred that `316`'s syllabus covered functional dependencies, BCNF, MVDs, and 4NF but no
snapshot held them, and that the 6 aliases must be those pages.

**Refuted.** All of it lives *inside* `mid-1__relational-database-design-e-r.md` — FDs,
attribute closure, Armstrong's axioms, non-key FDs, decomposition, BCNF, MVDs, the chase, 4NF.
It was there the whole time; I'd read the page's *title* and inferred its contents.

The alias inference survives on different evidence: **6 aliases, exactly 6 top-level SQL
pages**, SQL being core mid-1 material present nowhere else under that exam — mirroring the
`353` pattern. Recorded in `mid-1___exam.md` explicitly labelled as inference, not fact.

Corroborating: `sql-querying` has its own trailing blank untitled child, in the same
`286babf1` block range as the six. Dave leaves stray empty pages; consistent with these being
real-but-empty artifacts rather than lost content.

**Second time an inference of mine about missing content was wrong** (see the alias entry). Both
times the correction came from an agent reading the actual pages. Worth internalising before
ingest: *do not infer what a page contains from its title.*

---

## OPEN — **every `fetched:` date in the corpus is wrong.** My error.

All 95 snapshots carry `fetched: 2026-07-15`. **The pull ran on 2026-07-16**, spilling into
07-17. Not one file was fetched on the date it claims.

Cause: I hardcoded the literal string `fetched: 2026-07-15` into every agent instruction, and
every agent faithfully wrote what I told it to. It was wrong the first time I typed it — the
session opened on 2026-07-16 — and it propagated to 95 files because it was a constant, not a
computed value.

**Severity: low in practice, high in principle.** `CLAUDE.md` says `fetched` exists so lint can
say "this is 90 days old, upstream may have moved." A one-day error is immaterial against a
90-day threshold. But this vault's entire claim is that provenance is trustworthy, and a
provenance field that is *known to be false* is worse than a missing one — a missing field
announces itself, a wrong one doesn't.

**The exact class of error I spent this pull cataloguing in Dave's notes.** He states a theorem
correctly and swaps `y_1`/`y_2` one line later. He writes `SD(S_n)=\sqrt{n}SD(X_i)` on line 21
and `\sqrt{n}-SD(X_i)` on line 25. I wrote the date wrong once and copied it 95 times. The
understanding was fine; the transcription failed. Same failure, same mechanism — mine just had
better fan-out.

**Blocked on a schema gap.** `CLAUDE.md` says: *"`raw/` is immutable. You never write to it,
edit it, rename within it, or delete from it."* I wrote that rule, and it doesn't distinguish:

- the **body** — Dave's content, which the invariant absolutely must protect, and
- the **frontmatter** — provenance metadata *we* generate, which can be factually wrong and
  whose whole purpose is to be accurate

Correcting my own timestamp bug doesn't overwrite a single character of Dave's memory of
record. But the rule as written forbids it, and I am not going to quietly reinterpret an
invariant because it's inconvenient — that's precisely how invariants stop meaning anything.

**RESOLVED (Dave, 2026-07-16) — amend, then fix. Done.**

`CLAUDE.md`'s invariant now distinguishes body (immutable, no exception) from frontmatter
(machine-generated, correctable when demonstrably wrong, correction logged). All 95
`fetched:` dates corrected `2026-07-15` → `2026-07-16`, scripted, verified: 0 remaining
wrong, 95 correct. Logged in `wiki/log.md`.

Still true and worth carrying forward: any future pull must **compute** the date, never
hardcode it.

---

## RESOLVED — real department codes confirmed via Google Drive (2026-07-17)

A light Drive pull (16 files, `raw/drive/`) surfaced Dave's own file names and document
headers — not inference, not circumstantial pattern-matching, but Dave's own naming of his
own coursework. This is materially stronger evidence than anything in the earlier `ece 230
lab 1 orientation` / Simpsons-example entries, and resolves several previously-hedged items:

| course | confirmed code | evidence |
|---|---|---|
| `316` | **CompSci 316, Duke** | HW1/3/4 prompts and Schedule all reference `$DBCOURSE`, `courses.cs.duke.edu/fall25/compsci316d/`, `ratest.cs.duke.edu` |
| `280` | **ECE 280** (Duke) | `ECE280S25_Lab1.pdf` header; `lab_1_280_report.pdf` explicitly invokes "the Duke Community Standard" |
| `353` | **Math 353** — not ECE | `practice_midterm_353.pdf`'s own title: "Practice for First Midterm Exam Math 353" |
| `350` | **ECE/CS 350** (Duke) | cross-listing stated directly in the course's own final-project assignment document |

This also independently corroborates the `316` = Duke read the earlier pull inferred from
Simpsons-themed examples and a "duke page" mention in `roudy-notes.md` — that inference is
now confirmed fact, not pattern-matching.

**Still open:** `230-probability` and `270` have no confirmed code from any source yet. Do
not invent one. `230-semiconductors` has a *tentative* link to "ECE230L" via one Drive file
(see below) — tentative, not confirmed.

**Action:** `CLAUDE.md`'s course list updated with confirmed codes. Renaming
`raw/notion/316` etc. to reflect confirmed codes is a mechanical follow-up, not done yet —
low urgency since content-derived slugs work fine in the meantime, but noted here so it
doesn't get lost.

---

## NOTE — tentative link: "ECE230L" CMOS-logic content may belong to `230-semiconductors`

`raw/drive/230-semiconductors/final-exam-template-cmos-logic.md` — a single-slide fragment on
CMOS inverter/PUN-PDN transistor sizing, titled "FinalExam-Template-ECE230L".

Filed under `230-semiconductors` provisionally: the existing Notion material for that course
is device physics (MOSFET structure, band diagrams, PN junctions, C-V curves), and CMOS gate
design is a different sub-topic — but a comprehensive intro-devices course commonly ends with
CMOS logic as the applied payoff of the device physics, so this plausibly belongs to the same
course rather than signaling a third, distinct `230`.

**Not filed as an open ambiguity — evidence is too thin to call it one.** One slide fragment,
thin extraction (see below), no other corroborating signal either way. Recorded here so it
isn't silently lost if more evidence turns up later. **Needs Dave to confirm** whether
"ECE230L" is the same course.

**RESOLVED (2026-07-17) — CONFIRMED, no longer tentative.** The `uni/` archive settles it: the
folder `uni/spring 2026/230/` (the semiconductors 230, by semester) directly contains
`FinalExam-Template-ECE230L.pdf` alongside the CMOS device-physics coursework. The CMOS-logic
fragment and the device-physics material live in the *same course folder* — so `230-semiconductors`
**is** ECE 230L, spring 2026. Not a third course. See [[academic-timeline]] and the course card
[[230-semiconductors]]. Dave also confirmed the [[dave-zheng-pcb]] board is probably a 230-semi lab,
consistent with this.

---

## NOTE — two Drive extraction limitations, not source errors

`raw/drive/270/lab-4.md` and the CMOS-logic fragment above both came back from Drive's
`read_file_content` far thinner than expected — a handful of lines each, where the source is
almost certainly richer (tables, images, or multi-slide decks the "natural language
representation" doesn't preserve well). This is a **tool limitation**, distinct from every
other gap in this ledger, which are all either Dave's own errors or agent misjudgments.
Flagged in both files' frontmatter comments rather than treated as "the source is just this
short." If either course matters later, `download_file_content` (raw export) rather than
`read_file_content` may recover more — not attempted here per Dave's "doesn't need too much
processing" instruction for this pull.

---

## NOTE — Dave has two separate hardware/FPGA projects; do not conflate them

`raw/drive/350/technical-report-connect4.md` and its companion proposal/assignment files
describe Dave's **ECE 350 final project**: a Connect 4 game on a custom 5-stage pipelined FPGA
CPU, built with a partner (Faiz Ali), with physical IR sensors, VGA output, and a
minimax-in-assembly CPU opponent.

This is **completely separate** from `~/Documents/hw-cnn-accelerator` — the systolic-array
GEMM/MNIST accelerator `CLAUDE.md` already describes, which is solo and has no game/FSM
element. Same student, same general skill area (FPGA/Verilog/pipelined processors), two
distinct projects. Worth being explicit about this now, before either project gets its own
graph — conflating them later would be a much messier cleanup than flagging it here.

**Supersession, not a contradiction:** `final-project-proposal-poker.md` (Texas Hold'em,
modified 2026-03-20) and `final-project-proposal-connect4.md` ("...for real this time",
modified 2026-04-10, matches the shipped technical report) are the same two-person team
proposing two different games. The poker idea was dropped before the project started; the
"for real this time" title all but confirms it. Both kept — the poker proposal is real
project-planning history, just not what shipped.

**Also worth knowing:** the ECE 350 final project assignment explicitly **prohibits
LLM-generated Verilog** for the deliverable ("this includes avoiding any LLM-based systems —
ChatGPT, Copilot, Gemini, Claude, etc."). Relevant if this vault or any assistant is ever
asked to help with ECE 350 coursework directly — that course's own rules forbid it for the
graded artifact, separate from anything this vault's own scope covers.

---

## Pattern — source errors are systemic, not incidental

Three of three courses pulled so far contain real math errors in Dave's notes: `280`
(distributive property), `270` (radome formula), `230-probability` (combinations, CLT).

This is not noise to be tidied away — it is the central design constraint. A naive ingest
would launder every one of these into a clean, confident, **cited** concept page. The
citation would be accurate and the claim would be false, and the polish would make it
*harder* to catch than the messy original.

**Standing rule:** ingest promotes *understanding*, not *transcription*. Where a source's
reasoning is sound but its notation is garbled (`270` radome), promote the concept and note
the discrepancy. Where the claim itself is wrong (`280` distributive, `230-probability`
combinations), promote nothing until Dave rules. When uncertain which, do not promote.

---

---

---

## Dave's error (316) — relational-algebra monotonicity classification swapped

**Source:** ^[[sources/notion-316-relational-model-algebra]] (`raw/notion/316/mid-1__relational-model-and-algebra.md`, "classification of rel ops").

The note classifies **union** as "monotone wrt R, non-monotone wrt S" and **difference** as
simply "monotone." Both are wrong, and they look swapped:
- **Union** $R \cup S$ is monotone in **both** arguments (adding rows to either input only adds
  output rows).
- **Difference** $R - S$ is monotone in R but **non-monotone in S** (adding a row to S can remove
  a row from the output).

This is a symbolic/classification error of exactly the kind CLAUDE.md's "lessons" section predicts
(worked intuition fine, formal statement flipped). The correct version is stated in
[[relational-algebra]] with the divergence flagged inline, per the promotion rule. Raw snapshot
left untouched. Filed 2026-07-17 during the 316 ingest.
