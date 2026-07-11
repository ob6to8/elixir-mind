---
id: sb:7ecfb6
type: concept
title: LLM-as-judge
description: Using a language model's judgment in place of human annotation for evaluation tasks, validated by measured agreement with human raters — e.g. SAFE matching crowdworkers 72% of the time and winning 76% of disagreements at >20× lower cost.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evals, llm, annotation, methodology]
timestamp: 2026-07-11
---

# LLM-as-judge

Using a language model's judgment in place of human annotation for an
evaluation task — rating, labeling, or verifying outputs — with the
substitution validated by measured agreement against human raters rather than
assumed. The decompose-then-verify factuality results are the canonical
validation: SAFE matches crowdworkers 72% of the time and wins 76% of
adjudicated disagreements at more than 20× lower cost. The same pattern
underlies per-edge belief-graph judgments: local, cacheable model verdicts
composed by mechanical aggregation.

*Seen in:* [decompose-then-verify factuality reference](/SWE/evals/decompose-then-verify-factuality.md), [belief-decomposition plan](/meta/plans/belief-decomposition-analysis-mode.md)
