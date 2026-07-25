---
type: policy
title: Provenance lives in metadata, not body prose
description: When a document's frontmatter already records where its content came from (provenance, attribution and its from back-links), the body and index glosses must not restate the sourcing — no "from the journal entry", no "at operator direction"; a source appears in prose only as a plain link when it is load-bearing content, never as acknowledgement.
section: filing
order: 10
status: active
tags: [meta, governance, filing, attribution, provenance, composition]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T21:55:00Z
  channel: agent-authored
  agent: "Claude Code agent, journal-skill session"
  why: "the operator directed that explicit source acknowledgement be left out of documents wherever it is redundant with the metadata"
  from: [/meta/threads/2026-07-25-journal-skill-and-first-entry.md]
---

**Provenance lives in metadata, not body prose.** A document's sourcing is
already recorded structurally — `provenance` (where the content came from),
`attribution` (how it entered, including the `from` back-link to its thread) —
so the body must not restate it. No "from the first journal entry", no
"distilled from thread X", no "at operator direction" in body prose, and none
in the `index.md` gloss that lists the doc. The body states the knowledge;
the metadata states the origin.

- **The test: does the sentence lose meaning, or only credit, if the reference
  is removed?** A *credit-only* reference is metadata and belongs in
  frontmatter. A *load-bearing* reference — a citation supporting a claim, the
  grounding analysis a doctrine is judged against, a document the reader must
  follow to understand the argument — stays, as a plain cross-link per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md),
  without acknowledgement framing around it.
- **Why.** Acknowledgement prose is a shadow copy of the attribution record:
  unchecked where the metadata is machine-verified, stale-prone where
  governance `from` is append-only, and a leak of record-layer content into
  the knowledge layer (see
  [fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)).
  One origin, one home.
- **Scope.** Bundle documents, governance docs, and their index glosses alike.
  Thread docs are exempt — they *are* the record, and their narrative sections
  legitimately speak in terms of who said and did what. Frontmatter fields
  (`provenance`, `attribution.why`) are the sanctioned home for origin prose
  and are untouched by this rule.
