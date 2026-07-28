---
id: em:10be28
type: concept
title: sampling (MCP)
description: The MCP flow in which a server asks the client to obtain a model completion on its behalf, running opposite to the usual client-to-server direction of protocol traffic.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, mcp, protocol, agents]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-27 CCA study-program thread; its reversed direction is the part of MCP most often misread"
---

# sampling (MCP)

The reversal is deliberate and follows from MCP's confidentiality design. A
server that could call the model directly would need model credentials and would
have to see the conversation; routing the request through the client and up to
the host means it gets neither, while still being able to use inference.

Requires the *client* to have declared sampling support during
[capability negotiation](/beliefs/glossary/capability-negotiation.md) — a server
cannot assume it.

*Seen in:* [MCP architecture](/knowledge/SWE/agentic/mcp/mcp-architecture.md)
