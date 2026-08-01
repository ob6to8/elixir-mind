---
id: em:712e01
type: concept
title: "Normative records vs. descriptive traces"
description: The distinction between a trace, which records what an agent did, and a decision record, which records what was authorized, by whom, with what reason, and what was amended first — the second being the artifact human-oversight obligations ask for and debugging telemetry cannot supply.
provenance: "Agent-distilled from an operator-directed design session, 2026-07-30"
verified: false
tags: [supervision, observability, compliance, governance, audit, agentic]
timestamp: 2026-07-31
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

## The same distinction, arrived at from operations

Practitioners running agents against real systems reach this boundary from the
other side, without the compliance framing: an agent reports a refund issued, the
run is clean, and the billing system holds no such refund. The operational
statement of the problem is that a trace is
[testimony rather than evidence](/knowledge/SWE/agentic/supervision/reddit-agent-says-done-reconciliation-patterns.md) —
"task completed" and "state changed" are different signals, and observability
instruments only the first. What is missing is not more recording but
**reconciliation**: a read-back from the system of record, which is the only step
in the loop the agent does not narrate.

Three refinements from that experience sharpen the concept:

- **The verifier can be testimony too.** A check the agent generates from its own
  rendering of a page proves nothing — one operator's DOM-based confirmation check
  matched a node that renders identically on success and on validation failure,
  so it returned true precisely when a false was needed. Evidence has to be
  something the counterparty produced: an id they minted, a response they
  returned, a message they sent.
- **Absence of error is not evidence.** A run in which no request ever left the
  client and a run in which every request succeeded are indistinguishable in a log
  that records only failures.
- **The claim state must be earned, not defaulted.** A system that cannot obtain
  external confirmation should report `pending`, never `done` — and `pending`
  should be the easier state to reach.

This is the completeness gap above, restated at the level of a single action: the
record is honest only about the stream it observes, and an action path that
produces no external artifact leaves the record pristine.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:712e01">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:712e01`]**  (co-feeds: `em:24c203`)

**Compliance/governance.** The broker log is a different *kind* of record from a trace, not a better one: a trace is descriptive (what the agent did), the acknowledgement protocol's log is **normative** (what was authorized, by whom, with what reason, what was amended first). That's the artifact "meaningful human oversight" obligations actually ask for, and today it exists nowhere below the PR-approval boundary. Discipline-level effect: the unit of observability moves from the trace to the decision, and auditing shifts to verifying the instrumentation. Two failure modes hollow it out — rubber-stamping (visible as collapsing ack latencies, and Goodhartable) and ungated action paths. Recommendation: don't build for compliance, but take the two free enablers — append-only typed records and posture stamping. I flagged the regulatory mapping as directional from training knowledge.

### 2026-07-31-survey-batch-intakes-and-review-pr-skill-audit (2026-07-31)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:712e01`]**

This thread is a perfect evidence base for an existing document. It substantiates **`normative-records-vs-descriptive-traces.md`** (em:712e01) with real-world practitioner experience of the exact problem described — traces being agent testimony rather than evidence, and reconciliation patterns that address it.

I'll update that document in place to include this Reddit discussion, then create the intake:

**Intake complete ✓**

The Reddit discussion was **merged into an existing document** rather than created as a new one:

| Action | Document | Type | ID |
|--------|----------|------|-----|
| **Updated in place** | Normative records vs. descriptive traces | `concept` | `em:712e01` |

**Why merged, not new:** This Reddit thread is practitioner-validated evidence of the exact problem the existing concept describes — that traces are agent testimony, not evidence of actual work happening in downstream systems. The thread contributes real-world patterns (write-verify separation, read-back verification, reconciliation against source of truth) that directly substantiate and extend the concept.

**Key insights added:**
- Practitioners independently discovered "trace is testimony, not evidence"
- Validated patterns: write and verify as separate steps, read-back from system of record, delayed reconciliation for async operations
- Failure modes when verification itself can be testimony (matching DOM elements that appear identical on both success and error states)
- Critical distinction: absence of error ≠ evidence of success

**All gates passing.** Commit pushed to branch.
