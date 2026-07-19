---
kind: source
domain: projects
course: "imgsic"
title: "CLAUDE.md"
raw_file: raw/repos/imgsic/CLAUDE.md
source_kind: repos
repo_url: https://github.com/dzheng1328/imgsic
commit: e5175b5
fetched: 2026-07-18
---

# CLAUDE.md

imgsic repo doc "CLAUDE.md" — the full architecture: `uploader.js` → `api.js` → `composer/*.js`
(harmony/melody/dynamics) → `engine/*.js` (Tone.Transport scheduling, effects chain, sampler). The
exact JSON contract the serverless function returns (mood, tempo, key, mode, chordProgression,
melodyContour, dynamics, instruments, texture) with its valid-value enums. The **key constraint**:
the composer must produce real musical phrasing (voice-led chords, rests baked into rhythm, a
phrase-level velocity arc) — raw note arrays must never bypass it to hit Tone.js directly. Notes
Tone.js v15's breaking change (named imports, no default export) and that `analyze.js` deliberately
uses `claude-haiku-4-5-20251001` for cost efficiency on a task (structured JSON extraction) that
doesn't need a larger model. See [[imgsic]].

Raw: `raw/repos/imgsic/CLAUDE.md`.
