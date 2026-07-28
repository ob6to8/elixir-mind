---
id: em:c56e31
type: concept
title: same-lineage comparison
description: An evaluation design that varies one property of a model while holding its family fixed, comparing two artifacts derived from a common ancestor so an observed gap cannot be attributed to architecture, scale, or training data.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evaluation, study-design, methodology, benchmarking]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# same-lineage comparison

The model-evaluation instance of a matched-pairs design. Cross-vendor benchmark tables are the thing it corrects: when GPT-class and Llama-class models differ on a behavior, the difference is uninterpretable as evidence about any single factor, because they differ in all of them at once. Restricting the comparison to a parent and its own descendant reduces the confound set to the one edit that produced the descendant.

The design also constrains what may vary *around* the models — prompt construction, serving stack, decoding parameters, and scoring code are held identical, since any of them reintroduces a confound the lineage control was meant to remove. Reporting a second, independent lineage that shows the same direction is the usual robustness check.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
