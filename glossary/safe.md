---
id: sb:371597
type: concept
title: SAFE (Search-Augmented Factuality Evaluator)
description: Wei et al.'s open-domain factuality checker (NeurIPS 2024) — split a response into facts, revise each to be self-contained, then iteratively search and reason to label it; matches human annotators 72% of the time at >20× lower cost.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, evals, factuality, search]
timestamp: 2026-07-11
---

# SAFE (Search-Augmented Factuality Evaluator)

Wei et al.'s open-domain factuality checker (NeurIPS 2024): split a long-form
response into individual facts,
[decontextualize](/glossary/decontextualization.md) each into a self-contained
claim, filter for relevance, then iteratively issue Google Search queries and
reason over results to label each claim supported / not-supported /
irrelevant. Benchmarked on LongFact and aggregated via
[F1@K](/glossary/f1-at-k.md). Canonically covered in
[decompose-then-verify factuality evaluation](/SWE/evals/decompose-then-verify-factuality.md).

*Seen in:* [decompose-then-verify factuality reference](/SWE/evals/decompose-then-verify-factuality.md)
