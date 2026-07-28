---
id: em:6e1259
type: concept
title: on-behalf-of delegation
description: An OAuth token-exchange pattern in which a service acting for a user obtains a new token scoped to that user's own identity, rather than reusing its own service credential, so a downstream system sees the actual end user rather than the calling service.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, oauth, identity, security, agentic]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:51:37Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Archestra platform intake (2026-07-28), where it differentiates the MCP gateway"
---

# on-behalf-of delegation

Without it, a gateway calling a downstream API on a user's behalf has only its
own service identity to present, so every action it takes looks the same to
that API regardless of which user triggered it — audit logs, per-user access
controls, and revocation all collapse to the service account. On-behalf-of
delegation exchanges the caller's token for one carrying the end user's own
identity and permissions, so the downstream system enforces its normal
authorization against the actual user rather than trusting the gateway
blanket access. This is what makes an agent platform's [MCP](/beliefs/glossary/model-context-protocol.md)
gateway safe to point at production systems instead of only at data the
service account itself may see.

*Seen in:* [Archestra — open-source enterprise AI platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:6e1259">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-debugging-agent-harnesses-on-weak-models (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:6e1259`]**

Glossaried [on-behalf-of delegation](/beliefs/glossary/on-behalf-of-delegation.md) (`em:6e1259`) — the OAuth token-exchange pattern that lets Archestra's MCP gateway present the end user's identity downstream instead of a shared service credential.
