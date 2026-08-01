---
id: em:d6666b
type: concept
title: progressive disclosure
description: Presenting a hierarchy one level at a time so a reader meets only the next choice rather than the whole tree — implemented in this bundle by an `index.md` at every directory level, rooted at `/index.md`.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, information-architecture, navigation, taxonomy, index]
sense: dual
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 refile-architecture-paper-and-link-integrity thread, where the read-path cost of id-referenced links turned on it"
---

# progressive disclosure

A general interface-design principle — show the next decision, defer the rest —
that this bundle applies to navigation rather than to screens. The mechanism is
the reserved
[`index.md`](/meta/policy/reserved-filenames.md): each one lists its directory's
documents and immediate subdirectories with a
[gloss](/beliefs/glossary/gloss.md) apiece, so an agent or reader descends by
reading one small file per level instead of loading a map of the whole tree. This
is the practical arm of
[the tree is the taxonomy](/beliefs/glossary/tree-is-the-taxonomy.md): the
hierarchy can *be* the canonical classification only because there is a cheap way
to walk it.

The property that makes it work is that each step costs one file read and
resolves to a path. Anything inserting a lookup between a link and its target —
an id that must be resolved through a registry, say — taxes every step of every
descent, which is why the addressing scheme for cross-links is a navigation
decision and not only a maintenance one (see
[id-referenced links vs. path links](/meta/analysis/id-referenced-links-vs-path-links.md)).

*Seen in:* [2026-08-01 refile and link-integrity thread](/meta/threads/2026-08-01-refile-architecture-paper-and-link-integrity.md)
