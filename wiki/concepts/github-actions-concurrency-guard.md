---
kind: concept
domain: projects
title: GitHub Actions concurrency guard for schedule + workflow_dispatch workflows
course: "tradefabe"
---

# GitHub Actions concurrency guard for schedule + workflow_dispatch workflows

Any GitHub Actions workflow that combines a `schedule` trigger with `workflow_dispatch` (manual
run capability) can silently execute concurrently with itself unless a `concurrency:` block says
otherwise — a scheduled run and a manually-triggered run (or two overlapping scheduled runs) can
both start and both write shared state before either commits. ^[[sources/repos-tradefabe-doctrine]]

**Why an in-code cap doesn't save you.** Even if application code enforces a promotion/write cap
(e.g. "promote at most N per day"), that cap is only as real as the assumption that runs are
serialized. Two overlapping runs can each read the current count before either writes, both see
the same headroom, and both act — the guard exists to make the serialization assumption actually
true, not just assumed. ^[[sources/repos-tradefabe-doctrine]]

**Fix pattern:** add `concurrency: {group: <workflow-name>, cancel-in-progress: false}` — queuing
rather than cancelling matters specifically for workflows that write incrementally, so a run
cancelled mid-write can't leave a partial/corrupt state file behind. ^[[sources/repos-tradefabe-doctrine]]

**Where this bites silently:** it's easy to add a new `schedule`-triggered workflow that copies an
existing one's trigger shape without copying its `concurrency:` block, since the omission produces
no error — only an intermittent double-write under the right timing. Worth an explicit audit
whenever a new cron-triggered workflow is added alongside an existing one, in this vault's own
scheduled `/lint`/`/sync-projects`/daily-project-sync automation included, not just trading-specific
CI. ^[[sources/repos-tradefabe-doctrine]]
