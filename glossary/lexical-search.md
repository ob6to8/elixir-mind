---
id: sb:69e569
type: concept
title: lexical search
description: Retrieval that matches on surface tokens — shared words or character sequences — rather than meaning; fast and precise on exact terms but blind to synonym and jargon gaps.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, search, information-retrieval]
timestamp: 2026-07-12
---

# lexical search

Retrieval that matches on **surface tokens** — the actual words or character sequences a query and a document share — rather than on meaning. Keyword search, full-text indexes, and `grep` are all lexical. It is fast and precise when the exact term is used, but it is blind to the synonym/jargon mismatches that [semantic search](/glossary/semantic-search.md) bridges (and that [BM25](/glossary/bm25.md) ranks but does not close). In this brain, intake [deduplication](/glossary/deduplication.md) runs on lexical search over concept titles, descriptions, tags, and bodies — which is exactly why its [recall](/glossary/recall.md) is the weak point the [dedup-recall probe](/meta/plans/dedup-recall-probe.md) measures.

*Seen in:* [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md), [2026-07-09 vector-DB recall thread](/meta/threads/2026-07-09-vector-db-recall-evaluation-and-analysis-type.md)

*See also:* [semantic search](/glossary/semantic-search.md), [BM25](/glossary/bm25.md), [hybrid search](/glossary/hybrid-search.md), [recall](/glossary/recall.md)
