---
id: sb:5e7da1
type: concept
title: recall
description: In information retrieval, the fraction of relevant items that a search actually surfaces for a query; low recall means existing relevant material is missed.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, search, information-retrieval]
timestamp: 2026-07-12
---

# recall

In information retrieval, the fraction of relevant items that a search actually surfaces for a query. Low recall means existing relevant material is missed — the failure mode that matters for [dedup](/glossary/deduplication.md) at intake time.

A **recall failure** at intake sets off a quiet chain: intake dedup runs a [lexical search](/glossary/lexical-search.md) for an existing home; because that search misses the semantically-equivalent concept (it shares meaning but not enough surface tokens), intake concludes *nothing exists* and files a **new** concept beside the one it should have updated. Nothing errors — the miss is invisible at write time — so the duplicate lands silently and the two concepts drift apart, splitting one subject's knowledge across [residual fragments](/glossary/residual-fragmentation.md). That is why low recall is dangerous rather than merely lossy: it converts a retrieval gap into committed [fragmentation](/glossary/deduplication.md) that only a later editorial pass, not an error message, can catch.

*Seen in:* [2026-07-09 vector-DB recall thread](/meta/threads/2026-07-09-vector-db-recall-evaluation-and-analysis-type.md), [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md)

*See also:* [recall probe](/glossary/recall-probe.md), [recall@k](/glossary/recall-at-k.md), [lexical search](/glossary/lexical-search.md), [residual fragmentation](/glossary/residual-fragmentation.md)
