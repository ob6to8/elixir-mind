---
id: em:42b1f1
type: concept
title: Kimi Delta Attention
description: Moonshot AI's hybrid linear attention mechanism, which replaces quadratic softmax attention in most layers of the Kimi model line with a recurrent delta-rule state update that costs linearly in sequence length.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, attention, transformer-architecture, long-context, kimi]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Kimi K3 model-card intake"
---

# Kimi Delta Attention

"Hybrid" is doing real work in the definition: KDA is not applied uniformly but
interleaved with a minority of full-attention layers — Kimi K3 runs 69 KDA layers
against 24 Gated MLA ones — because pure linear attention loses the exact recall
that softmax attention provides, while pure softmax attention makes a
million-token [context window](/beliefs/glossary/context-window.md) quadratically
expensive. The stack buys the linear cost curve on most layers and keeps precise
retrieval on a few.

This shape is the emerging convention for long-context models rather than a
Moonshot peculiarity; KDA is one named instance of it.

*Seen in:* [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [multi-head latent attention](/beliefs/glossary/multi-head-latent-attention.md), [attention residuals](/beliefs/glossary/attention-residuals.md)
