---
id: em:630624
type: concept
title: attention residuals
description: A drop-in replacement for standard residual connections in which a layer attends over the representations of arbitrary earlier layers rather than reading only the running sum handed to it by its immediate predecessor.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, transformer-architecture, residual-connections, mixture-of-experts]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Kimi K3 model-card intake"
---

# attention residuals

A plain residual stream is a single accumulator: information a layer needs from
twelve layers back has to have survived every intervening addition. Making the
skip connection *learned and selective* lets a layer reach past that erosion to
the depth where the representation it wants actually lives.

The gain is reported to be largest in
[mixture-of-experts](/beliefs/glossary/mixture-of-experts.md) models, which is
plausible on the mechanism: different experts fire at each layer, so consecutive
layers may operate on quite differently-shaped representations, and a fixed
chain of additions blends them where a selective read need not.

*Seen in:* [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [Kimi Delta Attention](/beliefs/glossary/kimi-delta-attention.md), [mixture of experts](/beliefs/glossary/mixture-of-experts.md)
