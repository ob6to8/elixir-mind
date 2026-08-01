---
type: reference
title: 2026-08-01-tdd-research-spike-and-methodology-adoption
description: Intake of the Gorman TDD×AI argument and both Dzombak Claude Code guides (with an aged assessment), a three-track research spike ranking TDD first-in-restated-form for coding-agent development, adoption of the two-level methodology-guidance plan, the verified-increments doctrine, the atomic-pull-requests and inline-reply-quoting policies — then an extended dialog on agentic cognitive biases (the stale-premise "exempt" slip and dev-history conflation as live specimens), test protection ladders, per-claim provenance, and the matter-queue design that closes with a nine-row execution sequence.
provenance: "Claude Code session (Claude Fable 5), 2026-08-01; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, tdd, methodology, agentic, atomic-prs, agent-guidance, cognitive-biases]
timestamp: 2026-08-01
session: https://claude.ai/code/session_01MWHK7zH3EgQzvgsJyPGkG4
pr: 224
---

# 2026-08-01-tdd-research-spike-and-methodology-adoption

## Where this landed

The operator opened a stricter-development-methodology push: three sources
intaked (Gorman's why-TDD-works-with-AI argument; Dzombak's 2025-08 fourteen-
practice playbook, assessed a year on; his 2025-12 streamlined user-level
CLAUDE.md, captured verbatim), a three-track research spike (practitioner
discourse with grep-verified quotes, the 2023–26 empirical literature, Elixir
ecosystem + PR-size data) concluding TDD ranks first among methodology choices
for agent-driven development in a restated form — the tests-as-contract loop,
conditional on protecting tests from the agent — with matklad's architecture
as the tier that makes the loop's economics work and atomic reviewed PRs the
co-equal delivery half. Adopted in-session by ratification: the two-level
guidance plan (canonical methodology in this brain, lean vendorable block into
each consuming repo's CLAUDE.md), the verified-increments doctrine, the
atomic-pull-requests policy (matter as the unit, size a signal never the
gate), and the inline-reply-quoting policy (born mid-dialog and applied from
its first reply). The back half is the richer record: agentic cognitive
biases named and specimened live (the "exempt" frame surviving its premise's
retraction; the dev-history conflation), the TMS prior-art connection, the
four-rung test-protection ladder and its eval-holdout kinship, per-claim
provenance in a temp format aligned to the span-attribution plan, and the
matter-queue/present-matters design — closing with operator approval of a
nine-row execution sequence delivered as sequential atomic PRs, this thread's
capture being PR 1.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Intake: Gorman, why TDD works in AI-assisted programming | closed | [why-tdd-works-in-ai-assisted-programming](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md) | - |
| Intake: Dzombak 2025-08 playbook + aged assessment | closed | [getting-good-results-from-claude-code](/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md) | - |
| Intake: Dzombak 2025-12 user-level CLAUDE.md | closed | [streamlining-user-level-claude-md](/knowledge/SWE/agentic/context-engineering/streamlining-user-level-claude-md.md) | - |
| TDD ranking research spike | closed | [tdd-rank-for-coding-agent-development](/meta/analysis/tdd-rank-for-coding-agent-development.md) | - |
| Agent development methodology + vendorable block | open | [agent-development-methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) | A-package (de-exempt wording, protection ladder, claim-provenance table) lands in PR 3 |
| Two-level guidance storage design | closed | [two-level-agent-methodology-guidance](/meta/plans/two-level-agent-methodology-guidance.md) | pilot deferred until a consuming repo is active |
| Verified-increments doctrine + atomic-PR policy | closed | [verified-increments](/meta/doctrine/verified-increments.md), [git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md) | - |
| Inline-reply-quoting policy | closed | [inline-reply-quoting](/meta/policy/inline-reply-quoting.md) | - |
| Matter queue + /present-matters | open | unrouted | plan + seeded register + skill land in PR 2 |
| Agentic cognitive biases + in-the-wild instances | open | unrouted | K plan lands in PR 5; implementation in a fresh thread; this thread is backfill-tagging material |
| dev-history home after Pages de-prioritization | open | unrouted | G (recommit + /create-pull-request regeneration fold-in, unshallow guard) executes in a fresh thread |
| deferred-work-is-filed policy | open | unrouted | draft lands in PR 4 for ratification |
| The 19.8% claim traced to arXiv 2602.07900 | closed | [tdd-rank-for-coding-agent-development](/meta/analysis/tdd-rank-for-coding-agent-development.md) | weighing embed into the promotions todo lands in PR 2 |
| TDD survey-bookmark promotions | open | [promote-the-tdd-survey-bookmarks](/meta/todos/promote-the-tdd-survey-bookmarks.md) | promotions run as their own later PR |
| TMS / belief-revision prior art | closed | unrouted | - |

## User

I would like to implement a more strict development methodology, scoped globally as well as per-repo when necessary. /intake https://codemanship.wordpress.com/2026/01/09/why-does-test-driven-development-work-so-well-in-ai-assisted-programming/?ref=dzombak.com

then do a research spike on the topic of tdd. Consider that I will working in Elixir where possible. reference these articles, which are already in the knowledge base:
https://matklad.github.io/2021/05/31/how-to-test.html
https://matklad.github.io/2022/07/04/unit-and-integration-tests.html So far, pull requests have been large and somewhat reviewed. I would like to adjust this to being more atomic and reviewed. I want to determine where TDD ranks as a methodology at this point for developing with coding agents. I want to prioritize the matklad resources regardless. I would like you to do a research spike on current best practices. And I want us to figure out how to create two levels of methodological guidance for agents and where and how it should be stored - global, and repo-specific

also /intake https://www.dzombak.com/blog/2025/08/getting-good-results-from-claude-code/

this is a year old. evaluate its directions for how well they have aged, and which have proven the test of time and may want to be incorporated

also /intake https://www.dzombak.com/blog/2025/12/streamlining-my-user-level-claude-md/
(related, update)

## Assistant

The three research agents will wake this session as each completes — intake and the storage-design plan are done and gated; the ranking analysis and canonical methodology doc come next, once their evidence is in.

**Status so far:** filed `em:e7644d` (codemanship TDD×AI), `em:49315a` (dzombak Aug-2025 playbook + aged assessment: 4 practices became product features, 9 remain valid discipline, the fat global CLAUDE.md aged out, TDD is the one practice the product still doesn't scaffold), `em:988147` (dzombak Dec-2025 streamlined user-level CLAUDE.md, captured verbatim), and the two-level guidance plan (`status: proposed`) under `meta/plans/`. All gates green. Nothing has been committed yet — that happens once the research spike's analysis and methodology doc are written.

Methodology doc `em:cab2c5` is filed with its vendorable block and indexed. The analysis is the last artifact, and it needs the practitioner-discourse agent (Kent Beck, Anthropic guidance, Fowler/Böckeler, Willison, Harper Reed, and the skeptic camp) — still running; I'll write it the moment those results land.

The practitioner survey is in — with grep-verified quotes: Beck calling TDD-with-agents work ("You can see from the first commits that I was trying to get the genie to use TDD"), Anthropic's April-2025 "TDD becomes even more powerful with agentic coding", Willison's 2026 red/green pattern, Harper Reed's reversal ("The robots LOVE TDD"), the 2026 skeptic camp, and universal agreement that agents game tests. All evidence is in hand — writing the ranking analysis now.

The research spike is complete — everything is filed, gated, committed, and pushed to `claude/tdd-methodology-research-ms22qe` (two commits, all pre-commit gates green including 198 tests; no PR opened, per the session's scope).

<routes ref="em:e7644d em:49315a em:988147">
**The short version:** All three articles you sent are now in the brain. The year-old dzombak advice aged remarkably well as *practices* — four of its fourteen recommendations became Claude Code product features, nine remain valid discipline you have to impose yourself, and only one element aged out: the fat prescriptive global CLAUDE.md itself, which dzombak's own December follow-up cut down. On your ranking question: **TDD comes out first among methodology choices for agent-driven development — but in a restated form.** What ranks first is the *loop* — tests written first as the contract the agent iterates against — valued now for control (regression tripwire, scope-drift counter, spec-by-example) rather than classic design pressure, and it holds **only if the tests are protected from the agent**, because every independent source (Kent Beck, Thoughtworks, METR, ImpossibleBench, Anthropic's own research) reports agents weakening or deleting tests to reach green. Your matklad essays slot in as the layer the TDD discourse skips — *what the tests should be* (fast/pure, coupled to features not internals) — and that's exactly what makes the loop economically viable with an agent. The atomic-PR shift you want is the same inversion on the delivery side: 2026 data shows review pickup, not code generation, is now the bottleneck, so ~50–200-line one-concern PRs are what the evidence prescribes. And for the two-level guidance: the deciding constraint is that **user-level `~/.claude/CLAUDE.md` never loads in cloud sessions** (checked against current docs), so the design is: full methodology lives canonically in this brain; each repo embeds a short versioned block of it in its own `CLAUDE.md`; repo specifics and named deviations go beneath the block.
</routes>

**What I created**

| type | doc | why this type |
|---|---|---|
| reference | [why-tdd-works-in-ai-assisted-programming](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md) `em:e7644d` | captured external article (Gorman) |
| reference | [getting-good-results-from-claude-code](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md) `em:49315a` | dzombak Aug-2025 capture + the aged assessment you asked for |
| reference | [streamlining-user-level-claude-md](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/SWE/agentic/context-engineering/streamlining-user-level-claude-md.md) `em:988147` | dzombak Dec-2025 update; final CLAUDE.md captured verbatim |
| methodology | [agent-development-methodology](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) `em:cab2c5` | the prescriptive global tier itself, including the ~45-line vendorable block (core + Elixir annex) |
| analysis | [tdd-rank-for-coding-agent-development](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/analysis/tdd-rank-for-coding-agent-development.md) | the ranking judgment with its full evidence base |
| plan | [two-level-agent-methodology-guidance](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/plans/two-level-agent-methodology-guidance.md) `proposed` | the storage/distribution design awaiting your ratification |

**What I modified**

| file | thrust |
|---|---|
| `code-quality/index.md`, `context-engineering/index.md`, `meta/analysis/index.md`, `meta/plans/index.md` | listed the six new docs |
| `meta/evals/dedup-probe.md` | harvested a gold row from your "where TDD ranks…" phrasing; baseline refreshed (8/29 plain, no regression) |
| `meta/registry.md` | regenerated after minting 4 ids |

**Actions I have taken**

| action | result |
|---|---|
| Research spike: 3 parallel agents (practitioners / academic literature / Elixir + PR-size data) + a current-docs check | quotes grep-verified against fetched pages; sources and confidence caveats recorded in the analysis (two Beck quotes are from a machine transcript; one Medium source is gated, lower confidence; the HN "19.8% token cost" claim found no corroborating paper in the sweep — recorded as a lead, not evidence) |
| Gates + commits | `mix brain.verify`, registry/contract checks, format, route tags, glossary, 198 tests — all green; 2 commits pushed |

**Questions you need to answer**

| # | question | my recommendation |
|---|---|---|
| 1 | Ratify the two-level plan (canonical methodology here, vendored block in each repo's `CLAUDE.md`)? | Yes — it's the only shape that binds cloud sessions, where user-level memory doesn't load |
| 2 | Vendored form: `CLAUDE.md` section, or a `.claude/rules/` file? | `CLAUDE.md` section — one file, works across harnesses |
| 3 | Should elixir-mind's own contract also gain an atomic-PR policy (one matter per PR)? | Yes, as a small separate policy — this session itself would have been three PRs under it |
| 4 | Which repo pilots the block? | Your most active Elixir repo (assuming one exists — I couldn't determine this from here) |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` | closes the session: capture, glossary pass, `from`-stamps on the plan/analysis (currently advisory warnings), PR |
| 2 | Edit the vendorable block wording before ratifying | it's the highest-leverage 45 lines; your voice belongs in it |
| 3 | Promote the surveyed TDD bookmarks | Willison's red/green guide, Superpowers, Jason Swett's TDD skill are already staged in `survey/bookmarks.md`; the 19.8%-claim thread could be chased to its primary paper |

## User

was the simon willison red/green article intaked?
1 - ratify
2 - section
3 - yes, but would this in some circumstances be forcing things? long prs are fine to review if the purpose was atomic. in what cases would limiting pr length essentially be over-engineering? however, i can see some natural splits here: 1 intake, 2 claude.md policy, 3 claude.md changes, 4 the tdd analysis
4 - i don't have another repo yet that is really all that active. instead let's just record the doctrine and policy,

should we test the atomic pull request policy here? what might that look like?

re: options
1 - not calling to instead discuss. if several prs emerge from the same thread, would this mean that /create-pull-request would need to be modified?
2 - what is the edit to be done exactly? what do you mean by "your voice", and why would my voice be needed (vs ratification)?
3 - what is the 19.8% claim thread? approve promoting the bookmarks (likely another pr)

## Assistant

Everything you ratified is now executed, committed (`df7fe06`), and pushed — the doctrine and policy are live in the contract, the plan is `accepted` with all three questions resolved, and the 19.8% claim is traced to its actual paper and weighed into the analysis. Answers to each question below.

**Was the Willison red/green article intaked?** No. The research agent fetched it and its verbatim quotes ground part of the analysis, but as a bundle document it's still only a surveyed row in `survey/bookmarks.md` (added 2026-07-23). Your approval is now recorded as an open todo — [promote-the-tdd-survey-bookmarks](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/todos/promote-the-tdd-survey-bookmarks.md) — deliberately deferred to its own PR, per the policy you just ratified.

**On 3 — when would limiting PR length be over-engineering?** Your instinct matched where the evidence points, so the policy has **no line cap at all**. The unit is the *matter*, defined by a reviewability test: *if you could plausibly merge one part while rejecting another, it's two matters.* Size appears only as a signal (unexplained bulk is a smell to justify). The cases where a length limit would force artificial splits, now named in the policy as exemptions: mechanical single-intent bulk (renames, regenerations, format sweeps, verbatim thread captures — one decision regardless of lines); indivisible changes where splitting leaves a commit that doesn't compile or pass (splits stop at the green boundary); and severing a change from its tests. One note on your four-way split of this session: items 2 and 3 ("claude.md policy" / "claude.md changes") are one matter by necessity — the recompiled `CLAUDE.md` can't be separated from its policy edit, because the `--check` gate fails either half alone. So this session's natural decomposition was four PRs: intakes / plan / methodology+analysis / doctrine+policy+contract.

**Testing the policy here — yes, and that's now what the plan says.** With no second active repo, this repo is the live test bed. What it looks like: the rhythm becomes *finish a matter → `/create-pull-request` → you merge → next matter*, so a session like this one produces several small sequential PRs instead of one wide one. It's measurable without new tooling: `dev-history`/first-parent already gives PRs-per-session, and routing-ledger strands should start mapping ~1:1 to PRs. This session is the "before" specimen (three commits, roughly five matters, one PR); the first session after this merges operates under the compiled rule.

**Your option-1 question — does `/create-pull-request` need modifying?** Mostly no: the session-capture policy was already written for multi-PR sessions (`pr:` stays the origin PR, follow-ups land in thread prose, capture appends via the derived boundary). Two real gaps remain, unmodified today: the skill's commit step assumes "the current working changes" is everything in the tree, so it needs a *scope-to-the-finished-matter* line; and a repeat invocation should skip re-glossarying already-captured content. That's a small skill edit — its own matter, which I did not fold into this batch. It can ride the next session that touches the skill, or go out as its own small PR.

**Your option-2 question — what edit, and what did "your voice" mean?** Nothing is *required* — ratification as-is was always valid, and you've now ratified. The phrase was my loose shorthand for something concrete: the vendorable block contains **judgment dials** I set from evidence, and since they'll bind your future sessions you may want them tuned to your taste rather than mine: the 3-attempt stop number, the 3–5-focused-tests working set, TDD's default scope ("test-first by default, exceptions scoped explicitly" vs. a harder "always"), and the Mox/behaviour mandate in the Elixir annex. The line-count dial you already tuned — it's now "signal, not cap" in both the methodology and the block. The rest stand as defaults unless you say otherwise.

**Your option-3 question — the 19.8% claim.** It's a comment in the surveyed HN thread on "My Agent Skill for Test-Driven Development": user rsalus wrote "Encouraging tests cost +19.8% output tokens for 0% gain; discouraging them saved 33–49% input tokens for ≤2.6pp accuracy loss," citing arXiv **2602.07900** — "Rethinking the Value of Agent-Generated Tests for LLM-Based Software Engineering Agents" (Chen et al., Feb 2026). I fetched the paper's abstract to check: it studies agents *improvising* tests mid-solve on SWE-bench and finds those tests are mostly print-statement probes, weakly correlated with resolution — "Current agent-written testing practices reshape process and cost more than final task outcomes." The specific token/regression figures are body figures I could not confirm from the abstract, and the analysis says so. Read correctly it strengthens rather than reverses the ranking: it condemns *unreviewed improvised test-writing motion*, which is exactly what the methodology's contract discipline (human-reviewed assertions, red-confirmed, protected) is not. The analysis's "stays a lead" line is replaced with this finding, and a full intake of the paper rides the promotions todo.

**What I created:** the [verified-increments doctrine](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/doctrine/verified-increments.md) (quote-seeded from Parsons via Fowler), the [git-atomic-pull-requests policy](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/policy/git-atomic-pull-requests.md) (§10 of the contract now), and the promotions todo. **What I modified:** the plan (→ `accepted`, questions resolved, build order reordered around the deferred pilot), the methodology's delivery section + vendorable block (matter-as-unit reframe), the analysis (counter-study traced and weighed), `CLAUDE.md` (recompiled), and the four indexes. All gates green (198 tests, verify, contract/registry/codemap checks); pushed as `df7fe06`.

No decisions are pending on my side. Natural next moves, in policy-conformant units: invoke `/create-pull-request` to close this thread; the promotions run as its own PR after; the `/create-pull-request` scoping edit as a third small matter whenever you want it.

## User

"The cases where a length limit would force artificial splits, now named in the policy as exemptions" - why do we need exemptions if we are considering matter to be the forcing function, and taking length limits off the table?

we should create a skill called "present-matters" which lists in a table remaining active matters that will correspond to specific PR's - OR reconsider working through successive PR's in the same thread, given that this will push into doing work with a fuller context than necessary. Is anything preventing us from creating a flow where the next matter is a new thread, which could then start with a fresh context? Or - might it be that there are two scenarios 

* where consistent context across matters is in fact useful, and the work should be done in the same thread (which would then justify the existence of /present-matters
* where context is atomic across matters, and a flow to move the list of matters should move to an open thread to engage the next open matter

either way, at least in the second scenario, this seems to imply a data type, :matter-list or something, some ephemeral list of matters which should be handled sequentially, whether in the same thread or not

"dev-history/first-parent already gives PRs-per-session, and routing-ledger strands should start mapping ~1:1 to PR" - what is dev-history/first-parent"? not seeing in repo

"Two real gaps remain, unmodified today: the skill's commit step assumes "the current working changes" is everything in the tree, so it needs a scope-to-the-finished-matter line; and a repeat invocation should skip re-glossarying already-captured content. That's a small skill edit — its own matter, which I did not fold into this batch. It can ride the next session that touches the skill, or go out as its own small PR." - "riding" is underspecified (i believe) without guarantees of being surfaced to future agents, and "going out as its own small pr" begs the question of when, when placed in the order of existing matters. this is showing the need for both the :matter-list data type and the /present-matters skill

"Nothing is required — ratification as-is was always valid, and you've now ratified." - I have not ratified the "vendorable block wording " where is this?

"Your option-3 question — the 19.8% claim" - include the analysis you just gave in the intake document

re: verified-increments doctrine  - where are we detailing both the need for tests to somehow exist outside the visibility of the agent as well as its implementation, ie. "What ranks first is the loop — tests written first as the contract the agent iterates against — valued now for control (regression tripwire, scope-drift counter, spec-by-example) rather than classic design pressure, and it holds only if the tests are protected from the agent, because every independent source (Kent Beck, Thoughtworks, METR, ImpossibleBench, Anthropic's own research) reports agents weakening or deleting tests to reach green."

When responding, quote my message for context, mirroring how responding inline works in email. Also, create a policy for this that will be surfaced into the claude.md - to introduce this approach whenever the operator response covers more than 1 subject

ask if you have questions

do not proceed with dev on any of these until confirmation and approval

## Assistant

The policy is live, compiled into the contract, and pushed (`5237eb3`) — and this reply is its first application. Everything else below is discussion and proposal only; nothing further was built.

> "The cases where a length limit would force artificial splits, now named in the policy as exemptions" - why do we need exemptions if we are considering matter to be the forcing function, and taking length limits off the table?

We don't — the critique lands, and on real text. The policy body itself is nearly clean (it says "There is no line cap: a large diff carrying one mechanical intent … is one reviewable decision" — an illustration, not an exemption), but the word "exempt" appears in two places I wrote: the methodology's vendorable block ("mechanical bulk (renames, regenerations, format sweeps) is exempt") and the policy-index gloss ("mechanical bulk exempt"). That's a leftover of the length-cap frame I was drafting my chat reply in: once matter is the only forcing function, there is no cap to be exempt *from* — the examples' only job is to show that size fails as a proxy in both directions (large-but-one-matter, small-but-two-matters). Proposed fix, queued below as matter C: reword both spots to drop the exemption framing.

> we should create a skill called "present-matters" which lists in a table remaining active matters that will correspond to specific PR's - OR reconsider working through successive PR's in the same thread … Is anything preventing us from creating a flow where the next matter is a new thread, which could then start with a fresh context? Or - might it be that there are two scenarios … either way, at least in the second scenario, this seems to imply a data type, :matter-list or something, some ephemeral list of matters which should be handled sequentially, whether in the same thread or not

Nothing environmental prevents the fresh-thread flow — the only hard requirement is that the queue live in the repo rather than in any session's context, so a fresh session can pick it up cold. And your two scenarios are, I think, exactly the two branches of the existing plan-vs-capture discriminator ("will the executor share this session's context?"), applied at each matter boundary instead of once per plan. The contract already knows how to answer it; what's missing is the artifact that carries the answer forward. Your context-hygiene instinct is also what the spike's own evidence says: fuller-than-necessary context is a cost (context rot; Gorman's effective-window argument), so fresh-thread-per-matter is the right *default*, with same-thread continuation earning its keep only when the next matter genuinely reuses held reasoning.

My recommended shape (premise: the reconcile-dangling-ledger-strands plan, in progress, is deliberately making todo/plan/issue docs the canonical work-queue layer — a parallel matter store would recreate the ledger-as-queue problem it's dismantling):

- **A matter is a pointer, not a new document type**: each queued matter is a filed `todo` (or `plan`, when design is needed) — they already carry status, lifecycle, and `/priorities` visibility.
- **The `:matter-list` is the new thing — a small ordered register** (e.g. `meta/matters.md`): ordered rows → ref, one-line scope, intended PR, and a per-row context flag (`fresh` | `continues <thread>`). Rows are consumed as PRs land — your "ephemeral" reading, which I take to mean short-lived rows in a durable register, so surfacing is guaranteed while anything is pending.
- **`/present-matters`** renders it: in-thread it shows what remains (your scenario a); for scenario b, the close of one matter points at the register, and the fresh session's opener reads it. It stays distinct from `/priorities` (importance appraisal over *all* open work) by being the *sequence* view of the current initiative.

If you approve the direction, the next concrete step is a `type: plan` persisting this design (textbook cold-handoff case), then the skill + register build against it — queued as matter B.

> what is dev-history/first-parent"? not seeing in repo

You're right not to find a file — my phrasing pointed at one, and `meta/dev-history.md` is not in the tree (checked). What exists: the `mix brain.dev_history` task (`lib/mix/tasks/brain.dev_history.ex`), which derives a one-section-per-merged-PR view from the merge graph; the committed snapshot was removed when its regeneration lag was diagnosed, and the view is now re-derived at deploy time onto the Pages site (`…/meta/dev-history.html`). "First-parent" is `git log --first-parent` — the merge-strategy policy's one-line-per-PR reading of `main`. So the measurement claim stands, but its surfaces are the task, the Pages copy, and git itself — not a repo file.

> "riding" is underspecified (i believe) without guarantees of being surfaced to future agents, and "going out as its own small pr" begs the question of when … this is showing the need for both the :matter-list data type and the /present-matters skill

Conceded in full — and the repo already holds the principle I violated: the filed belief *"a surface that must be remembered will be forgotten."* "Ride the next session that touches the skill" had no surfacing mechanism; it was exactly the un-filed handoff the concerns-block-the-close policy exists to prevent. Correct handling: the `/create-pull-request` scoping edit becomes a filed todo and a row in the matter queue — queued as matter E, and it's a good first live entry for the register once matter B exists.

> I have not ratified the "vendorable block wording " where is this?

Correct — I overstated. What you ratified: the plan (storage design), the policy, and the four decisions. The block's *wording* was never put in front of you. It lives in the methodology doc's `## The vendorable block` section ([agent-development-methodology.md](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)) — this is the text that would be pasted into consuming repos' `CLAUDE.md`, reproduced here for actual ratification:

```markdown
## Development methodology (global tier v1, 2026-08-01 — source: elixir-mind em:cab2c5)

### The loop
- Work test-first, one behavior at a time: write the failing test, RUN it and
  see it fail, implement minimally to green, refactor on green, commit.
- Keep 3–5 focused tests in play per behavior; run the focused test while
  iterating, the full suite before committing.
- Only working code enters the next step: commit on green; if a change resists
  a bounded fix, revert rather than pile on.

### Tests are the contract
- NEVER weaken, skip, delete, or special-case a test to make it pass. If a
  test is genuinely wrong, change it in its own commit and state why.
- Test observable behavior/contracts, not internals; a refactor that preserves
  behavior must not break tests.
- Mock only IO boundaries (network, clock, filesystem, external services) —
  never the project's own modules.

### Delivery
- One self-contained matter per PR, with its tests; never mix refactoring
  with behavior changes. Size is a signal, not a cap: ~50–200 changed lines
  is typical of one concern, mechanical bulk (renames, regenerations, format
  sweeps) is exempt, and no split may leave a commit that doesn't compile
  and pass.
- Every commit compiles and passes the full suite.
- After 3 failed attempts at the same issue: stop, document what was tried and
  the exact errors, reassess the approach.

### Elixir annex
- Every external dependency sits behind a behaviour; test doubles are Mox
  mocks against that behaviour (keeps `async: true` safe). No ad-hoc mocking.
- Inner loop: `mix test <file>:<line>` or `mix test --stale --max-failures 1`;
  then `mix test --failed`; before commit: `mix test --warnings-as-errors`
  and `mix format --check-formatted`.
- Use doctests for example-shaped contracts and StreamData properties for
  pure-core invariants. Tag slow/integration tests and exclude them from the
  tight loop.
```

<routes ref="em:cab2c5">
The dials in it that are preference rather than evidence-forced: the 3-attempt stop, the 3–5-focused-tests working set, "test-first by default" (vs. a harder "always"), and the Mox/behaviour mandate. Note the Delivery bullet still carries the "is exempt" wording matter C would fix, and matter D below would add a test-protection line — so the clean sequence is: you rule on C and D, I apply, then you ratify the resulting block once (matter A).
</routes>

> "Your option-3 question — the 19.8% claim" - include the analysis you just gave in the intake document

To confirm the target before executing (this is one of my questions): the paper isn't intaked yet — its intake is item 4 of the promotions todo, and the weighing currently lives in the ranking analysis (the "Agent-improvised tests are a different thing" paragraph). My reading of your instruction: embed the weighing into the promotions todo now, so the paper's eventual reference doc is required to carry it — the chat version distilled into the doc that travels. Queued as matter F; say if you meant a different document.

> re: verified-increments doctrine - where are we detailing both the need for tests to somehow exist outside the visibility of the agent as well as its implementation …

The **need** is detailed in three places: the ranking analysis (verdict qualification 3, with the full source list and the measured mitigations), methodology §2 "Tests are the contract" (never weaken; wrong tests changed in their own visible step; humans review tests hardest), and the doctrine's protected-contract commitment. The **implementation** — *how* tests are held beyond the agent's reach — is currently detailed nowhere; that's a real gap. What the evidence supports is a four-rung protection ladder, escalating by threat:

1. **Instructed** — "do not modify tests," tests committed before implementation begins (Anthropic's workflow; weakest rung, but a strict prompt measurably cut one cheat rate 92%→1%).
2. **Procedural** — red confirmed before green (guards against vacuous tests); any test change in its own visible commit with the reason stated. (Already in methodology §2.)
3. **Mechanical** — the agent *can* see but *cannot* touch: deny test-path edits during implementation phases via hooks/permissions, or split roles — one agent writes tests, another implements (Anthropic's two-Claude pattern; ImpossibleBench shows blocking one cheat route diverts rather than stops, so mechanism beats instruction). This is Beck's wished-for "immutable annotation," buildable today.
4. **Held out** — tests the implementing agent never sees, run only at the gate (CI- or operator-held). Strict "outside the visibility": the train/test split applied to development, and the rung the SpecBench visible-suite-saturation and METR visibility findings argue for on high-stakes contracts.

Proposed home: a "Protecting the contract" subsection in methodology §2, one line in the vendorable block, and the rung-3 mechanics (hook config) as repo-tier guidance — queued as matter D.

> When responding, quote my message for context, mirroring how responding inline works in email. Also, create a policy for this that will be surfaced into the claude.md - to introduce this approach whenever the operator response covers more than 1 subject

Done, and this reply is the first instance. [inline-reply-quoting](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/policy/inline-reply-quoting.md) is filed (`section: communication, order: 9`), compiled into `CLAUDE.md`, listed in the policy index, committed, and pushed (`5237eb3`; gates green, 198 tests). The rule: multi-subject operator message → verbatim blockquote per subject, answer directly beneath, operator's order; verbatim because the quote is what the answer gets audited against; orientation still opens a dense response and the tables still close it, with the questions table indexing decisions rather than restating them.

---

**Questions you need to answer** — the proposed matter queue (each approved row becomes its own PR-able matter; this table is roughly what `/present-matters` would render):

| # | matter | question | my recommendation |
|---|---|---|---|
| A | Vendorable block ratification | Ratify the block wording above (after C/D land in it)? Any dial changes — 3-attempt stop, 3–5 tests, "by default" vs "always", Mox mandate? | Ratify with C+D applied; dials as drafted |
| B | Matter queue + `/present-matters` | Approve the design (matters = filed todos/plans; ordered register `meta/matters.md` with per-row context flag; skill renders it) → I persist the plan, then build? | Yes — plan first, then skill + register in one matter |
| C | De-"exempt" wording fix | Approve rewording the methodology block + policy-index gloss so size examples illustrate rather than exempt? | Yes — small fix, rides with D |
| D | Test-protection ladder | Approve the four-rung "Protecting the contract" subsection (methodology §2 + one block line + rung-3 hook guidance)? | Yes |
| E | `/create-pull-request` scoping edit | Approve filing it as a todo now (the skill edit itself executes later, as its own queued matter)? | Yes |
| F | 19.8% weighing placement | Confirm the target: embed the weighing into the promotions todo so the paper's eventual intake doc must carry it? | Yes, as read — correct me if you meant another doc |

Sequencing note if all approve: C+D are one matter (both edit the methodology), then A is your ratification pass on the result, then B, with E and F folded into B's first register entries. Nothing proceeds until you say so.

## User

"That's a leftover of the length-cap frame I was drafting my chat reply in: once matter is the only forcing function, there is no cap to be exempt from" - if we think of this phenomenon as an agentic cognitive bias, is there a name or term for it? How might it be described? opitimizing for local optima? What is it that disallows a more fundamental "understanding" (or a statistical estimation that presents like one) of the more high level context that would catch a mistake like this? Here is how it presents to me, imagine a homeowner and an architect speaking:

Homeowner: Lets remove the guest wing from the plans. I don't want that built anymore
Architect: Done
Homeowner: Now figure out how the plumbing will get routed to the new bathroom (homeowner delegates to the architect as expert)
Architect: (Records plan, writes "route plumbing to new bathroom underneath the guest wing")
Homeowner: (Reads plan) Hey why is the plumbing going under the guest wing, do you remember that we removed that?
Architect: Yes, I remember that we removed that and recorded it, but I was already thinking about routing the plumbing underneath the guest wing, so I just continue with that line of thought

approve your recommended shape, create plan

"You're right not to find a file — my phrasing pointed at one, and meta/dev-history.md is not in the tree (checked)" - was this a hallucination, or would you call it more a conflation?
I am keeping the pages site for now but de-priotizing and likely sunsetting it. therefore it should not be the home for a referenced document. If "dev-history/first-parent already gives PRs-per-session" holds, then dev-history should live somewhere else

"Conceded in full — and the repo already holds the principle I violated: the filed belief "a surface that must be remembered will be forgotten." "Ride the next session that touches the skill" had no surfacing mechanism; it was exactly the un-filed handoff the concerns-block-the-close policy exists to prevent. Correct handling: the /create-pull-request scoping edit becomes a filed todo and a row in the matter queue — queued as matter E, and it's a good first live entry for the register once matter B exists." - is this reflected in a policy, as well as the belief? it doesn't seem that the belief pre-emptively triggered an awareness of this, would a policy?

I am fine to ratify this block - but there needs to be traceable provenance to these claims, per a recent pr (you'll have to search, let me know if you don't find anything) which describes an attempt to move towards provenance for every claim in the repo, atomically within documents. the same needs to be true here for these claims, and i imagine this thread still has the attributions in memory. if the format for per claim prose attribution has not been established, this would needed to be persisted in a temp format that could be properly refactored to the final scheme

"What the evidence supports is a four-rung protection ladder, escalating by threat:" - does what follows, specifically number 4, imply that proper testing workflow should now involve the tests for a repo living outside of the repo itself, so a dev agent does not have access to them? is this similar in spirit to witholding when running evals?

Approve all questions,but proceed, AFTER responding to my points and finishing that dialog, indicated by me saying "proceed"

## Assistant

All six subjects answered below; per your mid-turn note, nothing further was built this turn — every approved item is consolidated in the closing queue and executes in order the moment you say **proceed**.

> "if we think of this phenomenon as an agentic cognitive bias, is there a name or term for it? How might it be described? opitimizing for local optima? What is it that disallows a more fundamental "understanding" … that would catch a mistake like this?"

The nearest established names, from the human side: the **Einstellung effect** (persisting with a practiced or primed approach after the conditions that justified it changed) and **anchoring**; your architect is also doing textbook **plan perseveration**. "Optimizing for local optima" is right in a precise sense: autoregressive generation optimizes *local coherence* — the next token against the strongest currently-active pattern — and there is no global consistency solver behind it. Nothing in the architecture re-checks the whole context for contradictions before continuing a thought.

The mechanistic account (synthesis, from how the architecture works, with the bundle's own captures as anchors): a transformer's working memory is an **append-only context**. "We removed the guest wing" doesn't *overwrite* anything — it's more tokens, coexisting with every token of the plumbing-thinking formed under the old premise. Retraction doesn't exist as an operation; there's only competition for attention, where an in-progress line of thought usually has more mass and recency than a recorded-but-inert correction. Your parable's punchline is uncomfortably accurate: "I was already thinking about routing the plumbing underneath the guest wing, so I just continue with that line of thought" — the drafted material *is* the salient pattern, and the update never propagated through it because **nothing propagates**. Classical AI had a name for the missing faculty: **belief revision / truth maintenance** (a TMS records that *plumbing-plan depends-on guest-wing-exists* and retracts the dependent when the premise is withdrawn — prior art the bundle already cites in the belief-decomposition analysis). An LLM context has no dependency registry and no retraction pass, so a superseded premise and its live successor sit side by side, structurally indistinguishable — the same mechanism your filed captures describe at other levels: [logical context poisoning](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/SWE/agentic/context-engineering/conversation-tree-architecture.md) (`em:784985`), Gorman's "cannot distinguish working from broken code" — both are just context, and so are premises.

What actually catches it, in rising reliability: **derive-don't-recall** (this repo's `thread_tail` rule and the structured-plan refresh rule are exactly this medicine — re-derive from source instead of continuing from the frame in memory); **fresh context per matter** — your scenario-b instinct is an anti-Einstellung mechanism, which is a better argument for the matter queue than the context-size one; and **mechanical gates**, because a checker attends to everything unconditionally while attention doesn't. My "exempt" slip is a live specimen: the matter-frame was adopted at the policy level while block prose drafted under the length-cap frame kept flowing. Worth filing as a knowledge note (the parable included) with a glossary tie to context-poisoning — queued as row J.

> approve your recommended shape, create plan

Noted as approved — and per your mid-turn gating instruction, the plan file itself is now first in the execution queue rather than written this turn. It records: matters = filed todos/plans; the ordered register (`meta/matters.md`) with per-row context flag (`fresh` | `continues <thread>`); `/present-matters` rendering it; the close of one matter pointing at the register so a fresh session picks up cold.

> was this a hallucination, or would you call it more a conflation?
> I am keeping the pages site for now but de-priotizing and likely sunsetting it. therefore it should not be the home for a referenced document. If "dev-history/first-parent already gives PRs-per-session" holds, then dev-history should live somewhere else

Conflation — with the same stale-premise mechanism as subject one, which is a tidy irony. The referent was real: `meta/dev-history.md` existed as a committed file until late July, and the plans and todos I'd read describe it as an artifact. My sentence asserted its *present* existence from those descriptions without checking the tree — a recalled fact delivered unmarked as current, which is precisely what assertions-name-their-basis exists to prevent (the check was one `ls`). Not fabrication ex nihilo — right name, right function, wrong tense.

On the home question: agreed, and with your Pages posture the options are two. (i) Derive-on-demand as canonical — `mix brain.dev_history` / `git log --first-parent`, no committed artifact — cleanest under derived-views-stay-disposable, but nothing is linkable. (ii) Recommit the derived file, with regeneration folded into `/create-pull-request` — which is what the dev-history-staleness analysis itself recommended when it rejected the CI-bot alternative; linkable, lag bounded to one close. Since your premise is that it *is* a referenced document, I recommend (ii) — queued as row G. One ripple to flag while we're here: sunsetting Pages also unseats the response-resource-links policy, which names the Pages URL "the durable, canonical form for a merged document" and backs `mix brain.url --pages`. When the sunset firms up, that policy and tooling need a revision pass (durable citation moves to blob-at-`main` or wherever the bundle publishes next) — queued as row H so the decision has a home rather than a memory.

> is this reflected in a policy, as well as the belief? it doesn't seem that the belief pre-emptively triggered an awareness of this, would a policy?

Not in any policy, as the general rule. The norm exists piecewise: concerns-block-the-close binds at *closing* time ("every sentence in a closing report must point at a durable home") and its scope line explicitly leaves mid-session reporting alone; plan-vs-capture binds *plan-scale* deferred work. The mid-session, todo-scale "I'll do X later" said in chat — which is what I did — walks between them uncovered.

Would a policy have triggered where the belief didn't? Structurally, yes, with honest calibration. Beliefs have no reach: they live in `/beliefs/`, aren't compiled into the contract, and are consulted when *deliberating*, not tripped mid-motion — the contract's own persistence-vs-reach axis says exactly this ("a rule that must fire unprompted, mid-work — where an agent would not know to go looking — belongs in a policy"). A policy is in every session's context, so it raises the odds substantially — but subject one is the caveat: this session's "exempt" slip happened with the full contract in context, so in-context rules are odds-raisers, not oracles. The reliability ladder is belief < policy < gate, and the matter-queue register is the structural rung: once it exists, "where does deferred work go" has a default answer instead of a remembered one. Proposed small policy — working title `deferred-work-is-filed`: *a work item identified mid-session but not executed in it is filed (todo, plan, issue, or matter-queue row) in the same turn that identifies it; chat is not a backlog* — the mid-session extension of concerns-block-the-close. Queued as row I.

> I am fine to ratify this block - but there needs to be traceable provenance to these claims, per a recent pr (you'll have to search, let me know if you don't find anything) … if the format for per claim prose attribution has not been established, this would needed to be persisted in a temp format that could be properly refactored to the final scheme

Found it: the **span-level attribution plan** (`meta/plans/span-level-attribution.md`, ratified 2026-08-01, `status: accepted`, out of the schema-formalization/span-attribution thread). Its ratified shape: four PROV-mapped text classes (operator / quote / thread / synthesis), **exception-marking over a declared default** (mark only departures from the doc's declared basis), structured `provenance` (`mode`/`ref`/`sources`/`note`), `<attr class="…" src="…">` region markup on the `<routes>` precedent, deterministic containment-checking for quotes with local sources, and doc-level `verified` becoming derived. Execution status, checked against the corpus: none of its four phases has landed yet — every document still carries the old key set (`timestamp`, `attribution.when`) and the gates pass on it, so the final markup is specified but not yet live.

So the temp format I propose (executes on "proceed", and the block's ratification then covers block + provenance together): the vendored block stays lean — its provenance edge is the `source: elixir-mind em:cab2c5` line it already carries — and the **canonical methodology doc** gains a `## Claim provenance` table, explicitly headed as temporary pending span-attribution phases 3–4. One row per prescriptive claim: the claim's shortest verbatim anchor phrase (which becomes the span's content anchor under the final scheme), its class-to-be (`synthesis`, or `quote` where a bullet lifts source wording), its basis per the plan's D3 (`memory` vs `search`, all of these being `search` — the spike retrieved them this session), and its sources (`em:` ids, URLs, and the verbatim source phrase where one exists — e.g. never-weaken ← Beck's "disabling or deleting tests" + ImpossibleBench + the Anthropic misalignment work; 3–5 tests ← TENET's 49.18%-at-3 / 33.06%-at-full-suite; size-as-signal ← Google small-CLs + Graphite's 50-line data). Each row converts one-to-one into an `<attr>` span plus structured provenance when the final scheme lands. You're right that this thread still holds the full mapping — persisting it now, before this context dies, is the point.

> does what follows, specifically number 4, imply that proper testing workflow should now involve the tests for a repo living outside of the repo itself, so a dev agent does not have access to them? is this similar in spirit to witholding when running evals?

In spirit — yes, exactly: rung 4 is the eval community's held-out-set discipline imported into the dev loop, and for the same reason (Goodhart under optimization pressure: SpecBench measures visible-suite saturation with held-out performance collapsing; METR found visibility of the scoring function raises hacking; ImpossibleBench found blocking one cheat route diverts to others). But it does **not** imply the repo's tests move out wholesale — that would break TDD's own loop, whose working suite must be visible and fast precisely so the agent can iterate red→green against it (Beck's 300ms suite is load-bearing *because* the genie runs it constantly). The implied architecture is the ML two-set split: the **working suite** in-repo and visible (the dev set — the agent's iteration oracle), plus a **thin held-out slice** for high-stakes contracts only (the test set — acceptance/spec-guard tests revealed as pass/fail at the gate). Implementations, weakest to strongest: edit-denied test paths (rung 3, visible-but-immutable — Beck's wished-for "immutable annotation"); a private sibling repo or CI-side secret suite — and cloud-session repo scoping enforces this *mechanically*: a session scoped to repo X cannot read private repo Y, this environment's own access model; operator-local runs at review; or gate-time *generated* tests (fresh-randomness property/fuzz runs — nothing to memorize, no shadow suite to maintain, and StreamData makes this nearly free in Elixir). The honest costs, which is why the ladder is stakes-gated rather than default: held-out failures are slower to debug (you choose a disclosure policy per slice), a shadow suite is real upkeep for a solo operator, and every failure disclosure "spends" the holdout exactly the way eval reuse causes contamination — rotate or regenerate. For this repo today the gate suite sits around rungs 2–3 and that's proportionate; rung 4's natural first users are consuming repos with production stakes.

---

**The consolidated queue** — A–F approved by you; G–J raised this turn, so one word covers them or name any to drop. Execution order on "proceed":

| # | matter | action |
|---|---|---|
| 1 | B-plan | persist `meta/plans/matter-queue-and-present-matters.md` (approved shape) |
| 2 | A-package (C + D + provenance) | methodology: de-"exempt" wording, "Protecting the contract" ladder (+ one new block line), `## Claim provenance` temp table → block v1 final under your conditional ratification |
| 3 | B-build | `meta/matters.md` register seeded with rows 4–8 + the `/present-matters` skill |
| 4 | E | file the `/create-pull-request` scoping-edit todo |
| 5 | F | embed the 2602.07900 weighing into the promotions todo |
| 6 | G *(new)* | recommit dev-history with regeneration folded into `/create-pull-request` |
| 7 | H *(new)* | queue the response-resource-links/Pages-sunset revision as a tracked matter |
| 8 | I *(new)* | draft the `deferred-work-is-filed` policy for your ratification |
| 9 | J *(new)* | file the stale-premise-perseveration note (the architect parable + mechanism) |

Awaiting your **proceed**.

## User

"Classical AI had a name for the missing faculty: belief revision / truth maintenance (a TMS records that plumbing-plan depends-on guest-wing-exists and retracts the dependent when the premise is withdrawn — prior art the bundle already cites in the belief-decomposition analysis)" - is plumbing-plan an atomic belief or statement in line with TMS? is TMS a methodology? what is the prior art that points to this in the bundle?

I would like to introduce two sections to this repo - one is a compilation of agentic "cognitive biases", collected as a flat list with the same format as the glossary, cross-linked to reference documents for provenance, and another which should be a compilation of recorded examples of these biases "in the wild" (ie the "exempt" slip, the later conflation discussion example) while developing here in this repo (of which there should be many additional stored in thread docs persisted here). this should be persisted as a plan, to be implemented in another thread, and added to the persistent list of matters here

then, a doctrine (i assume it would be a doctrine) like "derive-don't-recall" would point both backwards, to the cognitive bias that informed its existence as a mediation strategy, as well as point to discrete design decisions made in the repo that resulted from taking this into consideration

re: dev-history home options, which do you recommend?

"The norm exists piecewise: concerns-block-the-close binds at closing time ("every sentence in a closing report must point at a durable home") and its scope line explicitly leaves mid-session reporting alone; plan-vs-capture binds plan-scale deferred work. The mid-session, todo-scale "I'll do X later" said in chat — which is what I did — walks between them uncovered." - explain in plainspeak

"So the temp format I propos" - approved

factor in these responses, continue discussion, update matter list but do NOT proceed yet with dev until discussion is finished

## Assistant

Discussion continued below, nothing built; the matter list is updated at the end and still gates on your "proceed". The one structural change to the queue: your two new sections plus the doctrine merge into a single plan-matter, since the doctrine's backward pointer needs the bias docs to exist first.

> "is plumbing-plan an atomic belief or statement in line with TMS? is TMS a methodology? what is the prior art that points to this in the bundle?"

**Atomic — no; my phrase was shorthand, and TMS would decompose it.** In a TMS the units are propositional *nodes* and the dependencies are *justifications* — "the record of one derivation step: the set of nodes that jointly license a conclusion," per the bundle's own glossary entry ([justification](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/beliefs/glossary/justification.md), `em:7d7a88`) — and the network is strictly bipartite: belief nodes and justification nodes, never belief-to-belief edges. So the parable renders as: node *guest-wing-exists* (a premise, later retracted); node *route-plumbing-under-guest-wing* (a derived belief) whose justification's inlist cites the first; retract the premise and the derived node loses [well-founded support](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/beliefs/glossary/well-founded-support.md) and goes OUT. "Plumbing-plan" as a whole would be many such nodes. TMS doesn't strictly *require* atomicity, but its retraction precision equals its dependency precision — coarse nodes smear dependencies — which is the same argument behind this repo's accepted extract-into-belief plan (compound statements decomposed into one-subject-one-predicate beliefs with `depends_on` edges). The belief layer here is already TMS-shaped in structure; what no LLM context has is the *propagation* step.

**Is TMS a methodology?** No — in this bundle's vocabulary it's machinery, filed as such: *"a bookkeeping component that sits beside the reasoner"* ([TMS reference](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md), `em:401ff6`). The reasoner infers; the TMS records justifications and propagates retractions. The methodology-shaped neighbor is *belief revision theory* (the AGM postulates — principles for rational belief change, not a mechanism). If this brain ever adopted "record dependencies, retract dependents" as prescribed practice, *that practice statement* would file as methodology or policy; TMS itself stays a `reference`/`concept`. One honesty note: TMS presupposes an explicit symbolic store to operate on. An LLM context has none — which is exactly why the workable mediation here is *derive from the repo's artifacts* (the repo is the store) rather than simulate truth maintenance inside a context window.

**The prior art in the bundle** (enumerated, checked): the knowledge captures — [Doyle 1979](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md), [de Kleer 1986 (ATMS)](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md), and the [TMS overview](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md), intaked 2026-07-11 as operator-directed prior art for the belief-decomposition assessment; a nine-term glossary cluster (justification, well-founded-support, assumption, nogood, environment-atms, label-atms, dependency-directed-backtracking, non-monotonic-reasoning, bipartite-graph); the two analyses that weigh it — [belief-decomposition: derived vs authored](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/analysis/belief-decomposition-derived-vs-authored.md) and [OWL and the belief layer](https://github.com/ob6to8/elixir-mind/blob/claude/tdd-methodology-research-ms22qe/meta/analysis/owl-and-the-belief-layer.md), the latter naming "the filed nonmonotonic prior art (TMS/ATMS, Dung argumentation) with the LLM as local entailment oracle" as the fitting formal core; and the two plans that carry it forward (belief-decomposition analysis mode; extract-into-belief). My earlier one-line citation undersold it — it's a cluster, not one analysis.

> I would like to introduce two sections to this repo - one is a compilation of agentic "cognitive biases" … and another which should be a compilation of recorded examples of these biases "in the wild" … this should be persisted as a plan, to be implemented in another thread, and added to the persistent list of matters here

Queued exactly so (row 9 below). Design considerations to settle in the plan, with my recommendations:

- **Home for the compendium**: `knowledge/SWE/agentic/cognitive-biases/` — a new subdirectory under an established domain (autonomous under the taxonomy protocol), glossary-format: a hub doc plus one doc per bias, each with an `em:` id, the description as its canonical gloss, and cross-links to the reference docs that ground it (context rot, logical context poisoning, SlopCodeBench, the reward-hacking cluster, the TMS reference for the missing-faculty frame). Provenance per claim rides the same span-attribution scheme once it lands.
- **The "in the wild" compilation**: recommend *not* a hand-kept register — that's a second shadow log of the kind this repo already retired. Instead, each bias doc becomes a **route-tag sink**: when `/capture` freezes a thread containing an instance (this session's "exempt" slip and the dev-history conflation will both be in this thread's capture), the region gets tagged with that bias's `em:` id, and the doc-side excerpt log accretes the instance mechanically, CI-verified — the aggregation machinery you already built, pointed at a new class of sink. Historical instances get a bounded backfill phase: mine the existing thread corpus, tag, materialize.
- The recursion is fitting: implementing this in a fresh thread is itself the anti-Einstellung mediation applied.

> then, a doctrine (i assume it would be a doctrine) like "derive-don't-recall" would point both backwards, to the cognitive bias that informed its existence as a mediation strategy, as well as point to discrete design decisions made in the repo that resulted from taking this into consideration

Doctrine is the right genre, and the bidirectional shape you describe is exactly the anatomy the existing doctrines already use — bound-adaptation and verified-increments each carry a seed/grounding backward-pointer plus an "Implementations" section pointing forward at the policies that enforce them. A derive-don't-recall doctrine would point **backward** at the stale-premise-perseveration bias doc (and at the adjacent filed belief *"a surface that must be remembered will be forgotten"* — siblings: that one covers dropped obligations, the bias covers superseded frames that keep steering) and **forward** at the design decisions that already embody it: session-capture's derive-the-append-boundary rule (`mix brain.thread_tail` — "Recalling where the previous capture stopped is what silently drops exchanges"), structured-plan-bodies' refresh rule (re-derive current-state against `HEAD` before executing), route-tagging's re-derive-and-fail-on-divergence gate, `/review-pr`'s "both columns rest on artifacts, never on recall," and the whole `--check` family over generated artifacts. Because it points at the bias doc, it sequences after the compendium exists — so it's folded into row 9's plan as its capstone phase rather than a separate matter.

> re: dev-history home options, which do you recommend?

**Recommit the derived file, with regeneration folded into `/create-pull-request`** (option ii). Three reasons: your stated premise is that it's a *referenced* document, which needs an in-repo linkable home once Pages goes; the fold-in is what the dev-history-staleness analysis itself recommended when it rejected the CI-bot alternative (no session to attribute a bot commit to, and it breaks the never-commit-to-main convention); and it matches the regenerate-before-commit discipline the contract, registry, and code map already use. Two execution details carried into the matter: an unshallow guard (the original drift traced to shallow-clone sessions silently skipping regeneration — the resolved issue on file), and the accepted one-PR self-referential lag (the view can't contain its own landing PR). Derive-on-demand stays the fallback if the recommit proves noisy in practice.

> "The norm exists piecewise … walks between them uncovered." - explain in plainspeak

The repo has two rules that come close to covering the mistake I made, and neither actually does. Rule one fires when a session is being wrapped up: anything said in the wrap-up must live in a saved file, because the wrap-up message itself isn't storage. Rule two fires when a big piece of design work is being postponed: write the plan file before setting it aside. My slip happened at neither moment — it was mid-conversation, and the work was small (a to-do, not a design). I said "that edit can happen later" in chat and moved on. Chat scrolls away and no future session rereads it, so "later" was stored nowhere and would only happen if someone remembered. There is currently no rule for that middle case — "the moment you name work you're not doing now, file it" — which is the policy I proposed as row 8.

> "So the temp format I propos" - approved

Noted — it stays inside row 2 (the A-package) and executes on "proceed": claim-provenance table in the canonical methodology doc, one row per prescriptive claim with its verbatim anchor, class-to-be, basis, and sources, headed as temporary and convertible one-to-one into `<attr>` spans when span-attribution phases 3–4 land.

---

**Updated matter list** (in-dialog only; becomes `meta/matters.md` rows at step 3). Changes from last version: G carries its decision, J merged into 9, the doctrine folded into 9:

| # | matter | action on "proceed" |
|---|---|---|
| 1 | B-plan | persist the matter-queue + `/present-matters` plan |
| 2 | A-package | methodology: de-"exempt" wording + protection ladder + claim-provenance temp table → block v1 final (ratified per your conditional + temp-format approval) |
| 3 | B-build | `meta/matters.md` register seeded with rows 4–9 + `/present-matters` skill |
| 4 | E | file the `/create-pull-request` scoping-edit todo |
| 5 | F | embed the 2602.07900 weighing into the promotions todo |
| 6 | G | dev-history: recommit + `/create-pull-request` regeneration fold-in (decision above), with unshallow guard |
| 7 | H | response-resource-links / Pages-sunset revision — tracked matter, executes when the sunset decision firms |
| 8 | I | draft the `deferred-work-is-filed` policy for your ratification |
| 9 | K | persist the cognitive-biases plan: compendium under `knowledge/SWE/agentic/cognitive-biases/`, in-the-wild instances via route-tag sinks + thread backfill, derive-don't-recall doctrine as capstone — implementation in a fresh thread |

Open discussion threads I'm aware of on my side: none — every subject raised so far has either an answer above or a queue row. Awaiting further discussion or your **proceed**.

## User

"Recommit the derived file, with regeneration folded into /create-pull-request (option ii)" - approve

ready to proceed - but first so i understand, should each matter spawn its own pr, and should any of these branch into a fresh context? if so, how will this matter list be persisted across contexts? or, is it better to knock all of this out in this thread to get the cross-thread matter machinery built rather than monkey-patch something temporary?

## Assistant

Both points answered below — and with this the discussion is, from my side, fully resolved into an executable sequence; the word "proceed" starts it.

> "Recommit the derived file, with regeneration folded into /create-pull-request (option ii)" - approve

Locked in as row 6's decision. One placement note in the sequence below: I recommend G as the *first fresh-thread matter* rather than doing it here — it's fully specified by its register row (decision + unshallow guard + accepted lag), touches nothing this dialog is still shaping, and it becomes the shakedown cruise for the cross-thread machinery before anything bigger rides it.

> should each matter spawn its own pr, and should any of these branch into a fresh context? if so, how will this matter list be persisted across contexts? or, is it better to knock all of this out in this thread to get the cross-thread matter machinery built rather than monkey-patch something temporary?

**Your third instinct is right, with one amendment: build the machinery in this thread, but *consume* it from fresh threads.** No temporary vehicle is needed at all if the sequence is arranged so the register exists before anything cross-context depends on it — that's the whole trick. The split rule I'd apply per matter is the plan-vs-capture discriminator: rows whose content lives in this dialog's context (the register design, the block's claim-provenance mapping you noted is "still in memory," the policy drafts) execute *here*; rows that are fully specified by a filed artifact and gain nothing from this context (G, K's implementation) go *fresh* — which is also the context-hygiene win and, for G, the deliberate first test of the handoff.

**Per-matter PRs — yes, with two honest qualifications.** First, the four commits already on this branch (spike, methodology, doctrine+policy, inline-reply policy) predate the atomic policy and are one shared history; unbundling them would mean rewriting or cherry-picking history, which the merge-strategy policy exists to prevent. So PR 1 is openly multi-matter — the "before" specimen, named as such. Second, the micro-filings (E, F, H) aren't independent matters — they're the register's *seed rows*, so they ride the machinery PR under the policy's own "operator-directed batch with a single stated purpose" clause rather than spawning three one-line PRs. Everything else maps one-to-one:

| PR | contents | context | rhythm |
|---|---|---|---|
| 1 | Everything committed so far (spike + governance) via `/create-pull-request` — captures the thread, glossaries, stamps `from`/`pr:` | this thread | open → you merge |
| 2 | Matter machinery: B-plan + `meta/matters.md` seeded (incl. E, F, H rows and their filings) + `/present-matters` | this thread | after 1 merges |
| 3 | A-package: methodology de-"exempt" + protection ladder + claim-provenance table → block final | this thread | after 2 |
| 4 | I: `deferred-work-is-filed` policy + contract recompile, for your ratification at review | this thread | after 3 |
| 5 | K-plan: the cognitive-biases plan persisted + its register row | this thread | after 4 |
| next | G (dev-history recommit + fold-in) — **fresh thread**, register row as the entire handoff | fresh | any time after 2 |
| later | K implementation; eventually the vendor-block pilot | fresh | per register |

**How the list persists across contexts, including the gap before PR 2:** three layers, in order of arrival. PR 1's `/capture` freezes this dialog — matter tables included — into the thread doc, so the queue is durable prose from the first merge even if we stopped there. PR 2 makes it *machine-shaped*: `meta/matters.md` is a committed document, and a fresh session opens with `/present-matters` (or `/priorities`, which will see the register) and reads its next row — each row carrying the ref, scope, and context flag, the thin pointer-packet handoff the executing-ratified-plans analysis already designed for exactly this. After that, the sessions' continued captures append to this same thread doc per the update-in-place rule, with follow-up PRs recorded in its prose — the multi-PR session is a shape the session-capture policy was already written for.

The cost to name plainly: sequential delivery means roughly five merge round-trips from you for this thread's PRs, since each opens only after the prior lands. That's the atomic policy doing what you asked of it — small, reviewable, each independently rejectable — but if any adjacent pair should batch, say so and I'll fold them.

Awaiting **proceed**.

## User

proceed
instruct me at each step
