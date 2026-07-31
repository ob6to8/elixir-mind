---
id: em:c60c8e
type: concept
title: structured data
description: Data whose organization is fixed and known ahead of reading it, so a consumer can locate a field by its position in the layout; contested in practice against the looser sense of any data carrying machine-readable markup.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, data-modeling, serialization, terminology]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the definitional axis the r/LLMDevs serialization dispute turned on"
---

# structured data

The two senses in circulation are worth keeping apart because arguments run
aground on them. The **strict** sense is positional: a fixed schema where row
*n*, column *m* means one thing whether or not a value is present, so a consumer
can sort, index, or pivot on the structure without parsing any of the content —
the sense inherited from tabular and record-oriented systems. The **loose**
sense, dominant since JSON, is any self-describing format where fields carry
their own names, in contrast to unstructured prose.

A columnar text encoding satisfies both — a header row names the columns once
and each subsequent row is positional — which is why the distinction is a poor
weapon in a format argument: the strict sense excludes per-record key repetition,
not tabular layout, and the loose sense excludes almost nothing.

*Seen in:* [Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
