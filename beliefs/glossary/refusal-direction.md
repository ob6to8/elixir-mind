---
id: em:a1a6e2
type: concept
title: refusal direction
description: A single direction in a language model's activation space that mediates whether it declines a request — found as the normalized difference between the mean hidden states of refusal-eliciting and ordinary prompts, and suppressible or amplifiable by projection.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-safety, interpretability, alignment, refusal]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# refusal direction

Established by Arditi et al. (NeurIPS 2024) as a mechanistic-interpretability result: at a chosen layer, `r = (μᴿ − μᴬ) / ‖μᴿ − μᴬ‖` over centroids of the two prompt sets. Subtracting its projection from the hidden state — `h′ = h − α·r(rᵀh)` — suppresses refusal; adding it induces refusal on prompts that would otherwise be answered, which is the evidence that the direction is causal rather than merely correlated.

Its significance beyond safety work is what it implies about representation: a behavior as policy-laden as declining a request turns out to be linearly encoded and editable with a rank-one operation, making refusal one of the few high-level model behaviors that is straightforwardly *perturbable* rather than only observable. [Abliteration](/beliefs/glossary/abliteration.md) is the weight-space application.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
