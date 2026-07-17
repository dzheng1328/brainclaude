---
description: Ask the wiki a question; durable answers become synthesis pages
---

Answer from the wiki: $ARGUMENTS

## Procedure

1. **Search `wiki/` first.** It's the synthesized layer and it's why it exists — do not
   re-derive from `raw/` when the wiki already knows.

2. **Fall back to `raw/` only if the wiki is insufficient.** If you find the answer in
   `raw/` but not the wiki, that is a **gap** — say so explicitly and offer to ingest or
   promote. A question the wiki should have answered but couldn't is a signal.

3. **Answer with citations.** Every substantive claim links to its source card or concept
   page. If the wiki genuinely doesn't know, say so plainly. Do not fill the gap with
   general knowledge and present it as the vault's — if you supplement from your own
   knowledge, label it clearly as outside the vault.

4. **Compound it.** If the answer is durable and non-obvious — something worth having
   again — write it to `wiki/synthesis/` and link it into `_index.md`. Ask first; not
   every answer earns a page. Transient lookups don't.

   Answers compound into the wiki. They do **not** go in `output/`. `output/` is only for
   artifacts leaving the vault.

5. If you surface a conflict while answering, file it in `wiki/contradictions.md`.
