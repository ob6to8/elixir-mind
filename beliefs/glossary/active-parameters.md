---
id: em:dffd70
type: concept
title: active parameters
description: The subset of a mixture-of-experts model's weights that participate in computing any single token, reported alongside the total count and routinely mistaken for a memory figure.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, moe, self-hosting, inference, sizing]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the model-tier evaluation in the secure-financial-agent session, where the sizing error it invites is the decisive constraint"
---

# active parameters

Written as the second half of a [mixture-of-experts](/beliefs/glossary/mixture-of-experts.md) model's designation — "975B total / 41B active", "753B (~40B active)". The figure governs *arithmetic per token*, and therefore speed and cost.

It governs nothing about footprint. Every expert must be resident in memory because routing is per-token and unpredictable, so VRAM sizing uses the **total** count. Reading the active figure as a hardware requirement is the most common self-hosting sizing error, and at frontier scale it is the difference between a workstation and a multi-node cluster: a "41B active" model is a 975B-class deployment.

*Seen in:* [open-weight frontier models, mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md)
