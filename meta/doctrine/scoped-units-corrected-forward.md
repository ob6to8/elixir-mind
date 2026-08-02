---
type: doctrine
title: "Scoped units, corrected forward"
description: Work enters a thread as one scoped unit and leaves as one pull request, and imperfection in what landed is corrected by a following scoped unit rather than by narrated revision inside the thread that produced it — because a narrated instruction leaves no artifact, has no review boundary, and reaches one instance where a scoped correction reaches the type.
provenance: "Claude Opus 5, scope-unit-of-work session — operator-authored workflow, agent-drafted into doctrine after a proposal-and-amendment exchange"
tags: [meta, doctrine, session-workflow, matters, scoping, review, atomicity]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "the operator adopted a working method — thread = one scoped unit, revisions enter as new scoped units — and directed it be declared once agreed"
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md]
---

# Scoped units, corrected forward

A **standing direction** for how work enters and leaves a working session. It
is the session-shape counterpart to
[verified increments](/meta/doctrine/verified-increments.md): where that
direction shapes *what* is delivered, this shapes *how a thread acquires and
relinquishes* the work.

## The direction

**A thread carries one scoped unit, and what lands is corrected forward.**

Work enters a thread exactly once — as a queued
[matter](/beliefs/glossary/matter.md), or as a described unit scoped at the
door — and the thread's pull request is the unit's whole delivery. When the
result is imperfect, the correction is **scoped as a following unit**, not
narrated as revision instructions inside the thread that produced it.
Accepting some bloat in what landed, and correcting it in the next unit, is
preferred to steering mid-thread.

The reasoning is the same in three registers:

- **A narrated instruction leaves no artifact.** Chat is the one surface this
  brain does not retain: [deferred work is filed](/meta/policy/deferred-work-is-filed.md)
  closed the gap for *identified work*, and
  [concerns block the close](/meta/policy/concerns-block-the-close.md) closed
  it at *session end* — mid-thread revision requests were the remaining class
  of decision living only in the transcript. Scoping them makes each one a doc
  with a packet, a delivering model, and a review boundary.
- **A narrated instruction has no review boundary.** Steering mid-thread grows
  the open pull request by increments nobody approved as a unit, which is
  exactly what [atomic pull requests](/meta/policy/git-atomic-pull-requests.md)
  forbids at the matter level. A scoped correction gets its own approval.
- **A narrated instruction reaches one instance; a scoped one reaches the
  type.** Asked to fix *this* document, an agent fixes that document. Asked to
  scope the correction, it asks what the rule is and which instances it
  touches. This is the artifact-layer form of the
  [coding standards](/meta/policy/elixir-coding-standards.md) rule that a
  recurring miss is fixed by amending the standard, "never only in the
  offending change".

## What the direction buys

**Thread atomicity by construction, rather than by untangling.** A thread that
may only spawn new scoped threads cannot become a sprawl of unrelated topics
that a later pass must separate. The
[routing ledger](/meta/policy/routing-ledger.md) and
[route tags](/meta/policy/route-tagging.md) then *record* a coherent thread
rather than rescuing a tangled one.

**Atomicity of intent, not of size.** A scoped unit may still fan out — an
evaluation, several emitted matters, a plan — and remain one unit. What it may
not do is take on a second, unrelated intent.

## Its reflexive clause

This direction produces artifacts: matters, plans, register rows. **Their
number is not, by itself, evidence of overhead.** If everything filed is
necessary under the system's own rules, then it is necessary, and the only
real reduction is a change to the system. Suspected duplication or
inefficiency is therefore **scoped as an analysis of the system**, never
resolved by suppressing artifacts in the moment — which would be the
instance-level fix this direction exists to reject.

## Enforceability

Like [capability-matched model selection](/meta/doctrine/capability-matched-model-selection.md),
the direction itself binds judgment; its enforceable half is a policy —
[revision enters through scoping](/meta/policy/revision-enters-through-scoping.md) —
which states the thread's entry points, what may join it, and where a
correction goes instead. The policy is where an agent mid-work is bound; this
is the reasoning it applies when the policy does not name the case.

**Its own limit, stated up front.** The direction is adopted for a brain whose
work is presently governance and documents. Its behavior once the work is
substantially *code* is untested — the plausible strain is the inner
write-run-fix loop, which the policy exempts as delivery rather than revision.
That exemption is the hypothesis; if it proves insufficient, the direction is
revisited rather than quietly abandoned.
