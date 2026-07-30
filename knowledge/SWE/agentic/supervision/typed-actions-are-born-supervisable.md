---
id: em:91b88f
type: concept
title: "Typed actions are born supervisable"
description: The design principle that an agent whose actions are typed, schema-validated data on a dispatch path can be supervised by interposition — gate, amend, or refuse the action before it executes — while an agent that acts through opaque tool calls must be supervised by retrofit hooks that reconstruct intent from events.
provenance: "Agent-distilled from an operator-directed design session, 2026-07-30"
verified: false
tags: [supervision, agentic, architecture, frameworks, interposition, typed-edges]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T07:07:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed session on agent supervision and BEAM integration"
  why: "the principle generalizes past Jido and the pairing project — it is a claim about how agent frameworks should represent actions"
---

# Typed actions are born supervisable

How much supervision an agent admits is fixed less by its harness's goodwill
than by its **action representation**. Two architectures, two ceilings:

**Opaque actions, retrofit seams.** An agent that acts through tool calls whose
meaning lives in prose gets supervised by *interception*: lifecycle hooks fire
around each call, an external supervisor reconstructs what is happening, and
the hard parts — semantic unit boundaries, structured intent, pend-until-decided
semantics — must be rebuilt outside the agent from event correlation and
timeouts. This is what hook-based supervision seams are: capable, and
recognizably a retrofit.

**Actions as typed data, interposition.** An agent whose every action is a
schema-validated structure dispatched through a reducer or signal bus can be
supervised by *interposition*: the supervisor is a stage in the dispatch path,
and gating, amending, or refusing an action is routing, not callback
choreography. The properties retrofit struggles for arrive structurally —
actions are typed before they happen, plans and composite actions carry their
own unit boundaries, and a pending decision is just a message that has not been
forwarded yet. Jido on the BEAM is one instance (actions as validated structs,
CloudEvents signals, directives interpreted by the runtime); the principle is
not BEAM-specific.

Two implications follow:

- **For supervisors:** an ingest layer written for hook events should be an
  adapter at the edge, because a signal-bus-native subject makes most of the
  adapter obsolete — design for the better subject even while serving the
  retrofit one.
- **For framework authors:** if attended supervision and its
  [normative records](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md)
  become expected — by teams or by governance regimes — actions-as-typed-data
  stops being a design aesthetic and becomes the property that determines
  whether a framework can produce the record at all.

The applied case for both directions is the agent-pairing project's
[BEAM/Jido analysis](/projects/agent-pairing/beam-jido-integration.md), whose
gap list for supervising Claude Code via hooks is, read backwards, a
specification of what typed actions provide for free.
