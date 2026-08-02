---
type: plan
title: "The matter queue: a persistent register of pending matters and the /present-matters skill"
description: Persist the cross-session work queue as an ordered register of pending matters (meta/matters.md) whose rows are self-contained handoff packets — matter, scope with decisions and refs, context flag — consumed top-down by fresh threads under the atomic-PR policy, rendered by a /present-matters skill; the register is the durable answer to "how does the next thread know what to do" so no matter ever lives only in a session's memory.
status: accepted
provenance: "Claude Code session (Claude Fable 5), 2026-08-01/02 — designed in the TDD research-spike session's sequencing dialog; register stood up in the same session as the compaction-driven handoff"
tags: [meta, plan, matters, work-queue, handoff, atomic-prs, skills, context]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T04:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the operator approved the matter-queue shape and, facing context compaction, directed the handoff machinery be stood up so remaining dev continues in fresh threads"
  from: [/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md, /meta/threads/2026-08-02-deferred-work-policy-and-consumed-matters-log.md]
---

# The matter queue and /present-matters

## Problem

The [atomic-pull-requests policy](/meta/policy/git-atomic-pull-requests.md)
makes the [matter](/beliefs/glossary/matter.md) the unit of delivery, which
means a session routinely *identifies* more matters than it *executes* — and a
matter that lives only in chat or a session's memory is lost when the context
dies (the filed prior:
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)).
Fresh context per matter is also the hygiene default — the anti-[Einstellung](/beliefs/glossary/einstellung-effect.md)
mediation — so the queue must be readable by a session that shares nothing
with the one that wrote it.

## Decisions (operator-approved 2026-08-01)

- **The register is a committed doc: [`meta/matters.md`](/meta/matters.md).**
  Ordered rows, consumed top-down; a row is removed when its matter's PR
  merges (git history is the archive). Non-bundle governance doc, no `em:` id.
- **A row is a self-contained handoff packet**: matter (one line), scope
  (the decisions already made, with refs to the plan/todo/policy that carries
  detail — the thin pointer-packet shape of the
  [fan-out execution convention](/meta/analysis/executing-ratified-plans-via-workflow-fan-out.md)),
  and a context flag (`fresh` — new thread, the default — or
  `continues <thread>` when held context genuinely helps, per the
  [plan-vs-capture](/meta/policy/plan-vs-capture.md) discriminator applied at
  each matter boundary).
- **Big matters point at filed plans/todos; micro-matters carry scope
  inline.** The register never duplicates a plan's body — it dispatches.
- **`/present-matters`** (to build — row 3 of the seeded register) renders
  the register as a table in-thread and is the fresh session's opener
  alongside `/priorities`; distinct from `/priorities` (importance appraisal
  over all open work) by being the *sequence* view of pending delivery.
- **The close points at the register.** A session ending with queued matters
  says so and points at `meta/matters.md`; the next session (fresh) reads the
  top row and executes. `/create-pull-request`'s scoping relationship to this
  is row 4 of the register.

## Build order

1. ~~Register created and seeded~~ — **done 2026-08-02**, in the originating
   session's handoff.
2. `/present-matters` skill (register row 3, fresh thread): `SKILL.md`
   rendering the register, plus the skills-registry policy entry and contract
   recompile.
3. Evaluate after a few consumed rows: whether rows need explicit `after:`
   ordering metadata, and whether `/priorities` should surface the register's
   top row (likely yes, one line in its appraisal).

## Decision list

- **Rejected:** a per-session ephemeral matter list (fails surfacing — the
  compaction that motivated this handoff is the live demonstration); matters
  as a new controlled `type` (rows are dispatch, not documents; filed detail
  keeps its existing genres); routing-ledger rows as the queue (the ledger is
  the record layer — the
  [reconcile-dangling-strands plan](/meta/plans/reconcile-dangling-ledger-strands.md)
  is separating record from work-queue, and this register is where the queue
  half lands).
- **One register, fixed path — never per-initiative files** (operator-raised,
  decided 2026-08-02): the register sequences the repo's *delivery lane*,
  which is single (one operator, sequential merges), so a global order must
  exist somewhere and per-initiative `matters-<spike>.md` files would only
  push the ordering question up a level while breaking the zero-context
  discovery property (a fresh session reads one known path). Matches the
  standing pattern — todos, issues, plans, and the bookmarks register are
  single flat stores. Initiative multiplicity is handled **inside** the
  register: an `Initiative` column is added the moment a second initiative
  queues its first row; each row's refs already point at its initiative's
  plan.
- **Consumed rows are logged in-doc** (ratified 2026-08-02, amending the
  seeded git-history-only archive): a consumed row moves from the queue
  table to a `## Consumed` section in the register — date, matter, landing —
  written in the same edit that removes the row, so logging and removal are
  one motion. This matches the standing pattern for the sibling registers
  (todos, issues, and plans all keep their done entries visible); entries
  are pointers only, and git history remains the full archive of each row's
  scope packet.
- **Escalation trigger:** if simultaneous consumption ever produces real
  merge conflicts on row removal (rare by design — top-down consumption, one
  matter per PR), the register becomes a `meta/matters/` directory, one file
  per matter with a derived ordered view — a mechanical refactor recorded
  here so it need not be re-derived.
- **Open:** whether the register eventually generalizes to a
  `mix brain.matters` derived view once rows carry structure worth checking.
