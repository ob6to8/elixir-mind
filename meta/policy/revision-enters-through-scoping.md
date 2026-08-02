---
type: policy
title: Revision enters through scoping
description: A thread carries one scoped unit entered through /matter or /scope-unit-of-work, admits only revisions extending it and the infrastructure its own context requires, and takes no narrated instructions to change what it has already done — revision of delivered work enters as a new scoped unit, queued at the head unless a dependency holds it lower.
section: session-workflow
order: 4
status: active
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, governance, session-workflow, matters, scoping, review, work-queue]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "operator-adopted working method, ratified in-thread after a proposal-and-amendment exchange; the enforceable half of the scoped-units-corrected-forward doctrine"
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md]
---

**A thread carries one scoped unit, and revision of what it delivered enters
as a new one.** The enforceable half of
[scoped units, corrected forward](/meta/doctrine/scoped-units-corrected-forward.md):
narrated revision instructions are the last class of decision that lives only
in a transcript, and they reach one instance where a scoped correction reaches
the type.

- **Two entry points, once.** A working thread begins either by delivering a
  queued [matter](/beliefs/glossary/matter.md)
  ([`/matter`](/.claude/skills/matter/SKILL.md)) or by scoping a described unit
  ([`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md)) —
  which may be persisted for a later thread or executed in this one. The thread
  does not take on a second unit.
- **What may join the thread.** Only two things: **revision matters** that
  extend the initial unit's implementation, and **infrastructure the thread's
  own context requires**. No matter is executed or defined that does not
  naturally extend from one of those. A thread so shaped is *topic-canonical* —
  a unit, its implementation, the revision matters it authored, and the
  infrastructure it needed — and lands as one pull request.
- **No narrated feedback on work the thread has done.** A change to what this
  thread already produced enters as a new `/scope-unit-of-work` unit, not as
  instructions in the conversation. The pull request stands as written; the
  correction is a following unit.
- **In-flight completion is not revision.** Before the unit's pull request is
  opened, correcting work *inside its approved scope*, and fixing anything the
  gate suite rejects, is part of delivering it. The test is one question: was
  it in the approved scope and done wrong (finish it), or outside it (scope
  it)? The write-run-fix loop of a single delivery is never a revision.
- **A revision identified at review time is filed before the pull request
  merges.** Correcting forward requires the forward correction to exist as an
  artifact; otherwise accepted bloat becomes permanent bloat. This extends
  [concerns block the close](/meta/policy/concerns-block-the-close.md) one step
  past the open.
- **Artifact count is not evidence of overhead.** If what was filed is
  necessary under these rules, it is necessary. Suspected duplication or
  inefficiency is scoped as an *analysis of the system*, never resolved by
  suppressing artifacts mid-thread.

**Queue position — binds all queueing, not only revisions.** A matter is
sequenced at the **head** of [the register](/meta/matters.md) by default, and
placed lower only when it genuinely requires preceding rows to land first
(a plan's internal `order` is such a dependency and is never inverted).
**Nothing is appended to the tail.** Tail-parking encodes "I don't want to
forget this but cannot rank it", which is precisely an **unsequenced backlog
matter** — filed, findable, unranked. Reserving the register for head
insertions and stated dependencies is what makes its order carry real
prioritization: every row was either the top priority when queued, or as high
as its dependencies allowed.
