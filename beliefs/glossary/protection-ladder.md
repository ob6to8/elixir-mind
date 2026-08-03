---
id: em:07519b
type: concept
title: protection ladder
description: The four-rung escalation for holding a test suite beyond an implementing agent's reach — instructed → procedural → mechanical → held out — with the rung chosen by the stakes of the contract being protected.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, tdd, testing, agentic, reward-hacking]
sense: repo
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 methodology-finalization thread, which filed the ladder into the methodology"
---

# protection ladder

Ratified as the "Protecting the contract" subsection of the
[agent development methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md):
instruction states the rule (do not modify tests, tests committed first);
procedure makes violations visible (red confirmed before green, test changes
in their own commits); mechanism removes the ability (test-path edits denied,
or test-writer and implementer roles split); holding out removes visibility
itself — gate-time tests the implementing agent never sees, the
[held-out set](/beliefs/glossary/held-out-set.md) discipline applied to
development. Escalation is warranted because blocking a single cheat route
diverts rather than stops
[reward hacking](/beliefs/glossary/reward-hacking.md) under test pressure, so
mechanism beats instruction where the stakes justify its cost.

*Seen in:* [the TDD research-spike thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md), [2026-08-02 methodology-finalization thread](/meta/threads/2026-08-02-methodology-finalization.md)
