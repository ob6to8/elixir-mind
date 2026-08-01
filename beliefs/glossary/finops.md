---
id: em:496b87
type: concept
title: FinOps
description: An organizational discipline for governing variable cloud (and, by extension, AI/token) spend — pairing engineering, finance, and business stakeholders around real-time cost visibility, accountability per team or workload, and continuous optimization, rather than after-the-fact budget review.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, cost-optimization, finops, cloud-economics]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 LLM-workflow-decomposition intake thread, where the Seldon article draws a direct FinOps-for-tokens analogy via the Linux Foundation's Tokenomics Foundation"
---

# FinOps

The term names both the practice and the community/framework around it (the
FinOps Foundation's iterate-informed-optimize-operate loop). Its central move
is treating variable infrastructure cost as a shared operational metric —
visible per team, per workload, in near-real-time — rather than a finance-only
line item reconciled monthly. Applying the same discipline to LLM token spend
is an active analogy rather than a settled extension: the units differ (a
token isn't a compute-hour), and per-call cost is driven by prompt/response
shape and model choice rather than only provisioned capacity.

*Seen in:* [2026-08-01 LLM workflow decomposition intake](/meta/threads/2026-08-01-llm-workflow-decomposition-intake.md)
