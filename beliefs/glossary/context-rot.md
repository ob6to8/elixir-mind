---
id: em:cc0302
type: concept
title: context rot
description: The degradation of an LLM's effective attention and retrieval reliability as its context window fills — memory whose dependability drops with occupancy.
provenance: "Agent-distilled glossary pointer entry, 2026-07-13 session"
verified: false
sense: common
tags: [glossary, context-engineering, agent-architecture, terminology]
timestamp: 2026-07-25
attribution:
  when: 2026-07-13T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-13 second-mind-taxonomy thread cited in Seen in"
---

# context rot

Unlike RAM, whose access is uniform and exact-by-address, an LLM's context is content-addressed, and what the model can reliably surface from it falls off as the window fills. Canonically captured in this bundle by the Chroma research reference — see [context rot — Chroma research](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md).

*Seen in:* [2026-07-13 second-mind-taxonomy thread](/meta/threads/2026-07-13-second-mind-taxonomy-analysis-and-belief-plan.md), [Context engineering lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) (degradation before the window ceiling as the case for offloading)

*See also:* [lost-in-the-middle](/beliefs/glossary/lost-in-the-middle.md), [context window](/beliefs/glossary/context-window.md), [context offloading](/beliefs/glossary/context-offloading.md)
