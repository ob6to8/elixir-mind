---
id: em:725a08
type: concept
title: groundedness
description: The property that a generation asserts only what its supporting context actually contains — evaluated by comparing the answer against the retrieved evidence, rather than by judging correctness against an external reference.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, evals, rag, hallucination, llm-as-judge]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 RAG-evaluation Reddit intake thread"
---

# groundedness

A groundedness check sidesteps the need for a reference answer: instead of
asking "is this a good answer" (open-ended, no cheap oracle), it asks "did the
answer use the retrieved context, and did it add anything that isn't in the
context" — a narrower, mechanically checkable question that catches
[hallucination](/beliefs/glossary/hallucination.md) without needing ground
truth. It is the same decompose-then-verify shape used by
[LLM-as-judge](/beliefs/glossary/llm-as-judge.md) factuality checkers
(FActScore, SAFE), narrowed to a single evidence source — the chunk the
pipeline itself retrieved — instead of an open web search.

Its blind spot is inherited from upstream: when the retrieved chunk is
subtly wrong (adjacent to the right answer but not quite it), the generation
can be perfectly grounded in bad context and the check passes anyway. A
passing groundedness score is therefore evidence the generation stage
behaved, not evidence the pipeline as a whole is correct — it does not
substitute for [retrieval hit rate](/beliefs/glossary/retrieval-hit-rate.md)
evaluation, which catches exactly the failure groundedness cannot see.

*Seen in:* [Split retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md), [r/LLMDevs — evaluation is so much harder than actually building the model wrapper](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md)

*See also:* [hallucination](/beliefs/glossary/hallucination.md), [retrieval hit rate](/beliefs/glossary/retrieval-hit-rate.md)
