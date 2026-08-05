---
id: em:55363b
type: concept
title: agent-native
description: An application architecture where AI agents are first-class participants in the same rooms, records, and event streams as human users, rather than bolted on beside a separate AI-specific pipeline — an agent's actions travel the identical persistence and broadcast path a human's would.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, software-architecture, agentic, multi-agent-systems]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-05 reading-list batch intake"
---

# agent-native

The distinguishing test is where an agent's output enters the system: an
agent-native design has it enter through the same channel, schema, and
permission model a human user's action would (the same message table, the
same pub/sub topic, the same room), so no separate "AI layer" exists to fall
out of sync with the human-facing one. This is a stronger claim than merely
*supporting* agents as API consumers — it means the data model itself does
not distinguish agent from human at the storage or routing layer, only (if at
all) at the presentation layer.

*Seen in:* [Jido Assembly — a Slack clone built with Jido and Hologram](/knowledge/SWE/agentic/frameworks/jido-assembly-slack-clone.md)
