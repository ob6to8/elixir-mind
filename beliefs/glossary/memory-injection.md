---
id: em:a490ca
type: concept
title: memory injection
description: An attack class in which adversarial content plants persistent instructions or false facts in an agent's long-term memory store, so the compromise survives across sessions instead of dying with the context window — demonstrated by MINJA (query-only injection), SpAIware (persistent exfiltration via ChatGPT memory), and MemGhost (stealth writes via a single crafted email).
provenance: "Agent-distilled glossary definition, Claude Fable 5"
verified: false
tags: [glossary, security, agent-memory, prompt-injection]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:27:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 memory-system research-spike thread"
---

# memory injection

The persistence-layer escalation of
[prompt injection](/beliefs/glossary/prompt-injection.md) (usually delivered
through an [indirect](/beliefs/glossary/indirect-prompt-injection.md)
channel): where an injected prompt manipulates one conversation, an injected
memory manipulates every future one, silently. The defenses the 2026
literature converges on — write-gates, provenance on memory writes, audit
trails, confirmation prompts for external content — are governance
properties of the memory store rather than retrieval properties.

*Seen in:* [2026-08-01 memory-system research-spike thread](/meta/threads/2026-08-01-memory-system-research-spike.md), [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
