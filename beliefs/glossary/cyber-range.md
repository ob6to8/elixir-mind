---
id: em:8f223c
type: concept
title: cyber range
description: A simulated network environment used to evaluate offensive or defensive cyber capability end-to-end — reconnaissance through exploitation through post-exploitation — rather than testing an isolated skill in a single question.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, security, evaluation, cyber-capability]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the 2026-07-29 research digest, in UK AISI's open-weight cyber-capability evaluation"
---

# cyber range

Distinct from a narrow task battery, which isolates one skill at one
difficulty tier (e.g. "identify this vulnerability class"): a cyber range asks
a model to carry out an **autonomous, multi-step attack** against a simulated
network, so the score reflects whether capability composes across an entire
attack chain rather than whether any single step succeeds in isolation. UK
AISI runs both evaluation types side by side when measuring model cyber
capability, precisely because narrow-task and cyber-range scores can diverge —
a model strong on isolated skills doesn't automatically chain them
autonomously.

*Seen in:* [How far behind the frontier are open-weight models on cyber capability](/knowledge/SWE/security/open-weight-cyber-capability-gap.md), [2026-07-29 research digest thread](/meta/threads/2026-07-29-research-digest-mcp-spec-security-and-reliability.md)
