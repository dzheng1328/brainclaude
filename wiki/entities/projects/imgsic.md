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
stays cleanly separated from `player.js` (how Tone.js renders it). ^[[imgsic/CLAUDE.md]]

**Relationship to other work:** [[itm]] ("Image to Music") is a sibling React/Tone.js take on
the same image→music idea — likely an earlier or parallel version. Worth reconciling which is
canonical.

Latest work (2026-06): Phase 1 — image-appropriate sound palette and register.
