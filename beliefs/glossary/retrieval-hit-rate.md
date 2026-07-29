---
id: em:92ba1e
type: concept
title: retrieval hit rate
description: The fraction of gold-set queries for which the correct chunk(s) appeared anywhere in the retriever's returned set — the binary, coverage-only half of retrieval evaluation.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, evals, rag, retrieval, metrics]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 RAG-evaluation Reddit intake thread"
---

# retrieval hit rate

It answers only "did the right chunk surface at all", not "how prominently" —
that second question is [mean reciprocal rank](/beliefs/glossary/mean-reciprocal-rank.md),
the ranked companion metric scored over the same [gold set](/beliefs/glossary/gold-set.md).
Because the gold set is constructible (a human or another LLM annotates which
chunks a test question should pull from), hit rate is cheap to compute
mechanically and doesn't require judging the generated answer at all — it is a
[test oracle](/beliefs/glossary/test-oracle.md) applied to the retrieval stage
in isolation, which is what makes it possible to separate a retrieval defect
from a generation defect instead of scoring the pipeline as one blended unit.

*Seen in:* [Split retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md), [r/LLMDevs — evaluation is so much harder than actually building the model wrapper](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md)

*See also:* [mean reciprocal rank](/beliefs/glossary/mean-reciprocal-rank.md), [groundedness](/beliefs/glossary/groundedness.md)
