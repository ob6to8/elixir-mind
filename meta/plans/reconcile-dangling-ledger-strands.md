---
type: plan
title: "Reconcile dangling routing-ledger strands into tracked work"
description: A sweep that reviews every pending routing-ledger strand across meta/threads and reconciles each into a first-class todo/plan/issue or an explicit close — closing the gap where deferred work lives only inside frozen thread bodies and recurs forever in /priorities without ever being promoted or retired.
status: proposed
provenance: "Claude Code session, 2026-07-13 — operator asked, after noticing two offered intakes tracked only as paused ledger strands, for a plan to scan all routing ledgers for danglers needing promotion to todos/plans"
attribution:
  when: 2026-07-13T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, dangling-strand reconciliation session"
  why: "persists the design for reconciling routing-ledger danglers into tracked work per the persist-plans policy, so the freezing question and tool shape survive the session"
  from: [/meta/threads/2026-07-13-track-intake-todos-and-strand-reconciliation-plan.md]
tags: [meta, plan, tooling, routing-ledger, priorities, provenance]
timestamp: 2026-07-28
---

# Reconcile dangling routing-ledger strands into tracked work

## Problem

A captured thread's [`## Routing` ledger](/meta/policy/routing-ledger.md) records
one row per topic with a `State` (`open`/`paused`/`closed`) and a `Dangling`
question. Rows that are `open`/`paused`, or `closed` with a leftover `Dangling`
cell, are **deferred work that lives only inside a frozen thread body**.

`ElixirMind.SessionInit` (surfaced by [`/priorities`](/.claude/skills/priorities/SKILL.md))
already *scans* for these — `dangling_strands/1` collects pending rows across
`meta/threads/*.md` and folds them into the priority ranking. But scanning is
not reconciliation. There is no step that, for each strand, decides *this
becomes a todo / a plan / an issue, or is closed* — so a strand:

- **recurs forever** in every `/priorities` run until someone happens to act on
  it, with no memory that it was already considered; and
- **is still losable** — the work is a row buried in one thread's ledger, not a
  first-class item in `meta/todos/` or `meta/plans/`. This session is the proof:
  two offered intakes sat as `paused` strands and were nearly dropped until the
  operator asked where they were tracked.

The two surfaces — thread ledgers (where deferred work is *born*) and
todos/plans/issues (where open work is *tracked*) — never converge.

## The measured backlog (scan of 2026-07-28, 109 threads)

`dangling_strands/1` reports **89 pending strands** across 58 threads (41
`open`, 35 `paused`, 13 `closed` with a leftover `Dangling` cell). Classifying
each by what its `Routed to` cell actually points at:

| Routed to | Rows | Tracked by `/priorities`? |
|---|---:|---|
| a live tracker (`plan`/`todo`/`issue`, active status) | 27 | yes |
| a **closed** tracker (`status: done`/`resolved`) | 6 | no — parked inside a finished record |
| an `analysis` (genre carries no `status`) | 10 | no — analyses are never listed |
| a knowledge/project/eval document | 10 | no — not a tracker |
| a path that no longer resolves | 3 | no — dead link |
| `unrouted` | 33 | no |

**62 of 89 pending strands have no live tracker behind them.** Editorial triage
of those 62 splits them three ways, and the split is the finding:

- **~24 are already discharged** — the work landed or was promoted, and only the
  frozen ledger cell still says otherwise (escape-rate sampling, the swarm-eval
  harness, the branch-triage todo and orphaned-branches issue, the skills-compile
  plan, all four CCA knowledge gaps, both intake todos, the `elixir-mind` rename,
  the `agentic-coding` → `agentic` restructure, the dedup-recall probe and its
  synonym-expansion step, and four PR/merge session-mechanics rows whose threads
  carry a `pr:` stamp).
- **~9 were closed by an explicit decision** the cell records but the `State`
  column cannot express (*"left uncodified until it recurs (operator agreed)"*,
  *"only if a concrete need with real examples emerges"*).
- **~27 are genuinely live and untracked** — the actual orphans. The
  highest-value: the derived SQLite index (`mix brain.index`); spec→code
  traceability; the gate-suite tutorial's table, verified still missing four
  gates CI runs (`glossary`, `lineage`, `dev_history`, `dedup_probe`); a
  `mix brain.channels` generator for the register's re-derivable column; the
  Workflow fan-out execution convention's four open questions; both
  `meta/evals/` instruments, still `status: proposed` and unbuilt; the
  `deprecated/` triage, with 33 files still present; and the
  secure-financial-agent's air-gap and approval-gate decisions.

**The dominant failure mode is staleness, not loss.** A third of the pending
rows describe work that is *already tracked somewhere else* — so the ledger's
defect is not primarily that work escapes it, but that it has **no way to say
"discharged"**, and `/priorities` therefore re-surfaces settled matters forever.
That reorders the build: representing resolution is the prerequisite, and
promoting the orphans is what the representation then makes visible.

## The core design tension: freezing vs. state mutation

The [session-capture policy](/meta/policy/session-capture.md) freezes a thread
body at capture; the [route-tagging policy](/meta/policy/route-tagging.md) treats
the frozen body as an auditable record. So the plan must resolve: **when a
strand is promoted to a todo, may its ledger `State` be flipped `open` →
`closed` in the already-captured thread, or is the thread immutable?**

Two candidate answers, to be ratified before building:

1. **Reconciliation edit (mutate the ledger).** Permit a *narrow* post-capture
   edit to the `State`/`Dangling` cells of a ledger row — not the body prose —
   when a strand is promoted or resolved, leaving a pointer to where it went.
   Pro: the ledger stays truthful; `/priorities` stops re-surfacing it. Con: it
   dents the freeze invariant and needs the route-tag verifier to tolerate
   ledger-only edits.
2. **Dedup by back-link (leave the thread frozen).** Never touch the thread;
   instead teach `dangling_strands/1` to treat a strand as resolved when a
   `todo`/`plan`/`issue` carries an `attribution.from` back to that thread
   *and* names the strand. Pro: respects freezing, reuses the
   [attribution](/meta/policy/resource-attribution.md) `from` edge. Con: needs
   per-strand identity (a thread has many strands; `from` is thread-granular),
   so it likely needs a strand anchor (e.g. a slug/ordinal per row).

The freezing question is the plan's central open question; the tool shape below
is deliberately agnostic to which answer wins.

## Enforceability: what a check can and cannot assert

*"Should enforcement logic prevent any actionable item from being orphaned?"* —
the scan above answers the mechanical half and rules out the semantic half.

**Not enforceable: "every actionable item is tracked."** Whether a row is
actionable at all is a judgment — the ~9 decision-closed rows above look
identical to live work, and separating them took reading each cell. This is the
same shape as route-tag *coverage*, which [route-tagging](/meta/policy/route-tagging.md)
already concedes "has no mechanical oracle and stays editorial". A check keyed
on actionability would be a judgment gate, and would fire hardest on rows a
human already settled.

**Enforceable: "a pending row points at something that can still receive work."**
That is a mechanical property with a real oracle — a row whose `State` is
`open`/`paused` must have a `Routed to` that (a) resolves to an existing
document, and (b) if that document is a `plan`/`todo`/`issue`, is not
`done`/`resolved`/`superseded`. On today's corpus it fires on **52 rows**: the 3
dead paths, the 6 closed-tracker parks, and the 33 unrouted (the `analysis` and
knowledge-doc targets are a softer sub-case, since routing synthesized content
there is correct — what is missing is a *second* tracker ref, not a different
one).

**It must warn, never fail.** Two independent reasons:

1. **A hard gate would be unsatisfiable.** The ledger is a section of the thread
   body, which [session-capture](/meta/policy/session-capture.md) freezes. The
   only way to green a failing row on a merged thread is to edit a frozen body
   — so until the freezing question above is ratified, a blocking gate demands
   the very mutation the contract forbids.
2. **It would fail the build on day one**, for 52 pre-existing rows, most of
   which are stale rather than wrong. A gate that must be suppressed to land any
   change teaches agents to suppress it.

This matches the plan's own "No new gate" scope boundary, and the precedent is
in place: `mix brain.route_tags` already carries a warn-level **ledger
cross-check** (`check_ledger_coverage/3`, `{:warn, …}`) over these same
`## Routing` rows. The tracker-backing check belongs beside it, reusing
`ledger_doc_sinks/3`'s parsing rather than adding a second ledger reader.

**The enforcement that actually pays is at write time, not check time.**
`/capture` is the one moment an agent holds the context to know whether a strand
is live work — so the durable fix is a `/capture` obligation (every row it
writes as `open`/`paused` either routes to a live tracker or files one), with
the warn check as the backstop that catches the miss. Enforcement after the
session has ended can only report; it cannot decide.

## The shape of the change

1. **`mix brain.strands`** (`ElixirMind.Strands`, factoring the existing
   `SessionInit.dangling_strands/1`): list every pending strand across
   `meta/threads/*.md` — thread, topic, state, routed-to, dangling — and, for
   each, its **reconciliation status**: already promoted (a todo/plan/issue
   back-links it) vs. un-promoted. Read-only; the reconciliation *decision*
   stays an agent+operator judgment, not an automated file-writer.
2. **A reconciliation motion**, documented as the disposition step: for each
   un-promoted strand, either `/todo create …` / file a plan or issue (with
   `attribution.from` citing the source thread), or mark it closed per the
   ratified freezing answer. Mirrors the branch-triage todo's "each ends
   merged, superseded, or explicitly retired — none left in limbo" discipline.
3. **`/priorities` integration**: once resolution is representable (either
   answer above), `dangling_strands/1` filters out reconciled strands, so the
   digest shows only genuinely-pending work and the list monotonically shrinks
   as strands are dispositioned.

## Scope boundaries (explicitly out)

- **No auto-promotion.** The tool reports and the agent/operator disposition;
  it never files todos/plans on its own — "is this strand real open work or
  session chatter" is a judgment call, like intake dedup.
- **No new gate.** This is an on-demand review sweep, not a CI check. A strand
  left un-reconciled is a warning at most, never a build failure (coverage of
  deferred work has no mechanical oracle, same as route-tag coverage).
- **Not a `/priorities` rewrite.** `/priorities` keeps its role; this factors
  out and extends the strand-scanning it already does.

## Open questions (resolve before building)

- **The freezing answer** (§ core tension) — mutate the ledger cell, or dedup by
  back-link? Everything else depends on it.
- **Strand identity** — if dedup-by-back-link wins, strands need a stable
  per-row anchor so a `from` edge can name *which* strand it discharges.
- **The decision-closed state.** ~9 rows record a deliberate *"not until it
  recurs"* disposition that `open`/`paused`/`closed` cannot express, so they read
  as pending forever. Does the `State` vocabulary gain a `deferred` value, or
  does the freezing answer's pointer convention carry it?

**Answered by the 2026-07-28 scan** (no longer open):

- **Retroactive sweep — required, not optional.** Forward-only adoption leaves
  the 62 untracked rows in place, and since ~24 of them are already discharged,
  `/priorities` would keep re-surfacing settled work indefinitely. The sweep is
  what makes the list start shrinking.
- **Enforcement shape** (§ enforceability) — warn-level and keyed on
  tracker-backing, with the real obligation at `/capture` write time.

## Build order (after the freezing question is ratified)

1. Ratify the freezing answer and, if needed, the strand-anchor convention.
2. Factor `dangling_strands/1` into `ElixirMind.Strands`; add `mix brain.strands`
   with the reconciliation-status column.
3. Wire the resolution representation into `SessionInit` so reconciled strands
   drop out of `/priorities`.
4. Run the retroactive sweep, dispositioning the current backlog — the ~24
   already-discharged rows first, since closing them is bookkeeping rather than
   judgment and it shrinks the list the most.
5. Add the tracker-backing check beside `check_ledger_coverage/3` in
   `ElixirMind.RouteTags` (warn), and the matching `/capture` obligation to
   [session-capture](/meta/policy/session-capture.md), so newly-written rows stop
   adding to the backlog the sweep just cleared.
