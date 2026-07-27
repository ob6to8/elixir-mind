---
id: em:b78fb8
type: concept
title: abliteration
description: A weight-space edit that suppresses a model's refusal behavior by projecting the residual-writing matrices away from a learned refusal direction, producing a descendant that answers requests its parent would decline.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-safety, alignment, model-editing, refusal]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# abliteration

A portmanteau of *ablation* and *obliteration*, coined in the open-weights community for the practical recipe built on the [refusal direction](/beliefs/glossary/refusal-direction.md) result. Applied to the weights as `W′ = (I − α·r rᵀ)W`, it needs no retraining and no gradient step — one projection per targeted matrix — which is why abliterated descendants of popular open models circulate as ordinary downloadable checkpoints, typically re-quantized afterward.

The intervention is cruder than a targeted alignment change: it removes a *direction*, not a policy, so it degrades whatever else that direction encoded. Measured effects therefore run in both directions — abliterated models can gain on tasks their parent handled timidly and lose on tasks the parent handled well — which is what makes an aligned-versus-abliterated pair a usable experimental control rather than simply a "safety off" switch.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>

*See also:* [refusal direction](/beliefs/glossary/refusal-direction.md), [safety state](/beliefs/glossary/safety-state.md), [over-refusal](/beliefs/glossary/over-refusal.md)
