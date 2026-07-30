---
id: em:4d48ef
type: project
title: Agent pairing
description: A supervision layer that renders a coding agent's work into the operator's live editor at human pace and lets the operator gate, amend, and correct edits before they land — pair programming with the agent as driver, built as a broker plus thin editor clients.
status: incubating
tags: [projects, agents, supervision, neovim, editor-integration, broker]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:52:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed design session on agent-driven editor workflows"
  why: "operator resolved to build this system and opened a project hub to incubate its design records before it breaks out into its own repository"
---

# Agent pairing

A supervision layer for attended agent work. The agent drives — it types — and
the operator navigates: watching edits arrive in their own editor, at a pace
they can read, with the ability to stop, amend, or correct a change before it
lands. The posture is described independently in
[agent-as-driver](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md);
this project is the machinery that makes it available.

## What it is for

Agentic tooling routes attention at pane and task granularity — which agent is
blocked, which workspace is where. Once attention lands on an agent, the
operator gets whatever that agent prints in its own pane, and the change itself
is reviewed after the fact as a finished diff. The **edit** granularity is
unoccupied: there is no surface answering *what is this agent doing right now,
in my editor, and should I stop it*.

Two conditions make that surface buildable today. The harness already exposes
the supervision primitives —
[Claude Code hooks](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md)
can hold a tool call for ten minutes, rewrite its arguments, and inject the
operator's reasoning back into the model. And the editor already exposes both
directions of the channel: Neovim carries a scriptable Lua runtime and an
external RPC socket, so a supervisor can render into it and read its state (see
the [tooling landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md)).
Nothing in the middle consumes both.

## Shape

**Broker-first, editor clients thin.** A daemon owns the hook endpoints, the
pending-edit queue, the acknowledgement protocol, the replay buffer, and the
rule store. Editor plugins render and capture keys; they hold no state and no
model of their own.

```
Claude Code ──hooks──▶ broker ──socket──▶ nvim client (render, capture keys)
     ▲                   │                      │
     └──permissionDecision/updatedInput─────────┘
```

Three properties follow from that line. The supervision logic is written once
rather than per editor. A capability that can rewrite an agent's tool arguments
sits behind a narrow, logged verb set rather than a raw socket — the
capability-scoped broker shape this brain keeps re-deriving
([drivable-apps analysis](/meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md)).
And when other harnesses grow event surfaces, only the broker's ingest changes.

The build order, tier definitions, hook bindings, and deferred extensions are in
[architecture and build order](/projects/agent-pairing/architecture-and-build-order.md).

## Where it sits against existing tools

Complementary to the consoles rather than competing with them: they supervise at
pane, workspace, and task granularity, and hand off once attention lands. The
detailed comparison — including where the overlap is real and what this would
supersede — is in
[comparison with herdr and cmux](/projects/agent-pairing/comparison-herdr-cmux.md).
The competitive position and the state of each planned capability are in the
[opportunity assessment](/projects/agent-pairing/opportunity-assessment.md).

## Knowledge this project rests on

- [Agent-as-driver: the pair-programming inversion](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md) — the posture, its four advantages over diff review, and the pacing gap
- [Ambient agent observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md) — why salience rather than recording is the constraint, and what a trusted rendering owes its reader
- [Agent supervision consoles](/knowledge/SWE/agentic/supervision/agent-supervision-consoles.md) — the console landscape and its granularity axis
- [Neovim agent tooling landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md) — the editor-side ecosystem the first client lands in
- [Claude Code hook events as the agent-supervision seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md) — the harness interface the broker binds to
