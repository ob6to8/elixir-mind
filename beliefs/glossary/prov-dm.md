---
id: em:322fa9
type: concept
title: PROV-DM (the PROV Data Model)
description: The W3C conceptual model of provenance — entities, activities, and agents with the relations tying them together — specified independently of any encoding, so a system can adopt its vocabulary without adopting RDF.
provenance: "Agent-distilled glossary definition (Claude Opus 5)"
verified: false
tags: [glossary, provenance, attribution, knowledge-representation, standards]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T07:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the attribution program adopts this model's vocabulary while declining its RDF encoding, so the model/encoding split is load-bearing"
---

# PROV-DM (the PROV Data Model)

Where [PROV-O](/beliefs/glossary/prov-o.md) expresses the same content as an
OWL ontology over [RDF](/beliefs/glossary/rdf.md) triples, PROV-DM is the
serialization-neutral layer beneath it — which is what makes "take the
semantics, skip the substrate" a coherent position rather than a fudge. Four
of its relations carry the weight in this bundle's attribution design:
`wasAttributedTo` (an entity traced to an agent), `wasGeneratedBy` (an entity
produced by an activity), `wasQuotedFrom` (an entity repeating part of
another — verbatim quotation as a first-class relation), and
`hadPrimarySource`. Its agent/activity split is the one that resolves a field
straining under two jobs: *who acted* is an agent, *the context it acted in*
is an activity.

*Seen in:* [span-level attribution](/meta/plans/span-level-attribution.md), [2026-08-01 schema-formalization thread](/meta/threads/2026-08-01-schema-formalization-and-span-attribution-plans.md)
