---
id: em:6153c9
type: concept
title: frozen model
description: A model whose weights are held fixed while everything around it — prompts, retrieved context, instruction files — is optimized instead; "frozen" marks that improvement is happening at inference time, not through training.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, prompt-optimization, agentic, llm-training]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 Microsoft SkillOpt intake thread"
---

# frozen model

The framing matters because it draws the line on what's being claimed: a
result achieved against a frozen model is evidence about the artifact
surrounding it (a prompt, a skill file, a retrieval pipeline), not about the
model itself. [SkillOpt](/knowledge/SWE/agentic/skill-optimization/skillopt.md)
takes this literally — it calls the frozen model the *target*, and trains a
separate skill document as if it were the target's external, editable state.

*Seen in:* [2026-07-31 Microsoft SkillOpt intake](/meta/threads/2026-07-31-microsoft-skillopt-intake.md)

*See also:* [text-space optimization](/beliefs/glossary/text-space-optimization.md), [in-context learning](/beliefs/glossary/in-context-learning.md)
