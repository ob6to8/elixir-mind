---
id: em:005615
type: concept
title: GraphRAG
description: Retrieval-augmented generation whose corpus is a knowledge graph rather than a flat set of documents — retrieval returns a subgraph of entities and their relationships, which is then serialized into the prompt as text.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, graphrag, rag, knowledge-graph, retrieval, context-engineering]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the central term of the r/LLMDevs serialization thread intaken 2026-07-29"
---

# GraphRAG

What it buys over flat [RAG](/beliefs/glossary/retrieval-augmented-generation.md)
is reachability: a query that needs two entities connected through a third has no
single chunk containing the answer, but does have a path in the graph, so
retrieval can return the path rather than hoping one document happens to state
the conclusion. That makes it the standard answer for
[multi-hop](/beliefs/glossary/multi-hop-reasoning.md) questions over a
[knowledge graph](/beliefs/glossary/knowledge-graph.md).

It also adds a stage flat RAG does not have. A retrieved *subgraph* is not text,
so something must render it — as JSON, as
[Turtle](/beliefs/glossary/turtle.md), as a Cypher-like listing, as a table — and
that rendering is what the model actually reads. The choice is usually made once
by whatever `json.dumps` was nearest and never measured again.

*Seen in:* [Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
