---
id: em:4086a2
type: concept
title: folksonomy
description: A classification that emerges from uncoordinated free-text tagging rather than a governed vocabulary — cheap to write and able to express cross-cutting facets, but prone to synonym drift that degrades retrieval.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, taxonomy, tags, classification, retrieval]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the 2026-07-27 scar-tissue session's tag-governance strand — the regime the tags axis defaulted into unratified"
---

# folksonomy

The bargain is deliberate: no one must agree on a vocabulary before writing,
so tagging costs nothing at the point of filing and can express facets a
single hierarchy cannot (one document reachable from several angles). What it
gives up is *convergence* — nothing makes two writers pick the same string for
the same idea, so near-synonyms accumulate and a query on one misses documents
tagged with the other. The failure is invisible at write time and only shows
up as a retrieval miss later, which is why it is measured rather than
inspected.

**In this brain:** the regime the `tags` frontmatter field sits in by
default — never ratified, unlike the directory tree (the canonical taxonomy,
gated by the
[taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md))
and the `type` field (a controlled vocabulary). The
[tag-governance plan](/meta/plans/tag-governance.md) makes that implicit
choice explicit and decides whether to keep it, measuring sprawl first
because `/intake`'s dedup search reads tags, so tag idiolects erode entry-gate
recall directly.

*Seen in:* [tag-governance plan](/meta/plans/tag-governance.md), [2026-07-27 scar-tissue session](/meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md)

*See also:* [tree is the taxonomy](/beliefs/glossary/tree-is-the-taxonomy.md), [deduplication](/beliefs/glossary/deduplication.md), [recall](/beliefs/glossary/recall.md), [synonym expansion](/beliefs/glossary/synonym-expansion.md)
