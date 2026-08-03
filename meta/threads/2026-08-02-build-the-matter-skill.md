---
type: reference
title: 2026-08-02-build-the-matter-skill
description: A fresh thread consumes register row 1 under the interim protocol's final run and delivers matter-docs build 4 — the subcommand-dispatched /matter skill (approval-gated consume, list with the backlog inline, create filing backlog-by-default) — ratifying the inline-backlog and soft-priority decisions; the skill's first live invocation then fires its own sequencing guardrail and hands back, and the session closes.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [thread, matters, skills, work-queue]
timestamp: 2026-08-02
pr: 233
session: https://claude.ai/code/session_016Cmu4d8aRqZ7Ky69JBTLsn
---

# 2026-08-02-build-the-matter-skill

A register-consumption session under the interim approval-gated protocol's
last run — the consumed matter being the `/matter` skill that encodes that
protocol. Row 1 was [The /matter skill](/meta/matters/matter-skill.md) —
matter-docs build 4, merged former rows 2+3. The session printed the record,
proposed the shape with the two decisions the plan had left open — both
ratified: `/matter list` renders the backlog inline beneath the queue, and
backlog matters may carry the existing integer `priority:` key as a soft
signal the queue never sorts by — and on approval delivered the skill with
its riders (skills-registry entry, contract recompile, register protocol
prose and `/priorities` repointed), consumed the row, and pushed gates-green
as `0b2e579`. The harness picked the skill up immediately, and the operator's
bare `/matter` minutes later became its first live invocation: the sequencing
guardrail correctly refused a second consumption in a PR-pending session and
handed back. In passing, the session found the open
[wire-pre-commit-hook matter](/meta/matters/wire-pre-commit-hook-in-session-start.md)'s
fix already present in `session-start.sh` and filed the evidence on its doc.
Closed via `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Consume register row 1 (the /matter skill, build 4) under the interim protocol | closed | [matter-skill](/meta/matters/matter-skill.md) | - |
| The /matter skill built: consume/list/create dispatch + guardrails | closed | [skills-registry](/meta/policy/skills-registry.md) | - |
| Inline backlog + soft `priority:` decisions ratified | closed | [matter-docs plan](/meta/plans/matter-docs-architecture.md) | - |
| Register consumption bookkeeping (row out, queue renumbered, Consumed logged) | closed | [matters register](/meta/matters.md) | - |
| First live /matter fire → sequencing guardrail hand-back | closed | `unrouted` | - |
| Pre-commit hook wiring already present in session-start.sh | closed | [wire-pre-commit-hook-in-session-start](/meta/matters/wire-pre-commit-hook-in-session-start.md) | - |

## User

take the top matter from meta/matters.md as your task

interim protocol (last time — the top matter IS the /matter skill that
replaces this protocol):

1. re-print the matter row verbatim here in the thread first as labeled
   fields (Matter / Type / Order), plus the matter doc's packet body —
   this is the record, since the row leaves the file by the end
2. state what you are going to do and how, then stop and wait for my
   approval before executing anything
3. after approval and delivery: flip the matter doc done, remove the row
   from the queue, and log it under the register's ## Consumed section in
   the same edit (date, matter, landing), renumbering the remaining rows
4. at close, when I invoke /create-pull-request, append the landing PR
   number to the consumed row and stamp pr: on the done doc (PR #230–232
   precedent)

settled, don't re-open: /todo is already retired and /matter create
absorbs it — the matter-docs plan's "alias window" open question is
resolved. Genuinely open, put these in your approval proposal: whether
/matter list renders the backlog inline or via a subcommand, and whether
backlog matters may carry a soft priority.

## Assistant

The top matter is the `/matter` skill itself — matter-docs build 4, the skill that replaces the interim protocol we're running right now, one last time, to build it. Below: the record reprint (protocol step 1), then my proposed shape and the two open decisions, then I stop and wait for your approval (step 2).

<routes ref="meta/matters/matter-skill.md">
## The record — register row 1

- **Matter:** `[The /matter skill](/meta/matters/matter-skill.md)`
- **Type:** `[planned](/meta/plans/matter-docs-architecture.md)`
- **Order:** `4`

Packet body, verbatim from the matter doc:

> Merged former register rows 2+3 (operator-approved 2026-08-02), per
> [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 4:
> bare `/matter` consumes the top pointer under the approval-gated protocol
> (print the matter as the record, state the approach, wait for approval,
> deliver, flip the doc `done`, drop the pointer, log per
> [the register](/meta/matters.md)'s protocol); `/matter list` renders the
> register; `/matter create` files a matter (absorbing `/todo create`).
> Skills-registry entry + contract recompile ride; retires the planned
> `/present-matters`.
</routes>

<routes ref=".claude/skills/matter/SKILL.md meta/plans/matter-docs-architecture.md meta/matters.md">
## Proposed delivery

One new skill, subcommand-dispatched on the `/bookmarks` precedent (bare invocation = the common case), plus the riders. File-tree diff:

```
.claude/skills/matter/SKILL.md          # NEW — the skill
meta/policy/skills-registry.md          # MODIFIED — /matter entry
CLAUDE.md                               # REGENERATED — mix brain.contract
meta/matters.md                         # MODIFIED — protocol prose names /matter as its operational path;
                                        #   then row 1 out, renumber, Consumed row (this consumption)
meta/matters/matter-skill.md            # MODIFIED — status: done (pr: stamped at close)
meta/matters/index.md                   # MODIFIED — entry Open → Done
meta/plans/matter-docs-architecture.md  # MODIFIED — Open-questions line records the three resolutions
.claude/skills/priorities/SKILL.md      # MODIFIED (rider) — "consumed per the register" → "via /matter"
```

Skill outline — **Consume** (bare `/matter`, encoding the interim protocol exactly):

1. Read the register; take the top row, applying the register's blocker-skip rule (a doc recording an unmet blocker is skipped, next row consumed; the skipped row stays).
2. Print the record: Matter / Type / Order as labeled fields plus the doc's packet body verbatim.
3. State the approach and any open decisions as blocking questions with recommendations — **in chat text, never a UI dialog** (session-capture policy) — and stop for approval.
4. Deliver after approval.
5. Bookkeeping in the delivery motion: flip the doc `done` (bump timestamp), drop the row, renumber, log under Consumed (date · matter · type · order · landing), move the index entry Open → Done.
6. Close step, deferred to PR time: when `/create-pull-request` opens the PR, append the number to the Consumed row and stamp `pr:` on the done doc (the PR #230–232 precedent). The obligation lives in `/matter`'s text and binds the session; wiring it into `/create-pull-request` itself is a candidate rider for queued row 3 (the CPR scoping edit), not this matter.

**List** (`/matter list [queue|backlog|done|all]`) — read-only: render the queue rows, then the backlog beneath (open matter docs with no register row), per open decision #2 below; done/cancelled only under `done`/`all`. **Create** (`/matter create …`) — file the doc under `meta/matters/` (`type: matter`, `status: open`, `plan`/`order` only when a plan emits it, standard attribution, model named in `provenance`), update the index; **backlog by default** — a register row only when you explicitly queue it, at a position you state. Guardrails: one matter per PR and fresh-thread sequential consumption per the register prose; no `em:` ids; the register's order is its one authored datum.

`/present-matters` needs no edit anywhere: the superseded matter-queue plan already carries the consolidation pointer (checked — its status is `superseded` with the pointer block), and building `/matter` is the retirement. Settled per your message and not re-opened: `/todo` is retired, `create` absorbs it, no alias window — I'll record that resolution in the plan's Open line along with your answers below.

**Questions you need to answer**

| # | Question | My recommendation |
|---|---|---|
| 1 | Approve this delivery shape? | Proceed as outlined |
| 2 | Does `/matter list` render the backlog inline or via a subcommand? | **Inline, beneath the queue** (the plan's sketch already leans this way): the backlog's failure mode is invisibility — a separate subcommand is a surface that must be remembered, which is the forgetting the backlog exists to prevent. Compact rows keep ~20 backlog items to a screen; filter args (`queue`/`backlog`) give the slices when wanted |
| 3 | May backlog matters carry a soft priority? | **Yes — reuse the existing integer `priority:` key** that `mix brain.session_init` and `/priorities` already honor on matters, rather than minting a second field. Backlog-only semantics: `list` sorts backlog by it (1 = most urgent, unprioritized after, alphabetical within); the queue never sorts by priority — a queued row's position is its exact order, priority stays the coarse pre-queue signal |

Awaiting your approval before executing anything.
</routes>

## User

1 - approve
2 - agree
3 - agree

## Assistant

<routes ref=".claude/skills/matter/SKILL.md meta/matters.md">
Delivery landed clean — the pre-commit hook ran the full gate suite (format, xref, contract/registry/codemap/lineage freshness, verify, route tags, glossary, and all 202 tests) and everything passed; commit `0b2e579` is pushed to `claude/matter-queue-protocol-gvt36l`. One quick check on a related observation:

The `/matter` skill is built and the matter consumed. Here's where things stand: the top queued matter — building the skill that replaces the hand-run consumption protocol — was delivered as ratified, its register row is consumed and logged, every gate is green (the pre-commit hook ran the full suite including all 202 tests), and commit `0b2e579` is pushed to the session branch. The one remaining step is the close: when you invoke `/create-pull-request`, this session appends the PR number to the new Consumed row and stamps `pr:` on the done doc, per the protocol now encoded in the skill itself.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| skill | `.claude/skills/matter/SKILL.md` | the deliverable — subcommand-dispatched: bare consume under the approval-gated protocol, `list` (queue + backlog inline, backlog sorted by soft integer `priority:`), `create` (backlog-by-default filing) |

**What I modified**

| File | Thrust of the change |
|---|---|
| `meta/policy/skills-registry.md` | `/matter` entry added |
| `CLAUDE.md` | regenerated (`mix brain.contract`) |
| `meta/matters.md` | protocol prose now names `/matter` as its operational path; row 1 out, rows renumbered 1–7, Consumed row logged |
| `meta/matters/matter-skill.md` | `status: done` |
| `meta/matters/index.md` | entry moved Open → Done with delivered-fact gloss |
| `meta/plans/matter-docs-architecture.md` | Open-questions bullet now records the three resolutions (inline backlog; `priority:` reuse; alias window moot) |
| `.claude/skills/priorities/SKILL.md` | consume pointer now routes through `/matter` |

**Actions I have taken**

| Action | Result |
|---|---|
| Gate suite (via pre-commit: format, xref, contract/registry/codemap/lineage `--check`, `brain.verify`, route tags, glossary, `mix test`) | all green — 202 tests, 0 failures; only pre-existing advisory warnings |
| Commit + push to `claude/matter-queue-protocol-gvt36l` | `0b2e579`, 8 files, branch pushed |
</routes>

<routes ref="meta/matters/wire-pre-commit-hook-in-session-start.md">
Two observations, neither blocking: the harness picked up the new skill immediately (it now appears in the session's skill listing), and `core.hooksPath` is already set to `.githooks` in this sandbox (checked) — so the gate suite fires on commit here, which is evidence relevant to the open backlog matter about auto-wiring that hook, though I made no change there.
</routes>

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Invoke `/create-pull-request` | capture, glossary, `attribution.from` stamps, then the PR — and this session performs the close step (PR number onto the Consumed row, `pr:` onto the done doc) |
| 2 | Review the skill text first | any revision lands before the PR opens |

## User

/matter

## Assistant

<routes ref=".claude/skills/matter/SKILL.md">
The consume guardrail fires here rather than the consume flow: this session has already delivered its matter — the `/matter` skill itself, commit `0b2e579`, still awaiting its PR — and the skill's own protocol is one matter per PR, with the next row consumed by a fresh thread after this one's PR lands. Consuming the new top row now (row 1, [mix brain.matters verifier](/meta/matters/mix-brain-matters-verifier.md), planned, order 5) would stack a second matter into this session's PR, which is exactly what the atomic-pull-requests policy rules out. So per the skill: saying so and handing back.

The path from here: invoke `/create-pull-request` to close this session (capture, PR, and the close-step stamps — PR number onto the Consumed row, `pr:` onto the done doc); once that PR lands, a fresh thread's bare `/matter` takes the verifier row.

That said — you ratified the skill's shape minutes ago, so if your intent here is to override the sequencing guardrail and consume the verifier matter in this same session anyway, say so explicitly and I'll proceed under that instruction. A bare `/matter` I read as the protocol's default, and the protocol says hand back.
</routes>

## User

/create-pull-request merge
