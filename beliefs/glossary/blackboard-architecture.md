---
id: em:0d504c
type: concept
title: blackboard architecture
description: A software design pattern from 1970s–80s AI in which independent, specialized components ("knowledge sources") never communicate directly, but instead read and write a shared workspace (the "blackboard"), each reacting to whatever change makes it eligible to contribute next.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, architecture, multi-agent, history, coordination]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T04:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 agent-substrate-talks thread, naming the lineage ActiveGraph's design cites"
---

# blackboard architecture

An early multi-agent coordination pattern, originating in speech-understanding
systems like Hearsay-II: rather than a fixed pipeline or direct messages between
components, a set of independent "knowledge sources" all read and write one
shared workspace, and a control component decides which source acts next based
on the workspace's current state. No source needs to know which other sources
exist — coordination happens entirely through the shared structure, not through
calls between participants.

The pattern is the historical ancestor of two ideas that resurface in modern
multi-agent LLM systems without always citing it: many small workers reacting
to shared state instead of to each other (invoked directly in
[activegraph-event-sourced-agent-runtime](/knowledge/SWE/agentic/agentic-loop/activegraph-event-sourced-agent-runtime.md)'s
design, alongside Kafka), and coordination-through-shared-state as an
alternative to an orchestrator explicitly routing messages between agents.

*Seen in:* [2026-07-31 agent-substrate-talks-intake-analysis-and-ratifications thread](/meta/threads/2026-07-31-agent-substrate-talks-intake-analysis-and-ratifications.md), [activegraph-event-sourced-agent-runtime](/knowledge/SWE/agentic/agentic-loop/activegraph-event-sourced-agent-runtime.md)
