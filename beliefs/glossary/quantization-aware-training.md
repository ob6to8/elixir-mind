---
id: em:40976d
type: concept
title: quantization-aware training
description: Training a model with the target low-precision arithmetic simulated in the forward pass, so its weights learn to compensate for quantization error instead of absorbing it after training ends.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, quantization, training, ml-infrastructure, model-serving]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Kimi K3 model-card intake"
---

# quantization-aware training

The contrast is with post-training quantization, which takes a finished
full-precision model and rounds it down — a lossy transformation whose damage
varies unpredictably by model and task, and which is why a 4-bit community quant
warrants end-to-end evaluation before it is trusted. QAT moves that rounding
inside the optimization, so gradient descent routes around the representational
limits it will actually face at inference. It need not run for the whole budget:
starting at the supervised-fine-tuning stage is enough to claim the low-bit
checkpoint as the model rather than a degraded copy of one.

The consequence for anyone selecting a model is that the deployment question
shifts. Rather than asking how much accuracy a given quantization costs, ask
whether the released checkpoint *is* the trained artifact — which is the claim
Moonshot makes for Kimi K3's [MXFP4](/beliefs/glossary/mxfp4.md) weights.

*Seen in:* [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [quantization](/beliefs/glossary/quantization.md), [MXFP4](/beliefs/glossary/mxfp4.md)
