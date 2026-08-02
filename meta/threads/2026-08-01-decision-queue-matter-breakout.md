---
type: reference
title: 2026-08-01-decision-queue-matter-breakout
description: The decision-queue session — row 1 presented and paused, row 5 resolved by ratifying the governance backlog audit (session 5), the complete-docs-rewrite plan filed, main's matter system merged in, and the queue's remaining rulings and sweep broken out into the five-matter decision-queue sequence, queued at register rows 3–7.
provenance: "Claude Code session (Claude Fable 5), 2026-08-01/02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, decision-queue, matters, review, governance]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01DsJqM8LT7LskGcHkD48PZN
---

# 2026-08-01-decision-queue-matter-breakout

## Where this landed

The session opened as the review program's decision-queue thread: present the
five operator rulings one at a time, execute inline. Row 1
(model-attribution) was presented and paused; the operator then ratified two
additions mid-session — session 5, the governance backlog audit, replacing
queue row 5, and the complete-docs-rewrite plan — and row 2 (excerpt-log
discipline) was presented. When the matter system landed on main, the
operator redirected: merge main, break the thread's remaining spikes (rows
1–4 and the contract-synchronization sweep) into sequenced matters contained
by a plan, and determine their register placement. The session delivered the
[decision-queue matter sequence](/meta/plans/decision-queue-matter-sequence.md)
plan, five matter packets with refreshed row-states, and the ratified
placement at register rows 3–7 — the inline queue dissolved into the matter
register, and the two rulings already presented travel inside their matters.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Row 1 ruling: model-attribution's fate (presented, paused, folded into its matter with the span-level edge) | closed | [settle-model-attribution](/meta/matters/settle-model-attribution.md) | - |
| Row 2 ruling: excerpt-log discipline (presented, folded into its matter with the drafted amendment) | closed | [excerpt-log-discipline](/meta/matters/excerpt-log-discipline.md) | - |
| Session 5 — governance backlog audit ratified in place of queue row 5 | closed | [comprehensive-repo-review-program](/meta/plans/comprehensive-repo-review-program.md) | - |
| Complete docs rewrite commissioned as a proposed plan | closed | [complete-docs-rewrite](/meta/plans/complete-docs-rewrite.md) | - |
| Breakout of rows 1–4 + sweep into five sequenced matters | closed | [decision-queue-matter-sequence](/meta/plans/decision-queue-matter-sequence.md) | - |
| Register placement determination (contiguous block, rows 3–7) | closed | [Matters register](/meta/matters.md) | - |
| Committer-identity fix on the branch's first two commits | closed | unrouted | - |
| origin/main merge; plans-index conflict composed from both sides | closed | unrouted | - |

## User

Work the operator decision queue from the comprehensive review. The queue is the table
"Questions the review leaves with the operator" in
/meta/plans/comprehensive-repo-review-program.md; the argued case for each row is in
the epistemology and content review analyses it links.

For each of the five rows in order: present the recommendation and its case in chat
text, take my decision inline, and execute what a decision unblocks in-session
(policy edits + /render-contract, the model-attribution index-gloss fix, retyping
strays, filing a small plan where a row needs design rather than a ruling — likely
the excerpt-log discipline row).

After the queue, present the contract-synchronization sweep (§2–3 of
/meta/analysis/epistemology-and-governance-review.md) as a single ratification, and
execute it on approval.

Update the program plan's session ledger, then /create-pull-request.

## Assistant

Prep done — every load-bearing premise for row 1 is now checked against HEAD. Presenting the first row; the queue pauses here for your decision.

---

**Where we are.** This is the decision-queue session from the comprehensive review: five rulings the review left with you, then the contract-synchronization sweep as a sixth ratification, then the ledger update and PR. I present one row at a time, you decide inline in chat, and I execute each decision before presenting the next row. This turn is row 1 of 5.

<routes ref="meta/matters/settle-model-attribution.md">
## Row 1 — model-attribution's fate

**The finding** (epistemology review §4, re-verified this session): [model-attribution](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/model-attribution.md), ratified 2026-07-31, requires agent-authored governance and statement docs to name their producing model in `provenance`. Zero of the 41 policies carry a `provenance` field at all (checked: `grep -l "^provenance:" meta/policy/*.md` → none) — including `assertions-name-their-basis`, filed 2026-08-01, *inside* the rule's forward-looking scope. The nine doctrines split across five forms the policy says must not coexist (`Claude Fable 5`, `Claude Opus 4.8`, `claude-opus-4-8`, version-less `Claude Fable`, bare `Claude Code session`). The policy's own gloss in `meta/policy/index.md` says "in model-id form" — the form the body forbids. And the review's core argument for not leaving it standing: "A ratified rule with zero instances teaches agents that ratified rules are optional."

**The decision space** is the review's: enforce (warn-only presence+form check, backfill the corpus) or retract. The retract case is genuinely argued in the repo — the still-open todo [ratify-or-reject-provenance-names-producing-model](https://github.com/ob6to8/elixir-mind/blob/main/meta/todos/ratify-or-reject-provenance-names-producing-model.md) recommends rejection: the commit trailer already carries the model, and a third home for the same fact is the shadow-copy pattern `provenance-lives-in-metadata` exists to prevent. But the ratified policy already engaged and answered exactly that argument (its "What the commit graph already covers" section: a trailer attributes a commit, not a document; a document travels outside its git history) — so retraction today would re-litigate a ratification you made yesterday, on a counter-case the policy text already absorbed. The review's real finding is narrower: the policy deferred the retrofit as "its own decision," and that decision was never taken — so conformance stayed at zero.

**Feasibility, checked:** I dry-ran the backfill derivation this session. Taking each policy/doctrine's creating commit via `git log --follow` and reading its `Co-Authored-By` trailer yields a model for ~46 of 50 files (≈31 Claude Opus 4.8, 12 Claude Fable 5, 3 Claude Opus 5); the 4 unresolved all land on a merge commit, which is a derivation artifact I'd fix at execution with `--no-merges` — genuinely trailer-less files get the policy's own sanctioned `model undisclosed`. This is backfill from recorded evidence only, the same standard the session-URL backfill set; for doctrines it normalizes form and completes bare entries from their own commits' trailers, which I read as evidence-based completion rather than the provenance rewriting `verification-grounding` forbids — but that reading is yours to confirm.

**My recommendation: enforce.** Concretely, on your go:

1. Backfill `provenance` on the 41 policies from creating-commit trailers, display form (`"Claude Opus 4.8, Claude Code session"`), `model undisclosed` where no trailer survives; per-file verification that the derived commit really added the file.
2. Normalize the 7 agent-authored doctrine `provenance` fields to display form from their commits' trailers (the operator-pasted and Reddit-sourced doctrines are not agent-authored and stay untouched).
3. Fix the index gloss: "in model-id form" → the display form the body mandates.
4. Close the stale todo as `done` with a resolution note (the ratification happened; this decision completes it).
5. File a new todo for the warn-only presence+form report in `mix brain.verify` — the code work belongs to a gate-oracled session per `capability-matched-model-selection`, and this session's remit is the rulings.

Scope bound, stated plainly: this backfills policies + doctrines — the set the queue row names. The rest of `meta/` (plans, analyses, tutorials, issues, todos — many already carry `provenance`) is left for the warn-only report to enumerate once it exists, rather than swept silently here.

The honest cost of enforce: `provenance` becomes, in part, a hand-written copy of trailer data — the todo's shadow-copy objection. The mitigations are that it is write-once at filing (never maintained), and warn-only enforcement keeps presence visible without gating anything.

| # | Question you need to answer | My recommendation |
|---|---|---|
| 1 | Row 1: enforce model-attribution (backfill + normalize + gloss fix + todo close + warn-report todo, items 1–5 above), or retract the policy? | **Enforce**, as itemized — retraction re-litigates yesterday's ratification on an argument the policy text already answered |
</routes>

## User

Pause on that, will circle back

Additional scope, to execute in this thread after (or alongside) the queue:

Extend /meta/plans/comprehensive-repo-review-program.md with two additions I am
ratifying now:

1. A new review session — "the governance backlog audit" — covering what no
   existing plan scopes: a per-item audit of all of meta/plans/ (~38 active),
   meta/issues/ (~8 open), and meta/todos/ (~18 open). For each item: still
   valid / already satisfied (e.g. the ratify-or-reject-provenance todo the
   epistemology review flagged as stale on its face) / superseded by a later
   ratification / duplicate of another item / worth keeping with a
   defer-until condition. Output is an audit table plus a disposition
   recommendation per item for my ratification — this replaces decision-queue
   row 5 (plan-backlog posture), so resolve that row by pointing it at the new
   session rather than deciding it bare. Add the session to the plan's
   Remaining sections and Execution hand-offs with a ready hand-off prompt;
   recommended model tier: Opus-class main loop (criterion-guided grading over
   ~64 items; judgment but oracled by the ratification pass that follows).
   Note the coordination edges in the plan: reconcile-dangling-ledger-strands
   (in-progress) and matter-disjointness both touch adjacent ground; the
   audit consumes their state, it does not redo them.

2. File a new proposed plan — "complete docs rewrite" — for a wholesale pass
   over the reader-facing doc surfaces (README, meta/tutorials/, meta/flows/,
   index glosses, the root index), distinct from the review program's
   corrective sweeps (staleness findings 8–13 and the contract-sync sweep,
   which stay where they are). Two constraints go in the plan as ratified
   sequencing: it runs only after this thread's decision queue and sync sweep
   land (rewriting against rules that are about to change does the work
   twice), and it absorbs or explicitly defers to the doc-first phase 1 of
   /meta/plans/separate-okf-bundle-and-elixir-mind-library.md (README/
   preamble/root-index reframing) rather than duplicating it — one artifact
   per matter. Leave scope questions (whether policy prose beyond the sync
   sweep is in scope; whether the site chrome is) as the plan's open
   questions for me.

Update both indexes and the program plan's session ledger accordingly.

## Assistant

Row 5 is executed and committed; the queue now stands at rows 1–4, with row 1 paused for your circle-back. Row 2 follows below.

**What just landed, in plain terms:** the review program now contains the governance backlog audit you ratified — a new session 5 that reads all 65 open governance items (39 active plans, 8 open issues, 18 open todos) one by one and hands you a disposition table to ratify, replacing the queue's bare "plan-backlog posture" ruling. The docs-rewrite you commissioned is filed as a proposed plan with both of your sequencing constraints recorded. Both changes are committed with the full gate suite green.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `plan` | `meta/plans/complete-docs-rewrite.md` | a proposed change whose design and sequencing must survive until it runs — the two scope questions are recorded as its open questions for you |

**What I modified**

| File | Thrust of the change |
|---|---|
| `meta/plans/comprehensive-repo-review-program.md` | Session 5 (scope, disposition vocabulary, deliverable, coordination edges, ordering) added to Remaining sections; a ready hand-off prompt added (Opus-tier, your rationale in the heading); queue row 5 marked resolved-by-pointer with a note; in-progress ledger entry for this session; description parenthetical extended |
| `meta/plans/index.md` | New plan's entry added under Proposed; the program plan's gloss now says four-row queue + session 5 |

**Actions I have taken**

| Action | Result |
|---|---|
| Verified counts and edges before writing | 39/8/18 = 65 items live; `reconcile-dangling-ledger-strands` is `in-progress`, `matter-disjointness-check-for-parallel-filing` is `proposed`; separation plan's phase 1 confirmed as the README/preamble/root-index reframing |
| Committed in dependency order | `71932e6` (program extension), `d0dfc2e` (new plan + index); pre-commit gate suite green both times (201 tests; contract, registry, code map, lineage all fresh) |

One edge found while reading the plans index, parked for your row-1 circle-back: the **accepted** [span-level-attribution plan](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/span-level-attribution.md) already ratifies a structured model field "recovered from filing-commit trailers at migration" — the same trailer derivation my row-1 backfill would do into free-text `provenance`. When you return to row 1, the enforce option should be weighed against (or sequenced with) that migration; I'll present the reconciled options then.

---

<routes ref="meta/matters/excerpt-log-discipline.md">
## Row 2 — excerpt-log discipline

**The finding** (content review erosion 1, re-measured this turn post-fence-fix): 112 of 164 knowledge docs now carry a `## Thread excerpts — route-tagged log` section, totaling 4,037 of 20,492 lines — **19.7% of the corpus's text**, up in absolute terms from the review's 3,865 lines. In sampled docs the log exceeds the authored body ([first-order-logic-and-owl](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md): 157 lines of log under 136 of body). Because a multi-ref region is lifted whole into *every* sink it names, identical ~60-line blocks recur verbatim across documents; one tagged paste re-embedded an entire raw Reddit thread inside a distilled reference; process noise ("No PDF matching this is present…") is welded into a knowledge doc. The machinery is contract-sanctioned and freshness-gated — the weak joint is **selection** (what gets tagged) and **whole-region lifting with no size discipline**. The review's charge: "Decide once, as policy — the ratio only grows."

**The decision space** is the review's three levers: (a) a selection rule, (b) a per-sink size cap with link-instead-of-lift overflow, (c) a render-collapsed convention on the site. They are complementary, not exclusive — and they split cleanly into a ruling and a design. Collapse alone is cosmetic (agents load and grep the `.md` files, where the 20% actually sits); a cap alone truncates badly-selected regions instead of preventing them. Selection is the input-side fix and needs no machinery — it is pure judgment, ratifiable today.

**My recommendation — split ruling from design**, matching your brief's anticipation that this row needs a small plan:

1. **Ratify the selection rule now** as an amendment to the route-tagging policy (a new bullet beside "Per-paragraph, multi-ref, lifted whole"), riding the sweep's `/render-contract`. Draft text for your ratification, verbatim:

   > **Select the feeding paragraph, not the surrounding run.** A tag region covers the paragraph(s) that feed the sink's matter — the narrowest span that carries what the sink accretes — never the wider exchange for convenience. A paragraph that merely contains a wholesale external paste is not itself the feeding content: the paste files as its own capture document, and the tag covers the discussion of it.

2. **File the small plan** for the mechanical half — `meta/plans/excerpt-log-discipline.md`: per-sink size-cap semantics in the materializer (warn vs. fail, the overflow-as-link form), the render-collapsed site convention, and the retro question (whether to re-select the existing 112 sinks' tags — 4,037 lines are already lifted, and the selection rule alone only slows the ratio). These interact with the verifier's divergence gate and re-materialization, so they need design, not a bare ruling.

| # | Question you need to answer | My recommendation |
|---|---|---|
| 1 | Row 2: ratify the selection-rule amendment as drafted, and file the excerpt-log-discipline plan for the cap/collapse/retro mechanics? | **Yes to both** — the rule binds every future `/capture` immediately; the mechanics get designed once, with the retro pass decided there rather than improvised |
</routes>

Fixed and pushed. The two commits were rewritten with the correct committer identity (`bfad202` — program-plan extension with session 5; `c615458` — the complete-docs-rewrite plan + index) and the branch is now on the remote; the git identity is configured for every later commit this session, so this won't recur.

**Row 2 still awaits your ruling** from the previous message: ratify the selection-rule amendment to the route-tagging policy as drafted, and file the `excerpt-log-discipline` plan for the cap/collapse/retro mechanics — my recommendation is yes to both. Rows 3–4, the paused row 1, and the contract-synchronization sweep follow after it.

## User

pull main, a fair amount of work has landed, most significantly the matter system

this thread's series of spikes should now be broken out into sequenced matters, contained by a plan

do this, and then determine where in the matter registry the plan's matter sequence should occur when compared to the matters that are currently there.

## Assistant

The breakout is filed, verified, and pushed — the queue's remaining work now lives in the matter system, and the placement determination is below for your ratification.

**In plain terms:** main is merged in (one index conflict, resolved by keeping both sides' content). Your four pending rulings and the contract-sync sweep are no longer an inline conversation — each is now a matter doc: a self-contained packet a fresh thread can deliver under the approval-gated `/matter` protocol, one PR each. A small plan contains the five and fixes their internal order, and every packet's factual claims were re-checked against post-merge HEAD (main had already satisfied parts of the sweep). The two questions this thread had left hanging — the excerpt-log ruling and the paused model-attribution row — are withdrawn as inline questions; they arrive again, argued and updated, when their matters are consumed. This implements the new `deferred-work-is-filed` policy: the matters are filed as backlog, and the one thing the protocol reserves for you is their register position.

**Merge report.** `origin/main` (11 PRs, #224–#234) merged; the sole conflict was `meta/plans/index.md`, where main added two accepted-plan entries in the region where I had updated the review-program gloss. I resolved it by composing both sides — main's two entries kept, my strictly-newer gloss kept over main's pre-session copy of the same line — rather than escalating, since both sides' intents were fully enumerable; flagging it here for your veto. Gate suite green on the merge commit.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `plan` | `meta/plans/decision-queue-matter-sequence.md` (`accepted`) | the container you directed: sequence, rationale, shared context — packets stay in the matters |
| `matter` ×5 | `contract-synchronization-sweep` (1) · `excerpt-log-discipline` (2) · `standardize-verbatim-capture-filing` (3) · `settle-model-attribution` (4) · `contract-size-counterweight` (5) | review-quantized delivery units, `plan`/`order` frontmatter linking the container |

**What I modified**

| File | Thrust |
|---|---|
| `meta/plans/comprehensive-repo-review-program.md` | ledger + queue table record the breakout; session-5 scope and hand-off follow the todo fold (`meta/matters/`, moved link) |
| `meta/plans/complete-docs-rewrite.md` | its sequencing constraint now names matters 1–5 as the thing it waits on |
| `meta/plans/index.md` · `meta/matters/index.md` | merge conflict resolved; new plan entry; five matter entries; program gloss repointed |

**Actions:** packets carry refreshed row-states (main already landed the index-coverage gate and the survey/journal exemptions; the gloss and capture-gloss defects re-confirmed live); `mix brain.matters` + full gate suite green; committed `9781473`, pushed.

---

<routes ref="meta/plans/decision-queue-matter-sequence.md meta/matters.md">
## Register placement — the determination

The queue today: **1** `/create-pull-request` scoping · **2** dev-history recommit · **3** Pages-sunset revision (blocked on your decision) · **4** bias-taxonomy implementation · **5** TDD bookmark promotions · **6** vendor-block pilot (blocked).

**Insert the five as a contiguous block at positions 3–7.** The reasoning, row by row: rows 1–2 stay ahead — the scoping edit tightens the PR motion every one of my five deliveries will use, and the dev-history recommit decides whether sweep sub-item 13 drops. The block enters before the current row 3, which is blocked on you and sits regardless (the blocker-skip rule would leapfrog it anyway). It enters before the bias-taxonomy build on leverage: that is a large content build whose sessions read the contract, and the sweep corrects what the contract claims about its own hard gates — governance correctness first maximizes what the correction reaches; the excerpt-log ruling also has a running cost (19.7% and growing with every capture). Contiguous rather than interleaved because four of the five edit policies and share one review's context, and no dependency is served by scattering them. The result respects the verifier's invariant (queue order 3–7 = internal order 1–5):

| # | Matter | Type | Order |
|---|---|---|---|
| 1 | /create-pull-request scoping edit | independent | - |
| 2 | dev-history recommit + regeneration fold-in | independent | - |
| **3** | **contract-synchronization sweep** | planned | 1 |
| **4** | **excerpt-log discipline** | planned | 2 |
| **5** | **verbatim-capture filing pattern** | planned | 3 |
| **6** | **settle model-attribution** | planned | 4 |
| **7** | **contract-size counterweight** | planned | 5 |
| 8 | response-resource-links / Pages-sunset revision | independent | - |
| 9 | two-sided bias taxonomy implementation | planned | 1 |
| 10 | TDD bookmark promotions | independent | - |
| 11 | vendor-block pilot | planned | 3 |

Alternatives weighed: top of queue (rejected — rows 1–2 are small and improve the very delivery machinery the block uses); tail (rejected — defers the highest-leverage correctness work behind a large content build while the erosion accrues); interleaved (rejected — nothing gains, shared context scatters).

| # | Question you need to answer | My recommendation |
|---|---|---|
| 1 | Queue the five matters at register positions 3–7 as shown? (Per the `/matter` protocol a register row is placed only where you state.) | **Yes** — on your word I apply the register edit, and with the ledger current this thread's remaining step is the `/create-pull-request` close from the original brief |
</routes>

## User

confirm register edit

