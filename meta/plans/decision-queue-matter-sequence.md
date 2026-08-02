---
type: plan
title: "The decision-queue matter sequence: the review's rulings and sweep as atomic deliveries"
description: Break the comprehensive review's remaining decision-queue work — four operator rulings and the contract-synchronization sweep — out of the inline thread and into five sequenced matters, each a self-contained handoff packet delivered in its own fresh thread under the approval-gated /matter protocol, one PR each.
status: accepted
provenance: "Claude Fable 5, decision-queue session"
tags: [meta, plan, matters, review, decision-queue, governance]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T11:23:00Z
  channel: agent-authored
  agent: "Claude Code agent, decision-queue session"
  why: "operator-directed 2026-08-02: the thread's series of spikes breaks out into sequenced matters contained by a plan, now that the matter system exists"
---

# The decision-queue matter sequence

## Problem

The [review program](/meta/plans/comprehensive-repo-review-program.md)'s
decision queue was commissioned as an inline interactive thread: present each
row, take the ruling, execute in-session. That shape predates the matter
system. Each remaining row is precisely a
[matter](/beliefs/glossary/matter.md) — one coherent, separately-reviewable
intent pairing a ruling with its execution — and delivering them inline
batches five reviewable decisions into one thread and one PR, against
[git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md). The
operator directed the breakout (2026-08-02); this plan is the container: the
sequence, its rationale, and the matters' shared context. Each matter doc is
the self-contained handoff packet; this plan holds only what is common.

## The sequence

| Order | Matter | Intent |
|---|---|---|
| 1 | [contract-synchronization sweep](/meta/matters/contract-synchronization-sweep.md) | Re-align policy text with what the machine enforces (epistemology review §2), fix the intra-contract contradictions (§3), recompile |
| 2 | [excerpt-log discipline](/meta/matters/excerpt-log-discipline.md) | Ratify the tag-selection rule; rule on cap/collapse/retro mechanics |
| 3 | [verbatim-capture filing pattern](/meta/matters/standardize-verbatim-capture-filing.md) | Standardize on sibling-`source`; retype the strays |
| 4 | [settle model-attribution](/meta/matters/settle-model-attribution.md) | Enforce, retract, or fold into the span-level-attribution migration; absorb the stale sibling matter |
| 5 | [contract-size counterweight](/meta/matters/contract-size-counterweight.md) | Stand up the warn-only size trend; disposition the relocation candidates |

**Sequencing rationale.** The sweep runs first: it is the correctness
baseline — every later matter's consumption reads the contract, and two of
the desyncs mis-describe hard gates a delivering session will hit. The
excerpt-log ruling is second because the erosion compounds with every capture
(19.7% of knowledge-corpus lines at 2026-08-02 and growing in absolute
terms). The filing-pattern ruling is third — small, independent, restores
type-query trust. Model-attribution is fourth: its decision space now
includes folding into the accepted
[span-level-attribution](/meta/plans/span-level-attribution.md) migration, so
it benefits from settling after the cheap corrections land. The size
counterweight is deliberately last — it measures the contract after the
other matters' policy edits, so the trend baseline is the settled text.

## Already resolved in the originating thread

Recorded here so the matters' packets stay forward-looking:

- Queue **row 5** (plan-backlog posture) was resolved 2026-08-02 by
  ratifying **session 5 — the governance backlog audit** into the review
  program, in place of a bare posture ruling.
- The [complete docs rewrite](/meta/plans/complete-docs-rewrite.md) plan was
  filed `proposed` with its sequencing ratified; it waits on this sequence's
  matters 1–5 landing (its constraint 1) and coordinates with matter 5's
  relocation disposition.

## Delivery protocol

Consumption follows [`/matter`](/.claude/skills/matter/SKILL.md): each matter
in a fresh thread, approval-gated, one PR
([atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)); global
delivery order is the [matter register](/meta/matters.md)'s row order, which
must not invert the `order` fields above (`mix brain.matters` checks this).
Every matter's delivery begins with the
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md) refresh
step: re-verify the packet's row states against `HEAD` — the originating
review predates the matter-system build-out, and main has already satisfied
parts of some rows.

## Decision list

- **Recommended shape**: five matters, orders above, queued as a contiguous
  block (the register's global placement is the operator's edit; the
  originating thread's placement determination accompanies the filing).
- **Alternatives rejected**: continuing inline (batches five reviewable
  decisions into one PR, against atomic-pull-requests); one matter per
  *edit* rather than per *ruling* (fragments single intents — a ruling and
  its execution are one reviewable whole).
- **Open**: none held by this plan — each matter's packet carries its own
  open decisions for the approval gate.
