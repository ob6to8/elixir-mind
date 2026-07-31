---
id: em:ff9316
type: concept
title: multi-hop reasoning
description: Answering a question that requires chaining two or more separate facts, where no single retrieved item states the answer and the model must traverse from one relationship to the next.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, reasoning, retrieval, knowledge-graph, evaluation]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the question category the GraphRAG serialization benchmark separates out"
---

# multi-hop reasoning

"Who are Carol's followers' followers?" needs two traversals; "who follows
Carol?" needs one. The distinction matters for evaluation because single-hop
questions saturate — every reasonable representation scores near-perfectly — so
aggregate accuracy is dominated by the easy majority and hides the effect being
measured. Benchmarks that break accuracy out by hop count are reporting the
signal; those that report one number are usually reporting how many single-hop
questions they contained.

It is also where representation shows up. A format that scatters an entity's
edges across a verbose syntax forces the model to reconstruct adjacency before it
can traverse, and the cost lands entirely on the multi-hop subset.

*Seen in:* [Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
