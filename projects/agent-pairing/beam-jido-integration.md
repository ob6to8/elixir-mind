---
id: em:32fd52
type: analysis
title: "The broker on the BEAM — and what Jido 2 changes about who is being supervised"
description: Finds the broker is the first workload in this brain's orbit that actually fits the BEAM (long-lived, stateful, concurrent, failure-isolated), that Jido 2 fits as substrate only if the build burden stays small, and that the deeper implication runs the other way — Jido agents are born emitting the typed stream the broker must bolt onto Claude Code with hooks, making BEAM-native agents the pairing system's best-case supervised subject.
tags: [projects, agent-pairing, analysis, beam, otp, elixir, jido, architecture]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:48:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed design session on agent-driven editor workflows"
  why: "operator asked what the implications are of integrating agents on the BEAM, specifically Jido 2, with the pairing system"
---

# The broker on the BEAM — and what Jido 2 changes

**Question.** The [architecture plan](/projects/agent-pairing/architecture-and-build-order.md)
leaves broker language open, noting the operator's toolchain favors Elixir.
What do the BEAM and [Jido 2](/beliefs/glossary/jido.md) specifically change —
as implementation substrate, and as a class of agent the system might
supervise?

**Thesis.** Two separate questions with opposite polarities. As *substrate*,
the broker is the first workload in this brain's orbit that genuinely fits the
BEAM — the [Jido 2 evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md)
found the brain's Elixir layer is a batch toolchain with "nothing to grip" for
OTP, and the broker is precisely the long-lived, stateful, concurrent,
failure-isolated process that conclusion was waiting for. As *subject*, the
implication is larger: Claude Code must be adapted into the pairing protocol
via hooks, but a Jido agent's actions are already typed data on a signal bus —
BEAM-native agents are *born supervisable*, which makes the pairing system's
ingest gap a Claude Code artifact rather than a fact about agents.

## The broker as an OTP application

Map the broker's obligations onto OTP and every one lands on a primitive:

| Broker obligation | OTP shape |
|---|---|
| one supervision context per agent session | process per session under a `DynamicSupervisor` |
| pending queue with a blocking decision path | `GenServer` call with timeout — the hook's 600s budget is a `receive` deadline, not custom machinery |
| a crashed editor client must not strand an agent | monitors + supervision: client death is a `:DOWN` message; the session process answers `defer` and the agent proceeds under normal permission flow |
| many clients, one stream | `Registry`/pub-sub fan-out; each client a subscriber |
| replay buffer, interjection record | a persistent log owned by a single writer process — [backpressure](/beliefs/glossary/backpressure.md) bounded |
| fleet state | it *is* the supervision tree, inspected |

The failure-isolation row is the argument, not a row among equals. The broker
sits between a human's editor and a running agent holding real authority
(`updatedInput` rewrites actions); the design constraint "blocking lives in the
broker and degrades to `defer`, never to a stranded agent" is the let-it-crash
discipline stated as product behavior. Writing that in a single-threaded
runtime means hand-building timeout, isolation, and restart semantics the BEAM
issues as standard equipment.

The known cost also lands where the plan expected: **distribution friction.** A
casually-installed dev tool competing with 10MB Rust binaries ships as a
Burrito-style self-contained release or loses the install-decision before the
architecture is ever evaluated. That is packaging work, not a blocker, but it
is real and it is the reason a Rust/TS broker remains defensible if
casual-install distribution becomes the project's growth constraint.

## Jido 2 as substrate: yes, iff thin

The evaluation's three blockers were repo-specific (toolchain floor,
zero-dependency constraint, duplicate agent runtime) and none binds a
separate broker application — the project's break-out is the escape from all
three. What Jido contributes is a disciplined skeleton that matches the broker
one-to-one: the decision path as a pure
`cmd(agent, {Action, params}) → {updated_agent, directives}` reducer
(replayable and testable without a live agent — exactly the `broker.ingest/1`
fixture seam the plan specifies), hook ingest and client fan-out as
CloudEvents-compliant **Signals** with trie routing, side effects as
**Directives** the runtime interprets, all on the supervised GenServer runtime.
The caveats from the brain's Jido record apply unchanged: no cross-node
distribution story as of mid-2026, and `jido_ai` — the LLM-cognition layer —
is exactly the part the broker must *not* adopt, because the broker's whole
trust posture is that it is deterministic machinery between the human and the
model, not another reasoner.

So: Jido as chassis, `jido_ai` explicitly out, and the decision reversible
since the reducer-shaped core is portable Elixir either way.

## The deeper implication: the supervised subject

The plan's gap list is a description of adapting an *opaque* harness: no
semantic unit boundary, no structured intent, ingest bolted on via hooks. Now
run the pairing protocol against a Jido agent instead of Claude Code:

- **Every action is typed before it happens.** A Jido agent acts only through
  schema-validated Actions dispatched by its reducer — the "typed feed of what
  the agent is about to do" is not an event the harness deigns to emit; it is
  the agent's execution format.
- **Gating is interposition, not interception.** The broker stops being a hook
  server holding a callback and becomes a stage in the dispatch path: a
  directive is emitted, routed through the broker's gauntlet, executed or
  amended or refused. The 600-second-timeout dance is Claude Code adaptation
  work; on a signal bus the pend-until-decided semantics are just a routed
  message.
- **The unit-boundary gap closes structurally.** Jido plans and composite
  actions carry their own grouping; "gate the unit, not the keystroke" falls
  out of the data model instead of being reconstructed from announcements.

This is the convergence the brain has now derived three times: the
[write-gatekeeper](/meta/analysis/claude-managed-agents-vs-beam-jido.md), the
dark-factory
[librarian](/meta/analysis/dark-factory-epistemic-base-beam-jido.md) — a single
owned choke point through which agent authority flows — and the pairing broker
is the same organ grown for a different body. The dark-factory scenario runs
it autonomous-with-audits; agent pairing runs it with a human at the gate. One
architecture, a posture dial.

The strategic reading for the discipline: hook-based supervision seams are
what *retrofit* looks like. Frameworks that represent agent actions as data —
Jido is the BEAM instance of a wider pattern — get decision-granular
supervision, and its [compliance-grade record](/projects/agent-pairing/compliance-and-governance-observability.md),
nearly for free. If attended supervision and its attestations become expected,
"actions as typed, interposable data" stops being a framework-design
aesthetic and becomes a requirement with a paper trail.

**Recommendation.** Build the broker as an Elixir/OTP application with the
reducer-shaped core, deferring the Jido dependency decision to first-code (it
is reversible; the shape is identical). Keep the Claude Code hook ingest
behind `broker.ingest/1` as planned — and add a second ingest as a design
target, not for another hook dialect but for a signal-bus-native agent, so the
architecture is demonstrably not a Claude Code appendage. If a tier beyond
editor pairing ever runs agents *inside* the broker's own supervision tree,
that is the [thin-Jido-host plan](/meta/plans/thin-jido-brain-host.md)'s
territory — adjacent, and deliberately not this project.
