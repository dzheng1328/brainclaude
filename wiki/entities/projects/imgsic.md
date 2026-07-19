---
kind: project
domain: projects
title: imgsic
repo: https://github.com/dzheng1328/imgsic
path: /Users/dzheng/Documents/imgsic
stack: [Vite, JavaScript, Tone.js, Anthropic SDK, Vercel]
status: active
last_commit: 2026-06-25
---

# imgsic

A static web app: you drop in an image, Claude's vision API analyzes its mood/key/texture, and
a composer layer turns that into an ambient phrase played back in-browser via Tone.js. ^[[imgsic/README.md]]

**Stack:** Vite (vanilla JS) frontend, Tone.js v15 with multisampled instruments for audio,
Claude Haiku (vision) via the Anthropic SDK called server-side only, Vercel serverless
(`api/analyze.js`). The API key never touches the client. ^[[imgsic/README.md]] ^[[imgsic/CLAUDE.md]]

The **non-negotiable design principle** (from the repo's own CLAUDE.md): raw note data must
never be piped straight into Tone.js triggers — a prior attempt failed exactly that way and
sounded amateur. All musical parameters pass through a composer/arrangement layer that adds
phrasing, rests, dynamics, and chord voicing before playback. `composer.js` (what should happen)
stays cleanly separated from `player.js` (how Tone.js renders it). ^[[sources/repos-imgsic-claude]]

**Full architecture, from the repo's own CLAUDE.md:** `uploader.js` (drag-and-drop → base64) →
`api.js` (POST to `/api/analyze` or stub JSON) → `composer/` (harmony.js does chord parsing/voice
leading, melody.js builds scale-based contours with rests, dynamics.js shapes velocity/phrase arc)
→ `engine/` (Tone.Transport scheduling, a Chorus→AutoFilter→PingPongDelay→Reverb effects chain, a
sampler factory for piano/strings/pads/choir/marimba). The vision API returns a fixed JSON contract
(mood, tempo, key, mode, chordProgression, melodyContour, dynamics, instruments, texture) with
enumerated valid values that the composer and engine depend on. Uses `claude-haiku-4-5-20251001`
deliberately — structured JSON extraction from an image doesn't need a larger model.
^[[sources/repos-imgsic-claude]]

**Relationship to other work:** [[itm]] ("Image to Music") is a sibling React/Tone.js take on
the same image→music idea, confirmed dead (its own README is generic Vite/React boilerplate with
no project-specific content, and it isn't even a git repo) — [[imgsic]] is the canonical version.

Latest work (2026-06): Phase 1 — image-appropriate sound palette and register.
