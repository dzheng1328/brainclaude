---
description: Synthesize new/changed raw sources into the wiki, incrementally
---

Ingest raw sources into the wiki. Follow `CLAUDE.md` exactly — especially the raw/
immutability invariant and the artifacts-vs-knowledge promotion rule.

Scope: $ARGUMENTS (if empty, ingest everything new or changed)

## Procedure

1. **Diff.** Compute sha256 for each file under `raw/`. Compare to `.manifest.json`.
   Build the worklist: files absent from the manifest, or whose hash differs.
   **Report the worklist and its size before doing any synthesis.** If it's large,
   say so and propose a batch size rather than silently burning the context window.

2. **Skip silently.** Unchanged files are not re-read. Do not summarize what you skipped
   beyond a count.

3. **Per file, in worklist order:**
   - Read it.
   - Write/update its source card in `wiki/sources/`. Every raw file gets exactly one.
   - Decide promotions using the rule in `CLAUDE.md`. Ideas → `wiki/concepts/`.
     Course-scoped artifacts → source card only. **When in doubt, do not promote.**
   - Update affected concept/entity pages. Every claim carries a citation back to a
     source card. Uncited claim = do not write it.
   - If new content conflicts with existing wiki content, **do not overwrite** — append
     to `wiki/contradictions.md` and keep both. Check the real-conflict vs. supersession
     vs. overlap distinction first; most "conflicts" are overlap.
   - Update `.manifest.json`: hash + list of wiki pages derived from this source.

4. **Finalize.** Update `wiki/_index.md`. Append to `wiki/log.md` (append-only — never
   rewrite prior entries).

5. **Report**: files ingested, concepts created vs. updated, contradictions filed,
   promotions declined and why.

## Guardrails

- Never write to `raw/`.
- Never invent a citation. If you can't source a claim, drop the claim.
- Prefer updating an existing concept page over creating a near-duplicate. Search
  `wiki/concepts/` before creating.
- If a source is unreadable (corrupt PDF, empty file), log it and continue.
