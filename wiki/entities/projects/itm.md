---
kind: project
domain: projects
title: itm
repo: null
path: /Users/dzheng/Documents/itm
stack: [Vite, React, TypeScript, Tone.js, Framer Motion, Vitest]
status: dead
last_modified: 2026-03-22
---

# itm

A React + TypeScript + Vite web app whose `APP_NAME` is **"Image to Music"** — an image→music
generator, the same concept as [[imgsic]] but built on React with Framer Motion for animation
and Tone.js for audio. ^[[itm/src/config/constants.ts]] The in-app heading reads
"Interactive Toolkit - V0". ^[[itm/src/App.tsx]]

**Dead prototype — confirmed by Dave (2026-07-17).** itm is the *older* of the two image-to-music
builds; [[imgsic]] is the separate, later project that replaced it and is the one Dave carries
forward. itm is not a git repo, last modified 2026-03-22, and the `.orig`/`.rej` files in
`src/components/` are leftovers from an abandoned patch. Kept in the vault as history, not as
live work.

Generation defaults captured in config: 30 s duration, 4-bar loops, image/prompt influence
weighting 0.6/0.4. ^[[itm/src/config/constants.ts]]
