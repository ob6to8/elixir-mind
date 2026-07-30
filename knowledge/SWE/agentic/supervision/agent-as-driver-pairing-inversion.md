---
id: em:87c81a
type: concept
title: "Agent-as-driver: the pair-programming inversion"
description: The supervision posture in which the agent types and the human navigates — pair programming with the roles assigned opposite to the usual assumption — and the pacing capability that separates it from the asynchronous diff review shipped under the same name.
provenance: "Agent-distilled from an operator-directed design session, 2026-07-30"
verified: false
tags: [supervision, agentic, pair-programming, review, workflow, human-in-the-loop]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:42:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed session on agent-driven editor workflows"
  why: "names the posture the agent-pairing project is built to serve, and the distinction is true independent of that project"
---

# Agent-as-driver: the pair-programming inversion

In pair programming the **driver** types and holds the tactical frame; the
**navigator** reviews in real time, holds strategy, and catches wrong turns
before they compound. The navigator is conventionally the more experienced of
the two. Mapping an agent to driver and the human to navigator is therefore the
natural role assignment for agentic coding — the agent supplies throughput, the
human supplies judgment — and the operator phrase for it is *driving the
driver*.

## What distinguishes it from diff review

Mainstream agentic tooling ships a different loop under the pairing name: the
agent works out of sight and presents a finished changeset. That is
asynchronous code review with a very fast contributor. Four properties separate
attended pairing from it:

- **Interruption latency.** In diff review a wrong turn is discovered after it
  has been fully built out, and correcting costs a round trip. Under attended
  pairing the correction lands at the moment of divergence, before anything
  downstream rests on it. Most waste in agentic coding is an agent confidently
  completing work founded on a wrong premise adopted early.
- **Sequence carries reasoning.** A finished diff is a set, and intent must be
  reconstructed from it. Watching the edits arrive preserves order — what was
  read first, what was decided before what — which is a large part of the
  reasoning the diff discards.
- **A shared referent.** Both parties look at one buffer, so deixis works
  ("not that one, the one above"). Reproducing that in a chat-only loop costs
  paragraphs of re-established context.
- **Comprehension is maintained rather than deferred.** Attention paid during
  the change is the payment mechanism
  [cognitive debt](/beliefs/glossary/cognitive-debt.md) requires; deferred
  review lets the operator's model of the system drift from its state.

## The pacing gap

Attended pairing requires the driver to work at the navigator's reading speed.
Agents are built for the opposite — finish fast, present at the end — so forty
edits across six files arrive in seconds, which is not comprehension. Closing
the gap takes either **self-pacing** (the agent working in announced units and
pausing at decision points) or **replay** (recording the edit stream and playing
it back at reading speed, so the agent runs unthrottled while the human watches
history). Replay is the cheaper of the two because it demands nothing of the
agent, and it decouples attended review from synchrony entirely: the recording
can be watched whenever attention is available.

Notably the gap is a *harness* property, not an editor one. An editor that can
render an edit stream is not the constraint; an agent that emits no unit
boundaries is.

## It is a posture, not a mode

Attended pairing costs full attention for a quality gain that varies sharply by
task — clearly worth it on unfamiliar, subtle, or high-blast-radius code, and
wasteful on boilerplate. It occupies one end of a supervision spectrum whose
other end is [monitor by exception](/beliefs/glossary/monitor-by-exception.md),
where the system initiates and the human reads only escalations. A supervision
tool's job is to make the posture switchable per task rather than to pick one.

## Two writers, one buffer

Attended pairing puts a human and an agent in the same live session, which human
pairs resolve socially ("you have the keyboard"). The mechanical equivalents
are an explicit write token with deliberate handoff, or — more elegantly —
scheduling the agent around the human's attention, so it works ahead in files
the human is not watching and yields on the buffer they are. The second is only
available to a supervisor that reads editor state, which is the same capability
that makes [ambient observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md)
possible.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:87c81a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:87c81a`]**

**"Driving the driver" is the right name for it.** In classic pair programming the driver types tactically while the navigator holds strategy and reviews in real time — and the navigator is usually the more experienced one. Mapping the agent to driver and you to navigator is arguably the *natural* assignment for agentic coding, and it's notable that essentially nothing mainstream does it. What Claude Code, Cursor's agent mode, and the rest actually ship is "agent works out of sight, then presents a diff," which isn't pair programming at all — it's asynchronous code review with a very fast contributor.
