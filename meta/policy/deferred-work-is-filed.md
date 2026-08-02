---
type: policy
title: Deferred work is filed
description: A work item identified mid-session but not executed in it is filed — todo, plan, issue, or matters-register row — in the same turn that identifies it; chat is not a backlog, and the close-time inventory verifies filings rather than performing them.
section: filing
order: 18
status: active
provenance: "Claude Code session (Claude Fable 5), 2026-08-02 — drafted from the matters register's top row"
tags: [meta, governance, filing, session-workflow, work-queue, handoff]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T04:36:00Z
  channel: agent-authored
  agent: "Claude Code agent, fresh thread consuming the matters-register top row"
  why: "a mid-session 'ride the next session' deferral left unfiled in the TDD research-spike session exposed the gap between concerns-block-the-close and plan-vs-capture; the operator queued this policy for drafting, with ratification at PR review"
  from: [/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md, /meta/threads/2026-08-02-deferred-work-policy-and-consumed-matters-log.md]
---

**A work item identified mid-session but not executed in it is filed in the
same turn that identifies it — chat is not a backlog.** The moment a session
names work it will not do now — "I'll do X later", "this should eventually
Y", a defect noticed in passing, an edit deferred to a future session — the
item gets a durable home before the turn ends: a `todo`, `plan`, or `issue`
per [governance-artifact-routing](/meta/policy/governance-artifact-routing.md),
or a row in the [matters register](/meta/matters.md) when it is a pending
[matter](/beliefs/glossary/matter.md) awaiting its own PR. A deferral that
lives only in the conversation has no surfacing mechanism — it survives
exactly as long as someone remembers it
([a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)).

- **Same turn, not at close.**
  [concerns-block-the-close](/meta/policy/concerns-block-the-close.md) binds
  the *closing* flow — its scope line deliberately leaves mid-session
  reporting alone — and its close-time inventory runs on whatever the
  session still remembers. Filing at the naming moment removes the
  remembering step; the close then verifies that filings exist instead of
  performing them. This policy is that rule's mid-session extension.
- **The trigger is naming the deferral, not the item's size.**
  [plan-vs-capture](/meta/policy/plan-vs-capture.md) already forces
  plan-scale deferred work into a persisted plan; this rule closes the
  todo-scale gap beneath it — the small "later" too minor for a plan.
  A filing can be a three-line todo or one register row; smallness is a
  reason to file cheaply, never to skip filing.
- **A ledger strand records the deferral; it does not queue it.** A captured
  thread's `open`/`paused` routing rows are the record layer
  ([routing-ledger](/meta/policy/routing-ledger.md)), and the
  [matter-queue plan](/meta/plans/matter-queue-and-present-matters.md)
  rejected them as the work queue. Execution finds work in the filed
  artifacts and the register; an item filed in-turn leaves the eventual
  ledger row simply routing to it.
- **Boundaries.** Work executed in-session needs no filing — the commit and
  the capture record it
  ([plan-vs-capture](/meta/policy/plan-vs-capture.md)). Options offered but
  not chosen are not yet work items; one becomes filable the moment the
  operator picks it and defers it, or the agent commits to it. An item that
  already has a home is pointed at or extended, never re-filed
  ([update-in-place](/meta/policy/update-in-place.md)).
- **Scope.** Agent-identified and operator-directed deferrals alike, in
  every session. How findings are *raised* keeps its existing shape — this
  policy binds the disposition of named work, not the reporting of it.
