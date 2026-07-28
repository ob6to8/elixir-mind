---
id: em:52a1d5
type: concept
title: capability negotiation
description: A protocol's opening exchange in which each side declares which optional features it supports, fixing for the rest of the session what may legitimately be requested.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, protocol, mcp, networking]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-27 CCA study-program thread; it is the mechanism governing what an MCP session may do"
---

# capability negotiation

The pattern lets a protocol grow without versioning every change: new features
arrive as additional declarable capabilities, and a peer that does not
understand one simply never declares it. Backwards compatibility becomes a
property of the handshake rather than of a version number.

In [MCP](/knowledge/SWE/agentic/mcp/mcp-architecture.md) the obligation runs
both directions and is binding — a server may only emit resource-subscription
notifications if it declared subscription support, and a server may only request
model sampling if the *client* declared it.

*Seen in:* [MCP architecture](/knowledge/SWE/agentic/mcp/mcp-architecture.md)
