---
id: em:1aae91
type: concept
title: Dublin Core
description: The most widely deployed descriptive-metadata vocabulary, standardized as ISO 15836, whose small set of general elements names the fields nearly every document-metadata scheme independently converges on.
provenance: "Agent-distilled glossary definition (Claude Opus 5)"
verified: false
tags: [glossary, metadata, standards, schema, frontmatter]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T07:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "supplies the created/modified naming this bundle's date fields realign to"
---

# Dublin Core

Named for the 1995 workshop in Dublin, Ohio that produced it, maintained by
the DCMI, and reachable in two layers: the original fifteen elements
(`title`, `creator`, `subject`, `date`, `source`…) and the larger `dcterms`
refinement set that splits the coarse ones — `dcterms:created` and
`dcterms:modified` being the pair that separates when a thing came into
existence from when it last changed. Library catalogs, institutional
repositories, schema.org's lineage, and most static-site frontmatter
conventions all inherit from it, and the W3C designed
[PROV](/beliefs/glossary/prov-dm.md) to interoperate with it.

For a scheme that already carries `title`, `description`, and `source` under
those names, adopting its date vocabulary is less an adoption than finishing a
sentence already started.

*Seen in:* [span-level attribution](/meta/plans/span-level-attribution.md), [2026-08-01 schema-formalization thread](/meta/threads/2026-08-01-schema-formalization-and-span-attribution-plans.md)
