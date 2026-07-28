---
id: em:8ad00c
type: source
title: "Moonshot AI — Kimi K2.6 API pricing"
description: Moonshot's official per-million-token pricing for kimi-k2.6, the predecessor rate against which K3's increase is measured.
resource: https://platform.kimi.ai/docs/pricing/chat-k26
provenance: "Extracted from https://platform.kimi.ai/docs/pricing/chat-k26, fetched 2026-07-28"
tags: [source, kimi, moonshot, inference-pricing, ai-industry]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, grounding pass on em:51aede"
  why: "the 3-4x price increase claimed for K3 is measured against this predecessor rate"
---

# Moonshot AI — Kimi K2.6 API pricing

Model: **kimi-k2.6**. Prices per 1M tokens:

| Rate | Price |
|---|---|
| Input (cache hit) | $0.16 |
| Input (cache miss) | $0.95 |
| Output | $4.00 |

Context window: 262,144 tokens. The model offers automatic context caching to
reduce cost on cache hits.
