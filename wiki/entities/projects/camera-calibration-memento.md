---
kind: project
domain: projects
title: CameraCalibration (memento)
repo: https://github.com/dzheng1328/CameraCalibration.git
path: /Users/dzheng/Documents/CameraCalibration-memento
stack: [C#, .NET Framework, WinForms, Spinnaker SDK, Python]
status: shipped
last_commit: 2026-08-04
---

# CameraCalibration (memento)

A **personal snapshot, not the working repository** — camera calibration/measurement
tooling built during a summer 2026 RTX internship: a WinForms (.NET Framework) app that
pairs a Spinnaker machine-vision camera with a Leica theodolite to calibrate and validate
3D point measurements. ^[[CameraCalibration-memento/README.md]]

Reconstructed after the fact from local copies Dave had on hand, so it's intentionally
incomplete — missing project/solution files, resources, and image assets that never made
it out of the internship's own repo are stubbed with placeholder files so the folder
structure matches the real project. `CameraCalibration.Core/` holds the calibration math
and hardware interfaces (camera, theodolite, vision); `CameraCalibration.UI/` is the
WinForms front end plus a Python script for reviewing results. Not buildable as-is —
several `.csproj`/`.sln`/resource files are placeholders pending recovery. Kept as a
record of the work, not a runnable deliverable. ^[[CameraCalibration-memento/README-MEMENTO.md]]

Spotted as an unregistered project directory by `/sync-projects` on 2026-08-04 and
2026-08-05; carded now per Dave's go-ahead.
