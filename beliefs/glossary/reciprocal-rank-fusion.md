---
id: em:3a365d
type: concept
title: reciprocal rank fusion
description: A rank-aggregation method that merges several ranked result lists by scoring each item as the sum, over the lists, of 1/(k + rank) — favoring items that rank well in any list without needing the lists' scores to be comparable.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, search, retrieval, ranking]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T00:50:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread and its vocabulary-mismatch analysis"
---

# reciprocal rank fusion

The standard glue of [hybrid search](/beliefs/glossary/hybrid-search.md):
lexical (BM25) and semantic (embedding) backends produce incommensurable
scores, and RRF sidesteps calibration entirely by combining positions instead.
Distinct from [mean reciprocal rank](/beliefs/glossary/mean-reciprocal-rank.md),
which is an *evaluation metric* over one system's rankings — RRF is a *fusion
method* that produces a ranking.

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md) · [beyond-grep ranked retrieval options](/meta/analysis/beyond-grep-ranked-retrieval-options.md) · [solving vocabulary mismatch offline](/meta/analysis/solving-vocabulary-mismatch-offline.md)
