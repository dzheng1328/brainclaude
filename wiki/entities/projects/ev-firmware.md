---
kind: project
domain: projects
title: ev (Duke Electric Vehicles firmware)
repo: https://github.com/dukeelectricvehicles-25-26/DEV-2025-26-Firmware
path: /Users/dzheng/Documents/ev
stack: [C/C++, PlatformIO, CANbus]
status: active
last_modified: 2026-03-28
---

# ev — Duke Electric Vehicles firmware

Dave's local checkout of the **Duke Electric Vehicle Club** software platform — firmware for the
programmable modules on the DEV platform. ^[[ev/DEV-2025-26-Firmware/README.md]]

The `ev/` folder holds **two org-owned repos** (remotes under `github.com/dukeelectricvehicles-25-26`,
not Dave's personal account):
- `DEV-2025-26-Firmware` — structured into `boards/` (each subdir a PlatformIO project for a
  programmable module) and a common `libcannetwork` library implementing the CANbus messaging
  spec between boards. ^[[ev/DEV-2025-26-Firmware/README.md]]
- `DEV_25-26` — a second repo with `CAN_write` / `CAN_receiver` components.

This is **team/club work**, not a solo project — the code is owned by the DEV org, and Dave is a
contributor. Domain is `projects`, but it also carries extracurricular/team context. Embedded
CANbus + PlatformIO here is adjacent to the hardware skills in [[hw-cnn-accelerator]] and
[[ece-350-connect4]], though this is embedded firmware rather than FPGA/RTL.

**Docs snapshotted into the vault** (2026-07-17) — because this repo is external and team-owned,
its knowledge could vanish if Dave loses access, so the team-authored docs were mirrored into
`raw/repos/ev-firmware/` (docs only, never code):
- `README.md` — platform/board/library layout ^[[repos/ev-firmware/README.md]]
- `AGENTS.md` — engineering conventions: all CAN code lives in `libcannetwork`; advanced C++
  (`constexpr`, `std::atomic`, templates) forbidden; undergrad-focused simplicity ^[[repos/ev-firmware/AGENTS.md]]
- `docs/canlibrary.md` — the substantive knowledge: the `g_vehicle` global shared-state model,
  the `DevBoard` enum (COMMUNICATIONS/PERIPHERALS/MOTOR_CONTROLLER/POWER_DISTRIBUTION/THROTTLE/
  JOULEMETER), per-board "update only your own signals, read others" discipline, and ESP32 vs
  Teensy 4.1 timer setup ^[[repos/ev-firmware/canlibrary.md]]

The **CANbus shared-state architecture** (one global vehicle struct, each board writes only its
own fields on a periodic timer) is a genuinely reusable embedded pattern — a candidate concept
page if `/ingest` promotes it.

## Flagged for /ingest review

- 2026-07-31 sync: `README.md` and `docs/canlibrary.md` unchanged (repo `HEAD` still `c056be5`,
  same as the 2026-07-17 snapshot). `AGENTS.md` re-synced — **not a live change**: `git log`/
  `git diff` on the DEV-2025-26-Firmware repo confirm `AGENTS.md` hasn't been touched since
  commit `a381eee` (2026-02-28) and the working tree is clean, but the original 2026-07-17
  snapshot was missing the file's trailing two lines (a blank line + an empty `# ` heading
  marker). Re-synced to correct that completeness gap; `commit:` stays `c056be5` on both the
  raw snapshot and its source card since nothing upstream actually changed. Not a concept —
  operational/provenance only.
