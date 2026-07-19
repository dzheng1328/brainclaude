---
kind: source
domain: projects
course: "synth"
title: "README"
raw_file: raw/repos/synth/README.md
source_kind: repos
repo_url: https://github.com/dzheng1328/synth
commit: 303c44e
fetched: 2026-07-18
---

# README

synth repo doc "README" — project goals, stack, the phased build roadmap (basic audio → synthesis →
polyphony → advanced/GUI), directory structure, and build instructions. Beyond what the project card
already captured (CoreMIDI support), this snapshot adds the **Sample Loader & WAV Export** feature:
`sample_io.c` (backed by miniaudio/dr_wav) lets `synth_pro`'s PRESETS tab load and mix an arbitrary
WAV file through the audio callback, and render the live mix offline to a stereo WAV (audio thread
stays real-time-safe; capture is written out after the fact). See [[synth]].

Raw: `raw/repos/synth/README.md`.
