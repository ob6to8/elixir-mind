---
type: plan
title: "Reconcile dangling routing-ledger strands into tracked work"
description: Separate the record layer from the work queue — strip state out of thread routing ledgers, make every strand link to a plan/todo/issue at PR time, and stop /priorities from reading ledgers at all, so deferred work can no longer dangle inside a frozen thread body.
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
becomes a todo / a plan / an issue, or is closed* — so a strand **recurs
forever** in every `/priorities` run with no memory that it was already
considered, and **is still losable**, because the work is a row buried in one
thread's ledger rather than a first-class item in `meta/todos/`.

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
- **~27 are genuinely live and untracked** — the actual orphans, enumerated in
  the appendix as the sweep's worklist.

**The dominant failure mode is staleness, not loss.** A third of the pending
rows describe work that is *already tracked somewhere else* — so the ledger's
defect is not primarily that work escapes it, but that it has **no way to say
"discharged"**, and `/priorities` therefore re-surfaces settled matters forever.

## The resolution: the ledger is a record, not a queue

The ledger holds **state** (`open`/`paused`/`closed`) inside a body that
[session-capture](/meta/policy/session-capture.md) freezes at capture, while
`/priorities` reads that state as *current*. One artifact, a record and a queue,
wanting opposite things — a record must not change, a queue must.

The resolution is to stop making it both (operator-ratified 2026-07-28):

1. **State leaves the ledger entirely.** No `State` column. A strand's status
   lives on the artifact it links to, where `status: open|done|cancelled` is a
   mutable field on a document designed to be revisited.
2. **Every row links to the artifact holding its content or its action.** The
   ledger becomes a pure dispatch table — pointers, never state, never content.
3. **`/priorities` stops reading ledgers.** `dangling_strands/1` is deleted;
   the digest's sources become issues, todos, and plans alone.
4. **One carve-out:** a row may go unlinked *only* when the session made an
   explicit decision not to codify the matter — the *"left uncodified until it
   recurs (operator agreed)"* case. That decision is recorded in the cell, and
   it is the sole legitimate unlinked form.

**This dissolves the freezing question rather than answering it.** Freezing was
only a problem because something read the ledger as current state; once nothing
does, a frozen row is an accurate record of where a session left things, which
is what a thread doc is *for*. The prior draft's two candidate answers —
mutate the cell, or dedup by back-link with a per-row anchor — are both moot,
and no strand-identity anchor is needed.

This is [fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)
applied to a straddle the brain has carried since capture was adopted: record
layer frozen, tracking layer mutable, the ledger the one-way pointer between.

## The ledger schema

Current — state and question live in the row, and go stale:

```
| Topic | State | Routed to | Dangling |
|---|---|---|---|
| <one line> | open\|paused\|closed | [<doc>](/path.md) or `unrouted` | <question or -> |
```

Desired — pointers only; `Routed to` keeps dispatching content, `Action` carries
the tracker:

```
| Topic | Routed to | Action |
|---|---|---|
| <one line> | [<doc>](/path.md) or `unrouted` | [<tracker>](/meta/todos/x.md) │ none: <decision> |
```

- **`Routed to` is unchanged** — the document that absorbed the strand's
  synthesized content, which is often a knowledge doc or an `analysis`, and
  correctly so. It is not a tracker and was never meant to be.
- **`Action` is new** and holds exactly one of two forms:
  - a bundle-absolute markdown link to a `plan`, `todo`, or `issue`; or
  - the literal prefix `none:` followed by the decision text.

  A second column rather than an overloaded cell, so the gate's parse is
  unambiguous.
- **`Dangling` is dropped.** *Recommended, pending operator confirmation.* An
  open question with no tracker is exactly what this design forbids; with a
  tracker, the question belongs *in* the tracker. Keeping it in the row
  reintroduces the shadow copy the routing-ledger policy already bans —
  "Pointers and states only — never content" tightens to **pointers only**.

## Enforcement

**At PR time, as a blocking gate.** The obligation lands in
[`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md), when the
thread doc is still in-branch and editable — nothing frozen is being touched.
The check: **every ledger row's `Action` cell either resolves to an existing
`plan`/`todo`/`issue`, or begins `none:` with non-empty text.**

This is mechanical, needs no judgment, and — unlike the state-based check the
prior draft specced — can genuinely block. The two objections that forced
warn-only both dissolve: there is no frozen body to edit, and with the sweep run
first plus grandfathering by thread date, day one starts green.

**What it cannot assert.** The gate validates rows that *exist*. A matter the
session touched but `/capture` never wrote a row for escapes it, because there
is nothing to check. Partial oracle: **invert the existing cross-check.**
`ElixirMind.RouteTags.check_ledger_coverage/3` currently runs one direction
(ledger row → is it tagged?); running it both ways catches a route-tagged region
whose matter has no ledger row. What survives is a matter that got *neither* a
tag nor a row — un-oracle-able, since detecting it means reading the session.
That residue is unchanged by this redesign; the inverted check is an independent
improvement worth landing with it.

## Scope boundaries (explicitly out)

- **No auto-promotion.** The sweep reports; the agent and operator disposition.
  "Is this strand real open work or session chatter" is a judgment call, like
  intake dedup.
- **The gate never judges actionability.** It asserts only that every row has a
  home — never that the row *is* real work, which has no mechanical oracle.
- **`Routed to` semantics do not change.** Content still routes where content
  belongs; this adds a column rather than repurposing one.
- **Not a `/priorities` rewrite.** `/priorities` keeps its role and loses one
  source.

## Open questions

- **Drop the `Dangling` column?** Recommended above; needs operator
  confirmation, since it is the one part of the schema their ratification did
  not explicitly settle.
- **`none:` marker syntax.** Any literal token works so long as it is
  mechanically distinguishable from a malformed link; `none:` is proposed for
  legibility.
- **Grandfathering boundary.** Gate on threads dated after adoption, or only on
  threads touched by the diff? The latter is self-limiting and needs no date
  logic.

**Settled by the 2026-07-28 scan and ratification** (no longer open):

- The freezing question — **dissolved**, not answered (§ resolution).
- Retroactive sweep — **required**. Forward-only adoption would strip ~27 live
  items from view the moment `/priorities` stops scanning.
- Enforcement shape — **blocking gate at PR time**, keyed on `Action` presence.
- The decision-closed state — **the `none:` carve-out**, not a new `State` value.

## Build order

**The sequencing constraint is absolute: sweep before switch.** Stripping the
`State` column or dropping the `/priorities` scan before extracting the orphans
silently deletes ~27 items of live work from view. Steps 1–2 must complete
before step 3 begins.

1. **Sweep.** Disposition the appendix's 27 orphans with the operator — each
   becomes a `todo`/`plan`/`issue`, or is judged not worth tracking. Then close
   out the ~24 already-discharged and ~9 decision-closed rows, which is
   bookkeeping rather than judgment.
2. **Backfill `Action`.** Add the column to all 109 thread ledgers, populating
   it from step 1's dispositions. A ratified, deterministic, one-pass migration
   over frozen bodies — the same shape as the `sb:` → `em:` id migration, and
   legitimate on the same grounds. The pre-migration `State` values stay
   recoverable from git, which is the brain's history layer regardless.
3. **Switch.** Delete `dangling_strands/1` and its digest section from
   `ElixirMind.SessionInit`; update `/priorities` to describe three sources.
4. **Gate.** Add the `Action`-presence check, and the inverted tag↔row
   cross-check, to `ElixirMind.RouteTags` beside `check_ledger_coverage/3`;
   wire the obligation into `/create-pull-request`.
5. **Policies.** Rewrite [routing-ledger](/meta/policy/routing-ledger.md) to the
   pointers-only schema and [session-capture](/meta/policy/session-capture.md)
   to the new ledger step; update `/capture`'s § 3 table; recompile the contract.

## Appendix — the sweep worklist (27 orphans)

Live and untracked as of 2026-07-28. `[v]` marks a claim verified against the
tree this session rather than taken from the ledger cell.

| # | Matter | Source thread |
|---:|---|---|
| 1 | Derived SQLite index (`mix brain.index`) as hardening move 2 | 2026-07-20-storage-format-verdict-and-frontmatter-parser-plan |
| 2 | Spec→code traceability: tasks citing the policy they enforce | 2026-07-20-intent-as-source-and-dark-factory-pricing |
| 3 | nvim guided-tour skill, nvim MCP wrapper, hunk in the PR-review loop | 2026-07-18-agent-drivable-apps-warp-hunk-nvim |
| 4 | Gate-suite tutorial table missing 4 gates CI runs `[v]` | 2026-07-23-ai-drift-intake-and-coding-standards-ratification |
| 5 | `mix brain.channels` generator for the register's `Ingested` column | 2026-07-28-channels-register-merge-and-video-vetting |
| 6 | Eval-ledger format as a public export | 2026-07-20-evals-harness-ledger-and-observation-records |
| 7 | Routing ledger as a completion oracle for agent evals | 2026-07-20-evals-harness-ledger-and-observation-records |
| 8 | Workflow fan-out execution convention — four open questions | 2026-07-16-workflow-driven-plan-execution-convention |
| 9 | `source-recall-probe` instrument unbuilt (`status: proposed`) `[v]` | 2026-07-27-cca-study-program-and-the-primary-source-miss |
| 10 | `priorities-recitation` eval unbuilt (`status: proposed`) `[v]` | 2026-07-25-journal-skill-and-first-entry |
| 11 | Cross-model PR review Action: target repo + reviewer model | 2026-07-21-multi-model-dev-environment-and-cross-model-pr-review |
| 12 | `defverb`-style zero-dep macro for the `brain.*` verbs | 2026-07-14-elixir-ast-macros-and-loomkin-evaluation |
| 13 | secure-financial-agent: air gap vs. default-deny; VLM variant | 2026-07-27-secure-financial-agent-and-projects-namespace |
| 14 | secure-financial-agent: approval-gate placement and friction cost | 2026-07-27-secure-financial-agent-and-projects-namespace |
| 15 | `deprecated/` triage — 33 files still present `[v]` | 2026-07-11-deprecated-directory-triage-and-machinery-deletion |
| 16 | Reddit as a source for `/research` or `/bookmarks` | 2026-07-28-channels-register-merge-and-video-vetting |
| 17 | Security-directory body-format consistency | 2026-07-27-llm-security-intakes-and-two-evaluation-beliefs |
| 18 | Broaden `invisible-degradation` for the model-output sense | 2026-07-27-llm-security-intakes-and-two-evaluation-beliefs |
| 19 | Journal carry-forward close convention | 2026-07-26-journal-day-two-intermediary-layer |
| 20 | Essay seed: fear cycles → commoditization | 2026-07-26-journal-day-two-intermediary-layer |
| 21 | Empty `claude-managed-agents/` stub folder `[v]` | 2026-07-13-artifacts-concept-and-anthropic-node-restructure |
| 22 | Surface `sense` in the glossary index and registry | 2026-07-13-glossary-sense-disambiguation |
| 23 | `mix brain.recent` and the deferred recency surfaces | 2026-07-16-recreate-collection-view-by-date |
| 24 | Code-anchor identity + code-sink freeze/aggregation semantics | 2026-07-20-localized-code-conversation-and-comprehension-doctrine |
| 25 | Opt-in local pre-commit that renders and stages `CLAUDE.md` | 2026-07-16-render-contract-invocation-and-auto-render |
| 26 | Attribution policy: provenance names the producing model | 2026-07-13-three-level-documentation-plan-and-model-doctrine |
| 27 | Taxonomy stubs + tolerated broken links in frozen namespaces | 2026-07-13-artifacts-concept-and-anthropic-node-restructure |
