---
type: reference
title: 2026-08-02-deferred-work-policy-and-consumed-matters-log
description: Consumed the register's top matter — drafting the deferred-work-is-filed policy (section filing, order 18) with the contract recompile — then, through a misread-revert-ratify arc, added the register's Consumed log and its matter-queue plan bullet, and queued the matters-vs-plans definition question and the /matter skill as rows 1-2.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, matters, policy, filing, work-queue]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01CCfy5pcww4EAkwRSrBDNoF
pr: 227
---

# 2026-08-02-deferred-work-policy-and-consumed-matters-log

## Where this landed

A fresh thread opened with the register's standing instruction — take the top
matter — and consumed row 1: the
[deferred-work-is-filed policy](/meta/policy/deferred-work-is-filed.md) was
drafted for ratification at review (section `filing`, order 18 — the next free
after the communication-section split vacated 12/14/16), the contract
recompiled, and the row removed. A three-turn misread followed: the operator's
"log it" (meaning: re-print the matter in the thread) was read as a register
feature request, producing a `## Consumed` log that was then reverted when the
operator clarified — and finally ratified on its merits when the operator
endorsed the accidental idea, restored via cherry-pick with the amendment
recorded in the [matter-queue plan](/meta/plans/matter-queue-and-present-matters.md).
The closing exchange raised the matters-vs-plans definition question (is the
register just plan build-orders projected into a global FIFO?) and specified a
`/matter` consumption skill with an approval gate; both were punted per the
operator's direction and filed as rows 1–2 of [the register](/meta/matters.md),
with the rest renumbered. The PR carries two matters at the operator's
accepted widening.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| deferred-work-is-filed policy — top matter consumed | closed | [deferred-work-is-filed](/meta/policy/deferred-work-is-filed.md) | - |
| Consumed-matters log in the register (misread → revert → ratified) | closed | [matters](/meta/matters.md) | - |
| Matter-queue plan amendment recording the log | closed | [matter-queue plan](/meta/plans/matter-queue-and-present-matters.md) | - |
| Matters-vs-plans definition question | open | [matters](/meta/matters.md) | register row 1: store or view — should rows for planned work be derived projections of plan build-orders? |
| /matter consumption skill (approval-gated) | open | [matters](/meta/matters.md) | register row 2: build after row 1, which may revise it; reconcile with /present-matters |
| PR width — two matters in this session's PR | closed | unrouted | - |

## User

take the top matter from meta/matters.md. ask questions if needed
quote the matter at the beginning for reference, as protocol is to remove it by the end of the work

## Assistant

The top matter is row 1. Quoting it verbatim for reference, since the protocol is to remove the row by the end of this work:

> | 1 | `deferred-work-is-filed` policy | Draft for ratification-at-review: *a work item identified mid-session but not executed in it is filed (todo, plan, issue, or a matters row) in the same turn that identifies it; chat is not a backlog* — the mid-session extension of [concerns-block-the-close](/meta/policy/concerns-block-the-close.md), whose scope line deliberately leaves mid-session reporting alone. Section `filing`, next free order; contract recompile rides. | fresh |

Now I'll gather the context this row points at: the matter-queue plan (for register protocol), the parent policy, and the policy frontmatter/section machinery.

The gaps came from commit b0907d9 ("Give communication rules their own contract section") — communication policies moved out of `filing`, vacating 12/14/16. So "next free order" = append at the end: **order 18**. Now let me check the origin thread for the discussion behind this policy, and the render-contract skill.

<routes ref="meta/policy/deferred-work-is-filed.md">
Precedent confirmed: the previous consumption (commit a2e57d0) removed row 1 and renumbered the rest in the same commit as the work. I have everything I need — no blocking questions. Decisions I'm making, with basis: **order 18** (the `filing` gaps at 12/14/16 were vacated when communication policies got their own section in b0907d9, so "next free" = append after 17), **`status: active`** so the recompile picks it up (ratification happens at PR review, matching how the row frames it), and **`from:` pointing at the origin TDD research-spike thread** (this session's own thread gets appended later by `/create-pull-request`).

Now drafting the policy. First, the current UTC time for `attribution.when`:
</routes>

Done and pushed. The plainspeak version: the queue's top row asked for a new standing rule to be drafted — one saying that when a session mentions work it isn't going to do right now ("I'll fix that later"), that work must be written into a tracked file in the same breath, because the chat itself is never reread and anything living only there gets forgotten. I wrote that rule as a policy document, recompiled the operating contract so every future session sees it, and removed the consumed row from the queue. Everything is committed and pushed on the session branch; nothing is merged — merging the eventual PR is your ratification step, exactly as the row ("Draft for ratification-at-review") framed it.

Three judgment calls I made, each with its basis, all overridable at review:

- **`order: 18`** — the row said "next free order" in section `filing`, whose orders show gaps at 12/14/16. Checked: those were vacated when the communication policies moved to their own section (commit b0907d9), so I read "next free" as append-after-17, placing the policy at the end of §3 rather than mid-section.
- **`status: active`** — required for the policy to compile into `CLAUDE.md` ("contract recompile rides"); the ratification gate is the PR merge, matching how the previous consumption (PR #226) handled its ratification-at-review matter.
- **`attribution.from`** — points at the origin TDD research-spike thread where the gap was identified; this session's own thread gets appended by `/create-pull-request` at close, per the append-only carve-out.

The core rule sentence in the policy is the row's ratified text; the five supporting bullets (same-turn-not-at-close, size-independence, ledger-records-vs-queues, boundaries, scope) are my drafting from the origin thread's discussion — the part your review actually needs to weigh.

**What I created**

| type | doc | why this type |
|---|---|---|
| `policy` | [deferred-work-is-filed](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-v2z4ph/meta/policy/deferred-work-is-filed.md) | the row prescribed it: a rule that must fire unprompted mid-work belongs in the compiled contract, per governance-artifact-routing's reach test |

**What I modified**

| file | thrust of the change |
|---|---|
| [CLAUDE.md](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-v2z4ph/CLAUDE.md) | regenerated via `mix brain.contract`; the policy renders at the end of §3 Filing conventions |
| `meta/policy/index.md` | one gloss line added under `## filing` |
| [meta/matters.md](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-v2z4ph/meta/matters.md) | row 1 removed, remaining rows renumbered 1–7 (the shape the previous consumption, commit a2e57d0, established) |

**Actions I have taken**

| action | result |
|---|---|
| Full gate suite (compile, format, xref, verify, route_tags, glossary, registry/codemap/lineage checks, 201 tests) | green — ran both directly and again in the pre-commit hook; the only warnings are pre-existing advisory ones untouched by this change |
| Commit + push | `fd2d7aa` on `claude/meta-matters-top-v2z4ph`, pushed with upstream set |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Invoke `/create-pull-request` | captures this thread, stamps this session's thread into the policy's `attribution.from`, opens the PR; merging it ratifies the policy and completes the row-removal protocol |
| 2 | Request edits to the draft first | the bullets are the drafted part; I revise in place and the recompile rides along |

## User

not seeing the matter you worked on logged here - log it

## Assistant

<routes ref="meta/matters.md">
Confirmed from git: the prior consumption (a2e57d0) landed via PR #226. The picture: the seeded register design kept consumed rows only in git history — my report relied on that, so once the row was removed, the matter had no visible trace left in the register itself. I'll add a `## Consumed` log to `meta/matters.md`, which also matches how todos, issues, and plans all keep their done entries visible. Logging this matter, and backfilling the one prior consumption so the log is complete since the register's birth:
</routes>

## User

i'm just meaning that "quote the matter at the beginning for reference, as protocol is to remove it by the end of the work" is meant to say "re-print the matter you will work on here in the thread for reference since you will be removing it from the file at the end"

## Assistant

Understood — you meant the chat thread: re-print the row here so it survives its deletion from the file. My first reply did quote it, but as a raw blockquoted table row, which renders badly enough to miss; and I then compounded the misread by building a `## Consumed` register section you never asked for. I'm reverting that commit now — it was a register-protocol amendment made on misread direction, and it's a separable decision from this PR's one matter anyway — then re-printing the matter here readably.

Reverted and re-printed. The branch is back to exactly the policy-adoption state: `bc4e9db` (the Consumed-log amendment) is removed via `git reset --hard fd2d7aa` + force-with-lease push, so `meta/matters.md` and the matter-queue plan are restored to their operator-ratified design, and the branch again carries the one matter it should — checked: `git log` shows `fd2d7aa` directly atop merged `main`, working tree clean.

Here is the matter this session worked, re-printed for the thread record since its row no longer exists in the file — verbatim from `meta/matters.md` row 1 as it stood at session start:

> **Matter:** `deferred-work-is-filed` policy
>
> **Scope — decisions made, where detail lives:** Draft for ratification-at-review: *a work item identified mid-session but not executed in it is filed (todo, plan, issue, or a matters row) in the same turn that identifies it; chat is not a backlog* — the mid-session extension of [concerns-block-the-close](/meta/policy/concerns-block-the-close.md), whose scope line deliberately leaves mid-session reporting alone. Section `filing`, next free order; contract recompile rides.
>
> **Context:** fresh

Where things stand: one commit on the branch (`fd2d7aa`) — the drafted [policy](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-v2z4ph/meta/policy/deferred-work-is-filed.md), the contract recompile, the policy-index gloss, and the row's removal from the register — pushed and awaiting your review. If you'd actually like a consumed-matters log in the register (what I built on the misreading — it would match how todos, issues, and plans keep done entries visible), say so and I'll restore it as its own deliberately-ratified change; otherwise the register stays as seeded, with git history as the archive.

## User

ah I see. so, in misinterpreting my command, you had the idea to make a persistent record of matters having been done, akin to a completed plan being kept but marked done, correct? and now the question being, should we just go ahead and implement it? I'm leaning towards it

## Assistant

<routes ref="meta/matters.md meta/plans/matter-queue-and-present-matters.md">
Yes, that's exactly the idea — with one nuance worth stating: a done plan keeps its full body because the decisions *are* the content, whereas a matters row is a dispatch packet whose content graduates elsewhere on delivery. So the Consumed log keeps the pointer form — date, matter name, where it landed — while the full scope packet stays archived in the commit that removed the row. Register stays a queue; the log is its visible history, matching how the todo, issue, and plan registers all keep their completed entries.

My recommendation is also yes, and your lean settles it. The argument for: you felt the absence within a day of the register existing (the reading pattern is real), sibling-register consistency, and the cost is one table row written in the same motion that removes the queue row — no separate upkeep step to forget. The argument against, honestly weighed: it edges toward the hand-kept logs this repo retired. It stays on the right side because entries are pointers-only (the routing-ledger principle), written in the same edit as the removal, with git history remaining the full archive.

The change is preserved locally — restoring it via cherry-pick with the plan bullet reworded to reflect this ratification:
</routes>

Implemented and pushed — commit `3b6ad64`, all gates green. The register ([meta/matters.md](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-v2z4ph/meta/matters.md)) now carries the queue (rows 1–7, unchanged) plus a `## Consumed` section holding two entries: this session's `deferred-work-is-filed` row, and the backfilled first-ever consumption (methodology finalization, PR #226, recovered from its removal commit) so the log is complete since the register's birth. The section's intro states the protocol: logging and row-removal happen in the same edit, entries are pointers only, a row logged before its PR opens gets the number appended then, and git history stays the full archive of each scope packet. The amendment is recorded in the matter-queue plan's decision list as a ratified change to the seeded design.

| file | thrust of the change |
|---|---|
| `meta/matters.md` | description + intro updated to the new protocol; `## Consumed` section added with the two entries |
| `meta/plans/matter-queue-and-present-matters.md` | decision-list bullet recording the ratified amendment |

One delivery-shape fact for the close, so it's dispositioned now rather than blocking later: this branch now carries two matters — the policy adoption and this register amendment — so the session's eventual PR will carry both, which is technically wider than one-matter-per-PR. My recommendation is to accept that: you directed the amendment mid-session, it's two clean commits reviewable independently, and mid-session widening at operator direction has precedent (PR #224). Unless you say otherwise, that's how I'll proceed when you invoke `/create-pull-request`; if you'd rather split, say so and I'll move `3b6ad64` to its own branch for a follow-up PR instead.

## User

<routes ref="em:4c629e meta/matters.md">
it seems like essentially what we have done with matters is create an ordered fifo queue of work, like an ordered list of steps that should all break down to being atomic (single concern) PR's. my question at this point is - what's the difference between matters and plans? is it just scope? if so, plans should really just be aggregated collections of sequential matters that done sequentially would implement the complete scope of the plan. are we unecessarily creating a new data type?

this is an important question that needs to be discussed, but as you've pointed out this PR has already extended to 2 concerns, which is more that 1, which is the goal. so my guess is: we should punt, describe this question as a new matter, and bump that to the top of the matter list to be handled next, and it would be the next session that may or may not reconfigure how matters are defined and handled
</routes>

also, i would suggest, to avoid the issue we ran into hear with flawed communication by me, that we commit the /matter workflow (as it stands now, possibly to be revised per above) to a skill - a skill that when invoked would say "take the next matter on the list as your task, print the matter here at the top of the thread as a record, state what you are going to do and how, and wait for approval. then when accepted, remove the matter from the top of the matter list and file as ## consumed"

## User

that skill should, i think, be moved to second on the matter list

## Assistant

All filed and pushed — commit `a576bcb`, gates green. Replies under your subjects:

> "what's the difference between matters and plans? is it just scope? if so, plans should really just be aggregated collections of sequential matters that done sequentially would implement the complete scope of the plan. are we unecessarily creating a new data type?"

<routes ref="em:4c629e meta/matters.md">
Punted per your direction, so only my seed read, which I also compressed into the row for the next session: the reduction is nearly right, with one inversion and one gap. A `plan` carries the *decision record* — rationale, alternatives, shape — plus a per-initiative build order; a matter is a unit of *delivery*. For planned work, rows are exactly what you say: the plan's build order projected into the queue. But the register holds the one thing no individual plan can — the global delivery order across initiatives (bias-taxonomy rows interleave with dev-history rows) — and micro-matters exist with no plan behind them. So "plans = aggregated sequential matters" captures the delivery dimension while dropping the decision-record dimension. The sharper form of your redundancy worry, and what the next session should settle: whether rows for planned work ought to be *derived projections* of plan build-orders rather than hand-copies — i.e., is the register a store or a view. (A new controlled `type` was never minted — rows are dispatch, not documents — so the "new data type" risk lives in that hand-copy duplication, not in the vocabulary.)
</routes>

> "we should punt, describe this question as a new matter, and bump that to the top of the matter list to be handled next"

Done — row 1 of [the register](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-v2z4ph/meta/matters.md), carrying your question verbatim, the seed read above as weigh-not-conclude input, and the note that its outcome may reconfigure how matters are defined and handled, including whether the two skill rows beneath it consolidate. Context: fresh.

> "commit the /matter workflow (as it stands now, possibly to be revised per above) to a skill" … "that skill should, i think, be moved to second on the matter list"

Filed as row 2 — where your mid-turn note wanted it — with your workflow spec quoted verbatim (print the top row into the thread, state the approach, wait for approval, then on acceptance remove the row and file it under `## Consumed`), sequenced after row 1 since the definition question may revise it. The approval gate is the right fix for what happened here: it converts the print-and-confirm protocol from something either of us has to phrase or remember correctly into a structural step of the skill. The row also notes reconciling scope with `/present-matters` (now row 3), since both read the register and the next two sessions should decide whether they're one skill or two.

On PR width: these row additions are filing motions the `deferred-work-is-filed` policy requires in-turn, not new concerns — the PR still carries its two matters (the policy, the Consumed log) plus register upkeep. Close default unchanged: one PR, both matters, unless you say split.

| action | result |
|---|---|
| Queue edit: rows 1–2 inserted, rest renumbered 3–9, row text otherwise untouched | committed `a576bcb`, pushed |
| Branch state | `fd2d7aa` (policy) → `3b6ad64` (Consumed log) → `a576bcb` (queue rows), all gates green |

## User

merge

## Assistant

Your mid-turn "merge" registers as the merge opt-in — this invocation is now `/create-pull-request merge`, so after opening I'll drive CI to green and true-merge. Continuing the capture: reading the previous consumption session's thread doc as the format model, plus the glossary skill and threads index:
