---
id: em:461f5e
type: concept
title: retrieval-augmented generation (RAG)
description: Answering with a language model by first retrieving relevant material from an external corpus and placing it in the prompt, so the answer is grounded in a body of text the model was never trained on and can be updated without retraining.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, retrieval, rag, context-engineering, llm-engineering]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the GraphRAG serialization thread as the pipeline family the claim is about"
---

# retrieval-augmented generation (RAG)

The pattern is a pipeline, and each stage is a separate engineering decision:
chunking the corpus, embedding and indexing it, retrieving candidates for a
query (often [lexically](/beliefs/glossary/lexical-search.md) and by vector
similarity together — see [hybrid search](/beliefs/glossary/hybrid-search.md)),
reranking them, and finally rendering the survivors into the prompt. Practice
instruments the middle stages heavily and the last one barely, which is what
[GraphRAG](/beliefs/glossary/graphrag.md)'s serialization question exposes: the
text handed to the model is produced by a formatting choice nobody measured.

Its appeal is that the knowledge lives outside the weights — corpus updates take
effect immediately, citations are available, and access control stays at the
retrieval layer — at the cost of everything the retrieval stage gets wrong being
invisible to the model, which will answer confidently from whatever it was
given.

*Seen in:* [Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md), [Pruning RAG context with a small LLM before generation](/knowledge/SWE/llm-engineering/rag-context-pruning-with-a-small-llm.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
