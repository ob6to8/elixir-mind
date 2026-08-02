---
type: reference
title: 2026-08-02-matters-register-plan-metadata
description: Operator-directed register revision run through its own matter lifecycle — Type (planned/independent) and Order columns added to both tables of meta/matters.md, projected from the matter docs' plan/order frontmatter, with pre-migration Consumed rows derived from their git-history packets and the plans' build orders; filed, executed, and consumed in two commits, closed with /create-pull-request merge.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, matters, register, work-queue]
timestamp: 2026-08-02
session: https://claude.ai/code/session_015y8HUrdQj2u3JGAYwbjD61
pr: 231
---

# 2026-08-02-matters-register-plan-metadata

## Where this landed

The operator read the register's queue table and found it silent on two
facts the matter docs already carry: whether a plan emitted each matter,
and where the matter sits in that plan's self-contained build order. The
instruction — a Type column (planned/independent) and an Order column,
persisting in the Consumed section too — was itself run through the matter
lifecycle it concerns: filed as the independent matter
[matters-register-plan-metadata](/meta/matters/matters-register-plan-metadata.md)
(commit `fe50017`), then executed and consumed (commit `cacae74`). Both
register tables now project the docs' `plan`/`order` frontmatter, with
`planned` linking the emitting plan; pre-migration Consumed rows took
their values from their git-history scope packets and the plans' build
orders (the vocabulary adoption and the stand-up identified as matter-docs
builds 1 and 2; the definition question, the deferred-work policy, and the
methodology finalization independent). The register's protocol prose names
the docs as the columns' source, keeping them canonical, and row↔doc
agreement stays with the queued `mix brain.matters` verifier. Full gate
suite green on both commits (201 tests). Closed with
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Type/Order columns on the matter register — `planned` links the emitting plan, Order its in-plan build position, both tables | closed | [matters register](/meta/matters.md) | - |
| The instruction itself filed, executed, and consumed as an independent matter | closed | [matters-register-plan-metadata](/meta/matters/matters-register-plan-metadata.md) | - |

## User

<routes ref="meta/matters.md meta/matters/matters-register-plan-metadata.md">
re: meta/matters

in the matters list, we see:

# Matter
1 Todo fold
2 The /matter skill
3 mix brain.matters verifier
4 /create-pull-request scoping edit
5 dev-history recommit + regeneration fold-in
6 response-resource-links / Pages-sunset revision
7 Two-sided bias taxonomy implementation
8 TDD bookmark promotions
9 Vendor-block pilot

it isn’t clear from this table 1. if each entry is part of a plan or 2. if it is, what order the matter is in the plan’s self contained order. this should be expressed in the table with a type column (planned/independent) and with an order column (if planned, what order number internal to the plan)

these should persist in the consumed section as well
commit this instruction to a matter, execute, then file as done/consumed
</routes>

## Assistant

The operator wants the matters register to surface, per row, whether a matter is plan-emitted and its order within that plan — in both the pending and consumed sections — with the instruction itself run through the matter lifecycle. I'll read the register, the matter docs, and the surrounding conventions first.

<routes ref="meta/matters.md">
Evidence so far: pending rows 1–3 are matter-docs builds 3/4/5, row 7 is bias-taxonomy build 1, row 9 is two-level build 3, rows 4/5/6/8 are standalone. For Consumed: "vocabulary adoption" matches matter-docs build 1 verbatim, "stand up + thin" is build 2 per its done doc. Let me verify the remaining three Consumed rows aren't plan-emitted, and check what `mix brain.verify` demands of a matter doc's attribution.

`from` is warn-only and expected only on plan/analysis/elaboration/issue — a matter doc without it is clean. Before settling the three remaining Consumed rows as independent, let me check the pre-thinning register in git history — the original row packets are the definitive evidence for whether a plan emitted them.

The evidence is complete: the original row packets confirm the vocabulary adoption was matter-docs build 1 and the stand-up was build 2, while the definition question, the deferred-work policy, and the methodology finalization attach to no plan's numbered build item — independent. Now I'll file the matter doc (commit 1), then execute and consume it (commit 2).
</routes>

<routes ref="meta/matters.md meta/matters/matters-register-plan-metadata.md">
The register now answers both questions your message raised — every row shows whether a plan emitted it, and where it sits in that plan's own sequence — in the pending queue and the Consumed log alike. Your instruction itself went through the full lifecycle you prescribed: filed as a matter doc (commit 1), executed (commit 2), and consumed — its doc is `done` and it sits as the newest Consumed row. Both commits are pushed to `claude/matters-list-metadata-1eoigq`; no PR was opened since you didn't ask for one.

Shape of the change, in the [register](https://github.com/ob6to8/elixir-mind/blob/claude/matters-list-metadata-1eoigq/meta/matters.md): both tables gained **Type** and **Order** columns. `planned` links the emitting plan (so two plans' internal "order 3"s can't be confused), with Order the matter's position in that plan's build order; a standalone matter reads `independent` / `-`. The values are a projection of the matter docs' existing `plan`/`order` frontmatter — the docs stay canonical, and the register's protocol prose now says "authored here" of the global order and names the docs as the columns' source, so the file's self-description stays true. Row↔doc agreement, these columns included, already falls inside the queued `mix brain.matters` verifier's scope, so no new filing was needed for enforcement.

The values, derived rather than recalled: queue rows 1–3 are matter-docs builds 3/4/5, row 7 is bias-taxonomy build 1, row 9 is two-level build 3 (all from doc frontmatter); rows 4/5/6/8 are independent. In Consumed, "Stand up + thin" is matter-docs build 2 (its done doc) and the vocabulary adoption is build 1 (matches the plan's build-order 1 item verbatim); the definition question, the deferred-work policy, and the methodology finalization are independent — no numbered build item claims them in either cited plan's build order, the pre-thinning row packets in git history, or a grep across `meta/plans/`.

**What I created**

| type | doc | why this type |
|---|---|---|
| matter | [matters-register-plan-metadata](https://github.com/ob6to8/elixir-mind/blob/claude/matters-list-metadata-1eoigq/meta/matters/matters-register-plan-metadata.md) | your instruction is one coherent, reviewable delivery unit — filed, executed, consumed per its own three-step directive; independent (no plan emitted it) |

**What I modified**

| file | thrust of the change |
|---|---|
| [meta/matters.md](https://github.com/ob6to8/elixir-mind/blob/claude/matters-list-metadata-1eoigq/meta/matters.md) | Type/Order columns on both tables; protocol and Consumed prose name the docs as the columns' source; new Consumed row |
| [meta/matters/index.md](https://github.com/ob6to8/elixir-mind/blob/claude/matters-list-metadata-1eoigq/meta/matters/index.md) | new matter listed, moved Open → Done at consumption |

**Actions I have taken**

| action | result |
|---|---|
| Commit 1 — file the matter | `fe50017`, doc filed open as backlog |
| Commit 2 — execute + consume | `cacae74`, register revised, doc flipped done, Consumed row logged |
| Gate suite (pre-commit, both commits) | green — bundle verify, route tags, glossary, contract/registry/code-map freshness, 201 tests; warnings all pre-existing and advisory |
| Push | `claude/matters-list-metadata-1eoigq` pushed, up to date with both commits |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` | runs capture/glossary/stamping and opens the PR; per the register's protocol, the new Consumed row's Landed cell gets the PR number appended once one exists |
</routes>
