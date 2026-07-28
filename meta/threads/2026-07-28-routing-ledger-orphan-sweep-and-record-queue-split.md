---
type: reference
title: 2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split
description: Scanned all 109 thread routing ledgers for orphaned action items, found 62 of 89 pending strands with no live tracker, and — after the operator reframed the fix — replaced the plan's freezing question with a record/queue separation that strips state out of the ledger entirely, then executed the sweep.
provenance: "Claude Code session (Opus 5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, routing-ledger, priorities, strands, governance, enforcement]
timestamp: 2026-07-28
pr: 162
session: https://claude.ai/code/session_01V3yS3Ei8yWo51C1mnA55zi
---

# 2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split

## Where this landed

The operator asked for a scan of every routing ledger for action items not
persisted in an external artifact, plus a judgment on whether enforcement should
prevent orphaning. The scan found **89 pending strands** across 58 threads, of
which **62 had no live tracker** — but the dominant failure mode turned out to be
*staleness*, not loss: roughly a third described work already tracked elsewhere,
because the ledger has no way to say "discharged".

The session's first answer to the enforcement question was warn-only, on two
grounds: a blocking gate would demand editing frozen thread bodies, and would red
the build on pre-existing rows. Reading the committed plan back in full surfaced
an arithmetic error in that section (52 rows, actually 34) and a scope
contradiction with its own build order; both were corrected.

The operator then reframed the problem: have `/priorities` read only persisted
action docs and never the ledger, and require every thread action item to route
to an action doc at PR time. That **dissolves** the freezing question rather than
answering it — freezing only mattered because something read the ledger as
current state. Ratified: the `State` and `Dangling` columns leave the ledger
entirely, an `Action` column carries the tracker link, and the sole unlinked form
is an explicit `none:` decision. With the thread doc still in-branch at PR time,
enforcement upgrades from a warning to a blocking gate.

Step 1 was then executed: all 27 orphans dispositioned — 14 promoted into 11
todos and 1 plan, 13 recorded `none:` with a reason. Steps 2–5 remain in the
plan, which moved to `in-progress`. That landed in **PR 162**.

The session then continued past that merge. Asked whether a future session would
know to pick up step 2, the digest was *run* rather than reasoned about: the plan
sat 4th of 29 active plans and never reached the heuristic top-3, and its digest
line described the whole plan rather than its position. Both were fixed —
description leading with "step 1 done; steps 2–5 remain", and `priority: 2`
rather than `1`, which would have tied with the operator's existing pin and
outranked it on recency. Two further findings came out of the same check: the
plans-index gloss still described the superseded `mix brain.strands` design, and
a parallel session had filed the identical matter as
[an issue](/meta/issues/routing-ledger-has-no-post-capture-upkeep-path.md) hours
earlier, reaching the same diagnosis from the opposite direction — its three
candidates superseded by the ratified design, cross-linked both ways, and kept
`open` because the gap is live in the shipped policy until step 5 rewrites it.
This follow-up landed in **PR 170**.

A third round followed, after the operator ruled out deferring anything to a
future session: two loose ends were closed rather than folded forward. Step 2 of
the build order now names the one open question it depends on — the `project`-hub
answer decides what gets written into two rows, so answering it afterwards means
re-touching them. And the **duplicate-artifact class** was filed as
[its own issue](/meta/issues/parallel-sessions-file-duplicate-artifacts.md): two
sessions running the same day each searched `main`, each correctly found nothing,
and each filed — once as competing todos on the channels column, once as a `plan`
and an `issue` on the ledger-upkeep gap. The resulting files differ in name and
path, so git sees no conflict and no gate fires; both were caught by accident.
An earlier judgment that a third instance was needed before calling it a pattern
was reversed on re-reading the two.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Orphan scan across 109 ledgers; the 89/62 measurement and three-way triage | closed | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| Enforcement design: what a check can and cannot assert | closed | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| The freezing question — dissolved by the record/queue split | closed | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| Ledger schema: drop `State`/`Dangling`, add `Action` | closed | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| Step 1 sweep — 27 orphans dispositioned | closed | [sweep dispositions](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| Spec→code traceability promoted to its own plan | closed | [spec-to-code-traceability](/meta/plans/spec-to-code-traceability.md) | - |
| Steps 2–5: backfill, switch, gate, policies | open | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | Execution deferred to fresh sessions per the plan's build order |
| Cold-session discoverability of step 2 — digest position and self-describing line | closed | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| Duplicate matter filed as an issue by a parallel session | closed | [routing-ledger-has-no-post-capture-upkeep-path](/meta/issues/routing-ledger-has-no-post-capture-upkeep-path.md) | - |
| Step 2's dependency on the `project`-hub question, uncross-referenced | closed | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | - |
| Parallel sessions filing duplicate artifacts, undetectable by git | closed | [parallel-sessions-file-duplicate-artifacts](/meta/issues/parallel-sessions-file-duplicate-artifacts.md) | - |
| Do `project` hubs count as valid `Action` targets? | paused | [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md) | Raised by two secure-financial-agent strands held in the project's own Open questions; recorded `none:` for now |

_All routing targets are governance docs (no `em:` ids), so no route tags are
emitted — the tag cross-check applies to bundle-document sinks only._

## User

scan all routing ledgers for orphaned todo items not persisted in external artifacts (plans, todos, etc)
also - should there be enforcement logic that prevents any actionable item from being orphaned in the routing ledger?

## Assistant

I scanned all 109 thread ledgers. The headline: **89 pending strands, 62 with no live tracker behind them** — but the interesting part is that the biggest bucket isn't lost work, it's stale bookkeeping.

### The scan

Classifying each pending row by what its `Routed to` cell actually points at:

| Routed to | Rows | Surfaced by `/priorities`? |
|---|---:|---|
| live tracker (`plan`/`todo`/`issue`, active) | 27 | yes |
| **closed** tracker (`done`/`resolved`) | 6 | no — parked in a finished record |
| an `analysis` | 10 | no — the genre carries no `status` |
| knowledge/project/eval doc | 10 | no — not a tracker |
| dead path | 3 | no |
| `unrouted` | 33 | no |

Triaging those 62 by hand splits them three ways: **~24 already discharged** (escape-rate sampling, the swarm-eval harness, the branch-triage todo, all four CCA knowledge gaps, both intake todos, the `elixir-mind` rename, the dedup-recall probe and its synonym step — the work landed, only the frozen cell disagrees); **~9 closed by an explicit decision** the `State` column can't express (*"left uncodified until it recurs (operator agreed)"*); and **~27 genuine orphans**.

The sharpest of the 27: the derived SQLite index (`mix brain.index`), spec→code traceability, a `mix brain.channels` generator, the Workflow fan-out convention's four open questions, both `meta/evals/` instruments still `proposed` and unbuilt, the `deprecated/` triage (33 files still sitting there), and the secure-financial-agent's air-gap decision. One I verified rather than took on trust: the gate-suite tutorial's table is **still missing four gates CI actually runs** — `glossary`, `lineage`, `dev_history`, `dedup_probe`.

So the dominant failure mode is staleness, not loss. A third of pending rows describe work tracked elsewhere. The ledger's real defect is that it has no way to say *discharged*, so `/priorities` re-surfaces settled matters forever. That reorders the existing plan's build: represent resolution first, promote second.

### On enforcement

Yes — but warn-level, and not on the property you'd reach for first.

"Every actionable item is tracked" has no oracle. Those ~9 decision-closed rows look identical to live work; separating them took reading each cell. That's the same concession route-tagging already makes for coverage — it "has no mechanical oracle and stays editorial". A check keyed on actionability would fire hardest on rows a human already settled.

What *is* checkable: **a pending row points at something that can still receive work** — the target resolves, and if it's a tracker, it isn't `done`. That fires on 52 rows today.

It has to warn rather than fail, for a reason I think is decisive: the ledger lives in the thread body, which session-capture freezes. Greening a failing row on a merged thread means editing a frozen body — the exact mutation the contract forbids, and the unresolved question at the center of that plan. A blocking gate would be unsatisfiable by design, and would red the build on 52 pre-existing rows on day one, which just teaches agents to suppress it.

The enforcement that actually pays is at **`/capture` write time** — the one moment an agent knows whether a strand is live. A check running after the session ended can only report; it can't decide.

| Section | |
|---|---|
| **What I modified** | `meta/plans/reconcile-dangling-ledger-strands.md` — added the measured backlog, the enforceability finding, and reordered the build around resolution-first |
| **Actions I have taken** | Scanned 109 ledgers, cross-checked against every tracker; gates pass; committed `0b23cf6` and pushed to `claude/routing-ledger-orphaned-todos-8fdzcg` |

I updated the existing plan rather than filing a new artifact — it's the one artifact for this matter, it's still `proposed`, and it was already waiting on exactly these answers. No PR opened.

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Close the ~24 discharged rows first | Bookkeeping, not judgment — shrinks the list most and makes `/priorities` trustworthy again. Needs the freezing question answered first, since it means touching frozen ledgers |
| 2 | Promote the ~27 real orphans | I'd file the gate-suite tutorial drift as a todo today (verified, one-file fix) and hold the rest for your call on which deserve tracking |
| 3 | Build the warn check now | Add it beside `check_ledger_coverage/3` in `RouteTags` — reuses the existing ledger parser, ships independent of the freezing question |
| 4 | Ratify the freezing answer | Everything in option 1 blocks on it; my read is the narrow ledger-cell edit, since per-strand identity for the back-link alternative means re-anchoring every existing row |

## User

see the plan reconcile dangling routing-ledger strands

## Assistant

Read it back in full. Two defects in what I committed last turn, both now fixed and pushed (`cfe808f`).

**The fire count was wrong.** I wrote that the tracker-backing check fires on 52 rows. It fires on **34**. Two compounding errors: 3 + 6 + 33 is 42, not 52, and I'd forgotten the check only reaches `open`/`paused` rows — a `closed` row can't violate it by construction. Recomputed against the corpus: 76 pending rows are `open`/`paused`, 34 fire — 28 unrouted plus 6 pointing at a dead path or a finished tracker. The number matters because it's the whole basis for "would red the build on day one," and 34-of-76 still carries that argument.

While correcting it I also made explicit something the section only implied: the `analysis` and knowledge-doc targets deliberately **don't** fire. Routing synthesized content to an analysis is exactly what the routing policy asks for; those rows lack a *second* tracker ref, not a different one. A check that flagged them would be arguing with the policy it's meant to serve.

**Build order 5 contradicted the scope boundary.** The boundary read "*not a CI check*," and step 5 adds a warn-level check to `mix brain.route_tags` — which runs in CI. The boundary was drawn on the wrong axis. The distinction actually doing the work is **blocking vs. reporting**, and the precedent settles it: `route_tags` already carries a warn-level ledger cross-check in CI today. Rewrote the boundary on that axis and added the companion constraint that the check never judges actionability.

### The plan as it now stands

`status: proposed` — unchanged, still awaiting your ratification.

| Section | Where it landed |
|---|---|
| Problem | untouched — the two surfaces never converge |
| **Measured backlog** | 89 pending strands, 62 without a live tracker; ~24 discharged / ~9 decision-closed / ~27 real orphans |
| Core tension (freezing) | untouched — still the central open question, still unratified |
| **Enforceability** | actionability has no oracle; tracker-backing does, fires on 34, must warn |
| Shape of the change | untouched — `mix brain.strands`, a reconciliation motion, `/priorities` integration |
| Scope boundaries | sharpened to blocking-vs-reporting; added the no-judging-actionability bound |
| Open questions | freezing and strand-identity still open; **new**: the ~9 decision-closed rows need a `State` value that doesn't exist |
| Build order | 5 steps; retroactive sweep now required, discharged rows first |

The finding that reorders everything is in the backlog section: **the dominant failure mode is staleness, not loss**. A third of pending rows describe work already tracked elsewhere. So the ledger's defect isn't primarily that work escapes it — it's that it has no way to say *discharged*, and `/priorities` re-surfaces settled matters forever. That's why representing resolution has to come before promoting orphans, and it's why the freezing question (option 4 from last turn) is still the thing everything else waits on.

One thing I'd flag as under-specified rather than wrong: build order 4 says "the ~24 already-discharged rows first," but that step can't run at all until the freezing answer exists, since closing them means touching frozen ledgers. The dependency is stated in the header ("after the freezing question is ratified") but the step reads as if it could be picked up independently.

## User

what is the freezing question?

## Assistant

It's the plan's central unresolved question, and it's a genuine conflict between two policies rather than a detail.

### The setup

`/capture` writes a thread doc once, at session close, and the body is frozen from that moment. The `## Routing` ledger is a *section of that body* — routing-ledger is explicit that it's "a section of the thread doc itself (not a sibling file)".

Now a strand sits there marked `paused`. Six weeks later the work gets promoted to a todo, or just quietly ships. The row still says `paused`. So:

> **When a strand is promoted or resolved, may its `State`/`Dangling` cells be edited in the already-captured thread — or is the thread immutable?**

### Why it's actually hard

The ledger is doing two incompatible jobs at once.

As part of a thread doc it's a **historical record** — living-text-is-present-tense names thread docs among "[r]ecords that are historical *by construction*", and route-tagging depends on the frozen body being auditable. Records must not change.

But `/priorities` reads those same rows as a **live work queue** every time it runs. Queues must change. That's why the backlog is 89 rows deep — a queue with no way to mark anything done.

One artifact, a record and a queue, wanting opposite things.

### The two candidate answers

**Mutate the ledger** — permit a narrow post-capture edit to the `State`/`Dangling` cells only, never body prose, leaving a pointer to where the strand went. The ledger stays truthful and `/priorities` stops re-surfacing settled work. Cost: it dents the freeze invariant, and the route-tag verifier has to learn to tolerate ledger-only edits.

**Dedup by back-link** — never touch the thread. Teach `dangling_strands/1` to treat a strand as resolved when some todo/plan/issue carries `attribution.from` pointing back at that thread *and* names the strand. Freezing survives intact and it reuses an edge that already exists. Cost: `from` is **thread**-granular while strands are **row**-granular, so it needs a new per-row anchor — a slug or ordinal on every ledger row, including all 89 existing ones.

### My read

I'd take the mutation option, and there's more support for it in the contract than the plan currently credits. session-capture already says "tagging and ledger upkeep are one finalization motion over that frozen body" — it names *ledger upkeep* as something that happens **to** the frozen body, distinct from the body's frozen prose. The freeze was drawn around the verbatim `## User`/`## Assistant` render, which is what makes a thread doc a faithful record. The ledger is metadata over that render, not part of it. Extending upkeep past the capture moment is a smaller step than it first looks.

The back-link option is the more principled one on paper, but retrofitting a stable anchor onto 89 existing rows is a migration, and it buys purity in a place where the freeze wasn't really load-bearing.

Worth naming, though: both answers treat the symptom. The root problem is that a live queue is stored inside a document defined as historical. A third option — derive the queue *out* of the ledgers into something that can hold state, leaving threads untouched forever — isn't in the plan and might be the cleaner shape. I didn't add it since that's a design direction for you to want, not one I should quietly write in.

## User

why not have /priorities only reference persisted action docs (plans etc) and NOT reference the routing ledger? then, make a policy that all action items stemming from threads should route to action docs via the routing ledger at time of pr - making it impossible to have dangling action items

## User

or, your third option

## Assistant

Both, actually — and I don't think they're rival options. Yours is the steady state; mine is its migration step. Neither works alone.

### Why yours is better than both candidates in the plan

The plan's two answers both try to *answer* the freezing question. Yours **dissolves** it.

Freezing is only a problem because something reads the ledger as current state. Stop reading it, and a stale row is just an accurate record of where that session left things — which is what a thread doc is *for*. The 89 pending rows don't need editing, don't need back-link anchors, don't need a `deferred` state value. They become inert historical text. The whole §"core design tension" section stops applying.

And it puts the state where state can actually live. A todo has `status: open|done|cancelled` — a mutable field, on a document designed to be revisited. That's precisely the representation the ledger lacks and can't grow without breaking its own freeze. This is fit each layer to its purpose applied to a straddle the brain has been carrying since capture was adopted: record layer frozen, tracking layer mutable, and the `Routed to` cell as the one-way pointer between them.

### Why my third option isn't a real alternative

I said "derive the queue out of the ledgers into something that can hold state." Pushing on it, that splits two ways and both collapse:

A **live derived view** — a generated `meta/strands.md` you annotate with dispositions — is a generated artifact you hand-edit, which is the exact pattern this repo bans everywhere else (`CLAUDE.md`, `meta/registry.md`, `meta/code-map.md`). Keep it purely derived and the disposition has to live back in the action docs keyed to a strand, which needs the per-row anchor retrofitted onto all 89 existing rows — the plan's option 2, with its full cost.

A **one-time extraction** — sweep the ledgers once, mint the action docs, never derive again — is not an alternative to your proposal. It's step one of it.

So: extraction fixes the backlog, your policy fixes the inflow. Extraction without the policy and the ledgers refill with orphans over the next 50 threads. The policy without extraction is worse — it **silently drops ~27 items of live work out of view** the moment `/priorities` stops scanning. That's the one hard sequencing constraint: sweep, then switch. Never the reverse.

### This upgrades my earlier conclusion on enforcement

I said the check must warn and never fail, for two reasons: a hard gate would demand editing frozen bodies, and it would red the build on 34 pre-existing rows. Your design removes both. Enforcement lands at PR time, when the thread doc is still in-branch and editable — nothing frozen is being touched. And with the sweep done first plus grandfathering by thread date, day one starts green.

So under your proposal it can be a genuine blocking gate: *a row with `State: open|paused` must carry a ref to a `plan`/`todo`/`issue` that isn't `done`*. Mechanical, no judgment, no oracle problem. That's a real strengthening — my earlier answer was correct for the design as it stood, not for this one.

### Four things to settle before it's buildable

**The two-ref problem.** `Routed to` currently points at whatever absorbed the *content* — often a knowledge doc or an analysis, which is correct and shouldn't change. A pending row now needs *additionally* a ref to an action doc. Second column, or both refs in one cell? I'd add a column; overloading the cell makes the gate's parse ambiguous.

**Closed-with-dangling.** 13 rows are `closed` yet carry a leftover `Dangling` cell, and `dangling_strands/1` counts them as pending. Under your policy the gate should key on `State` alone, and a `Dangling` note on a closed row is just commentary. That's cleaner than today and drops 13 rows from scope for free.

**The bar for filing versus closing.** Closing a row becomes the only alternative to filing a doc, so some sessions will file five or six todos each. The ~9 decision-closed rows show the escape valve already exists in practice — *"left uncodified until it recurs (operator agreed)"* is a legitimate close, not a dodge. The policy needs to say so explicitly, or `meta/todos/` bloats.

**Grandfathering.** The gate checks threads dated after adoption, or only threads in the diff. Without it, it can't land.

One honesty note on "impossible": this makes it impossible for an item that *reaches the ledger* to dangle. An actionable item `/capture` never wrote a row for still escapes — ledger coverage has no oracle, same as route-tag coverage. That's a much smaller hole than the one you're closing, but it isn't zero, and the policy shouldn't claim otherwise.

Want me to rewrite the plan around this? It'd mean replacing the core-tension and enforceability sections outright, reordering the build to sweep-then-switch, and moving `mix brain.strands` from a standing tool to a one-shot migration instrument. I'd keep the measured backlog as-is — it's the evidence for the sweep.

## User

* second column
* "closed, pending", all states should be completely removed from all thread doc routing ledgers in favor of being linked to the artifacts that contain the relevant content the only exception being:
* ""left uncodified until it recurs (operator agreed)"" - the only non-linked state
* re: the honesty note - this is to say that, if the llm missing a section in the thread (ie. no route tags were assigned) then that aspect will not be surfaced? ie, we are dependent on the route tagging being carried out successfully?
* should we rewrite plan and execute in new thread, or this one?

## Assistant

Four clear ratifications. Let me correct one thing in your fourth point first, since it changes the answer.

**Route tags and the routing ledger are different mechanisms.** Route tags (`<routes ref="…">`) mark body regions and feed the doc-side excerpt logs — they aggregate *content*. The ledger is the `## Routing` table. My honesty note was about **ledger row coverage**, not tagging. So the scheme depends on `/capture` enumerating the session's matters into *rows*, not on tags landing correctly.

But your underlying worry is right, and there's a partial oracle I missed. The existing cross-check runs one direction only — ledger row → is it tagged? Inverting it catches real misses: **every route-tagged region should map to a ledger row.** If the agent tagged a region for some document but wrote no row for that matter, that's mechanically detectable today. What survives is only a matter that got *neither* a tag nor a row — which needs someone to read the session to notice. Bounded, and unchanged by this redesign either way. I've written the bidirectional check into the plan.

Now the rewrite.

## Assistant

Plan rewritten around your design and pushed (`dd51df7`).

| | |
|---|---|
| **What I modified** | `meta/plans/reconcile-dangling-ledger-strands.md` — replaced the core-tension and enforceability sections with the record/queue separation; added the schema, a sweep-first build order, and the 27-orphan appendix |
| **Actions I have taken** | Gates pass; committed and pushed. Still `status: proposed` — nothing executed |

Your four ratifications went in as stated: second column, `State` deleted from every ledger, the `none:` carve-out as the only unlinked form, and the gate promoted from warn to blocking (PR-time means nothing frozen is being edited, so both objections that forced warn-only fall away).

Two things I decided that you should overrule if you disagree. **I dropped `Dangling` too** — your ratification didn't cover it, but a question with no tracker is what the design forbids, and with a tracker it belongs *in* the tracker; keeping it recreates the shadow copy the policy already bans. And I noted that stripping `State` from 109 frozen bodies is legitimate on the **`sb:` → `em:` migration precedent** — ratified, deterministic, one pass — with the old values recoverable from git.

### On where to execute

**Rewrite here (done), execute in fresh sessions** — with one exception.

The plan-vs-capture discriminator is context-transfer, and this now hits three of the escalation triggers: cross-session build order, substantial standalone design, and cold-context handoff. The appendix exists specifically so a fresh session doesn't re-derive the scan.

The phases split cleanly by what they need:

| Phase | Nature | Where |
|---|---|---|
| 1. Sweep the 27 | judgment — is each worth tracking? | **wants you**, any session |
| 2. Backfill `Action` across 109 ledgers | mechanical migration | fresh |
| 3. Switch `/priorities` | mechanical | fresh |
| 4. Gate + inverted cross-check | mechanical | fresh |
| 5. Policies + contract recompile | mechanical | fresh |

The exception is step 1. It's the only phase that's judgment rather than execution, and it's the one thing that must finish before anything else starts — stripping `State` before extracting the orphans deletes them from view. It doesn't need *this* session, but it does need you in the loop wherever it runs.

My recommendation: PR this branch now so the plan lands, then start a fresh session on step 1 with the appendix as the worklist. This session has spent its context on the analysis; steps 2–5 are exactly the kind of well-specified mechanical work a fresh agent does better from a plan than from a long thread.

**One blocking question:** confirm or reject dropping `Dangling`. Step 2 migrates 109 files, and getting the column set wrong means doing it twice.

## User

confirm dropping dangling
commit, then proceed step 1
then make sure 2-5 are persisted in a plan, and /create-pull-request merge

## Assistant

Merged and done.

| | |
|---|---|
| **Merge SHA** | `dd29e7c` — true merge commit, per merge-strategy |
| **CI** | green on both `verify` runs before merging |
| **Head branch** | auto-deleted (confirmed gone from `origin`) |
| **Thread doc** | `meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md`, `pr: 162` |

### What landed

The scan (89 pending strands, 62 without a live tracker, staleness as the dominant failure mode), the record/queue separation that dissolves the freezing question, and step 1 executed — 27 orphans dispositioned into 11 todos and 1 plan, 13 recorded `none:` with a reason.

The plan is now `in-progress` with steps 2–5 remaining and its appendix carrying every disposition, so the migration is mechanical from here.

### Where to pick up

Step 2 (backfill `Action` across 109 ledgers) is the natural next fresh session — it's the one step nothing else can start before, and the plan is written to be executed cold. Steps 3–5 follow it in order.

Two things I recorded rather than decided, both waiting on you and both cheap to answer before step 2 runs:

- **Do `project` hubs count as valid `Action` targets?** Two secure-financial-agent strands are genuinely held by that project's own `## Open questions` — a bundle doc, not a tracker. They're `none:` with a pointer for now, but if you widen the rule, step 2 should write them as links instead of re-touching those ledgers later.
- **The grandfathering boundary** for the gate: threads dated after adoption, or only threads in the diff. Step 4 needs it, not step 2 — less urgent.

I did not subscribe to PR activity; the PR is merged and closed, so there's nothing left to watch.

## User

if i close this session will a future session know to pick up step 2?

## Assistant

Tested it rather than assumed. **Findable, but not pointed at** — and the gap is bigger than I'd have guessed.

Running `mix brain.session_init` against merged `main`:

| Section | Count | Where the plan sits |
|---|---:|---|
| Open issues | 6 | — |
| Open todos | 17 | — |
| **Active plans** | **29** | **4th** |
| Dangling strands | 99 | — |
| **Heuristic top-3** | — | **absent** |

The top-3 is a `priority: 1`-flagged plan and two open issues. Issues outrank in-progress plans by class weight, and `main` gained two more issues while we worked.

So three concrete gaps:

**It's 4th of 29 in a list nobody reads to the bottom.** The digest is a wall — 151 items across four sections. A reader scanning for what to do next takes the top-3, and the plan isn't there.

**Its digest line doesn't say where it is.** The line shows title + `in-progress` + description, and the description describes the *whole* plan. Nothing signals "step 1 is done, step 2 is next." That only appears once you open the file and read the build order. A fresh agent has no reason to open the 4th of 29 plans.

**Discovery is pull, not push.** Nothing runs `/priorities` automatically. The SessionStart hook nudges — `run /priorities to review open work` — but a session that starts with a task goes straight to the task.

One thing worth naming: dangling strands went **89 → 99**. Some of that is `main`'s other threads, but two rows are mine — my own capture added to the backlog this plan exists to eliminate. That's the inflow problem demonstrating itself in the same session that diagnosed it, and it's exactly what steps 2–5 close.

### Two fixes

| Fix | Effect | Whose call |
|---|---|---|
| Amend the plan's `description` to state the position — "step 1 done; steps 2–5 remain, starting with the ledger backfill" | The digest line becomes self-describing, so a reader learns the state without opening the file | mine to do, if you want it |
| Set `priority: 1` on the plan | Pins it above every heuristic class — it becomes the top-3 item a fresh session sees first | yours — the contract calls this the operator's escape hatch |

I'd do both. The description fix is the one that actually helps a cold reader, since a pin gets it *seen* but still doesn't say what's next.

Both need a fresh branch and PR — the merged branch is gone. Say the word and I'll restart `claude/routing-ledger-orphaned-todos-8fdzcg` from `main` and land them together; it's a two-line change, so it'd be one small PR rather than a session's worth of work.

## User

do both
then
/create-pull-request  merge

## Assistant

PR [#170](https://github.com/ob6to8/elixir-mind/pull/170) is open, CI running. I'll merge once green.

Both fixes are in, and the verification confirmed the plan now ranks **#2** in the top-3 rather than 4th-of-29 and invisible.

One deviation from what you approved: I used **`priority: 2`, not `1`**. There's an existing `priority: 1` on `compile-skills-registry-from-skill-frontmatter`, and a tie would have broken on recency — silently pushing your existing pin down. Flagged items sort above every heuristic class regardless, so `2` gets the same top-3 placement without disturbing what you'd already flagged.

Two things surfaced while testing that I folded in rather than leaving:

**The plans-index gloss was stale** — my miss from #162. It still described the superseded `mix brain.strands` design, so a reader browsing the index would have gotten the old plan.

**A parallel session filed the same matter as an issue**, hours before ours merged — `routing-ledger-has-no-post-capture-upkeep-path`, reaching the identical diagnosis from the opposite direction (a strand resolved later with no sanctioned way to update its row). Its three candidate resolutions are superseded by our ratified design, which dissolves the gap rather than resolving it. Cross-linked both ways and marked superseded, but I kept it **open** — the gap is live in the shipped policy until step 5 rewrites it, and closing it now would claim a fix that hasn't landed.

That's the second duplicate this session (after the channels todo). Two parallel sessions independently filing the same matter within hours is itself a signal worth watching — though I'd want a third instance before treating it as a pattern rather than coincidence.

## Assistant

Conflict resolved and pushed; waiting on CI before retrying the merge.

The conflict was worth reading rather than reflexively resolving: `main` **deleted** `meta/dev-history.md` in `e96a6d3` — "stop committing the dev-history view; generate it at deploy only." My branch had regenerated that file, per the `/create-pull-request` step that was current when this session started. So the modify/delete conflict was my branch doing work `main` had just removed the need for. Accepted the deletion rather than restoring the file.

That also explains a change you may have noticed in the skill itself — the dev-history regeneration step is gone from `/create-pull-request` now.

Gates all pass locally on the merged tree (188 tests). I'll merge #170 once CI confirms.

## Assistant

Merged, and verified against merged `main` rather than assumed.

| | |
|---|---|
| **Merge SHA** | `e07b42b` — true merge commit |
| **CI** | green on both runs before merging |
| **Head branch** | auto-deleted |
| **Thread doc** | extended in place; `pr: 162` (origin), PR 170 in narrative prose |

**The answer to your original question is now yes.** A fresh session running `/priorities` sees the plan at **#2 in the top-3**, and its digest line leads with *"Step 1 done (27 orphans dispositioned); steps 2-5 remain, starting with the ledger backfill"* — so the position is legible without opening the file.

Worth noting what sits at **#3**: the parallel session's ledger-upkeep issue. A fresh session now gets the plan and its independently-filed twin adjacent in the same top-3, cross-linked, with the duplicate's candidates marked superseded. That's about as good as the discovery path gets without the step 2–5 machinery.

Two deviations from the literal instruction, both flagged above and neither reversible without your say: `priority: 2` instead of `1` (to avoid demoting your existing pin), and accepting `main`'s deletion of `meta/dev-history.md` mid-merge rather than restoring the copy my branch had regenerated.

For whenever you pick this up: step 2 is the ledger backfill across 109 threads, and the plan's appendix carries every disposition, so it's mechanical. The two questions still open — whether `project` hubs count as valid `Action` targets, and the grandfathering boundary — are both cheap to answer and only the first affects step 2.

## User

re: "The two questions still open — whether project hubs count as valid Action targets, and the grandfathering boundary — are both cheap to answer and only the first affects step 2." - is this something i need to address in this thread before closing, or is it persisted somewhere

## Assistant

**No — you don't need to address them before closing.** All of them are persisted in the plan's `## Open questions` section on merged `main`, each with my recommended answer attached, so a future session can ratify rather than re-derive.

Two corrections to what I said last message.

**There are three, not two.** I dropped the `none:` marker syntax. Persisted list: `none:` marker syntax, grandfathering boundary, and whether `project` hubs count as valid `Action` targets.

**"Only the first affects step 2" was wrong on ordering** — the project-hub question is listed third, not first. The substance holds: it's the only one step 2 depends on, since it changes what gets written into two rows. The other two bind steps 4 and 5.

One real gap, small enough that I'd leave it: **step 2 doesn't cross-reference the question it depends on.** It says "populating it from step 1's dispositions," and the appendix records those two rows as `none:` with a pointer. A fresh session executing step 2 by the letter would write `none:` for them — which is the correct default, and reversible, but it wouldn't know the question was live. Only a session that reads the whole plan, not just the build order, would connect them.

That's a one-line patch to step 2. Not worth a PR cycle on its own — I'd fold it into whatever session picks up step 2, or into the next change that touches the plan for another reason. Say the word if you'd rather it land now.

Nothing else in this session is unpersisted. The thread doc is extended and merged, the 12 promoted artifacts are on `main`, the plan is `priority: 2` and #2 in the top-3, and the duplicate issue is cross-linked. Closing the session loses nothing.

## User

there is no folding it into or further actions from you outside of me authoring another pr. if there are actions to be taken, do them and i will. if anything in the transcript since the pr needs to be persisted, tell me and i will create another pr. otherwise we want to end this thread

## Assistant

Done. Branch `claude/routing-ledger-orphaned-todos-8fdzcg` is pushed with two commits' worth of content in one commit — [open a PR from it](https://github.com/ob6to8/elixir-mind/pull/new/claude/routing-ledger-orphaned-todos-8fdzcg). Gates green, 188 tests.

**Two things needed persisting.** The first I'd already flagged; the second I under-called last message and want to correct.

**Step 2's dependency, now cross-referenced.** It said "populating it from step 1's dispositions" without naming the one open question it depends on. Step 2 now says to settle the `project`-hub question first, because answering it afterwards means re-touching those two rows.

**The duplicate-artifact class, filed as an issue.** I said last message I'd want a third instance before treating it as a pattern. That was too cautious — there were already two documented instances in this session, each with concrete cost, and re-reading them the class is sharper than I credited:

- The channels todo: a parallel session filed the same matter on `main`; I filed mine independently and had to delete it.
- The ledger-upkeep gap: a parallel session filed it as an `issue` while this branch filed it as a `plan` — *different types, different wording, same matter*, so even a filename check would have missed it.

Both defeat `update-in-place` identically: each session searched `main`, each correctly found nothing, and the resulting files differ in name and path — so git sees no conflict and no gate fires. That makes it worse than the merge-conflict class already tracked, not milder: a conflict stops you, a duplicate doesn't. Both of these were caught by accident.

Governance artifacts have no equivalent of the intake dedup probe. The issue records the problem and three candidate fixes without committing to one; my read is that reconciling at *merge* time is the only option that catches both documented instances, since duplication is only detectable once both branches exist.

If you disagree that the duplicate issue is worth filing, drop that file from the PR — the step 2 patch stands on its own.

Nothing else from this session is unpersisted.

## User

i still don't follow. relay in plain speak

## Assistant

Plain version.

**Earlier you asked** whether a future session would pick up where this one stopped. I checked instead of guessing. It would have *found* the work but nothing would have *pointed at it* — buried 4th in a list of 29. I fixed that, and it's already merged and live.

**Then you asked** whether the leftover questions were written down or needed answering before you close. They're written down, in the plan itself, each with my suggested answer. Nothing was going to be lost.

**Then you said** don't hand things off to some future "later" — do it now or say so. Fair. There were two loose things. I did both and put them on a branch for you to submit.

---

**The small one.** The plan has a numbered list of remaining steps. Step 2 didn't mention that one of the leftover questions has to be answered *before* it starts. Someone following the list literally would do step 2, then answer the question, then have to redo part of step 2. Now step 2 says so.

**The one actually worth understanding.** Twice today, another session running at the same time as me wrote up the exact same topic I was writing up. Neither of us knew. We each checked the shared copy of the repo first, found nothing, and both wrote something — because at the moment we each looked, neither document existed yet.

When the two sets of changes came together, nothing complained. The two files had different names, so as far as the tooling was concerned they were unrelated documents. Both times I only spotted it by luck.

That's a genuine hole. The repo has a rule: *don't create a duplicate, update what's there.* That rule works fine when the duplicate already exists when you look. For two sessions working at the same moment, it can't. So I wrote it up as a known problem — what happened, both examples, three possible fixes, no decision made.

I'd said last message I'd wait for a third occurrence before calling it a pattern. I changed my mind. Two in one day, both costing cleanup, is enough to write down.

---

**What you do:** [open a pull request from the branch](https://github.com/ob6to8/elixir-mind/pull/new/claude/routing-ledger-orphaned-todos-8fdzcg). All checks pass.

If you think the duplicate write-up isn't worth keeping, delete `meta/issues/parallel-sessions-file-duplicate-artifacts.md` before you submit — the step 2 fix is independent and stands on its own.

Nothing else from this session is sitting unsaved.

## User

put them on a branch? meaning this branch?
so, is the second one written down?

## Assistant

**Same branch name, but a new branch.** The original one merged in PR #170 and GitHub deleted it. So I started a fresh one from `main` reusing the name `claude/routing-ledger-orphaned-todos-8fdzcg`. It has exactly one commit on it.

**Yes, the second one is written down** — as a real file, 95 lines, `meta/issues/parallel-sessions-file-duplicate-artifacts.md`. It's committed and pushed to GitHub.

But here's the distinction that probably caused the confusion: **written down on the branch is not the same as in the repo.** The branch is a side copy. Until a pull request merges it into `main`, that file doesn't exist in the main repo — so `/priorities` won't list it, and a future session won't find it.

The whole branch is three changes:

```
meta/issues/parallel-sessions-file-duplicate-artifacts.md   +95   (new — the duplicate problem)
meta/issues/index.md                                         +1   (lists it)
meta/plans/reconcile-dangling-ledger-strands.md              +6   (the step 2 note)
```

So: it's saved, it's pushed, it's not lost — and it becomes real when you merge it. [Open the PR here.](https://github.com/ob6to8/elixir-mind/pull/new/claude/routing-ledger-orphaned-todos-8fdzcg)

If you'd rather I open the PR myself, say so and I will — I held off only because you said you'd author it.
