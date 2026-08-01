---
id: em:e8818e
type: concept
title: PROV-O (the PROV Ontology)
description: The W3C vocabulary for provenance in RDF — entities, activities, and agents, with relations recording what was derived from what, by which activity, attributed to whom — the standard target for serializing this bundle's provenance and attribution metadata.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, provenance, knowledge-representation, semantic-web, rdf]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-07-28T07:12:25Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "named in the OWL/belief-layer analysis as the data-layer target for extraction provenance"
---

# PROV-O (the PROV Ontology)

A W3C Recommendation (2013) expressing [PROV-DM](/beliefs/glossary/prov-dm.md) in
[RDF](/beliefs/glossary/rdf.md): three core classes — `Entity` (a thing),
`Activity` (something that happened to it), `Agent` (who bears responsibility)
— related by `wasDerivedFrom`, `wasGeneratedBy`, `wasAttributedTo`, and
`used`. It is the standard answer to statements *about* statements, the role
this bundle fills with its own [provenance](/beliefs/glossary/provenance.md) and
attribution frontmatter, and therefore the natural target vocabulary should
those fields ever be serialized into a derived export — including the
extraction provenance (which artifact, which span, which judge, when) a
derived belief graph would carry.

This bundle adopts the model without this encoding: the vocabulary is what the
attribution design needed, and the triple store is what it declined.

*Seen in:* [OWL and the belief layer](/meta/analysis/owl-and-the-belief-layer.md), [2026-07-28 OWL/RDF/SKOS thread](/meta/threads/2026-07-28-owl-rdf-skos-and-the-belief-layer.md), [2026-08-01 schema-formalization thread](/meta/threads/2026-08-01-schema-formalization-and-span-attribution-plans.md)
