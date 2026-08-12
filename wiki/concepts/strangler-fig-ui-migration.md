---
kind: concept
domain: projects
title: Shared data-layer strangler-fig pattern for UI migrations
course: "tradefabe"
---

# Shared data-layer strangler-fig pattern for UI migrations

When rebuilding a live UI's front end (framework, stack, or both) without being able to afford a
rewrite freeze, extract the *data and chart-shaping logic* the old UI already uses into a single
module that both the legacy UI and the new stack import from — rather than reimplementing that
logic twice and letting the two versions drift. ^[[sources/repos-tradefabe-readme]]

**Shape of the migration.** A Streamlit dashboard's data/chart-shaping code is pulled into a
standalone module the legacy `app.py` imports from (no behavior change to the live UI). A thin
read-only API layer (here, FastAPI) is then built over that same module, and a new front end (here,
Vite/React/TypeScript/Tailwind) is built incrementally against the API — one endpoint and one
screen at a time — while the legacy Streamlit app stays the only *live* UI throughout. Neither UI
duplicates the shaping logic; both call into the one shared source of truth.
^[[sources/repos-tradefabe-readme]]

**Why this avoids the two failure modes of a UI rewrite:** a big-bang rewrite risks a long freeze
on the legacy UI while the new one catches up, and a naive parallel rebuild risks the two UIs'
data logic silently drifting apart as each evolves independently. Sharing one data-layer module
underneath both eliminates the drift risk; building the new UI incrementally against a stable API
eliminates the freeze. ^[[sources/repos-tradefabe-readme]]

This is a specific application of the general **strangler fig pattern** (incrementally replacing a
legacy system by routing new functionality through it while the old system keeps running) to a
UI-and-data-layer migration specifically. Generalizable to any live-system UI rewrite that can't
afford downtime or a feature freeze during the transition.
