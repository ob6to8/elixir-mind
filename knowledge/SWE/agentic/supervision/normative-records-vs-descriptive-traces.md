---
id: em:712e01
type: concept
title: "Normative records vs. descriptive traces"
description: The distinction between a trace, which records what an agent did, and a decision record, which records what was authorized, by whom, with what reason, and what was amended first — the second being the artifact human-oversight obligations ask for and debugging telemetry cannot supply.
provenance: "Agent-distilled from an operator-directed design session, 2026-07-30"
verified: false
tags: [supervision, observability, compliance, governance, audit, agentic]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T07:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed session on agent supervision and governance"
  why: "the distinction generalizes past the project that surfaced it — it applies to any agent-oversight regime"
---

# Normative records vs. descriptive traces

Agent observability produces **descriptive** records: traces of what the agent
did — tool calls, tokens, latencies. Oversight obligations ask for a
**normative** record: what was *authorized*, by whom, with what stated reason,
and what was amended before it was allowed to happen. The two are different
kinds, not different qualities — a perfect trace contains no authorization
events, because the system it observes has none to record.

The distinction has three load-bearing consequences:

- **Evidence of oversight is currently one rung deep.** The chain for "a human
  supervised this agent's work" typically bottoms out at a merged PR approval —
  post-hoc, coarse, and silent about every decision inside the changeset. A
  transcript underneath it is descriptive: it tells an auditor what the agent
  did, and nothing about what a human knowingly permitted.
- **Decision-granular authorization is checkable; inferred oversight is not.**
  A record carrying proposal, decision (allow / deny / amend), stated reason,
  and decision latency turns "a human approved each consequential change" from
  an inference into a claim with evidence — and an *amendment* is categorically
  stronger evidence of active control than assent ever is. Credibility rests on
  the record being a
  [contemporaneous record](/beliefs/glossary/contemporaneous-record.md), made
  at the decision rather than reconstructed at review.
- **The audited property becomes stream completeness.** "All consequential
  actions were authorized" is a claim about the *event stream*, not the log: an
  action path that bypasses instrumentation falsifies it while leaving the
  record pristine. Auditing a normative record therefore means verifying the
  instrumentation, and the record honestly attests only "no ungated action *in
  this stream*" — a negative finding that names its scope.

Two failure modes hollow a normative record out from inside: rubber-stamping
(acknowledgement fatigue producing a formally perfect, evidentially empty log —
visible as decision latencies collapsing toward zero, and Goodhartable the
moment latency becomes a target) and the completeness gap above. Both are
invisible to a reader of the record alone.

Where such records exist, evidence standards ratchet toward them — an applied
working-through, with the mechanism that generates the record as a side effect
of normal supervision, is the agent-pairing project's
[observability-as-compliance analysis](/projects/agent-pairing/compliance-and-governance-observability.md).
