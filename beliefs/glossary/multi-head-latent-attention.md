---
id: em:219996
type: concept
title: multi-head latent attention
description: DeepSeek's attention variant that compresses keys and values into a low-rank latent vector cached in place of the full key-value pairs, cutting KV-cache memory at long context.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, attention, kv-cache, transformer-architecture, long-context]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Kimi K3 model-card intake, which uses Gated MLA layers"
---

# multi-head latent attention

Defined in place, with its lineage among the other KV-cache compression
techniques, in
[the KV-cache compression history](/knowledge/SWE/llm-engineering/kv-cache-compression-history.md).

Gated variants appear in later models — Kimi K3 pairs 24 Gated MLA layers with 69
[KDA](/beliefs/glossary/kimi-delta-attention.md) layers — as the full-attention
minority in a hybrid stack.

*Seen in:* [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [Kimi Delta Attention](/beliefs/glossary/kimi-delta-attention.md)
