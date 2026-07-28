---
id: em:768cc8
type: concept
title: lethal trifecta
description: Simon Willison's name for the combination that turns indirect prompt injection into data loss — an agent that simultaneously has access to private data, exposure to untrusted content, and a channel to exfiltrate what it reads.
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

# lethal trifecta

Any one of the three properties alone is ordinary and often unavoidable — an
agent usually needs private data to be useful, will eventually see content it
didn't author, and often needs some outbound channel to act. The risk is the
**conjunction**: remove any single leg (deny outbound network, keep untrusted
content out of the privileged context, or withhold the sensitive data) and the
same untrusted content becomes inert. This is the framing the
[dual-LLM pattern](/beliefs/glossary/dual-llm-pattern.md) is built to break, and the
structural bet behind the [secure financial agent](/projects/secure-financial-agent.md)
— that what the agent is *permitted* to do is the security boundary, not
whether the model is trustworthy.

*Seen in:* [Archestra — open-source enterprise AI platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:768cc8">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-debugging-agent-harnesses-on-weak-models (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:768cc8`]**

Glossaried [lethal trifecta](/beliefs/glossary/lethal-trifecta.md) (`em:768cc8`) — Simon Willison's term for the conjunction of private-data access, untrusted-content exposure, and an exfiltration channel that Archestra names as a guardrail category.
