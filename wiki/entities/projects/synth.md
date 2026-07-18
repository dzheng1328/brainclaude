---
kind: project
domain: projects
title: synth
repo: https://github.com/dzheng1328/synth
path: /Users/dzheng/Documents/synth
stack: [C, CMake, miniaudio, Soundpipe, dr_wav, cJSON]
status: active
last_commit: 2025-12-03
---

# synth

A minimal, cross-platform **software synthesizer written in pure C**, built to learn
professional real-time audio programming and DSP fundamentals. ^[[synth/README.md]]

**Stack:** miniaudio (cross-platform audio I/O), Soundpipe (modular synthesis DSP), dr_wav
(WAV file I/O), cJSON (preset serialization), CMake build. ^[[synth/README.md]] The `synth_pro`
GUI build listens to external hardware over CoreMIDI — incoming note/CC/pitch data is queued
lock-free into the audio thread for sample-accurate playback. ^[[synth/README.md]]

Roadmap runs from basic oscillators → ADSR/filter → 8-voice polyphony with voice stealing →
presets, unison/detune, effects, and GUI. The repo carries many status/plan markdown files
(`AUDIO_ENGINE_STATUS.md`, `CURRENT_STATUS.md`, `REFACTOR_PLAN.md`, `SYNTH_GUI_PLAN.md`, etc.) —
worth mining if a synth concept ever gets promoted. ^[[synth/README.md]]

Shares the real-time-audio / Tone.js-adjacent domain with [[imgsic]] and [[itm]], but this one is
low-level C/DSP rather than web audio.
