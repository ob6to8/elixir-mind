---
type: reference
title: 2026-08-02-matter-type-vocabulary-adoption
description: Consumed register row 1 under the interim protocol — build-order 1 of the matter-docs plan: the matter vocabulary entry drafted in the proposal so approval ratified its wording, delivered into controlled-type-vocabulary with the contract recompile, the plan flipped in-progress as an approved rider, and the queue consumed and renumbered; closed with /create-pull-request merge.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, matters, types, vocabulary, contract]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01NsNFJzjuALMpkiUkL8ywcy
---

# 2026-08-02-matter-type-vocabulary-adoption

## Where this landed

A fresh thread consumed the register's top matter — the `type: matter`
vocabulary adoption, build-order 1 of the
[matter-docs plan](/meta/plans/matter-docs-architecture.md) — under the
operator's interim consumption protocol (re-print the row as the record,
propose, wait for approval). The proposal carried the drafted entry text
itself plus one rider (flip the plan `accepted` → `in-progress`), so the
operator's approval ratified wording, not just intent. Delivered in one
commit (`28ea26b`): the `matter` entry in
[controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md)
(review-quantized delivery unit; `status: open/done/cancelled`; optional
`plan`/`order` props, omitted on standalone matters; governance namespace,
no `em:` id), the contract recompile, the plan status flip, and the register
consumption (row 1 → Consumed, queue renumbered 1–10). The full gate suite
ran green (201 tests, 0 failures). Closed with `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| `matter` vocabulary entry (register row 1) | closed | [controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md) | - |
| Matter-docs plan lifecycle (`accepted` → `in-progress`) | closed | [matter-docs plan](/meta/plans/matter-docs-architecture.md) | - |
| Register consumption: row 1 → Consumed, queue renumbered | closed | [matters register](/meta/matters.md) | - |

## User

take the top matter from meta/matters.md as your task

interim protocol (until the /matter skill exists — see register row 4):

1. re-print the matter row verbatim here in the thread first, as labeled
   fields (Matter / Scope / Context), not a raw table row — this is the
   record, since the row will be removed from the file by the end
2. state what you are going to do and how, then stop and wait for my
   approval before executing anything
3. after approval and delivery: remove the row from the queue and log it
   under the register's ## Consumed section in the same edit (date,
   matter, landing), renumbering the remaining rows
4. at close, when I invoke /create-pull-request, append the landing PR
   number to the consumed row per the Consumed section's protocol line

## Assistant

The queue's top row is **row 1 — `type: matter` vocabulary adoption**. Nothing is executed yet; per the interim protocol, here is the row as the record, then my intended approach, and I stop for your approval.

<routes ref="meta/matters.md">
## The record — matter row, reprinted

**Matter:** `type: matter` vocabulary adoption

**Scope:** Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 1 (ratified 2026-08-02, [analysis](/meta/analysis/matters-vs-plans.md)): add `matter` to the controlled-type-vocabulary policy — the review-quantized delivery unit; `status: open/done/cancelled`; optional `plan` (bundle-absolute path) + `order` (integer position in that plan's sequence), both omitted on standalone matters; governance namespace, no `em:` id — and recompile the contract.

**Context:** fresh
</routes>

## What I will do, and how

I read the matter-docs plan (build-order 1 and its boundary decisions), the matters-vs-plans analysis, and the current vocabulary policy; the entry below is drafted from those three, and every property in it traces to the scope packet or a plan boundary decision.

<routes ref="meta/policy/controlled-type-vocabulary.md">
**1. Edit `meta/policy/controlled-type-vocabulary.md`** — insert this entry into the seed vocabulary immediately after `todo` (keeping the work-tracking cluster `issue`/`plan`/`analysis`/`todo`/`matter` adjacent), and bump the policy's `timestamp` to 2026-08-02:

> - `matter` — the review-quantized unit of delivery: one coherent intent a
>   reviewer can approve or reject as a whole (one matter per PR, per
>   [atomic pull requests](/meta/policy/git-atomic-pull-requests.md)), filed
>   as a self-contained handoff packet — the intent plus the decisions already
>   made, with refs carrying the detail — so a fresh thread can deliver it.
>   Carries a `status` (`open`/`done`/`cancelled`); when a plan's build order
>   emits it, also a `plan` (the bundle-absolute path of that plan) and an
>   `order` (integer position in that plan's own sequence) — both keys omitted
>   on a standalone matter. Queued-ness is register membership, never a
>   status: an open matter listed in [the matter register](/meta/matters.md)
>   is committed and globally ordered; an open matter outside it is backlog.
>   Distinct from a `plan` (a *decision record* whose build order emits
>   matters — a matter is the delivery unit itself and needs no plan behind
>   it), an `issue` (a tracked *problem* that may never become work; an issue
>   spawns a matter when its fix is decided), and a `todo` (a plain task item,
>   not committed to delivery as a PR) — a matter is *committed work shaped to
>   fit review* (lives under `meta/matters/`, governance namespace, no `em:`
>   id).

Scope notes on the draft: the queued-ness sentence encodes the plan's "register membership is the queue marker" boundary decision, so no one invents a `queued` status; the `distinct from a todo` clause is written for the present (both types coexist until the build-order-3 fold, which is a later matter and stays untouched here); the plan's `pr:`-on-done landing metadata is deliberately left out — it belongs to build-order 5, which retires the Consumed section.
</routes>

**2. Recompile the contract** — `mix brain.contract` regenerates `CLAUDE.md` (the recompile rides its source change per the atomic-PR policy), then `mix brain.verify` and `mix brain.contract --check` to confirm the gates are green.

**3. Consume the row in the same delivery** — edit `meta/matters.md`: delete row 1, renumber rows 2–11 to 1–10, and append to `## Consumed` (newest first):

> | 2026-08-02 | `type: matter` vocabulary adoption | [vocabulary entry](/meta/policy/controlled-type-vocabulary.md) + contract recompile |

The PR number is appended to that row at close, when you invoke `/create-pull-request` (which also stamps this thread into the policy's `attribution.from`).

**4. Commit and push** on `claude/matter-queue-protocol-ami2jd` (creating it locally first). The PR waits for your `/create-pull-request`.

**Questions you need to answer**

| # | Question | My recommendation |
|---|---|---|
| 1 | Approve executing the above as stated (including the entry wording)? | Approve — every property traces to the scope packet or a ratified boundary decision |
| 2 | Rider, one line outside the scope packet: flip the matter-docs plan's `status: accepted` → `in-progress` in the same commit, since its first emitted matter is now delivering? | Yes — present-tense upkeep of the plan doc, and it rides naturally |

Awaiting your approval.

## User

<routes ref="meta/policy/controlled-type-vocabulary.md meta/plans/matter-docs-architecture.md">
1 - approve
2 - yes
</routes>

## Assistant

Delivered. The `matter` type is now in the controlled vocabulary and compiled into the contract, the matter-docs plan is marked in-progress, and the register row is consumed — all committed as `28ea26b` and pushed to `claude/matter-queue-protocol-ami2jd`. The full pre-commit gate suite ran green (format, xref, freshness checks, bundle/route-tag/glossary verifiers, and 201 tests, 0 failures; the warnings in the output are advisory and pre-existing, none introduced by this change).

**What I modified**

| File | Thrust of the change |
|---|---|
| `meta/policy/controlled-type-vocabulary.md` | Added the `matter` entry after `todo` (review-quantized delivery unit; `status: open/done/cancelled`; optional `plan`/`order`, omitted on standalone matters; governance namespace, no `em:` id); timestamp bumped |
| `CLAUDE.md` | Regenerated by `mix brain.contract` — the entry now binds every fresh session via §5 |
| `meta/plans/matter-docs-architecture.md` | `status: accepted` → `in-progress` (approved rider) |
| `meta/matters.md` | Row 1 removed, queue renumbered 1–10, landing logged under Consumed (PR number pending) |

**Actions I have taken**

| Action | Result |
|---|---|
| `mix brain.contract` + `--check` | Recompiled; fresh |
| `mix brain.verify`, `mix brain.route_tags`, `mix brain.registry --check`, glossary/lineage checks, `mix test` | All green — 201 tests, 0 failures |
| Commit + push | `28ea26b` on `claude/matter-queue-protocol-ami2jd` (branch pushed, tracking set) |

Per the interim protocol's step 4, the one remaining motion is yours: when you invoke `/create-pull-request`, I'll append the landing PR number to the consumed row (and the close flow will stamp this thread into the revised policy's and plan's `attribution.from`). The next queued matter — stand up `meta/matters/` and thin the register, now row 1 — is flagged `fresh`, so it waits for its own thread after this one lands.
