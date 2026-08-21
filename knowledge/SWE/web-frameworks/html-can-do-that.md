---
id: em:437cf0
type: reference
title: "HTML can do that (Chris Burnell)"
description: A survey of HTML/CSS features now natively supported by browsers without JavaScript — popovers, the dialog element with invoker commands, mutually-exclusive details groups, anchor positioning, and hidden-until-found — with adoption limited more by inconsistent browser support than by capability.
resource: https://chrisburnell.com/article/html-can-do-that/
provenance: "Chris Burnell, chrisburnell.com, fetched 2026-08-21; discussed on Hacker News (item 49362689)"
tags: [html, css, web-frameworks, browser-standards, progressive-enhancement]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# HTML can do that

A catalog of browser-native HTML/CSS features that replace patterns
developers commonly reach for JavaScript (or a dedicated library) to build.

## Featured capabilities

- **Popovers** — automatic stacking and cascading close behavior with no
  script
- **`<details>` groups** — mutual exclusivity across a set via a shared
  `name` attribute, like radio buttons
- **Anchor positioning** — CSS-native dynamic placement of one element
  relative to another
- **`<dialog>` with invoker commands** — native modal dialogs
- **Richer form inputs** — `date`, `color`, and `datalist` types with native
  browser UI
- **`hidden=until-found`** — content hidden by default but still reachable
  by in-page search

## Where native still falls short

`datalist` in particular cannot enforce validation or provide fuzzy
matching/typo tolerance, so a dedicated library is still the practical
choice for anything beyond a simple suggestion list — one of several places
commenters noted a gap between "browsers technically support this" and
"this is production-ready everywhere," since Firefox and Safari lag on some
of these features.

## Relevance

Read alongside this bundle's other framework-boundary documents
([Hologram](/knowledge/SWE/web-frameworks/hologram.md),
[Phoenix frontend options](/knowledge/SWE/web-frameworks/phoenix-liveview-vs-inertia-vs-spa.md))
as the other end of the same question — how much of what a framework or a
JS library provides is now just what the platform provides, if you're
willing to accept browser-support gaps.

# Citations

- <https://chrisburnell.com/article/html-can-do-that/>
- <https://news.ycombinator.com/item?id=49362689> — Hacker News discussion
