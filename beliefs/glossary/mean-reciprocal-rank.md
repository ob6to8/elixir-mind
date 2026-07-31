---
id: em:1c5e08
type: concept
title: mean reciprocal rank
description: An information-retrieval metric averaging, across a set of queries, the reciprocal of the position at which the first correct result appeared — rewarding a correct result ranked first far more than one buried on page two.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, evals, rag, retrieval, metrics, information-retrieval]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 RAG-evaluation Reddit intake thread"
---

# mean reciprocal rank

Where [retrieval hit rate](/beliefs/glossary/retrieval-hit-rate.md) only asks
whether the correct chunk appeared anywhere in the returned set, MRR asks how
high — a correct-but-buried result scores far lower than a correct result
ranked first, since the per-query score is `1/rank`. The two metrics are
computed over the same [gold set](/beliefs/glossary/gold-set.md) of
query-to-correct-chunk pairs and are usually reported together: hit rate as
the coverage floor, MRR as the ranking-quality signal on top of it.

*Seen in:* [Split retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md), [r/LLMDevs — evaluation is so much harder than actually building the model wrapper](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md)

*See also:* [retrieval hit rate](/beliefs/glossary/retrieval-hit-rate.md)
