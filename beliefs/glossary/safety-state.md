---
id: em:52184b
type: concept
title: safety state
description: Whether a model's refusal behavior is intact or has been ablated — treated as an experimental variable in its own right, so that behavioral differences can be attributed to alignment rather than to architecture, scale, or training data.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-safety, alignment, evaluation, study-design]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# safety state

The construct exists to make alignment *manipulable* in an experiment. Comparing a safety-tuned frontier model against a permissive one from a different vendor confounds alignment with every other difference between them; holding one model fixed and varying only whether its refusal circuitry has been [abliterated](/beliefs/glossary/abliteration.md) isolates the factor. Conventionally written as the two levels ALIGNED and ABLITERATED.

Its limit is that public abliterated artifacts are released models, not laboratory controls — they typically carry [quantization](/beliefs/glossary/quantization.md) and format conversion alongside the refusal surgery — so a safety-state comparison is a matched-lineage design rather than a clean causal intervention.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>

*See also:* [same-lineage comparison](/beliefs/glossary/same-lineage-comparison.md)
