---
type: plan
title: "Workflow-driven plan execution: fresh-context workstream fan-out via the Workflow tool"
description: A convention for executing a ratified plan's workstreams as fresh-context subagents through the environment's Workflow tool — defining the per-workstream spec a plan must carry, a standard minimal Execution Context Payload each spawned agent receives instead of full session history, a pre-execution readiness gate, and how results fold back into the plan doc, the PR/commit graph, and the session-capture flow.
status: proposed
provenance: "Claude Code session (claude-opus-4-8), 2026-07-15 — operator asked to investigate and formalize a convention for executing ratified plans via the Workflow tool's fresh-context subagent primitives, since plans already reach for fresh-session execution informally with no defined mechanism"
attribution:
  when: 2026-07-15T14:21:49Z
  channel: agent-authored
  agent: "Claude Code agent, workflow-execution-convention session"
  why: "persists the proposed Workflow-driven plan-execution convention per the persist-plans policy, for operator ratification before implementation"
  from: []
tags: [meta, plan, orchestration, workflow, agents, execution, fresh-context, delegation]
timestamp: 2026-07-15
---

# Workflow-driven plan execution: fresh-context workstream fan-out via the Workflow tool

## Status & provenance

**Proposed** — not yet accepted. This plan records a design so the operator can
ratify (or redirect) a *convention* before it is built. It is a change to how
the brain operates — a new repeatable execution mode plus, eventually, a
`type: methodology` doc — so it follows the persist-plans and
taxonomy-evolution disciplines: propose, ratify, then implement and pilot.
Per the persist-plans policy this is filed now, before any of it is acted on.

The convention is the model-and-tooling application of two ratified
directions this bundle already holds:

- [The engineer as orchestrator, not implementer](/meta/doctrine/engineer-as-orchestrator.md)
  — "agent coordination over hand-implementation"; the orchestrator's binding
  constraint is *judgment-context across many delegated matters*.
- [Capability-matched model selection](/meta/doctrine/capability-matched-model-selection.md)
  — allocate capability by the epistemic weight of the motion; delegate
  mechanical/derivational/oracle-checked motions downward.

Fresh-context subagent execution is exactly the shape both point at, and it is
what Anthropic's current Claude Code guidance recommends: isolate bounded units
of work into subagents with fresh, minimal, task-scoped context — not the full
session history — keep the orchestrating session thin, and compose independent
workers for parallelism heavier than one orchestrator handles serially.

## The gap this closes

Plans in this bundle *already* reach for fresh-context execution, but only as
ad hoc prose promises with no defined mechanism:

- [rename second-brain → elixir-mind](/meta/plans/rename-second-brain-to-elixir-mind.md)
  splits the lift into "workstream A" and "workstream B" with "Phase 1
  execution handed to a fresh session" — but never says what that fresh session
  receives to start cold.
- [epistemic overlay](/meta/plans/epistemic-overlay.md) defines "Thread A (CB
  asset import) and Thread B (architecture sketch), in order, with filed
  captures as the handoff artifact" and even writes a per-thread reading
  allowlist ("Thread B does not open CB") — the closest existing instance of
  the payload this plan standardizes — but each thread is still hand-launched
  prose, with no mechanical fan-out, no readiness gate, and no defined
  reconciliation back into the plan/PR/capture flow.

Neither names **a standard payload** for what a fresh executor needs to start
cold, nor **a standard way the results fold back** into the plan doc, the PR,
and the session-capture record. This plan supplies both, and makes the
environment's `Workflow` tool (`agent()`, `parallel()`, `pipeline()`,
`phase()`, worktree isolation) the concrete mechanism.

The [orchestrator-alignment analysis](/meta/analysis/alignment-with-the-orchestrator-role.md)
names the constraint this must respect (gap 3): the brain "coordinates agents
across time superbly but in parallel poorly" — concurrent branches "collide on
`index.md` and registry files," and the near-term palliative is "making the
collision-prone surfaces order-insensitive or regenerable." Any parallel
fan-out this convention enables must obey that (see *Decision 5*).

## What the convention is (overview)

A ratified plan whose build order is bounded, self-contained work becomes
*executable* by carrying an **`## Execution` section**: a per-workstream spec
plus an execution order. A thin **orchestrating session** then:

1. runs a **pre-execution readiness gate** over that section (is each
   workstream actually scoped to fit a fresh context?);
2. generates and runs a **Workflow script** that fans the workstreams out to
   fresh-context `agent()` calls, each receiving only a minimal **Execution
   Context Payload (ECP)** — never the deliberation history;
3. **folds the synthesized results back** into the plan doc (an execution
   record + status flip), the PR/commit graph (the actual changes, carrying
   session provenance), and the thread doc (the orchestrator's narrated
   synthesis, captured normally).

The plan doc is the durable payload; the ECP is a thin pointer packet into it;
the orchestrating session is the single session of record.

## Decision 1 — a plan's `## Execution` section is the executable spec

An accepted plan opts into Workflow execution by carrying an `## Execution`
section. It declares an **execution order** (which workstreams are independent
→ `parallel()`, which chain → `pipeline()`, which are strictly sequential) and,
per workstream, a **workstream spec** with these fields:

| Field | Holds | Why it's needed |
|-------|-------|-----------------|
| **id / label** | short slug, e.g. `workstream-A`, `thread-a-cb-import` | names the `agent()` label and the execution-record row |
| **scope** | the in/out boundary — what this workstream changes and what it must not touch | plans already write this; it becomes the agent's mandate |
| **reading allowlist** | what the fresh agent may read (bundle paths, specific plan sections, attached repos) — and what it must *not* open | context-fit: the epistemic overlay's "Thread B does not open CB" made a `type` distinction; here it is a first-class field |
| **deliverable** | what the agent produces and returns — a structured result (schema) when it folds back mechanically, or a synthesized prose result otherwise | the Workflow `agent(..., {schema})` contract; defines fold-back shape |
| **verification** | the gate commands / residue checks the agent runs to self-certify before returning (the plan's existing gate suite, scoped to this workstream) | delegates the correctness burden to a mechanical oracle per the capability-matched doctrine |
| **isolation** | `read-only` (returns text/data, mutates nothing) or `mutates-files` (needs `isolation: 'worktree'`) | decides worktree cost and the *Decision 5* write-partition |
| **depends-on** | ids of workstreams that must complete first | maps directly to `parallel` vs `pipeline` vs sequential |

A plan that names workstreams in prose (like the two examples above) is
*retrofitted* to this shape by lifting the boundaries it already states into the
table — the section formalizes what good plans already gesture at, it does not
add new planning burden.

## Decision 2 — the Execution Context Payload (ECP): the standard cold-start packet

The core question the task poses is *what a fresh session needs to start cold*.
The answer rests on an existing invariant: **the plan doc already survives the
session that produced it** (that is the whole point of persist-plans). So the
ECP is not a re-transcription of deliberation history — it is a **thin pointer
packet into the plan on disk**. Every spawned `agent()` receives exactly:

1. **`plan_ref`** — the bundle path to the plan doc (present in the checkout /
   worktree the agent runs in).
2. **`workstream_id`** — which workstream spec (Decision 1) to execute.
3. **scope + reading allowlist** — lifted from the spec, stated as the agent's
   hard bounds ("read only these; do not open …").
4. **deliverable contract** — what to return, with the `schema` when structured.
5. **verification commands** — the gate/residue checks to run before returning.

What the ECP deliberately **excludes**: the deliberation thread, the chat
history, the reasoning that produced the plan, and sibling workstreams' internal
work. The operating contract (`CLAUDE.md`) is *not* in the payload — it loads
automatically because the agent runs inside the repo. The **context-fit
assertion** is precisely that a workstream is executable from *the plan text
plus the live bundle it is allowed to read* — nothing that lived only in the
originating session. If an executor would need session-only knowledge, the plan
is underspecified and the readiness gate (Decision 3) must catch it.

This makes the ECP small, uniform, and auditable: five fields, all derivable
from the `## Execution` section, no free-form context dump.

## Decision 3 — a pre-execution readiness gate before any executor spawns

Yes, the pre-execution check the task asks about belongs in the convention — it
is the mechanism that keeps the ECP's context-fit assertion honest, and it
catches the exact failure the two example plans risk: *promising fresh-context
execution without writing down what the fresh context needs.*

The gate is a cheap first phase — one `agent()` (or the orchestrator itself)
reading only the plan's `## Execution` section and returning a **structured
readiness verdict per workstream**:

- plan `status` is `accepted` or `in-progress` (never execute a `proposed`
  plan);
- each workstream names all seven spec fields (Decision 1);
- **context-fit** (the judgment call): is the workstream executable from
  `plan_ref` + its reading allowlist alone, or does it smuggle a dependency on
  session-only knowledge? Flag underspecified workstreams with the missing
  piece named.
- **isolation sanity**: any `mutates-files` workstream declares its file
  partition (Decision 5); no two parallel workstreams claim the same files or
  the same derived surface.

Verdict `ready` → proceed to fan-out. Verdict `underspecified` → the
orchestrator stops and reports the gaps to the operator for a plan edit, rather
than spawning executors that will improvise. This is the readiness gate as a
Workflow `phase()`, in the spirit of `mix brain.verify`: a boolean floor before
the expensive work, not a score.

## Decision 4 — fold-back: the orchestrating session is the single session of record

This is the subtle reconciliation the task flags: **threads freeze at
`/capture` time**, and `/capture` renders only the *delivered* `## User` /
`## Assistant` message stream — it strips tool calls and reasoning. A Workflow
runs *inside a tool call*, so its subagents' internal work never enters the
delivered stream. Three rules resolve this without breaking any existing policy:

1. **One thin orchestrating session, captured normally.** The Workflow runs
   inside one orchestrating session. That session is what `/capture` freezes and
   what `/create-pull-request` ships as one PR + one thread doc, with the usual
   routing ledger and route tags. Subagents do **not** produce their own thread
   docs — they have no delivered message stream to capture.

2. **The orchestrator must narrate the synthesized results in delivered chat
   text.** Because `/capture` strips the tool calls the Workflow ran in, an
   execution that is *only* tool calls vanishes from the thread doc. The
   convention therefore **mandates**: after the Workflow returns, the
   orchestrator reports each workstream's synthesized result and verification
   verdict as ordinary `## Assistant` chat text. That narration is what capture
   retains verbatim — it is the thread-level record of what the fan-out
   produced. (This is the Workflow analogue of the existing "ask the operator in
   the chat, not the dialog box" rule: only the delivered stream is captured.)

3. **Commits carry the real per-change provenance; the plan doc carries the
   execution record.** The thread narrates the *synthesis*; the **commit graph**
   records the *actual changes*, and via true-merge into `main` (never
   squash/rebase, per the merge-strategy policy) those commits stay reachable
   with the orchestrating session's trailer. On completion the orchestrator
   appends an **execution record** to the plan doc — which workstreams ran, the
   Workflow `runId` and persisted script path, the verification verdicts, and
   the resulting PR — and flips `status` (`accepted` → `in-progress` → `done`).
   This mirrors how the rename plan already records "Both PRs merged
   2026-07-14." The three surfaces are orthogonal and none duplicates another:
   **plan doc** = how it was executed + status; **PR/commits** = the changes +
   provenance trailer; **thread doc** = the narrated synthesis.

## Decision 5 — parallel writes must partition files; regenerate shared surfaces once, serially

The [orchestrator-alignment analysis](/meta/analysis/alignment-with-the-orchestrator-role.md)'s
gap 3 is load-bearing here: this bundle's collision-prone surfaces —
`index.md` files, `meta/registry.md`, `CLAUDE.md`, the materialized route-tag
logs — are shared derived artifacts that parallel writers corrupt. Worktree
isolation (see
[git worktrees for parallel agents](/knowledge/SWE/version-control/git/git-worktrees-for-parallel-agents.md))
converts silent overwrites into merge-time conflicts, but the cleaner discipline
is to avoid the conflict:

- **Read-only / spec / analysis workstreams** (e.g. the epistemic overlay's
  Thread A captures and Thread B architecture sketch) return synthesized content
  (structured or prose); the **orchestrator writes and commits it** in the main
  session. No worktree needed.
- **Independent file-mutating workstreams** run with `isolation: 'worktree'`
  and must claim **disjoint file sets** — enforced by the readiness gate's
  isolation-sanity check.
- **Shared derived surfaces are never regenerated in parallel.** Index upkeep,
  `mix brain.registry`, `mix brain.contract`, and
  `mix brain.route_tags --materialize` run **once, serially, in a final
  integration phase** by the orchestrator after the fan-out completes — exactly
  the "make collision-prone surfaces regenerable, regenerate once" palliative
  the analysis prescribes. Regeneration is a derivational motion (delegate-down
  per the capability-matched doctrine); the correctness oracle is the `--check`
  gate suite.

## Scope boundaries (what this plan deliberately excludes)

- **No new policy or verifier gate — yet.** This convention lands as a
  `type: methodology` doc (the repeatable how-to), not a machine-enforced
  policy. Whether a thin policy later *requires* accepted plans to carry a
  well-formed `## Execution` section — and whether `mix brain.verify` grows a
  check for it — is deferred until the pilot shows the section shape is stable
  and worth gating. Doctrine already supplies the "why"; a premature policy
  would gate a shape still in flux.
- **No autonomous execution of unratified plans.** The gate refuses any plan
  not `accepted`/`in-progress`. This convention is about *executing* ratified
  decisions, never *making* them — ratification stays the operator's, per the
  preamble's role split.
- **No cross-session parallelism beyond one orchestrator's Workflow.** The unit
  is one orchestrating session running one Workflow. Coordinating multiple
  independent *orchestrator* sessions (the "agent team" scale, the librarian
  write-broker) stays out of scope — this is the near-term, single-orchestrator
  step toward the alignment analysis's parallel-coordination goal, not the
  end state.
- **No committing of generated Workflow scripts as bundle documents.** The
  script is an ephemeral execution artifact; its persisted path and `runId` are
  recorded in the plan's execution record for reproducibility, but the script is
  not filed as a `type` document. The plan's `## Execution` section is the
  durable spec; the script is regenerated from it.

## The methodology that comes out of a successful pilot

Per the task and the type vocabulary, the durable, repeatable procedure is a
`type: methodology` doc — the distilled *how-to* for running this execution
mode, written after a real pilot proves it. Placement (deferred to the
methodology step, following the taxonomy-evolution protocol): the
`methodology` type is not pinned to `meta/`, and the one existing methodology
([testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md))
lives in the knowledge tree, not governance. This one is about orchestrating
*this brain's* plan execution via the Workflow tool, so it fits under the
established `knowledge/SWE/agentic/` domain — most likely a new
`knowledge/SWE/agentic/orchestration/` subdirectory (creating a subdir under an
already-established top-level domain is autonomous per the taxonomy protocol;
its `index.md` is added on creation). The methodology would carry the concrete
recipe: the `## Execution` section template, the ECP field list, the readiness
`agent()` prompt + schema, the fan-out `pipeline`/`parallel` skeleton, the
integration-phase regeneration order, and the fold-back checklist.

## Build order (on ratification)

1. Flip this plan to `in-progress`.
2. **Write the `## Execution` section template** and the ECP field list as the
   convention's normative core (in this plan, then lifted into the methodology).
3. **Author the readiness-gate `agent()`** — the prompt and the structured
   readiness-verdict schema (`ready` | `underspecified` with named gaps).
4. **Author the fan-out Workflow skeleton** — a parameterized script that reads
   a plan's `## Execution` section, runs the readiness phase, fans workstreams
   out via `pipeline()`/`parallel()` with per-workstream ECPs and schemas, and
   returns synthesized results for the orchestrator to fold back.
5. **Pilot against one real pending case** (see below), end to end: readiness
   gate → fan-out → fold-back (plan execution record, PR, narrated capture).
6. **Distill the successful run into the `type: methodology` doc** under
   `knowledge/SWE/agentic/orchestration/` (create the subdir + `index.md`);
   update [`meta/plans/index.md`](/meta/plans/index.md) and flip this plan to
   `done` with the pilot's execution record.

### Pilot candidate (for the operator to confirm at ratification)

The task named the rename Phase 1 and the epistemic Thread A/B split. Since
filing, the [rename plan is `done`](/meta/plans/rename-second-brain-to-elixir-mind.md)
(both PRs merged) — a good *retrospective* illustration of the two-workstream
shape, but no longer a live pilot. Of what is actually pending in
[the Accepted / In-progress section](/meta/plans/index.md):

- **[Three-level documentation](/meta/plans/three-level-documentation.md)**
  (`accepted`, execution deferred) — **recommended pilot.** Self-contained,
  reads only this bundle, no external repo dependency, and its build order
  already decomposes into near-independent workstreams (a policy-doc + verifier
  workstream, and two pilot-document workstreams) with an explicit gate suite —
  an almost ready-made `## Execution` section, and a clean test of the
  write-partition + serial-regeneration discipline (Decision 5).
- **[Epistemic overlay](/meta/plans/epistemic-overlay.md) Thread A/B**
  (`proposed`) — the more ambitious pilot, and the one that best exercises the
  reading-allowlist ECP field (Thread A reads CB; Thread B reads only the
  bundle). But it is not yet `accepted`, and Thread A needs the Composable
  Beliefs repos attached to the session — a heavier setup. Better as a second
  pilot once the convention is proven on the self-contained case.

The operator's call on which to pilot (and whether to accept the epistemic
overlay first so it qualifies) is part of ratifying this plan.

## Open questions (for the operator / executing session)

1. **Pilot choice** — three-level-documentation (recommended, self-contained)
   or epistemic Thread A/B (more ambitious, needs CB attached and the overlay
   plan accepted first)?
2. **Execution-record home** — append the record to the plan doc (recommended,
   keeps how-it-executed with the decision) or to the thread doc? The plan
   outlives the branch and already carries status; the thread records the PR.
   Recommendation: plan doc.
3. **How much to mandate vs. recommend** — is the orchestrator-narration rule
   (Decision 4.2) a hard convention or a strong recommendation? It has no
   mechanical oracle (like route-tag coverage), so enforcement is editorial
   either way; the question is how firmly the methodology states it.
4. **Worktree default** — default file-mutating workstreams to
   `isolation: 'worktree'` always, or only when two or more mutate in parallel?
   Worktrees cost setup + disk; a single mutating workstream in an otherwise
   read-only fan-out may not need one.
