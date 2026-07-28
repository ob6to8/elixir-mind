---
id: em:e1a8ee
type: concept
title: dual-LLM pattern
description: A mitigation architecture for the lethal trifecta in which a privileged model that never sees untrusted content directs a separate, quarantined model that does the reading, so tainted input can influence only the quarantined side's output.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, security, agentic, prompt-injection]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:51:37Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Archestra platform intake (2026-07-28), which names it as a guardrail category"
---

# dual-LLM pattern

The privileged model plans and issues instructions but is architecturally
barred from reading anything an attacker could have written — a webpage, an
email, a document. The quarantined model does that reading and returns only a
constrained, structured result the privileged model can consume without
inheriting whatever instructions were smuggled into the content. This trades
capability (the quarantined model cannot make its own judgment calls that
require the privileged context) for a hard architectural guarantee that beats
prompting the model not to follow injected instructions — the failure mode the
[lethal trifecta](/beliefs/glossary/lethal-trifecta.md) names.

*Seen in:* [Archestra — open-source enterprise AI platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:e1a8ee">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-debugging-agent-harnesses-on-weak-models (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:e1a8ee`]**

Glossaried [dual-LLM pattern](/beliefs/glossary/dual-llm-pattern.md) (`em:e1a8ee`) — the companion mitigation architecture, a privileged model that never sees untrusted content directing a quarantined model that does.
