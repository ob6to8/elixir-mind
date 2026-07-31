---
id: em:0a860c
type: concept
title: Turtle (Terse RDF Triple Language)
description: The W3C's human-readable text syntax for RDF, writing triples as subject–predicate–object statements with prefix abbreviations, semicolons for shared subjects, and commas for shared predicates.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, rdf, semantic-web, serialization, knowledge-graph]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the outlier format in the GraphRAG serialization benchmark intaken 2026-07-29"
---

# Turtle (Terse RDF Triple Language)

It is the syntax people actually write [RDF](/beliefs/glossary/rdf.md) in by
hand, being far terser than RDF/XML while staying a complete serialization of the
model; SPARQL's query syntax is deliberately built on the same shape.

Its terseness is relative to RDF/XML, not to formats generally, and the
difference matters when the consumer is a language model: every statement
repeats its subject IRI unless a `;` continuation applies, so an entity's
properties are spread across many syntactically similar lines. In the ISONGraph
benchmark it was the one format whose accuracy collapsed —
[multi-hop](/beliefs/glossary/multi-hop-reasoning.md) 10/21 where every other
format scored 16–18 — while costing more tokens than compact JSON.

*Seen in:* [Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
