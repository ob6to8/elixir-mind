---
id: em:63aa2e
type: concept
title: fine-tuning
description: Further training an already-pretrained model on task- or domain-specific data so the desired behavior is encoded in its weights rather than supplied in the prompt at inference time.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, model-training, llm, ai-agents, adaptation]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# fine-tuning

The relevant contrast for agent builders is iteration speed, not capability. A
weight-level change requires assembling data, running training, and evaluating
the result — a cycle measured in days or weeks, and one that must be repeated
against each new base model, so improvements are coupled to a slow pipeline and
risk being obsoleted by the next frontier release. An
[in-context](/beliefs/glossary/in-context-learning.md) change ships in hours and
rides whatever model is currently best. That asymmetry is why fast-moving agent
products typically bet on
[context engineering](/beliefs/glossary/context-engineering.md) over fine-tuning,
reserving weight-level adaptation for behavior that prompting genuinely cannot
reach — narrow output formats, latency-critical small models, or domains too
unlike the pretraining distribution.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
