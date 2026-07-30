---
id: em:a8dd36
type: plan
title: "Agent pairing — architecture and build order"
description: The broker-plus-thin-clients architecture, the three build tiers from filesystem-follow to a full acknowledgement protocol, the hook bindings each tier requires, and the deferred extensions the event stream enables once it exists.
status: proposed
tags: [projects, agent-pairing, architecture, plan, hooks, neovim, broker]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:55:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed design session on agent-driven editor workflows"
  why: "records the design and build sequence for the agent-pairing system before implementation begins"
---

# Agent pairing — architecture and build order

## Problem

An operator supervising an agent at edit granularity has no surface. The agent
works at machine speed and reports at the end; the editor shows the result only
after the fact; and the correction the operator would have made at the moment of
divergence has to wait for a finished diff and a round trip. Closing that
requires three things nothing currently provides together: a typed feed of what
the agent is about to do, a rendering of it where the operator's attention
already is, and a return path carrying the operator's decision back into the
agent's reasoning.

## Boundary decisions

- **The broker detects and holds.** It receives hook events, owns the pending
  queue, and decides whether an edit proceeds. All blocking lives here — an
  editor client that crashes must not strand an agent.
- **The broker persists.** Replay buffer, interjection records, and the rule
  store are its state; clients keep none across restarts.
- **The client renders and captures keys.** No supervision logic, no model of
  the agent, no independent state. A second client (another editor) is a
  rendering problem only.
- **The agent is never driven.** Edits reach the filesystem through the agent's
  own tool calls; the broker gates and amends them but never writes buffers.
  This keeps the operator's editor single-writer.

## Desired-state topology

```
Claude Code
  │  PreToolUse ─────────────▶ broker.ingest/1 ──▶ pending queue ──▶ client render
  │      ◀── permissionDecision | updatedInput | additionalContext ──┘
  │  PostToolUse ────────────▶ broker.record/1 ──▶ replay buffer ──▶ client follow-window
  │  MessageDisplay ─────────▶ broker.narrate/1 ─▶ client virtual-text
  │  Subagent*/Task* ────────▶ broker.fleet/1 ───▶ client quickfix queue
  ▼
filesystem ──FileChanged──▶ broker.reconcile/1
```

Under test the seam is `broker.ingest/1`: hook payloads are fixtures, so the
whole decision path runs without an agent, and the client is exercised against a
recorded stream rather than a live session.

## Build tiers

### Tier 1 — follow mode

Watch the working tree; on an agent write, open the file in a designated follow
window, jump to the changed hunk, flash the delta, and show the LSP diagnostics
that appeared or cleared as a result. No agent cooperation, no hooks, no
blocking — pure filesystem observation plus editor rendering.

Validates the premise cheaply. If watching an agent work in the operator's own
editor is not useful, nothing above this tier is either.

### Tier 2 — replay buffer

Record the edit stream and play it back at reading speed, with pause, step,
rewind, and jump-to-live. The agent runs unthrottled; the operator watches
history. This is what dissolves the pacing gap without asking the agent to slow
down, and it decouples attended review from synchrony — the recording can be
watched whenever attention is available.

**Consume [Entire](https://github.com/entireio/cli)'s checkpoint stream rather
than building a recorder.** Session capture, commit-anchored checkpoints, and an
append-only shadow branch are solved there; the unbuilt half is paced playback,
which is a rendering concern and belongs in this project.

### Tier 3 — the acknowledgement protocol

`PreToolUse` posts the pending edit to the broker, which renders it in the
editor as a pending overlay. One keystroke resolves it:

| Key | Returns |
|---|---|
| accept | `permissionDecision: "allow"` |
| accept + comment | `allow` with `additionalContext` carrying the operator's note |
| amend | `updatedInput` with the operator's edited arguments |
| reject | `deny` with `permissionDecisionReason` |

The write-token problem resolves here without a lock: while the operator holds
the keyboard, the broker returns `deny` with a retry reason and the agent waits.

Pacing budget is the hook timeout — 600 seconds per call.

## Gaps this design must close itself

The harness surface supplies action, not intent, and no unit boundary:

1. **No semantic unit boundary.** Pacing is per tool call, so a six-edit
   refactor asks six times. Near-term mitigation: instruct the agent to announce
   units and have the broker group by announcement; `PostToolBatch` may carry
   enough structure to group on directly.
2. **No structured intent.** `PreToolUse` carries the file and the diff; the
   reasoning arrives as prose on the display path, so the broker correlates the
   two rather than reading intent directly.
3. **No rollback checkpoint.** "Undo the last unit" has no primitive.
   Jujutsu's operation log is the right substrate — it checkpoints working-copy
   states automatically, where git needs explicit commits.
4. **No cross-harness event schema.** The ingest layer is Claude Code-specific
   and must stay isolated behind `broker.ingest/1`.

## Anchors

- Hook field names, decision values, and timeouts: [hook events as the supervision seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md)
- Editor-side rendering precedents — diff rendering, context variables, terminal session management: [Neovim agent tooling landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md)
- Broker rationale and the trust argument: [agent-drivable-apps analysis](/meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md)
- Quickfix as the fleet exception queue, and the derived-view discipline the rendering inherits: [ambient agent observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md)

## Deferred

Extensions the broker's event stream enables once tiers 1–3 exist. Each stays
here until it graduates into its own plan at build time.

- **Attention-aware scheduling.** Feed the operator's cursor, visible region,
  and active buffer back to the agent so it works ahead in unwatched files and
  yields on the one being read. Resolves buffer contention by scheduling rather
  than locking. Requires the tier-3 protocol first.
- **Exploration visibility.** `PreToolUse` fires on Read, Grep, and Glob as well
  as Edit, so the broker can mark which files the agent has read and which
  searches it ran — and compute the absences no trace contains ("edited a file
  it never read"). Cheapest of the deferred set; needs no protocol design.
  Absence marks must encode their search space per the
  [scoping rule](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md).
- **Fleet decision queue.** Route every agent's blocking decision point into the
  editor's quickfix list, so `]q` walks the herd. Uses `SubagentStart`,
  `SubagentStop`, `TaskCreated`, `TaskCompleted`, `TeammateIdle`.
- **Interjection capture and rule promotion.** Persist operator corrections
  anchored to code and commit; on repetition, offer to promote the correction
  into committed project rules. Differentiated from harness auto-memory by being
  anchored, operator-ratified, and committed rather than agent-private.

## Decisions, alternatives, open questions

**Recommended shape:** broker plus thin clients, tiers built in order, tier 2
consuming an external recorder.

**Rejected — a self-contained Neovim plugin.** Puts supervision logic in the
least durable layer, forecloses other editors, and gives raw
argument-rewriting authority to a plugin rather than a narrow logged surface.

**Rejected — driving the editor's buffers directly.** Adds a second writer to a
session the human is using, for an outcome the file-and-diff path already
achieves. The editor is read as a sensor and written to as a display, never
edited into.

**Open questions:**

- Does `PostToolBatch` carry enough structure to serve as the semantic unit
  boundary, or must units come from agent self-announcement?
- Broker implementation language — the operator's toolchain favors Elixir, and
  the supervision loop is a natural process-per-agent fit; weigh against
  distribution friction for a tool meant to be installed casually.
- Does tier 1 alone change the operator's behavior enough to justify tiers 2–3?
  This is the question tier 1 exists to answer, and the answer should gate the
  rest.
