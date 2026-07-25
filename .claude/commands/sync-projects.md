---
description: Mechanically re-sync active project repos' docs and refresh pointer cards
---

Sync active project repos into the vault. **Mechanical only — do not promote concepts, do
not rewrite prose.** Concept promotion stays a judgment call for `/ingest` or a manual
session.

Scope: $ARGUMENTS (if empty, sync every project pointer card with `status: active`)

## Procedure

1. Read every `wiki/entities/projects/*.md` frontmatter. Build the worklist: pages with
   `status: active` and a non-null `path:` pointing at a real directory on disk.

2. Per project, in worklist order:
   - Find its already-snapshotted docs under `raw/repos/<project>/` (check
     `.manifest.json` / existing source cards for the list — usually `README.md`,
     `CLAUDE.md`, and any other top-level docs previously snapshotted).
   - Compare each snapshotted doc against the live file at `<path>/<doc>` (sha256, or
     the repo's own git history if `<path>` is a git repo).
   - **Unchanged: skip silently.**
   - **Changed:** re-snapshot verbatim (overwrite `raw/repos/<project>/<doc>` — this is a
     living-source re-sync per `CLAUDE.md`'s Snapshots rule, not a `raw/` immutability
     violation), update its source card, update `.manifest.json`.
   - Update only the **mechanical frontmatter fields** on the pointer card: `status`,
     `last_commit`/`last_modified`, `stack` (only if the repo's own docs state a stack
     change). Never touch the pointer card's prose body.
   - If a re-synced doc contains something that reads as a genuinely new, reusable idea
     (not project-scoped detail), **do not write a concept page.** Append one line under
     a `## Flagged for /ingest review` heading in the pointer card instead (create the
     heading if absent). A human or a later `/ingest` pass decides whether to promote it.
   - A directory under `~/Documents/` with its own `CLAUDE.md`/`README.md` but no pointer
     card yet: **do not auto-create one.** Flag it in the report only — a new project
     card is a judgment call (what it is, in one honest sentence — not mechanical), same
     bar as any first-time `/ingest`.

3. **Finalize.** Append one `wiki/log.md` entry summarizing the run: projects checked,
   which had doc changes (with what changed), which were flagged for concept review, and
   any new unregistered project directories spotted. If nothing changed anywhere, write
   one line: "No project doc changes since last sync." Don't pad a no-op entry.

## Guardrails

- Never touch `status: dead`, `status: shipped`, or `status: complete` projects — those
  are frozen by design; re-syncing them is noise.
- Never write to a project's own repo — read-only on `path:`.
- Never promote a concept page from this workflow. If it's concept-worthy, flag it; a
  real `/ingest` pass (or Dave) makes that call.
- If a project's `path:` no longer exists on disk (moved/deleted), report it — do not
  guess a new path, do not delete the pointer card.
