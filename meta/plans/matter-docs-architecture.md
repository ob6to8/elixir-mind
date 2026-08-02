---
type: plan
title: "Matter docs: a matter type, plan/order props, and the register as an order-only view"
description: Execute the ratified matters-vs-plans resolution — each matter becomes a governance doc (type matter, status, optional plan/order props), plans back-link as superstructure, meta/matters.md thins to the order-only pointer view over queued matters, todo folds into matter, and a /matter skill plus a mix brain.matters verifier close the loop.
status: done
provenance: "Claude Fable 5, matter-register consumption session, in ratification dialog with the operator"
tags: [meta, plan, matters, work-queue, types, skills, verifier]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T07:25:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (row 1)"
  why: "the operator ratified the matter-doc architecture while consuming the matters-vs-plans question; this plan is its executable spec, superseding the matter-queue plan"
  from: [/meta/threads/2026-08-02-deferred-work-policy-and-consumed-matters-log.md, /meta/threads/2026-08-02-matters-vs-plans-and-matter-docs.md, /meta/threads/2026-08-02-matter-type-vocabulary-adoption.md, /meta/threads/2026-08-02-build-the-matter-skill.md]
---

# Matter docs and the order-only register

## Problem

[matters-vs-plans](/meta/analysis/matters-vs-plans.md) settled the definition
question and the operator ratified the architecture (2026-08-02): once each
matter is a first-class doc, the register's row-packets duplicate nothing, and
the register keeps only the one datum it alone can hold — the global delivery
order. This plan is the executable spec. It supersedes
[matter-queue-and-present-matters](/meta/plans/matter-queue-and-present-matters.md),
whose own escalation clause ("the register becomes a `meta/matters/`
directory, one file per matter with a derived ordered view") it completes.

## Desired state

File-tree diff:

```
meta/
~ matters.md          # thinned: ordered pointer rows over queued matters — order is the only stored datum
+ matters/            # NEW: one doc per matter, type: matter
+   index.md          # NEW: reserved listing
- todos/              # folds into meta/matters/ (build 3); type todo retires
```

Matter-doc frontmatter shape:

```yaml
type: matter
title: ...
description: ...              # the packet: the intent plus decisions already made; refs carry detail
status: open                  # open · done · cancelled — queued-ness is register membership, not a status
plan: /meta/plans/<slug>.md   # omitted on a standalone matter
order: 2                      # position in that plan's own sequence; omitted alongside plan
attribution: { ... }          # standard governance attribution
# on done: landing metadata (pr: <N>), which eventually retires the register's Consumed section
```

## Boundary decisions

- **The canonical edge is matter→plan** (`plan` prop, bundle-absolute path —
  governance docs carry no `em:` ids). Plan-side back-links are prose;
  bidirectional consistency is a verifier concern, never an authoring
  invariant.
- **Register membership is the queue marker.** Open and in the register =
  committed, globally ordered; open and outside = backlog (the former todo).
  `status` never encodes queued-ness.
- **Absence is omission.** A standalone matter carries no `plan`/`order` keys —
  the bundle's existing convention (`verified` omitted on captures, `session:`
  omitted when unset).
- **Order lives twice, checked once.** `order` is the per-plan position; the
  register is the global sequence; the invariant — the global sequence never
  inverts a plan's internal order — belongs to `mix brain.matters`.
- **The register stays hand-kept.** Its one stored datum cannot be derived;
  everything else about it becomes a view over the docs.

## Build order (one matter each, queued as register rows 1–5)

1. **Vocabulary + contract.** Add `matter` to
   [controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md) —
   the review-quantized delivery unit; `status: open/done/cancelled`; optional
   `plan`/`order`; governance namespace — and recompile the contract.
2. **Stand up `meta/matters/` and thin the register.** Migrate the queued rows
   to matter docs; rewrite `meta/matters.md` as the order-only pointer view;
   revise its protocol prose; add the directory index.
3. **Todo fold.** Migrate all of `meta/todos/` to `meta/matters/` (open todos
   become backlog matters; done/cancelled keep their status); retire
   `type: todo` from the vocabulary and recompile; repoint the reading
   surfaces (`mix brain.session_init`, `/priorities`, the `/todo` skill
   retired or aliased to `/matter`); indexes.
4. **The `/matter` skill** (merged former register rows 2+3,
   operator-approved 2026-08-02). Bare invocation consumes the top pointer
   under the approval-gated protocol: print the matter as the record, state
   the approach, wait for approval, deliver, flip the doc `done`, drop the
   pointer, and log per the register's protocol. `list` renders the register
   (and the backlog beneath it); `create` files a matter, absorbing
   `/todo create`. Skills-registry entry + contract recompile ride; retires
   the planned `/present-matters`.
5. **`mix brain.matters` verifier.** Pointer refs resolve; the global order
   never inverts a plan's internal order; row↔doc agreement. Then retire the
   register's Consumed section in favor of landing metadata on done docs.
   Gate admission per the
   [coding standards](/meta/policy/elixir-coding-standards.md) rule (signal
   beats upkeep) — built after 1–4 make the structure checkable.

## Decision list

- **Adopted now rather than at the drift trigger** (operator-ratified
  2026-08-02): the migration is cheapest while the queue is nine rows and the
  `/matter` skill does not yet exist — the skill gets built once, against the
  final shape.
- **Rejected: deriving the register from plan-resident build orders** (the
  operator's interim proposal, weighed in
  [the analysis](/meta/analysis/matters-vs-plans.md)): the global interleave,
  plan-less matters, and cross-initiative row context have no derivable
  source; the ratified shape moves the packets out instead and keeps the
  register as the irreducible order store.
- **Rejected: `todo`/`task`/`pr`/`feature` as the type name** — the analysis
  carries the weighing; `matter` ratified.
- **Rejected: `em:` ids on matter docs** — work-tracking docs are governance,
  outside the identity registry, like the todos they absorb.
- **Resolved at build 4 (operator-ratified 2026-08-02):** `/matter list`
  renders the backlog inline beneath the queue (filter arguments slice it) —
  the backlog's failure mode is invisibility, and a separate subcommand is a
  surface that must be remembered; backlog matters may carry the existing
  integer `priority:` key (1 = most urgent, the key `mix brain.session_init`
  already honors) as the soft signal, with the queue never sorted by it — a
  queued row's position is its exact order; and the `/todo` alias window is
  moot — build 3 retired the skill outright and `/matter create` absorbs
  filing with no alias.
