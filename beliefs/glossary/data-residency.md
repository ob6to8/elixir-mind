---
id: em:2d756f
type: concept
title: data residency
description: The requirement that data be stored and processed inside a specified legal jurisdiction, making *where* computation physically happens a compliance constraint independent of how securely it is done.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, compliance, jurisdiction, llm, enterprise]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the constraint downloadable weights relieve, per the Kimi K3 implications analysis"
---

# data residency

The constraint is jurisdictional rather than technical, which is what makes it
resistant to engineering answers: an encrypted, audited, perfectly-secured
pipeline still fails the requirement if the servers sit in the wrong country.

For language models the binding case is inference, since prompts carry the
regulated data. This is the standing enterprise objection to Chinese frontier
models regardless of their capability or price — and it is why downloadable
weights are a substantive unlock rather than a cost story: running the model in
your own jurisdiction converts a compliance blocker into a hardware-budget
problem. It is a distinct axis from
[provider lock-in](/beliefs/glossary/provider-lock-in.md), though open weights
relieve both at once.

*Seen in:* [open weights stopped being a price weapon](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md), [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [provider lock-in](/beliefs/glossary/provider-lock-in.md), [open weights](/beliefs/glossary/open-weights.md)
