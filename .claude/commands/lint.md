---
description: Health check the wiki — contradictions, staleness, orphans, uncited claims
---

Health check the vault. **Report findings; do not auto-fix.** Dave decides.

Scope: $ARGUMENTS

- `--full` — exhaustive sweep, all 6 checks, full reasoning over the entire vault. Expensive
  by design; meant to run weekly (paired with `/ingest`, which has already loaded full-vault
  context that turn), not daily.
- (default, no argument) — **incremental mode.** Cheap on a normal day. Read
  `.lint-state.json` at the vault root (create it with today's date and empty history if
  absent — first run behaves like `--full`). Checks split into two tiers:

  **Always full-vault, mechanical (no per-page reasoning, cheap regardless of vault size):**
  - Stale snapshots (check 2) — pure date comparison against `fetched:` frontmatter.
  - Broken provenance (check 5) — pure existence checks (does the `raw/` file exist, does
    every manifest-referenced wiki page exist).
  - Orphans (check 3) — grep every `[[wikilink]]` vault-wide, diff against the page list.
    Set arithmetic, not judgment — cheap even at full scope.

  **Judgment-requiring, scoped to only what changed since `last_incremental_check`:**
  - Contradictions (check 1), uncited claims (check 4), missing cross-refs (check 6) — run
    these only against pages added or modified since `last_incremental_check` (`git log
    --since=<that date> --name-only -- wiki/`, or file mtimes if git history is unavailable).
    An unchanged page was already checked on a prior run; re-reasoning about it daily buys
    nothing. New/changed pages still get checked against the *rest* of the vault for
    cross-page contradictions — the scoping is on which pages trigger a check, not on what
    they're checked against.

  After a run, update `.lint-state.json`: bump `last_incremental_check` to now always; bump
  `last_full_sweep` to now only if this was a `--full` run.

## Checks

1. **Contradictions** — pages asserting incompatible things. Apply the
   conflict/supersession/overlap distinction from `CLAUDE.md` before filing. Overlap is
   not a contradiction.

2. **Stale snapshots** — any `raw/notion/` file whose `fetched:` is >90 days old. Report
   as "may have moved upstream," **not** as a contradiction. You have not re-fetched, so
   you do not know it changed. Offer to re-sync.

3. **Orphans** — wiki pages with no inbound `[[links]]`. Usually means a concept was
   promoted but never wired in, or it was over-promoted and should be demoted to a source
   card.

4. **Uncited claims** — concept pages with substantive assertions lacking a source
   citation. This is the highest-severity finding: an uncited claim is indistinguishable
   from a hallucination. List them precisely.

5. **Broken provenance** — source cards whose underlying `raw/` file no longer exists, or
   manifest entries pointing at deleted wiki pages.

6. **Missing cross-refs** — pages that clearly discuss the same concept without linking.
   Suggest; don't auto-link.

## Output

Group by severity: uncited claims > broken provenance > contradictions > staleness >
orphans > missing cross-refs.

For each: the file, the specific problem, and the proposed fix. Be concrete — "3 uncited
claims in `concepts/hamming-codes.md:12,19,24`" beats "some citations missing."

If everything is clean, say so in one line. Do not manufacture findings to look useful.
In incremental mode, say explicitly how many pages were in-scope for the judgment checks
this run (e.g. "3 pages changed since 2026-07-27, mechanical checks ran full-vault") so a
reader isn't misled into thinking a full sweep just happened when it didn't.

Append a dated summary to `wiki/log.md` by running `scripts/log-append.sh "<heading>"`
with the entry body on stdin — don't Read the file first; the script appends without
loading its existing content.
