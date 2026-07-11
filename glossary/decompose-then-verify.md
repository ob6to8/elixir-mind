---
id: sb:bc34de
type: concept
title: decompose-then-verify
description: The evaluation pattern of atomizing a long output into individually checkable statements, verifying each against a source, and aggregating the local verdicts mechanically — validated at scale by FActScore and SAFE.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, evals, factuality, claim-decomposition, methodology]
timestamp: 2026-07-11
---

# decompose-then-verify

The evaluation pattern of atomizing a long generation into
[atomic facts](/glossary/atomic-fact.md), verifying each independently against
a knowledge source, and aggregating the local verdicts into a score
mechanically — beating holistic judging because it localizes error and makes
factuality additive and auditable per claim. Validated at scale by
[FActScore](/glossary/factscore.md) and [SAFE](/glossary/safe.md); the
empirically grounded core that belief-decomposition generalizes from
support-checking to entailment and conflict. Canonically covered in
[decompose-then-verify factuality evaluation](/SWE/evals/decompose-then-verify-factuality.md).

*Seen in:* [decompose-then-verify factuality reference](/SWE/evals/decompose-then-verify-factuality.md), [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
