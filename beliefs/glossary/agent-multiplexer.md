---
id: em:58d708
type: concept
title: agent multiplexer
description: A terminal multiplexer that knows its panes hold coding agents — detecting them by process and output, rolling each up to a supervision state such as blocked or working, and surfacing the set as one attention queue.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, agents, terminal, supervision, tooling]
sense: common
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:09:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-30 session's comparison of herdr and cmux against the agent-pairing design"
---

# agent multiplexer

The specialization of the
[terminal multiplexer](/beliefs/glossary/terminal-multiplexer.md) that arrived
once operators began running several coding agents at once: tmux and zellij
treat every pane as opaque, so a herd of agents becomes a tab-switching problem.
herdr and cmux are the leading instances.

Its defining capability — and its defining limit — is that the state is
**inferred from rendered output**: process names, terminal output patterns, or
notification escapes a pane chooses to emit. That yields session-granularity
routing (*which agent needs me*) reliably and cheaply, and cannot reach edit
granularity (*what is this agent about to change*), which requires typed events
from the harness rather than a scrape of its display.

*Seen in:* [agent supervision consoles](/knowledge/SWE/agentic/supervision/agent-supervision-consoles.md), [agent pairing vs. herdr and cmux](/projects/agent-pairing/comparison-herdr-cmux.md)
