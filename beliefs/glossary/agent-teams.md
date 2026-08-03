---
id: em:4e18d8
type: concept
title: agent teams
description: Claude Code's experimental multi-agent mode in which a lead session spawns teammate sessions — each a full Claude Code instance — that coordinate through a shared task list and per-agent mailboxes and message each other directly, unlike subagents, which only report back to their caller.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, claude-code, multi-agent, agent-teams]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-26 agent-teams intake thread"
---

# agent teams

Canonically captured in this bundle as
[Claude Code agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)
(the filed reference, distilled from the official docs) — this entry is a
pointer. Architecturally the feature is [actor](/beliefs/glossary/actor-model.md)-shaped
(named peers, mailboxes, a lock-guarded shared work queue) but implemented as
files on one machine with no supervising runtime; the comparison with a
[Jido](/beliefs/glossary/jido.md)/BEAM build of the same design is in
[agent teams vs. BEAM/Jido](/meta/analysis/agent-teams-vs-beam-jido.md).

*Seen in:* [2026-07-26 agent-teams intake thread](/meta/threads/2026-07-26-agent-teams-intake-and-beam-jido-comparison.md), [agent-teams reference](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md), [agent teams vs. BEAM/Jido analysis](/meta/analysis/agent-teams-vs-beam-jido.md), [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md)
