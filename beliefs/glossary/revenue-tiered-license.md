---
id: em:e07c3b
type: concept
title: revenue-tiered license
description: A license that grants permissive rights by default but attaches further obligations — a negotiated commercial agreement, mandatory attribution, or fees — once the licensee crosses a stated revenue or user-count threshold.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, licensing, open-weights, ai-industry, business-model]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the license shape the Kimi K3 release ships under"
---

# revenue-tiered license

The design answers the free-rider problem in open-weight releases: distribution
is maximized by giving the weights away, but the parties best placed to profit
from them are the intermediaries who merely serve them. Setting the trigger at a
commercial threshold leaves researchers, hobbyists, and ordinary internal
deployment untouched while reaching exactly the businesses that would otherwise
resell the release for free. Meta's 700M-monthly-active-user clause on Llama is
the early instance; Kimi K3's $20M
[model-as-a-service](/beliefs/glossary/model-as-a-service.md) revenue gate
generalizes it into a revenue tier.

Such a license is not open source in the OSI sense, since the field-of-use and
threshold conditions fail the no-discrimination criteria. The practical
consequence is that
[open weights](/beliefs/glossary/open-weights.md) now spans a spectrum from MIT to
commercial-use-restricted, and the phrase alone carries no legal information about
a given release.

*Seen in:* [open weights stopped being a price weapon](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md), [Kimi K3](/knowledge/machine-learning/kimi-k3.md)

*See also:* [model-as-a-service](/beliefs/glossary/model-as-a-service.md), [open weights](/beliefs/glossary/open-weights.md)
