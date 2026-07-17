---
description: Health check the wiki — contradictions, staleness, orphans, uncited claims
---

Health check the vault. **Report findings; do not auto-fix.** Dave decides.

Scope: $ARGUMENTS (if empty, lint everything)

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

Append a dated summary to `wiki/log.md`.
