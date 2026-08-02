---
type: reference
title: 2026-08-02-matters-vs-plans-and-matter-docs
description: Consumed register row 1 under the interim protocol — the matters-vs-plans definition question — through a proposal-counter-ratification arc; the derived-register idea weighed and declined, the matter-doc architecture ratified (type matter, plan/order props, order-only register, todo fold, issue kept, the term matter kept), delivered as the analysis + superseding plan + reshaped queue, then trimmed of process narrative after a style challenge and closed with /create-pull-request merge.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, matters, plans, work-queue, architecture, terminology]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01V4SmiwzSTymGF1CnYUWjbr
---

# 2026-08-02-matters-vs-plans-and-matter-docs

## Where this landed

A fresh thread took the register's top matter — the matters-vs-plans
definition question — under the operator's interim consumption protocol
(re-print the row as the record, propose, wait for approval). The proposed
disposition (register stays a hand-kept store; drift contained by
quote-don't-restate rows) was met by the operator's counter (unify plan
build-orders with rows and derive the register), which was declined on three
irreducibility gaps — and then dissolved by the operator's architecture:
one doc per matter (`type: matter`, `plan`/`order` props), plans as prose
superstructure, the register thinned to the order-only pointer view. Ratified
with refinements, plus: `todo` folds into matter (backlog = open matter
outside the register), `issue` survives, and the term `matter` was weighed
against `todo`/`task`/`pr`/`feature` and kept. Delivered as the
[matters-vs-plans analysis](/meta/analysis/matters-vs-plans.md), the
superseding [matter-docs plan](/meta/plans/matter-docs-architecture.md), the
reshaped queue (row 1 consumed, former rows 2+3 merged into the `/matter`
skill row, the build queued as rows 1–5), a definitional glossary edit, and
the retag that moved this dialog's excerpts out of the term's log. A closing
style challenge — is the analysis's historical reference and operator quoting
more effective than flat statement? — was answered (genre division of labor;
quotes as ratification anchors) with a concession: process-narrative clauses
failing the meaning-vs-chronology test were cut. Closed with
`/create-pull-request merge`; the mid-session commits are `86cdd8f`
(delivery) and `73d71ca` (trim).

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Matters-vs-plans definition question (register row 1) | closed | [matters-vs-plans](/meta/analysis/matters-vs-plans.md) | - |
| Matter-doc architecture: type, props, order-only register | closed | [matter-docs plan](/meta/plans/matter-docs-architecture.md) | - |
| Todo fold and issue survival | closed | [matter-docs plan](/meta/plans/matter-docs-architecture.md) | - |
| The type's name: matter vs. todo/task/pr/feature | closed | [matters-vs-plans](/meta/analysis/matters-vs-plans.md) | - |
| Glossary excerpt-log mis-route (dialog tagged into the term's log) | closed | [matters-vs-plans](/meta/analysis/matters-vs-plans.md) | - |
| Register-row provenance (what the record re-print contains) | closed | unrouted | - |
| Analysis style: history and quoting in the genre | closed | [matters-vs-plans](/meta/analysis/matters-vs-plans.md) | - |

## User

take the top matter from meta/matters.md as your task

interim protocol (until the /matter skill exists — see register row 2):

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

The top of the queue is the matters-vs-plans definition question you raised on 2026-08-02. Following the interim protocol: below is the row re-printed as the record, then what I propose to deliver and how — including the conclusions I intend to argue, so your approval ratifies a direction rather than a blank check. Nothing has been executed; the working tree is clean and I stop here until you approve.

## The record — register row 1

**Matter:** Matters-vs-plans definition question

**Scope:** Operator-raised (2026-08-02), verbatim: "what's the difference between matters and plans? is it just scope? if so, plans should really just be aggregated collections of sequential matters that done sequentially would implement the complete scope of the plan. are we unecessarily creating a new data type?" Seed read to weigh, not conclude: a `plan` carries decisions/rationale plus its own build order; the register holds the single global delivery order across all initiatives; rows are dispatch pointers, not documents (the [matter-queue plan](/meta/plans/matter-queue-and-present-matters.md) already rejected a controlled `type`) — the live duplication risk is hand-projecting plan build-orders into rows. Outcome may reconfigure how matters are defined and handled, including whether the two skill rows below consolidate.

**Context:** fresh

## What I propose to do

The deliverable is a reasoned judgment on a question, so per governance-artifact-routing it files as a `type: analysis` under `meta/analysis/`, with small consequential edits applying its conclusions — one matter, one PR. The conclusions I intend to argue, decomposed against your question:

1. **"Is it just scope?" — No; the difference is role, not size.** A plan is a *decision record* (rationale, alternatives, shape, build order — what persist-plans exists to keep); a matter is a *unit of delivery* (one reviewable intent — what the atomic-PR policy quantizes). They relate as source to emission: a plan's build order emits a sequence of matters. A matter needs no plan behind it (checked against the live register: rows 2 and 4 carry inline scope with no plan).

2. **Your reduction is half right, and the half it keeps is real.** "Plans = aggregated collections of sequential matters" is exactly true of the build-order dimension. What it drops is the decision record: when a plan's matters are all consumed, the plan doesn't vanish — it goes `status: done` and is kept, because "the decision history is the point." That remainder is what a plan is that a matter sequence isn't.

3. **No new data type was created.** A matter has no controlled `type`, no frontmatter, no `em:` id — a row is a dispatch pointer, and the concept lives in one glossary entry. The redundancy worry is real only as *hand-copy drift* between plan build-orders and register rows.

4. **The register is a store, not a view** — the sharper question the seed read isolated. Its two contents exist nowhere else: the global cross-initiative delivery order (an operator sequencing decision no per-initiative plan can hold) and the packets of plan-less micro-matters. There is nothing to derive them from; a derived view would force machine-readable build orders onto prose plans and still leave the order hand-kept. Drift is contained by the already-ratified rule ("the register never duplicates a plan's body — it dispatches") sharpened into row-writing discipline: a planned-work row is matter + plan-step ref, detail stays home. The plan's existing `mix brain.matters` open question remains the escalation valve.

5. **Rows 2 and 3 consolidate into one `/matter` skill,** subcommand-dispatched: bare `/matter` consumes the top row under the approval-gated protocol we're running by hand right now; `/matter list` renders the register. Precedent is `/todo` and `/bookmarks` — one register, one skill — and prefer-established-terminology retires the bespoke `present-matters` coinage. Deciding and applying this to the queue is this matter's scope; *building* the skill stays the next matter's.

Artifacts, on approval:

| # | Action | Artifact | Why |
|---|---|---|---|
| 1 | create | `meta/analysis/matters-vs-plans.md` | the full judgment above — the matter's primary deliverable |
| 2 | modify | `beliefs/glossary/matter.md` | add the plan relationship to the definition body (update-in-place; timestamp bump) |
| 3 | modify | `meta/plans/matter-queue-and-present-matters.md` | decision list gains the store-not-view and consolidation decisions, dated, citing the analysis; `/present-matters` bullet and build order revised to the single `/matter` skill |
| 4 | modify | `meta/matters.md` | protocol steps: row 1 → `## Consumed` with renumbering; plus rows 2+3 merged into one `/matter` row |
| 5 | modify | `meta/analysis/index.md` | list the new analysis |

No new `em:` id is needed (the analysis is governance-namespace); the gate suite runs before commit; at close, your `/create-pull-request` stamps the thread into the analysis's `attribution.from` and I append the PR number to the consumed row per the register's protocol line.

## Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Approve the deliverable and the conclusions in 1–4 (analysis doc; store-not-view; drift handled by row discipline)? | Approve as stated |
| 2 | Approve the row-2/3 consolidation into a single subcommand-dispatched `/matter` skill (reshapes the queue now, builds next matter)? | Approve — it matches the `/todo`/`/bookmarks` pattern and your interim protocol already names the skill `/matter` |

## User

3 - to avoid the redundancy worry would it make sense to make the plans build-orders verbatim copies of the matter register rows? which would then imply the matter registry should be derived

4 - explain in plainspeak

5 - explain in plainspeak

## Assistant

Answers under each of your three points. The upshot on 3: your inference is right — verbatim copies maintained by hand would be the worst shape, so unified formats would demand generation — but a generated register can never be complete, because the cross-plan order and the plan-less rows exist only in the register itself. I recommend recording your shape as the named upgrade path while keeping the hand-kept register, with a stricter row-writing rule that removes most of the drift surface. Points 4 and 5 are restated in plain terms below. The approval gate from my last message is still open; nothing has been executed.

> 3 - to avoid the redundancy worry would it make sense to make the plans build-orders verbatim copies of the matter register rows? which would then imply the matter registry should be derived

The inference is exactly right: if plan build-orders and register rows ever share one format, keeping two hand-edited copies would be the worst of all shapes, so one side must be generated from the other. Where the proposal runs aground is that the generator would have incomplete sources — the register holds information the plans don't. Three gaps, all visible in today's queue:

- **The cross-plan order.** Each plan can order its own steps; none of them can say whether the bias-taxonomy step runs before or after the dev-history recommit. That interleaving is an operator decision, and whatever file records it is, by definition, a store. Derivation can relocate row *content* into plans, but the *order* is irreducible — so a fully derived register is unreachable in principle, and the realistic end-state of your proposal is a thin hand-ordered list of refs whose packets are pulled from plans.
- **Rows with no plan.** Rows 2 and 4 carry inline scope with no plan document behind them (checked against the live register). A derived register forces every such micro-matter to first be filed somewhere derivable — a todo or mini-plan per item — turning one row-write into two file-writes.
- **Cross-initiative context.** Row 2's scope reads, verbatim, "sequenced after row 1, which may revise it." That sentence relates two initiatives and cannot live inside either one's plan. Rows already carry register-level content.

There is also a cost shift on every consumption: today it is one edit in one file (move the row to Consumed); derived, it becomes an edit to the source plan plus a regeneration, gated by a freshness check like the contract's. That machinery pays off only if hand-kept rows actually drift — and the drift surface is small if rows obey the cheap version of your verbatim instinct, pointed the other way: a planned-work row *quotes or refs* the plan step ("per plan X, build-order 2", plus a one-line gloss and any cross-initiative note) instead of restating it in fresh prose. Then nothing can fall out of sync but the pointer.

So, updated by your question, point 3's disposition becomes: keep the register a hand-kept store now; write the quote-don't-restate row rule into the analysis; and record your architecture — packets resident in plans/todos, the register reduced to a thin ordered ref list with a derived render — as the named escalation shape, triggered when consumption hits real drift (a row contradicting its plan at read time) or the queue outgrows hand-ordering. The matter-queue plan already reserves a `mix brain.matters` slot for this; the analysis fills in the target shape so a future session doesn't re-derive it.

> 4 - explain in plainspeak

Some files in this repo are written by hand; others are generated. `CLAUDE.md` is generated — a command assembles it from the policy files, and you never edit it directly because the next regeneration would overwrite you. Call the hand-written kind a *store* (the information lives there) and the generated kind a *view* (a display of information that lives elsewhere). The open question was which kind the matters file should be — should a command build it out of the plans, the way the contract is built out of the policies?

My answer: it has to be a store, because two things in it are written down nowhere else. First, the order *across* projects: each plan can say "do my steps in this sequence," but nothing in any plan says whose step goes first when several plans are queued at once — that's a call you make, and this file is where it's recorded. Second, the small one-off tasks that never had a plan: their entire description exists only as their row. A generator can only rearrange information that already exists somewhere; it can't produce those two things.

"Drift" names the risk behind your question: a row summarizes a plan, the plan later changes, and the two quietly disagree. The containment is to make rows mostly pointers — "see plan X, step 2" — so there's almost nothing in a row that *can* disagree. And the "escalation valve": the previous session already noted that a generated version can be built later if the queue grows or drifts anyway — declining it now doesn't close that door.

> 5 - explain in plainspeak

The queue was set to get two separate commands: `/present-matters`, which would only display the list, and `/matter`, which would take the next task off the top. I'm proposing one command with two uses instead. Typing `/matter` takes the top task and runs the routine we're currently doing by hand — print the task as a record, propose an approach, wait for your OK, and on delivery move the row to the Consumed log. Typing `/matter list` shows the queue without touching it. This is exactly how `/todo` already works: one command, and the word after it picks the action. One name to remember, and everything queue-related lives under it.

If you approve, what changes today is only the queue file — the two planned rows merge into one row describing the combined skill. Writing the actual skill happens next session, when that merged row reaches the top and is consumed.

## Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Approve the analysis + edits as proposed, with your derived-register architecture recorded as the escalation shape rather than built now? | Approve — the cross-plan order can never be derived, plan-less rows exist today, and quote-don't-restate rows remove most of the drift surface at no machinery cost |
| 2 | Approve merging rows 2 and 3 into the single subcommand-dispatched `/matter` skill row? | Approve — it matches the `/todo` and `/bookmarks` pattern, and your interim protocol already names the skill `/matter` |

One unrelated notice: the alphaXiv MCP server attached to this session needs authorization before its tools work (via your claude.ai connector settings if it's a connector, otherwise via `/mcp` in an interactive session); it's unavailable until then.

## User

also - above you quoted "what's the difference between matters and plans? is it just scope? if so, plans should really just be aggregated collections of sequential matters that done sequentially would implement the complete scope of the plan. are we unecessarily creating a new data type?" - where was this sourced from?

in the intial prompt, i said: "1. re-print the matter row verbatim here in the thread first, as labeled
   fields (Matter / Scope / Context), not a raw table row — this is the
   record, since the row will be removed from the file by the end"

Was this printed here and i'm missing it? i can't imagine its that verbatim quote above

## Assistant

Both questions have file-level answers, now checked directly against the repo.

> where was this sourced from?

It is your own message, and the repo carries it in four places (enumerated by grep just now — that's the full set of occurrences in the bundle):

1. **The primary capture:** `meta/threads/2026-08-02-deferred-work-policy-and-consumed-matters-log.md`, line 160 — a `## User` block in that session's thread doc, your words rendered verbatim. This is where you raised the question and, two paragraphs later, directed "we should punt, describe this question as a new matter, and bump that to the top of the matter list".
2. **The register row:** that session's agent compressed the matter into `meta/matters.md` line 27, embedding your question inside the scope cell with the marker "Operator-raised (2026-08-02), verbatim: …" — the row citing you.
3. **The glossary excerpt log:** `beliefs/glossary/matter.md` line 48 — the route-tagging machinery lifted the same passage into the generated "Thread excerpts" section of the *matter* glossary entry, because that session tagged your paragraph as feeding `em:4c629e`.
4. The same thread doc again at line 175, where that session's agent re-quoted it while replying to you.

What I quoted in my first message came from source 2, the register row — which is the point of the next answer.

> Was this printed here and i'm missing it? i can't imagine its that verbatim quote above

Yes — it's printed, and the verbatim quote is *part of* it, which I think is exactly what made it hard to recognize. In my first message, immediately after the opening paragraph, there is a section headed **"The record — register row 1"** with the three labeled fields:

- **Matter:** Matters-vs-plans definition question
- **Scope:** the row's scope cell in full — which *opens with* your quoted question, because the row itself embeds your words verbatim (that's how the previous session wrote it, following your "describe this question as a new matter" direction)
- **Context:** fresh

So the record block is a quote-within-a-quote: I re-printed the row verbatim, and the row quotes you. That's why it reads as "that verbatim quote" rather than as an obvious table-row transcription — the row's content just *is* mostly your question plus the previous session's seed read. Fidelity check, done just now against `meta/matters.md` line 27: my re-printed Scope field matches the row word-for-word, including the original "unecessarily" spelling and the embedded link — nothing was paraphrased or trimmed.

The approval gate from the proposal is still open — questions 1 (analysis + edits, with your derived-register architecture recorded as the escalation shape) and 2 (merging rows 2 and 3 into one `/matter` skill row) await your call.

## User

regarding the plan/matter question:

<routes ref="meta/plans/matter-docs-architecture.md meta/matters.md">
what makes the most intuitive sense to me is to have matter retain its scope and association with a single concern and PR (idealy as we can see threads spin out quite easily, but at least we can identify the platonic ideal and when and where reality diverges from it), and have each matter be an okf document, I would imagine of type "matter". each matter would have a prop which may associate it with a plan, as well as an "order" prop, indicating where in the plans self contained order it would appear. if the matter were NOT part of a plan, it would then be self contained, with null for plan and order (or whatever is convention in elixir.)

the plan would then backlink to the matters, though notably without specifying order, which would as stated above a prop on the matter. this way the plan would be a superstructure over the matters and hold all necessary context. both matters and plans would be shifted to done when done

meanwhile, matters.md would be a pointer registry. it would be an opnionated view - the only data being stored would be order, as this should be the master list of all matters to be done - sequential plan related series as well as standalone matters.
</routes>

<routes ref="meta/plans/matter-docs-architecture.md">
the question this would raise for me is: can we still justify todos and issues? in a way, given each represents a concern that could be scoped to a PR, they are by definition a type of matter
</routes>

/matter list approved

re: the message

<routes ref="meta/analysis/matters-vs-plans.md">
3. why would this go to the glossary? this is a development concern, my dialog does not help define the term
</routes>

so that was the verbatim entry for the register row?

ok, so everything after scope is from the register? the comments after my quote are from that, NOT from you?

## Assistant

Your architecture lands very close to the upgrade path the matter-queue plan already reserved for itself, and I recommend adopting it now — with a handful of refinements — rather than waiting for the drift trigger. Answers under each subject, then the updated ratification gate. Grounding I just checked: there are 19 open todos and 8 open issues, and the two glossary-feeding tag regions sit at lines 159 and 177 of the origin thread doc.

> what makes the most intuitive sense to me is to have matter retain its scope and association with a single concern and PR … have each matter be an okf document, I would imagine of type "matter". each matter would have a prop which may associate it with a plan, as well as an "order" prop … the plan would then backlink to the matters, though notably without specifying order … meanwhile, matters.md would be a pointer registry. it would be an opnionated view - the only data being stored would be order

This is nearly exactly the escalation shape the plan already recorded for itself — its decision list reads, verbatim: "the register becomes a `meta/matters/` directory, one file per matter with a derived ordered view — a mechanical refactor recorded here so it need not be re-derived." Your proposal is that clause plus three additions: the controlled `type: matter`, the `plan`/`order` props, and the vocabulary question below. Two of my earlier objections dissolve under it — the packet gets a durable home (no more scope-cells-into-git-history), and drift dies structurally instead of by discipline, since the register stores nothing but order. My third point survives and your design already absorbed it: the global order is irreducibly a store, and your register stores exactly that one thing. I endorse it, with these refinements:

- **Namespace: governance, like its siblings.** Matter docs live in a `meta/matters/` directory beside todos/issues/plans — OKF documents with frontmatter and `type: matter`, but no `em:` id (work-tracking docs are outside the identity registry; they carry `attribution` like any governance doc). The `plan` prop is then a bundle-absolute path (`plan: /meta/plans/foo.md`), matching how governance docs already reference each other.
- **Absent means omitted, not null.** The bundle's existing convention for "not applicable" is key omission — `verified` is omitted on captures, `session:` is omitted when unset — so a standalone matter simply carries no `plan` and no `order` key. (In Elixir code it surfaces as `nil`; in the file it's absence.)
- **`order` mechanics.** Integer, scoped within its plan; insertions renumber siblings (plans hold few matters, so this stays cheap). One machine check falls out for later: the register's global sequence must never invert any plan's internal order — a natural `mix brain.matters` rule, which is the plan's existing open question filled in.
- **The canonical edge points matter→plan; the plan's backlinks are prose.** The plan stays the superstructure — decisions, rationale, links to its matters — but its link list is narrative, not a second structured store that can disagree with the props. A plan's sequence is derivable: collect matters where `plan` = it, sort by `order`. Bidirectional consistency is machine-checkable later.
- **Done handling.** Matters carry `status: open/done/cancelled`; done drops a matter from the register (the doc persists as its own record, eventually carrying its landing PR in frontmatter). The register's `## Consumed` section retires once docs carry landing metadata — until that build lands, it stays.

> the question this would raise for me is: can we still justify todos and issues? in a way, given each represents a concern that could be scoped to a PR, they are by definition a type of matter

Split verdict. **Issue survives**, with a crisp discriminator: a matter is *committed work* — it will be delivered as a PR — while an issue is a *tracked condition* that may never become work at all; `wontfix` is the proof (a lifecycle outcome no delivery unit has), and several of the 8 open issues have no known fix to commit to. An issue *spawns* a matter the moment its fix is decided; the two types are a pipeline, not duplicates.

**Todo does not survive** — it's near-isomorphic to your standalone matter (same status vocabulary open/done/cancelled, same "plain task, approach obvious" content, no plan behind it). But the 19 open todos expose one wrinkle in "master list of all matters to be done": forcing a total order over 19 parked items you've only ever hand-ordered 9 of would be fake precision. The resolution: **register membership is the queue marker**. An open matter *in* the register is committed and sequenced; an open matter *outside* it is backlog (today's todo). Folding then means: todos migrate to `meta/matters/` as backlog matters in one mechanical sweep, `/todo`'s create/list become `/matter` subcommands (or aliases during transition), and you pull a backlog matter into the register at a position when you commit to it. Issues stay untouched.

> /matter list approved

Recorded — rows 2 and 3 merge into one `/matter` skill row (bare invocation consumes the top of the register under the approval-gated protocol; `list` renders it). One sequencing consequence of ratifying the architecture: the skill row moves *after* the architecture-build rows in the queue, so the skill is built once, against the final shape.

> 3. why would this go to the glossary? this is a development concern, my dialog does not help define the term

You're right, and the cause is mechanical, not editorial judgment about your dialog. Route-tag refs come in two kinds: an `em:` id aggregates excerpts into that document's log, while a plain path is a non-aggregating back-link. Only bundle docs carry `em:` ids — and the only id-bearing document anywhere near "matter" is the glossary concept `em:4c629e`, so the previous session's tag landed your paragraphs in the term's excerpt log for want of any other sink. The system-development discussion properly back-links to the *plan* and the *register*, both governance docs, both path-only. The fix I'll fold into this delivery: on both regions (thread lines 159 and 177), replace `em:4c629e` with the plan's path, keep `meta/matters.md`, and re-materialize — the two excerpt blocks leave the glossary entry. The one glossary change that remains is the definitional body sentence about the plan relationship, which does help define the term.

> so that was the verbatim entry for the register row? ok, so everything after scope is from the register? the comments after my quote are from that, NOT from you?

Yes, yes, and yes. The entire **Scope** field — your quoted question *and* everything after it, from "Seed read to weigh, not conclude:" through "…whether the two skill rows below consolidate" — is the register row's cell reproduced word-for-word. The previous session's agent wrote that seed-read text when it filed the row (its fuller original is that agent's reply at line 178 of the thread doc). I composed none of it in this session; in my first message, my own words end at "## The record — register row 1" and resume after "**Context:** fresh".

## Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Ratify the matter-doc architecture with the refinements above (governance namespace, omission for absent props, matter→plan as the canonical edge, register = ordered pointers over *queued* matters only)? | Ratify — it's the plan's own escalation shape completed, and migration is cheapest now, before the skill exists and while the queue is 9 rows |
| 2 | Ratify the todo→matter fold (19 open todos migrate as backlog matters; `/todo` retires or aliases; issues stay a separate type)? | Ratify the fold; keep issues — the committed-work vs. tracked-condition line is real |
| 3 | Approve the glossary retag (swap `em:4c629e` for the plan's path on the two regions, re-materialize, excerpts leave the term's log)? | Approve |

On ratification I execute this matter's delivery in this PR: the analysis recording these judgments, the matter-queue plan revised to the new architecture with the migration build-order queued as register rows, the register edits (row 1 consumed and logged, rows 2+3 merged, build rows added), the glossary body edit plus retag, and the indexes — with the architecture build itself running as the queued matters in subsequent PRs.

## User

<routes ref="meta/analysis/matters-vs-plans.md">
approve the three questions, save the following:

makes sense on the migration of todos to matters - question being, at that point, is matter really the correct term? it almost seems like todo is closer to convention (a plan with todos), and we should retire matter in favor of the atomic element being a single concern todo scoped to a PR. thoughts? we could also consider other words: task, pr, feature, etc, and weigh matter against them
</routes>

## Assistant

All three approvals are recorded — architecture, fold, retag — with execution holding on this one last token, because the winning word becomes the `type:` value, the directory name, the skill name, and the vocabulary of every doc I'm about to write. My recommendation: keep `matter`. The weighing:

> is matter really the correct term? it almost seems like todo is closer to convention (a plan with todos) … we could also consider other words: task, pr, feature, etc, and weigh matter against them

The load-bearing question is what the unit fundamentally *is* in this system. It is a **review quantum, not a doing quantum**: the ratified definition is "one coherent intent a reviewer can approve or reject as a whole," and the delivery doctrine it implements is explicitly review-centric ("generation is cheap and review attention is the bottleneck, so work is shaped to fit review"). `todo` and `task` name work from the doer's side — something to do. `matter` names it from the disposition side — something brought before a decision-maker for judgment, which is the term's established general-English and legal sense (the matter before the court, the matter at hand). The name should carry the system's one load-bearing property, the review boundary — and only the incumbent does.

The candidates against that bar:

| Term | Established sense | Verdict |
|---|---|---|
| `todo` | GTD lists; `TODO` comments — informal, untracked deferred marginalia | Its connotation is exactly the **backlog half** and nothing more. Two failures as the delivery unit: the repo's own coding standards define TODO comments as precisely what *filed* work is not ("future-work asides become `meta/todos/` entries, not `TODO` comments"), and keeping the name while adding plan/order props, register membership, and PR quantization is stealth redefinition under 19 live docs. Calling a policy adoption or the bias-taxonomy build "a todo" also trivializes it. |
| `task` | PM convention: a unit of work, any size, subdividable | The strongest challenger in the abstract — and disqualified in *this* repo by a fatal collision: the toolchain is built of Mix **tasks**. "Plain `mix` task" and "the `mix brain.*` tasks" run through the contract, the tutorials, and the code map; a `type: task` and `meta/tasks/` beside them guarantees ambiguity exactly where precision matters. |
| `pr` | The GitHub object | Names the shipping container, not the intent: a queued unit has no PR yet, a merged one has finished with it — and the atomic rule itself needs both words to be sayable ("one X per PR"). |
| `feature` | User-facing functionality | Most units here aren't features: policy adoptions, analyses, intake batches, a retag fix. |
| `ticket` / `story` / `increment` / `concern` | Tracker object / user-value framing / Scrum's sum-of-completed-work / separation-of-concerns' system-aspect | Each imports wrong semantics: ticket sits in `issue`'s territory; story demands user-value framing; increment isn't a count noun for single units in convention; and in-repo "concern" already leans issue-ward (an issue is "a tracked … open concern"). |
| `matter` (incumbent) | General English / legal: a discrete concern brought for disposition | The core sense *is* the review boundary. Bespoke only as software jargon — and that bespoke cost is already paid: glossaried with `sense: repo`, ratified into the atomic-PR policy, woven through the register, the plan, and two threads' route tags. |

The prefer-established-terminology policy cuts both ways here, and ends up deciding it. Its tie-breaker — "an approximate standard term with a one-line qualification beats an exact bespoke one" — is what makes `task` the real contender; the Mix-task collision breaks that tie back to `matter`. And its churn clause — "a rename's cost (links, skills, muscle memory) usually exceeds a marginal terminology gain" — prices the switch: the gain is marginal at best, the cost spans a ratified policy, the glossary, the register, and every thread that already speaks the word fluently.

Your parenthetical instinct — "a plan with todos" — survives intact, just as a *state* rather than a *type*: under the fold, an open matter outside the register **is** the todo of convention (parked, informal, uncommitted), and pulling it into the register is what promotes it to committed work. The architecture keeps the todo concept; it just doesn't need the todo *type*.

Recommendation: keep `matter`, fold `todo` into it as ratified, and record this weighing in the analysis's decision list so the question doesn't get re-litigated.

## Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Ratify `matter` as the term (or name the alternative you prefer)? | Keep `matter` — it encodes the review boundary, `task` collides with Mix tasks, `todo` warps 19 live docs |

On your answer I execute the full delivery — analysis, plan revision with the queued build-order, register edits, glossary body edit plus retag, indexes — in this PR.

## User

<routes ref="meta/analysis/matters-vs-plans.md meta/plans/matter-docs-architecture.md">
ratify matter
proceed
</routes>

## Assistant

Matter 1 is delivered, committed (`86cdd8f`), and pushed — the full pre-commit gate suite ran green (201 tests, all verifiers passing; the warnings in the output are pre-existing and editorial). The register now leads with the five architecture build rows, the consumed row is logged, and the origin PR-number append waits for your `/create-pull-request`, per the protocol.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `analysis` | `meta/analysis/matters-vs-plans.md` | the reasoned judgment: review quantum vs. decision record, the irreducible order store, the fold/survive verdicts, the terminology weighing, the tagging rule of thumb |
| `plan` | `meta/plans/matter-docs-architecture.md` (`status: accepted`) | the ratified executable spec — frontmatter shape, boundary decisions, five-step build order — for fresh sessions to execute |

**What I modified**

| File | Thrust of the change |
|---|---|
| `meta/matters.md` | row 1 consumed → `## Consumed`; former rows 2+3 merged into the `/matter` skill row; architecture build queued as rows 1–5; old rows renumbered 6–11 |
| `meta/plans/matter-queue-and-present-matters.md` | `status: superseded` + pointer block to the matter-docs plan |
| `beliefs/glossary/matter.md` | plan distinction added to the definition body; orphaned excerpt log removed by the materialize |
| `meta/threads/2026-08-02-deferred-work…md` | the two dialog regions retagged from `em:4c629e` to path refs (plan + register) |
| `meta/analysis/index.md`, `meta/plans/index.md` | new entries; old plan's entry moved to Done/Superseded |

**Actions I have taken**

| Action | Result |
|---|---|
| `mix brain.route_tags --materialize` | excerpt log left the glossary entry; 221 sink blocks verify |
| Gate suite (verify, contract, registry, glossary, lineage, format, xref, tests) | all green, 201 tests, 0 failures |
| Commit + push | `86cdd8f` on `claude/matter-queue-protocol-drl0o2`, pushed with upstream set |

Whenever you're ready, `/create-pull-request` closes this out — capture, glossary pass, `attribution.from` stamping on the two new governance docs, the PR, and the consumed-row PR-number append. After it merges, the next fresh thread takes the new row 1: the `type: matter` vocabulary adoption.

## User

matters-vs-plans.md has a fair amount of historical reference and operator quoting. can you make an argument that this is more effective than simply stating how both plans and matters are defined and what the operational concerns are?

## Assistant

Yes — the argument exists, and it rests on the genre division of labor. But it licenses only *load-bearing* history, and by that standard the doc has a few clauses it shouldn't, which I'll concede specifically.

**The flat version you describe already exists — three times.** What a matter *is* lives in the glossary entry; the operational architecture and its rules live in the matter-docs plan; the binding definition will live in the vocabulary policy the moment build-order 1 lands. If the analysis also "simply stated how both are defined and what the operational concerns are," it would be a fourth copy of settled conclusions — exactly the duplication the one-artifact rule exists to prevent — and the system would have persisted the conclusions four times while persisting the *reasoning* zero times. The analysis genre is defined as the home of that reasoning ("a question investigated against evidence … filed so the reasoning and its conclusion persist"). Strip the history and quotes from this one and it doesn't get leaner; it gets redundant.

**Why reasoning requires the history.** A weighed judgment is a relation between a conclusion and its defeated alternatives. "The register is hand-kept" as a bare statement is indistinguishable from a default nobody examined; "the register is hand-kept, and here is the derivation proposal in its strongest form and the three gaps that sank it" is a settled question. The difference is operational, not aesthetic: the next time a session looks at `meta/matters.md` and thinks "shouldn't this be derived?" — a natural thought; you had it, and it was half right — the grep lands on the analysis and the thought terminates in five lines instead of a re-derivation session. Recording the losing side in its strongest form is the whole anti-re-litigation mechanism, and the strongest form of a proposal is its proposer's own words. There's a second-order version of the same point: the record shows the derivation idea's own advocate ratified against it after seeing the gaps, which forecloses the objection far harder than "the agent considered and rejected derivation" ever could.

**Why *operator* quotes specifically.** Two reasons. First, ratification fidelity: the architecture binds because you approved it, and what you approved is what you said — "the only data being stored would be order" — not my restatement of it. A paraphrase that drifted even slightly (say, "the register stores order and status") would put words into the ratification, and nothing downstream could detect the substitution. Verbatim-plus-citation is the only form that keeps the ratified design auditable against its ratifier; that's the quote-primary-sources rule doing exactly its job. Second, your question *is* the document's subject — row 1 was the question — and the verdict on your reduction ("exactly true of the build-order dimension; silently drops the decision record") is unintelligible without showing the reduction being graded. You can't grade a claim you don't display.

**The concession.** The test the provenance policy supplies — does the sentence lose *meaning*, or only *chronology and credit*, if the reference is removed? — is the right audit, and a few clauses in the doc fail it. "Punted at origin into register row 1 and consumed by this analysis" is process narrative that `attribution.from` and the register's Consumed row already carry structurally. "In dialog the question sharpened twice" is scaffolding; the sharpened questions could simply head their sections. Call it ten percent of the doc: history that narrates the *session* rather than grounding the *judgment*. The quotes and the weighing are the other ninety and are doing the work argued above.

One more framing that I think dissolves most of the tension: effectiveness is reader-relative, and the genres are routed by reader. Someone who wants the definitions should never be *on* the analysis — the glossary and the plan are the lookup surfaces, and the analysis cross-links both in its first screen. The analysis's reader is the one asking "why is it this way, and could it be otherwise?" — and for that reader the dialectical record is the content, not the packaging.

If you want, I'll cut the process-narrative clauses (the two named above, plus a pass for others failing the meaning-vs-chronology test) as a small follow-up commit on this branch — the quotes and weighing stay. Say the word and it's done.

Separately: the Cloudflare and alphaXiv MCP servers attached to this session need authorization before their tools work (claude.ai connector settings, or `/mcp` in an interactive session); both are unavailable until then.

## User

proceed with the cuts
then /create-pull-request  merge
