---
id: em:dcffa5
type: concept
title: derived view
description: A data structure computed from a canonical source to serve queries the source's native form answers poorly — legitimate exactly as long as it stays disposable, holding nothing the source cannot regenerate.
provenance: "Agent-distilled glossary definition, 2026-07-25 session"
verified: false
tags: [glossary, storage, architecture, derived-views]
sense: dual
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T23:40:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-25 journal-skill thread's derived-views doctrine and database tutorial"
---

# derived view

The common database sense: a view, index, or materialized table computed from base tables, safe to drop and rebuild because the base data holds all the truth.

**In this brain:** every committed generated artifact — the id registry, the glossary `## Terms` listing, the route-tag excerpt logs, the site's search index — is a derived view over the markdown files, [materialized](/beliefs/glossary/materialize.md) to disk and freshness-gated in CI. The governing rule is [derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md): a view may cache, index, and accelerate, but never *know* anything the files don't — the day a fact lives only in a view, it has become a second source of truth and the markdown→database line has been crossed.

*Seen in:* [2026-07-25 journal-skill thread](/meta/threads/2026-07-25-journal-skill-and-first-entry.md), [journal 2026-07-25](/journal/2026-07-25.md), [future beliefs](/beliefs/future-beliefs.md) (the "derive the graph, never author it" entry states the same discipline for belief-graph work)
