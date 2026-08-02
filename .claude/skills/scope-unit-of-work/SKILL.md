---
name: scope-unit-of-work
description: Scope a described unit of work into either a plan with sequenced matters or a single matter, stamping each matter with the model that should deliver it — filed unsequenced (backlog) by default, queued into the matter register only when invoked as "/scope-unit-of-work sequence". Use when the operator says "/scope-unit-of-work", "scope this out", "break this into matters", "turn this into a plan", or hands over a spec for work that is not being delivered right now.
---

# /scope-unit-of-work — scope a spec into deliverable units

Turn a described unit of work into the artifacts that let a **fresh thread**
deliver it: either one [matter](/beliefs/glossary/matter.md), or a
[plan](/meta/plans/index.md) whose build order emits sequenced matters. Every
matter is stamped with the model the roster says should deliver it. Matter and
plan docs are **governance** — no `em:` ids, standard governance `attribution`.
Follow the [operating contract](/CLAUDE.md).

**Everything following the invocation is the spec** (minus a leading
`sequence` argument). The spec is the operator's statement of intent: scope it,
do not silently re-aim it.

**Scoping is not delivering.** This skill produces artifacts and stops; the
work itself is delivered later by [`/matter`](/.claude/skills/matter/SKILL.md),
one matter per thread, one PR each
([atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)).

## Dispatch

- `/scope-unit-of-work <spec>` → scope and file, leaving the unit **unsequenced**
  (backlog: filed matter docs, no register row).
- `/scope-unit-of-work sequence <spec>` → scope and file, then **commit the unit
  to the queue** — append its matters to [the register](/meta/matters.md) in
  order. The `sequence` argument *is* the operator's ratification to queue.

**Unsequenced is the default because queueing is a commitment.** An open matter
with no register row is backlog — filed and findable, awaiting pickup; a row is
a promise about global delivery order, which is the register's one authored
datum. Scoping something does not commit to delivering it next.

## 1. Take the spec, then refresh against `HEAD`

1. **Read the spec whole** before shaping it. If it names a target that does not
   exist, or leaves a decision that changes the *shape* of the output (one
   matter vs. five), raise it as a blocking question in chat text and wait —
   never a UI dialog element
   ([session-capture](/meta/policy/session-capture.md)).
2. **Search before filing** ([update-in-place](/meta/policy/update-in-place.md)):
   grep `meta/matters/`, `meta/plans/`, and `meta/issues/` for the subject. An
   existing artifact covering this unit is **extended**, never duplicated — say
   so and edit it.
3. **Re-derive current state against `HEAD`**, per the
   [structured-plan-bodies](/meta/policy/structured-plan-bodies.md) refresh
   rule. A spec written from memory of the tree binds to anchors that may
   already have moved; scoping against a stale tree emits matters that are
   partly already done.

## 2. Decide the shape — one matter, or a plan with sequenced matters

The discriminator is
[governance-artifact-routing](/meta/policy/governance-artifact-routing.md)'s:
*if the approach needs deciding, it is a plan; if only the doing remains, it is
a matter.* Applied to a whole unit of work:

| The unit is… | File as |
|---|---|
| one coherent intent a reviewer approves or rejects as a whole, approach already decided | **a single matter** |
| several intents a reviewer would want to approve separately, and/or decisions worth recording before any of them runs | **a plan + its emitted matters** |

- **The split test is independence**, not size: *if the operator could plausibly
  want to merge one part while rejecting another, those are two matters.*
- **Splits stop at the green boundary** — never split where a half cannot
  compile and pass the suite alone, and never sever a change from its tests.
- **A plan that would contain no decisions is a matter.** Do not manufacture a
  plan as a container for one step.
- **Where the plan lives**: `meta/plans/` for the brain or its tooling;
  `projects/<slug>/` for a system built outside this repo
  ([project-namespace](/meta/policy/project-namespace.md)).
- **A new top-level directory is a shape change** — propose it and wait for the
  operator ([taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)).

## 3. Determine the delivering model, per matter

Read [the model roster](/meta/model-roster.md) — the operator's preference data
for which models this repo spends — and apply
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md)
to **each matter separately**. A plan's steps rarely share one epistemic
weight: a decision-bearing step and its mechanical execution belong at
different tiers, which is also a signal they are two matters.

- Stamp the roster's `model:` value on the matter doc's frontmatter (display
  form — `Claude Fable 5`, `Claude Opus 5`).
- Put the **determination** in the doc body, under a `## Model` heading: one or
  two sentences naming the weight that decided it (canonical output · judgment
  with no oracle · oracle-checked execution · derivational or bulk). Frontmatter
  carries the queryable datum; the reasoning is prose and belongs in prose.
- **Undetermined is stated, never guessed**: `model: undetermined` with the
  reason under `## Model`.
- `model:` is **prospective and advisory** — the recommendation for whoever
  delivers. It is not `provenance`, which retrospectively names the model that
  *wrote the doc* ([model-attribution](/meta/policy/model-attribution.md)); on
  an agent-scoped matter the two routinely differ and both are correct.

## 4. File the artifacts

**Each matter doc** at `meta/matters/<kebab-slug>.md`:

- frontmatter: `type: matter`, `title`, `description` (the packet in one
  sentence), `status: open`, `model` (§3), `plan` + `order` **only** when a plan
  emitted it (both omitted on a standalone matter), `provenance` naming the
  scoping model, `tags`, `timestamp`, governance `attribution`
  (`when`/`channel`/`agent`/`why`).
- body: the intent plus the decisions already made, refs carrying the detail —
  enough that a fresh thread delivers it with the doc as the entire handoff —
  then the `## Model` section.
- a backlog matter may carry an integer `priority:` (1 = most urgent), the
  coarse urgency signal where exact order would be fake precision.

**The plan doc** (when the shape is a plan) at `meta/plans/<kebab-slug>.md`:
`type: plan`, `status: proposed` (or `accepted` when the operator has ratified
it in the invocation), the problem, the sequence table (Order · Matter · Intent),
the sequencing rationale, and the decision list that closes every structured
plan. Its subject's *shape* is written as structured artifacts — trees,
file-tree diffs, signatures — per
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md), with prose
carrying the why.

**Indexes**: add each matter to [`meta/matters/index.md`](/meta/matters/index.md)
(Open, alphabetical) and the plan to
[`meta/plans/index.md`](/meta/plans/index.md).

## 5. Sequence — only on `sequence`

Without the argument, stop after §4: the matters are backlog and the response
says so.

With `sequence`, append rows to [the register](/meta/matters.md)'s queue table:

1. **Insert at the head** in the plan's own `order`, renumbering beneath —
   never at the tail
   ([revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md)).
   A unit is placed lower only when it genuinely requires preceding rows to
   land first, or when the operator states a position. A unit that cannot be
   ranked is not queued at all: it stays an unsequenced backlog matter.
2. **Never invert a plan's internal order** — rows sharing a `plan` must appear
   in ascending `order`; `mix brain.matters` fails on inversion.
3. **Cells are exactly four** — `# · Matter · Type · Order`. The Type cell is
   `independent` or a `[planned](<plan path>)` link; Order mirrors the doc's
   `order`, or `-`. A fifth column fails the register-shape check, which is why
   the model is rendered by `/matter list` from the docs rather than stored as a
   register cell.

## 6. Verify, then report

- `mix brain.verify` — bundle conformance.
- `mix brain.matters` — register shape, ref resolution, row↔doc agreement,
  plan-order inversion.
- Report per
  [response-work-report-format](/meta/policy/response-work-report-format.md):
  what was created, the shape chosen and why, each matter's stamped model, and
  whether the unit is queued or backlog. Any decision the scoping left open is a
  blocking question with a recommendation.

## Guardrails

- **Invoking the skill authorizes scoping and filing; it does not authorize
  queueing.** Only `sequence` does that.
- **Scope, do not deliver.** Producing the artifacts is the whole output; a
  matter is delivered later under [`/matter`](/.claude/skills/matter/SKILL.md)'s
  approval-gated protocol. Asked to scope *and* deliver, scope, then hand back.
- **One matter per PR.** Emitting five matters does not license delivering five
  in one thread.
- **Questions are chat text**, never a UI dialog element.
- **Governance namespace** — never mint an `em:` id for a matter or plan doc.
- Never touch `deprecated/`.
