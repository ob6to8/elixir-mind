---
id: em:a96688
type: belief
title: Plan artifacts compress the decisions and leave the bodies to the agent
description: Structured plan artifacts encode the decisions — interfaces, layout, call order — exactly, while deliberately leaving function bodies to the implementing agent, where implementation freedom is cheap.
provenance: "Claude Code session (claude-fable-5), 2026-07-26 — synthesized in the pseudocode-plans thread while reconciling the wsff.md program-design method with Dex Horthy's spec-length bound; ratified as a belief by the operator in the same thread"
tags: [belief, planning, program-design, coding-agents, context-transfer]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session — operator-directed belief filing"
  why: "operator directed filing this session-synthesized statement as a belief, with the session thread as its provenance once captured"
---

# Plan artifacts compress the decisions and leave the bodies to the agent

The belief, stated (synthesized in the originating session, quoted verbatim from
its delivered response):

> "The artifacts compress the *decisions* (interfaces, layout, call order) while
> leaving function bodies to the agent."

It reconciles two priors that would otherwise pull against each other:
[plan artifacts surface decisions otherwise made implicitly at code review](/beliefs/plan-artifacts-surface-implicit-review-decisions.md)
(so encode more structure into the plan) and
[a spec detailed enough to reliably generate quality code is roughly as long as the code](/beliefs/spec-detail-approaches-code-length.md)
(so encoding *everything* is self-defeating). The resolution: a plan's
structured artifacts capture exactly the load-bearing decisions — what the units
are (interfaces/signatures), where they live (layout/file trees), and how they
compose (call order/flow trees) — and stop there, leaving function bodies to
implementation, where the agent's freedom is cheap and review catches what
matters.

Acted on as the granularity rule of the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md).

# Citations

- The originating session's thread doc under `meta/threads/` (captured at PR
  time; the route-tagged excerpt log below aggregates the relevant passages once
  materialized).
