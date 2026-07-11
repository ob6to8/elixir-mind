---
id: sb:6a6054
type: concept
title: F1@K
description: SAFE's long-form factuality aggregate — harmonic mean of factual precision (fraction of supplied facts supported) and recall against K, a stipulated facts-per-response target; penalizes both fabrication and under-informing.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evals, metrics, factuality]
timestamp: 2026-07-11
---

# F1@K

The aggregate metric of the SAFE long-form-factuality work: the harmonic mean
of factual **precision** (the fraction of a response's supplied
[atomic facts](/glossary/atomic-fact.md) that are supported) and **recall
against K**, where K is a stipulated facts-per-response target standing in for
the user's preferred response length. The recall arm is the point: precision
alone rewards a model for answering in one timid, safe sentence, so the metric
penalizes under-informing as well as fabrication. Companion metric to
[recall@k](/glossary/recall-at-k.md) in this glossary's retrieval cluster —
same "@K" convention, different task.

*Seen in:* [decompose-then-verify factuality reference](/SWE/evals/decompose-then-verify-factuality.md)
