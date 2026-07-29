---
id: em:51e5f3
type: reference
title: "How far behind the frontier are open-weight models on cyber capability (UK AISI)"
description: The UK AI Security Institute's narrow cyber-task and cyber-range evaluations of GLM-5.2 and DeepSeek V4-Pro find the open-to-frontier capability lag on offensive cyber tasks has narrowed from 6–10 months (2025) to 4–7 months, with GLM-5.2 matching Opus 4.5 on cyber ranges.
resource: https://www.aisi.gov.uk/blog/how-far-behind-the-frontier-are-leading-open-weight-models-on-cyber
provenance: "UK AI Security Institute (AISI) blog, fetched 2026-07-29"
tags: [security, open-weights, cyber-capability, evaluation, ai-industry]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: auto-intake
  agent: "Claude Code agent, /research daily Routine"
  why: "featured in the 2026-07-29 digest under SWE; reason-tag: influential, impactful"
---

# How far behind the frontier are open-weight models on cyber capability

The UK AI Security Institute (AISI) measures open-weight models against
frontier closed models specifically on **offensive cyber capability**, using
two complementary evaluation designs: narrow cyber-task batteries across four
difficulty tiers (technical non-expert through expert), and **cyber ranges** —
simulated networks where a model attempts an end-to-end autonomous attack
rather than answering an isolated question.

## The finding

Recent open-weight models trail frontier closed models' cyber capability by
**4–7 months** — down from the 6–10 month gap AISI measured through 2025. In
AISI's own words: "recent open weight models lag frontier closed models'
cyber capabilities by 4 to 7 months." The models evaluated:

- **GLM-5.2** (June 2026) — the most capable open-weight model tested;
  performs comparably to Opus 4.6 and GPT-5.3-Codex on the narrow-task
  batteries, and matches Opus 4.5 on the longer cyber-range assessments.
- **DeepSeek V4-Pro** — comparable to Opus 4.5, trailing GLM-5.2 slightly on
  cyber ranges.

AISI states it plans to evaluate Kimi K3 once its weights are publicly
available.

## Why this belongs beside the price-side open-weight thesis

The brain already tracks open-weight/closed-model gap compression as a
pricing and switching-pressure story
([em:07610c](/knowledge/ai-industry/ai-margin-collapse-glm-5-2.md)) and, most
recently, as a raw capability story via
[Kimi K3](/knowledge/machine-learning/kimi-k3.md) (open-to-closed gap
"reduced from the debated 6-9 months to something shorter, say 3-5 months,"
per Nathan Lambert). AISI's result is the same compression measured on a third
axis — **offensive security capability specifically** — and lands at a
comparable window (4–7 months). The three measurements (price, general
capability, cyber capability) are independent evaluations converging on the
same underlying fact: whatever moat separated open and closed models is
shrinking uniformly across the dimensions that have been checked, not just
the ones vendors advertise.

# Citations

- <https://www.aisi.gov.uk/blog/how-far-behind-the-frontier-are-leading-open-weight-models-on-cyber> — UK AISI, "How Far Behind the Frontier are Leading Open Weight Models on Cyber?"

# See also

- [GLM-5.2 and the coming AI margin collapse](/knowledge/ai-industry/ai-margin-collapse-glm-5-2.md)
- [Kimi K3 (Moonshot AI)](/knowledge/machine-learning/kimi-k3.md)
- [Agent Data Injection (ADI)](/knowledge/SWE/security/agent-data-injection.md)
