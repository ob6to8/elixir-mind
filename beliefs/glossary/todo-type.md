---
id: em:d7e3c5
type: concept
title: todo (type)
description: A retired controlled type (2026-08-02) for a lightweight actionable task, absorbed into matter — a plain task now files as a backlog matter under meta/matters/.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, types, governance, retired]
sense: repo
timestamp: 2026-08-02
attribution:
  when: 2026-07-11T20:15:23+00:00
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the captured sources cited in Seen in (backfilled)"
---

# todo (type)

A **retired** controlled type: the todo fold
([matter-docs plan](/meta/plans/matter-docs-architecture.md), build 3,
2026-08-02) absorbed it into [matter](/beliefs/glossary/matter.md), migrating
`meta/todos/` into `meta/matters/`. While live, a todo was a plain *task to
complete* — a single thing to be done, carrying a `status`
(`open`/`done`/`cancelled`) — distinct from an
[issue](/beliefs/glossary/issue-type.md) (a *problem* to diagnose and track)
and a [plan](/beliefs/glossary/plan-type.md) (a *design/decision record*).
That task sense now files as a **backlog matter**: an open matter outside
[the register](/meta/matters.md). Historical documents and thread records
referring to a "todo" mean this unit; the current vocabulary is the
[controlled-type vocabulary](/meta/policy/controlled-type-vocabulary.md).

*Seen in:* [2026-07-11 branch-deletion/contract thread](/meta/threads/2026-07-11-branch-deletion-policy-and-contract-as-abstraction.md), [2026-07-12 priorities-skill thread](/meta/threads/2026-07-12-priorities-skill-and-persistence-listers.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:d7e3c5">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-todo-fold-into-matters (2026-08-02)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:d7e3c5`]**  (co-feeds: `em:4c629e meta/matters/codify-routes-ref-maintenance-on-file-moves.md meta/plans/matter-cli-and-neovim-surface.md`)

**3 — Judgment calls inside the approval**

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

---

**[`em:d7e3c5`]**  (co-feeds: `meta/matters.md meta/tutorials/the-session-init-digest.md`)

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
