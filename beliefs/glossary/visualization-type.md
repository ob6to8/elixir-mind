---
id: em:2ef786
type: concept
title: visualization (type)
description: The controlled type for a self-contained interactive page a reader launches to manipulate a model directly, filed as a document pair — the .md carrying identity and a launch field, a same-slug sibling .html carrying the artifact.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, types, visualization, explorable-explanations]
sense: repo
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the evolutionary-search explorable and visualization-type thread"
---

# visualization (type)

Defined in the [controlled-type vocabulary](/meta/policy/controlled-type-vocabulary.md).
Distinct from a `snippet` (a fragment to paste elsewhere, not a page to open),
a [methodology](/beliefs/glossary/methodology-type.md) (the how-to for
*building* one — see [explorable explanation](/beliefs/glossary/explorable-explanation.md)),
and a `reference` (a capture of someone else's material, whereas a
visualization is authored here). The `launch` field names the sibling
`.html`; self-containment (inline CSS/JS, no `fetch`, no ES modules) is a
mechanical requirement, not a style preference — over `file://`, both fetch
and module imports fail CORS, which is exactly what makes the local-launch
property hold. `mix brain.verify` rule 9 enforces the pairing. Introduced
and executed via [the visualization-type-and-local-launch plan](/meta/plans/visualization-type-and-local-launch.md).

*Seen in:* [2026-07-31 evolutionary search explorable and the visualization type](/meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md)
