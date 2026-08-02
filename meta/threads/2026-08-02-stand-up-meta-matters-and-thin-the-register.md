---
type: reference
title: 2026-08-02-stand-up-meta-matters-and-thin-the-register
description: Consumed register row 1 under the interim protocol — build-order 2 of the matter-docs plan: the ten queued matters migrated to type matter docs under meta/matters/, the register thinned to the order-only pointer view with protocol prose revised, the directory index added, and the consumption logged; closed with /create-pull-request merge.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, matters, migration, work-queue]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01EbYn88ufkFo5nrH3SjGRcX
---

# 2026-08-02-stand-up-meta-matters-and-thin-the-register

## Where this landed

A fresh thread consumed the register's top matter — standing up
`meta/matters/` and thinning the register, build-order 2 of the
[matter-docs plan](/meta/plans/matter-docs-architecture.md) — under the
operator's interim consumption protocol (re-print the row as the record,
propose, wait for approval). The proposal carried the full doc-by-doc
migration table plus four judgment calls (row 1 gets its own `done` doc; the
`fresh` flag retires into protocol prose; blocked matters stay unmarked in
the pointer view; the bias-taxonomy matter takes `order: 1`) and one rider
(fix the stale matter-docs gloss status in the plans index), so approval
ratified the shape, not just the intent. Delivered as commit `63b24a2`: ten
`type: matter` docs under [`meta/matters/`](/meta/matters/index.md) (this
matter's own doc filed `done`), the register rewritten as the order-only
pointer view with its protocol prose revised and the queue renumbered 1–9,
the directory index, the meta-index updates, and the Consumed row. The full
gate suite ran green (201 tests, 0 failures). A stop hook required the
delivery committed and pushed before capture, so the close ships the capture
in a follow-up commit inside the same PR. Closed with
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Consume the top matter: stand up `meta/matters/`, migrate the ten queued rows to matter docs | closed | [stand-up-meta-matters-and-thin-the-register](/meta/matters/stand-up-meta-matters-and-thin-the-register.md) | - |
| Register thinned to the order-only pointer view; protocol prose revised (skip-blocked rule, backlog, `fresh` retired) | closed | [matters register](/meta/matters.md) | - |
| Stale matter-docs gloss status in the plans index (rider) | closed | [plans index](/meta/plans/index.md) | - |

## User

take the top matter from meta/matters.md as your task

interim protocol (until the /matter skill exists — see register row 3):

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

Taken: the top matter, row 1. Per the interim protocol, here is the record, then my approach — nothing is executed yet.

<routes ref="meta/matters.md meta/matters/stand-up-meta-matters-and-thin-the-register.md">
## The matter (row 1, re-printed as the record)

> **Matter:** Stand up `meta/matters/` + thin this register
>
> **Scope:** Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 2: migrate the queued rows to matter docs, reduce this file to the order-only pointer view (the global sequence over queued matters is the one datum stored here), revise its protocol prose, add the directory index.
>
> **Context:** fresh

(Scope quoted verbatim, bundle-absolute link as written. The plan: [matter-docs-architecture](https://github.com/ob6to8/elixir-mind/blob/claude/matter-queue-processing-lf3nqi/meta/plans/matter-docs-architecture.md); the register: [meta/matters.md](https://github.com/ob6to8/elixir-mind/blob/claude/matter-queue-processing-lf3nqi/meta/matters.md).)
</routes>

<routes ref="meta/matters/index.md meta/matters.md meta/index.md meta/plans/index.md">
## What I will do

**Create `meta/matters/` — one doc per queued row, ten docs plus the index:**

| File | `plan` / `order` | `status` |
|---|---|---|
| `stand-up-meta-matters-and-thin-the-register.md` (this matter) | matter-docs plan / 2 | `done` at delivery; `pr:` stamped at close |
| `todo-fold.md` | matter-docs plan / 3 | open |
| `matter-skill.md` | matter-docs plan / 4 | open |
| `mix-brain-matters-verifier.md` | matter-docs plan / 5 | open |
| `create-pull-request-scoping-edit.md` | standalone — both keys omitted | open |
| `dev-history-recommit-and-regeneration-fold-in.md` | standalone | open |
| `response-resource-links-pages-sunset-revision.md` | standalone; blocker stated in body | open |
| `two-sided-bias-taxonomy-implementation.md` | two-sided-bias plan / 1 | open |
| `tdd-bookmark-promotions.md` | standalone; refs the todo | open |
| `vendor-block-pilot.md` | two-level plan / 3; blocker stated in body | open |
| `index.md` | reserved listing, no frontmatter; Open/Done sections; queue order explicitly deferred to the register | — |

Each doc follows the plan's frontmatter shape: `type: matter`, one-sentence `description`, `status`, `plan`/`order` only where a plan's build order emits it, `provenance` naming the model in the trailer's display form (per model-attribution), and governance `attribution` with `channel: agent-authored` and `from: [/meta/matters.md]` — the register is what each packet is extracted from, and its git history keeps the original rows. Bodies carry the row's scope packet faithfully, links intact — no editorializing.

**Rewrite `meta/matters.md` as the order-only pointer view:** revised protocol prose; a two-column pointer table (`#` + link to the doc); the `## Consumed` section kept until build 5 retires it, gaining this matter's row (date, matter, landing; PR # appended at close per step 4); remaining rows renumbered 1–9. Frontmatter `attribution` kept verbatim (immutable); `description`/`timestamp` updated.

**Update two indexes:** `meta/index.md` (revise the `matters.md` line to the pointer-view description citing the matter-docs plan instead of the superseded matter-queue plan; add the `matters/` directory line), and a one-word rider in `meta/plans/index.md` — its matter-docs gloss still reads `status: accepted` though the plan was flipped `in-progress` in PR #229 (checked both files this session).

**Then:** run the local gate suite (compile/format/test, `brain.contract --check`, `brain.registry --check`, `brain.codemap --check`, `brain.verify`, `brain.route_tags`, `brain.lineage --check`), leave the changes in the working tree for your `/create-pull-request` at close.
</routes>

<routes ref="meta/matters.md meta/matters/stand-up-meta-matters-and-thin-the-register.md">
## Judgment calls embedded above, so you can strike any

1. **Row 1 gets a doc too, flipped `done`** — "migrate the queued rows" read as rows-at-migration-start; gives build 5's "landing metadata on done docs" its first instance and the `/matter` skill its done-flip precedent. Dual record (doc + Consumed row) during the transition, matching build 4's own protocol.
2. **The `fresh` flag retires into protocol prose** — all ten rows carry it, so it discriminates nothing; under the doc architecture every queued matter is a fresh-thread handoff by construction.
3. **Blocked matters stay unmarked in the pointer view** — order is the only stored datum; the blocker lives in the doc, and the protocol prose says to skip a matter whose doc records an unmet blocker and consume the next.
4. **The bias-taxonomy matter gets `order: 1`** — its plan's build order runs entirely inside this one matter, so it is position 1 of a single-matter sequence; stated in the doc body.
</routes>

Awaiting your approval before executing.

## User

proceed

## Assistant

Delivered. The queue now lives as ten standalone matter docs under `meta/matters/`, and the register is down to what only it can hold — the delivery order. All gates are green and the changes sit uncommitted in the working tree for your `/create-pull-request` at close.

<routes ref="meta/matters/index.md meta/matters.md meta/index.md meta/plans/index.md">
**What I created**

| Type | Doc | Why this type |
|---|---|---|
| matter (done) | `meta/matters/stand-up-meta-matters-and-thin-the-register.md` | this matter's own record — plan/order 2, `done` at delivery, `pr:` stamped at close |
| matter ×9 (open) | `todo-fold` (3), `matter-skill` (4), `mix-brain-matters-verifier` (5), `create-pull-request-scoping-edit`, `dev-history-recommit-and-regeneration-fold-in`, `response-resource-links-pages-sunset-revision`, `two-sided-bias-taxonomy-implementation` (bias plan, 1), `tdd-bookmark-promotions`, `vendor-block-pilot` (two-level plan, 3) | each queued row's packet, migrated verbatim with links intact; `plan`/`order` only where a plan emits it; blockers stated in-body on the two blocked ones |
| reserved index | `meta/matters/index.md` | directory listing, Open/Done sections, alphabetical — queue order explicitly deferred to the register |

**What I modified**

| File | Thrust |
|---|---|
| `meta/matters.md` | thinned to the order-only pointer view: revised protocol prose (fresh-thread handoff, skip-blocked rule, backlog definition), two-column pointer table renumbered 1–9, Consumed section kept with this matter's row added; attribution untouched |
| `meta/index.md` | added the `matters/` directory line; matters.md line now describes the pointer view and cites the matter-docs plan instead of the superseded matter-queue plan |
| `meta/plans/index.md` | the approved one-word rider: matter-docs gloss `status: accepted` → `in-progress` |

**Actions I have taken**

| Action | Result |
|---|---|
| Gate suite: compile, format, tests, `contract`/`registry`/`codemap --check`, `brain.verify`, `brain.route_tags`, `brain.lineage --check` | all green — 201 tests, 0 failures; index-coverage rule passed over the new directory; the only warnings are pre-existing advisories on the excluded `meta/evals/` corpus and one 2026-07-13 thread |
| Commit/push | deliberately not done — left in the working tree per the interim protocol, for your `/create-pull-request` |
</routes>

At close, when you invoke `/create-pull-request`, I'll perform the two remaining stamps in that motion: append the landing PR number to the Consumed row, and set `pr: <N>` in the done matter doc's frontmatter.

## User

Stop hook feedback:
[~/.claude/stop-hook-git-check.sh]: There are uncommitted changes in the repository. Please commit and push these changes to the remote branch.

## Assistant

<routes ref="meta/matters/stand-up-meta-matters-and-thin-the-register.md">
The delivery is now committed and pushed — the stop hook's commit-and-push requirement supersedes the leave-in-working-tree posture I'd stated, so the record is: commit `63b24a2` on `claude/matter-queue-processing-lf3nqi`, 14 files (11 created, 3 modified), with the full pre-commit gate suite green on the way in (the glossary/route-tag warnings in the output are pre-existing editorial advisories, untouched by this change).
</routes>

Nothing about the close changes: when you invoke `/create-pull-request`, it will capture the thread, commit that, and open the PR — at which point I'll append the landing PR number to the Consumed row and stamp `pr: <N>` into the done matter doc's frontmatter, landing both in the same PR.
