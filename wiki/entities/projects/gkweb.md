---
kind: project
domain: projects
title: gkweb
repo: https://github.com/dzheng1328/gkweb
path: /Users/dzheng/Documents/gkweb
stack: [Next.js 16, TypeScript, i18n]
status: active
last_commit: 2026-05-23
---

# gkweb

A **Next.js 16 marketing site for Green-Keen Consulting**, a cross-border US/China accounting
firm. ^[[gkweb/CLAUDE.md]]

Every user-facing route is internationalized under `app/[lang]/` with an `/en/...` or
`/zh-CN/...` prefix; supported locales `en` and `zh-CN` are defined in
`app/[lang]/dictionaries.ts`, with dictionaries as JSON. The root `app/page.tsx` /
`app/layout.tsx` are a legacy landing shell — the real content lives under `app/[lang]/`, wrapped
by `<SiteHeader>`/`<SiteFooter>`/`<ScrollRevealReset>` and pre-rendered for both locales via
`generateStaticParams`. No test suite is configured. ^[[gkweb/CLAUDE.md]]

This is a **client project** (a real firm's site), distinguishing it from Dave's personal/portfolio
builds — the only one in the current set that is work-for-a-third-party rather than self-directed.
Green-Keen is a cross-border US/China **accounting firm**, which lines up with a planning doc found
in Drive: a 6-phase stack/build spec (Next.js 15/React 19, Shadcn+Aceternity+Magic UI for the landing
page, Zod-validated lead-gen forms including a tax/ROI calculator, WCAG 2.2 + schema.org production
checklist). ^[[sources/drive-gkweb-2026-accounting-firm-platform-spec]] Read as **roadmap/research**,
not an as-built record — the live repo (Next.js 16 per its own `CLAUDE.md`) is the source of truth for
what's actually shipped; the spec may describe planned-but-not-yet-built features.
