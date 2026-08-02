---
type: reference
title: 2026-08-02-todo-fold-into-matters
description: A fresh thread consumes register row 1 under the interim protocol and delivers matter-docs build 3 — meta/todos/ folds into meta/matters/, type todo retires with a contract recompile, the reading surfaces repoint with queued-row annotation — then retitles the todo-cli plan to the matters store at operator direction and closes.
tags: [thread, matters, todos, migration, vocabulary, session-init]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01KFww9ccMjBjmzd9ZSEwroC
---

# 2026-08-02-todo-fold-into-matters

A register-consumption session: the operator pointed it at the top row of
[the matter register](/meta/matters.md) under the interim approval-gated
protocol. Row 1 was [Todo fold](/meta/matters/todo-fold.md) — matter-docs
build 3. The session scouted every surface the fold touches, presented the
record and a seven-call approach, and on approval delivered it whole: 21 todo
docs migrated (18 open → backlog matters, 2 done kept, one merged into its
queued duplicate), `type: todo` retired from the vocabulary with the `matter`
entry widened to absorb the plain-task sense, the digest repointed to
`meta/matters/` with register-queued rows annotated by position, the `/todo`
skill retired, cross-links repointed outside frozen threads, and five frozen
threads' `<routes ref>` attributes maintained to keep the hard route-tag gate
green — a motion the operator approved per-session and which is now filed for
codification as
[a backlog matter](/meta/matters/codify-routes-ref-maintenance-on-file-moves.md).
The register consumed row 1 (queue renumbered to 8) and the delivery landed as
one commit, gates green. The operator then picked option 2 from the closing
report — retitling the proposed todo-CLI plan to
[a mechanical matter surface](/meta/plans/matter-cli-and-neovim-surface.md),
which surfaced the `brain.matter`/`brain.matters` name-adjacency question now
recorded in that plan — and invoked `/create-pull-request merge` to close.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Consume register row 1 (the todo fold) under the interim protocol | closed | [todo-fold](/meta/matters/todo-fold.md) | - |
| `type: todo` retirement; `matter` widened to absorb the task sense | closed | [controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md) | - |
| Reading-surface repoint: digest scans matters, queued rows annotated | closed | [the-session-init-digest](/meta/tutorials/the-session-init-digest.md) | - |
| `/todo` skill retired outright, no alias window | closed | [skills-registry](/meta/policy/skills-registry.md) | - |
| Routes-ref maintenance on frozen threads (moves + one dead back-link) | closed | [codify-routes-ref-maintenance-on-file-moves](/meta/matters/codify-routes-ref-maintenance-on-file-moves.md) | - |
| TDD todo/matter duplicate resolved by folding into the queued doc | closed | [tdd-bookmark-promotions](/meta/matters/tdd-bookmark-promotions.md) | - |
| The todo-cli plan retargeted to the matters store | closed | [matter-cli-and-neovim-surface](/meta/plans/matter-cli-and-neovim-surface.md) | - |

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

The top matter is taken; per the interim protocol, the record first, then my approach — I stop before executing anything.

## 1 — The record (register row + packet, verbatim)

The register row is now the pointer form (Matter / Type / Order), with the scope packet in the matter doc — reproduced here as the record since both leave the queue by the end:

- **Matter:** Todo fold — `/meta/matters/todo-fold.md` (row 1)
- **Type:** planned — `/meta/plans/matter-docs-architecture.md`
- **Order:** 3
- **Packet** (the doc body, verbatim):

> Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 3:
> migrate `meta/todos/` to `meta/matters/` (open todos become backlog matters —
> open, outside [the register](/meta/matters.md); done/cancelled keep status),
> retire `type: todo` from the vocabulary + contract recompile, repoint the
> reading surfaces (`mix brain.session_init`, `/priorities`, `/todo` skill
> retired or aliased), indexes.

<routes ref="meta/matters/todo-fold.md meta/policy/controlled-type-vocabulary.md lib/elixir_mind/session_init.ex">
## 2 — What I am going to do

Plainly: the todos directory dissolves into the matters directory. Every task file that lived in `meta/todos/` becomes a matter doc in `meta/matters/` — open ones become backlog (filed but not queued in the register), finished ones keep their done status. The word "todo" then stops being an official document type: the rulebook entry for it is removed and the contract recompiled, and everything that used to read or mention todos — the priorities digest, the skills, the indexes, cross-links — is repointed at matters. I've scouted every surface that touches todos; the full move, checked against the gates, is below.

**A. Migrate the 21 docs** (19 open + 2 done in `meta/todos/`):
- 18 open todos move to `meta/matters/<same-slug>.md` retagged `type: matter` (tags `todo`→`matter`; `status: open` kept = backlog; no `plan`/`order` keys; `attribution`/`provenance` untouched — the ingestion event is immutable).
- 1 open todo — `promote-the-tdd-survey-bookmarks.md` — does **not** move: queued matter `tdd-bookmark-promotions.md` (register row 8) is today a thin pointer into it ("Per the [todo](…)"), so the todo's full body folds into that doc, making it the self-contained packet; migrating it separately would create two open matters for one piece of work.
- 2 done todos move keeping `status: done`.
- `meta/todos/` (with its `index.md`) is deleted.

**B. Retire the type + recompile.** Remove the `todo` entry from the controlled vocabulary; recast the `matter` entry (its todo contrast dissolves — a backlog matter absorbs the plain-task sense). Repoint the policies that name todos: `governance-artifact-routing` (routing-table row + the issue-vs-todo / todo-vs-plan pairs recast to matter), `deferred-work-is-filed`, `elixir-coding-standards` (future-work asides → `meta/matters/` or `meta/issues/`), `concerns-block-the-close`, `skills-registry` (drop `/todo`, reword `/priorities`). Then `mix brain.contract`.

**C. Repoint the reading surfaces.** `SessionInit.open_todos` → `open_matters` over `meta/matters/` (`status: open`), section "Open matters", same heuristic weight slot; queued matters annotated `(queued #N)` by parsing the register's pointer table, ordered register-position first, backlog newest-first behind. Tests updated; moduledoc/shortdoc updated → `mix brain.codemap`. Skill prose updated: `/priorities`, plus the todo-contrast lines in `/issue` and `/plan`.

**D. Retire `/todo`** (delete `.claude/skills/todo/`) rather than alias — `/matter` doesn't exist until build 4, which is the next row in the queue, so the gap is one PR wide; in the window a matter is filed inline per the contract.

**E. Repoint cross-links everywhere except frozen surfaces.** Mechanical `/meta/todos/…` → `/meta/matters/…` in living and historical docs (2 open issues, 6 plans, 5 analyses, `survey/channels.md`, `meta/index.md`, tutorials — the link checker scans all of them, so leaving rot would pollute every future digest with warnings). Glossary: `todo-type` (`em:d7e3c5`) revised to a retired-term pointer at `matter` (kept, not deleted — id stability), `session-init-digest` description updated, `matter` entry gains the absorbed task sense, index regenerated via `mix brain.glossary`. Thread bodies stay verbatim — **except** four `<routes ref="…">` attributes naming `meta/todos/` paths, which must follow the move because `mix brain.route_tags` ref-resolution is a hard CI gate; I treat the tag attribute as routing metadata over the frozen body, not body text, and `--materialize` then regenerates the excerpt logs.

**F. Indexes + register consumption.** `meta/matters/index.md` absorbs the migrated entries; `meta/index.md` drops the todos row. Then per protocol: `todo-fold.md` → `status: done`; register row 1 removed, rows 2–9 renumbered 1–8, Consumed row logged (PR # appended at your `/create-pull-request`, per step 4).

**G. Gates + delivery.** Full local suite (`format`, compile/test with warnings-as-errors, `brain.verify`, `brain.route_tags`, `brain.glossary`, contract/registry/codemap `--check`), a few semantic commits each gate-green, pushed to `claude/matter-queue-processing-skhriq`. One matter, one PR.
</routes>

<routes ref="em:4c629e em:d7e3c5 meta/matters/codify-routes-ref-maintenance-on-file-moves.md meta/plans/matter-cli-and-neovim-surface.md">
## 3 — Judgment calls inside the approval

| # | Call | My recommendation |
|---|---|---|
| 1 | TDD todo vs queued matter duplicate | Fold the todo's body into `tdd-bookmark-promotions.md`; no separate migration |
| 2 | Timestamps on migrated docs | Preserve — container move, not content change; keeps recency signal in the digest |
| 3 | `/todo` alias window (plan's open question) | Retire outright now; `/matter create` (build 4, next in queue) absorbs it |
| 4 | Digest queued/backlog distinction | Annotate queued matters from the register parse; plain rename is the minimal fallback if you'd rather defer register-reading to build 5 |
| 5 | `todo-cli-and-neovim-surface` plan (proposed) — its subject is renamed under it | Mechanical link repoints only; retitle/supersede stays your call, surfaced at delivery |
| 6 | Frozen threads' `<routes ref>` attributes | Update the four refs to the new paths (tag metadata maintenance; required for the hard gate) |
| 7 | `todo-type` glossary entry | Revise to retired-term pointer, keep the `em:` id |

Awaiting your approval — say the word (or adjust any of 1–7) and I'll execute.
</routes>

## User

proceed

## Assistant

New find in the sweep: a migrated matter (`generate-the-channels-ingested-column.md`) itself links a todo path. Two files stay untouched: the second-brain-field analysis (its todo reference sits in a code span quoting broken links verbatim) and `meta/index.md` (rewritten in task 6). Everything else gets the mechanical repoint:

**Delivered and pushed.** The todo fold (matter-docs build 3) is complete on `claude/matter-queue-processing-skhriq` — commit `5db24d8`, 72 files, every gate green (the sandbox's pre-commit hook ran the full suite: format, xref, contract/registry/codemap/lineage `--check`, `brain.verify`, `brain.route_tags`, `brain.glossary`, 202 tests, 0 failures).

Plainly: `meta/todos/` no longer exists. Its 21 task files live in `meta/matters/` — 18 as open backlog matters, 2 keeping their done status, and one (the TDD-promotions todo) merged into the queued matter doc that had been pointing at it. "Todo" is no longer an official document type: the vocabulary entry is gone, the `matter` entry now spans plain small tasks through plan-emitted build steps, and the contract is recompiled. Everything that read or mentioned todos — the priorities digest, four skills, six policies, indexes, glossary, cross-links — now reads matters. The register's top row is consumed and the queue renumbered to 8 rows.

<routes ref="meta/matters.md em:d7e3c5 meta/tutorials/the-session-init-digest.md">
**What I modified** (grouped; 72 files total)

| Area | Thrust |
|---|---|
| `meta/matters/` (+21, −22 in todos) | migration with `type`/`tags` retag; TDD todo folded into `tdd-bookmark-promotions.md`; index absorbs all entries |
| 6 policies + `CLAUDE.md` | `todo` entry removed, `matter` recast; routing/deferred-work/coding-standards/close/skills-registry repointed; contract recompiled |
| `session_init.ex` + task + tests + `code-map.md` | scans `meta/matters/`, annotates register-queued rows `(queued #N)` and lists them first; new queued-ordering test; smoke-tested live (26 open matters render correctly — checked) |
| 5 skills | `/todo` deleted; `/priorities`, `/issue`, `/plan`, `/journal` reworded |
| ~20 cross-linking docs | mechanical `/meta/todos/` → `/meta/matters/` outside frozen threads |
| 5 thread docs + 2 regenerated sinks | routes-ref attributes only: four followed the file moves, and a fifth (the 2026-07-10 thread) back-linked the deleted skill file — I dropped that dead path ref, keeping its surviving vocabulary ref; sink logs rematerialized |
| Glossary (3 entries + index) | `todo-type` is now a retired-term pointer at `matter`; `session-init-digest` and `matter` updated; index regenerated |
| `meta/matters.md` | row 1 removed, rows renumbered 1–8, Consumed row logged |

Two surfaces beyond the approved list turned up linking the deleted skill and were fixed in the same motion: the cca-certification plan (its dispatch-pattern exemplar now cites `/bookmarks`) and the journal skill (now offers a *matter*). The two editorial warnings in gate output pre-exist this change — confirmed by diff, neither file is one I touched.

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Invoke `/create-pull-request` | closes the matter; per interim-protocol step 4 I'll append the PR number to the Consumed row (and stamp `pr:` on the done doc, matching PR #230/#231 precedent) |
| 2 | Decide the [todo-cli plan](meta/plans/todo-cli-and-neovim-surface.md)'s fate | the proposed plan's subject was renamed under it; it kept mechanical repoints only. Retitle to matters, supersede, or leave for `/priorities` to resurface — your call, no action taken |
| 3 | Continue to register row 1 | now [The /matter skill](meta/matters/matter-skill.md) (build 4) — a fresh thread per protocol, or here if you prefer |
</routes>

## User

2 retitle to matters
then /create-pull-request merge
