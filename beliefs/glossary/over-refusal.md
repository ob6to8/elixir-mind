---
id: em:c42550
type: concept
title: over-refusal
description: A safety-trained model declining a request that its own policy permits — the false-positive half of refusal behavior, typically triggered by surface features of a prompt rather than by its actual intent.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-safety, alignment, evaluation, failure-modes]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# over-refusal

Also called false refusal. It is the cost side of the safety tradeoff that harmful-compliance benchmarks do not price: tightening refusal to catch more genuine misuse necessarily catches more legitimate requests that merely resemble it, and the two error rates move together. Dedicated benchmarks (OR-Bench) exist because a model optimized only against harmful compliance will happily refuse everything.

The domains worst affected are those whose legitimate vocabulary overlaps its illegitimate one — security research above all, where the words a defender needs are the words an attacker would use. Refusal rate is a poor instrument for it, since a model can avoid over-refusing while still degrading the answers it gives; see [coverage and quality must be measured jointly](/beliefs/coverage-and-quality-must-be-measured-jointly.md).

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>

*See also:* [dual-use](/beliefs/glossary/dual-use.md), [safety state](/beliefs/glossary/safety-state.md)
