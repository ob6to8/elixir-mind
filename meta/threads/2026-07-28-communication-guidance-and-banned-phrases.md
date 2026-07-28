---
type: reference
title: 2026-07-28-communication-guidance-and-banned-phrases
description: The operator commissioned formal communication guidance; the session filed the banned-phrases register and plainspeak-orientation policies, the /ban-phrase skill, and — on ratification — split the prose-composition rules into their own contract section.
provenance: "Claude Code session (Claude Fable 5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, communication, policy, plainspeak, banned-phrases]
timestamp: 2026-07-28
session: https://claude.ai/code/session_018PjkiFACfCNu2LakjRazV5
pr: 165
---

# 2026-07-28-communication-guidance-and-banned-phrases

## Where this landed

The operator asked for standing communication guidance in two parts: an
organically-growing list of banned words and phrases (seeded with "worth
flagging rather than burying" and its reasoning), and a formalized balance
between technical density and plainspeak, motivated by having twice had to
request plainspeak restatements (the 2026-07-27 and 2026-07-28 sessions). The
session researched both incidents, found the response-surface question already
half-answered by the accepted three-level-documentation plan's plain tier, and
filed two policies — [banned-phrases](/meta/policy/banned-phrases.md) (the
register, grown via the new [`/ban-phrase`](/.claude/skills/ban-phrase/SKILL.md)
skill, whose invocation is the ratification) and
[plainspeak-orientation](/meta/policy/plainspeak-orientation.md) (a dense
response opens with a whole plain-language orientation, then the technical
presentation — never phrase-by-phrase interleaving, which stays `/elaborate`'s
job). The operator then ratified a dedicated contract section: six
prose-composition policies moved out of `filing` into section 4,
"Communication — composing responses and prose"
(`ElixirMind.Contract` `@sections`; the scenario test's pinned git-workflow
heading number moved 9 → 10, and the register heading was demoted to H3 so the
inlined policy body cannot inject a sibling of the contract's numbered
sections). Both commits landed on `claude/communication-guidance-style-gtucgm`
(`67a3277`, `b0907d9`) with the full gate suite green, and the session closed
by opening and merging the PR via `/create-pull-request merge`.

The session then continued past its origin PR (#165) as the guidance's first
live exercise, on the branch restarted from the merged `main`. Four
`/ban-phrase` invocations grew the register to five entries (announced
candor + euphemized defect-grading; pre-action hedging with unquantified
gravity, with the announced-candor entry extended by its "straight/upfront"
and enumerated-preamble variants; post-hoc "honest headline" editorializing;
episodic "let me audit rather than answer from memory" diligence narration).
Two operator-supplied failure samples of post-merge trailing reports became
[concerns-block-the-close](/meta/policy/concerns-block-the-close.md) — a
concern held at close time blocks the irreversible step as a question the
operator dispositions; the driving question is verified before the close;
the close persists-or-points because post-capture chat is outside every
record; "for whenever you pick this up" is the named failure signature —
wired into `/create-pull-request` as a concerns gate at step 8 and before
the step-10 merge. The "OR" in the final flag resolved as both: the phrase
banned, and
[assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md)
adopted (checked facts cite what was checked, recalled facts are marked,
scoped to actionable assertions). This second movement landed as a
follow-up PR — see the landing note at the end of this narrative — with the
origin `pr: 165` anchor kept per the write-once rule.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Banned words/phrases register + organic growth skill | closed | [banned-phrases](/meta/policy/banned-phrases.md) | - |
| Plainspeak/technical balance in responses | closed | [plainspeak-orientation](/meta/policy/plainspeak-orientation.md) | - |
| Dedicated `communication` contract section | closed | [policy index](/meta/policy/index.md) | - |
| Close-time trailing notes: concerns, post-merge verification, unhomed handoff context | closed | [concerns-block-the-close](/meta/policy/concerns-block-the-close.md) | - |
| Memory-vs-checked assertion basis | closed | [assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md) | - |
| Register growth: four operator flags in the guidance's first live day | closed | [banned-phrases](/meta/policy/banned-phrases.md) | - |

## User

Would like to create a set of instructions and guidance for communication. One aspect would be a list of banned words and phrases. For example, "Two things worth flagging rather than burying" is an unnecessary phrase that should be banned - It wasn't worth flagging, you wouldn't be mentioning it. And nobody said anything about burying - you don't need to call attention to the negative case that you are not taking. So, this example and this reasoning would be included in the communication guidance document. It means this document would occur organically during discussions. Perhaps we could create a skill that formalizes this.

The Next aspect I would like to formalize is to find a balance of technical communication with plainspeak. If you check the last couple commits and their thread docs or grip plainspeak, you can see situations where I have been unable to follow a dense technical expression. and have had to request a plain speak presentation to understand. Generally, I can then return to the technical presentation and follow it. So what tends to happen is I need to be onboarded to the general thrust before I am encountering terminology that is referencing artifacts or concepts that I'm not holding in my mind at that time. what I'm looking for is some sort of balance between the two. Perhaps it's beginning with plain speak to establish what has just happened or what needs to happen, where the state of the discussion after you have done work followed by a more technical presentation akin to what you would naturally express. I'm not sure if this should be a phrase by phrase breakdown or a full plain speak presentation followed by a more technical presentation.

## Assistant

This is exactly the material needed — both incidents are in the last two threads, and I can even see the near-verbatim source of your banned-phrase example ("Two things worth noting rather than burying", 2026-07-27 thread, line 746). There's also prior art: a `three-level-documentation` plan and glossary term that look directly related to the plainspeak balance question. Let me read those plus the policy/skill formats.

<routes ref="meta/plans/three-level-documentation.md meta/policy/plainspeak-orientation.md">
The prior art is strong: the accepted [three-level-documentation plan](meta/plans/three-level-documentation.md) already ratified a "plain tier" for *documents*, and your request is the *response-surface* sibling of that same idea. And the banned-phrase example ("Two things worth noting rather than burying", 2026-07-27 thread) partially overlaps the existing negate-only-explicit-cases policy — the new list is its phrase-level register. Let me check the policy section/order scheme and skill format before building.
</routes>

Both pieces of communication guidance now exist as policy, compiled into the contract, committed and pushed to `claude/communication-guidance-style-gtucgm`.

In plain terms: there is now a written list of banned phrases that every future agent session reads automatically, seeded with your example and its reasoning. Adding to the list is a one-line command — when I use a phrase you dislike, you flag it, and the flagging itself files the entry. And there is now a standing rule that a dense response must start with a plain-language summary — what happened, where things stand — before the technical version, so you meet the general thrust before the terminology.

<routes ref="meta/policy/plainspeak-orientation.md meta/policy/banned-phrases.md">
On the question you left open — phrase-by-phrase breakdown versus full plainspeak presentation — I decided for **full presentation first, then technical, never interleaved**, and encoded that in the policy. The evidence came from your own two incidents (I found both: the is-to-ought restatement in the 2026-07-27 thread and the dev-history restatement in the 2026-07-28 thread). Both were resolved by whole plainspeak accounts, and you said yourself that afterward you could return to the technical version and follow it — which is exactly the "orientation as runway" shape. Phrase-by-phrase unpacking already exists on demand as `/elaborate`, so building it into every response would duplicate that skill and chop up the technical register. The policy also requires introducing an artifact by what it does before its repo name ("the file that lists every merged PR (`meta/dev-history.md`)"), since your description located the failure at exactly that moment — terminology arriving before the concept it labels.

Two connections to existing governance shaped the design. Your banned-phrase reasoning ("nobody said anything about burying") is the phrase-level case of the existing negate-only-explicit-cases policy, so the register entry links it — and the near-verbatim phrase ("Two things worth noting rather than burying") appears in the 2026-07-27 thread, which is recorded as the seed's origin. And the plainspeak rule is the response-surface sibling of the plain tier your accepted [three-level-documentation plan](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/three-level-documentation.md) ratified for documents; the policy cites it and inherits its one-canonical-level rule (the orientation is a derivation of the technical content, never a second account that can drift).
</routes>

**What I created**

| type | doc | why this type |
|---|---|---|
| policy | [banned-phrases](https://github.com/ob6to8/elixir-mind/blob/claude/communication-guidance-style-gtucgm/meta/policy/banned-phrases.md) | must fire unprompted mid-composition in every session, so it compiles into the contract; holds the register (phrase · generalized pattern · reason · recast), seeded with your example |
| policy | [plainspeak-orientation](https://github.com/ob6to8/elixir-mind/blob/claude/communication-guidance-style-gtucgm/meta/policy/plainspeak-orientation.md) | same reason — a response-shape rule is useless if the agent has to go looking for it; triggers on referential density, exempts conversational turns |
| skill | [/ban-phrase](https://github.com/ob6to8/elixir-mind/blob/claude/communication-guidance-style-gtucgm/.claude/skills/ban-phrase/SKILL.md) | formalizes organic growth: derives phrase/pattern/reason from the flagging exchange, dedups against existing patterns, appends to the register, recompiles the contract; your invocation is the ratification |

**What I modified**

| file | thrust of the change |
|---|---|
| `meta/policy/skills-registry.md`, `meta/policy/index.md` | registered the new skill and the two policies |
| `CLAUDE.md` | recompiled via `mix brain.contract` (generated, not hand-edited) |

**Actions I have taken**

| action | result |
|---|---|
| Full gate suite (format, xref, contract/registry/code-map checks, verify, route tags, glossary, 188 tests) | green; one pre-existing editorial warning on a 2026-07-13 thread, untouched by this change |
| Commit + push to `claude/communication-guidance-style-gtucgm` | `67a3277`, pushed; no PR opened |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` (or `merge`) | lands the guidance; the capture step will stamp this session's thread into both policies' `attribution.from` |
| 2 | A dedicated `communication` contract section | the two policies sit in the filing section beside their siblings (negate-only-explicit-cases, quote-primary-sources); splitting communication rules into their own numbered contract section is a shape change I'd want your ratification for |
| 3 | Seed more register entries now | if other phrases already grate, name them and I'll file them with reasoning before the PR |

## User

2, then 1 and merge

## Assistant

<routes ref="meta/policy/banned-phrases.md">
All tests green, but the compiled contract shows a structural defect: the `## The register` heading inside the banned-phrases policy body renders as a sibling of the contract's numbered section headings — exactly the hazard the three-level plan's design finding 1 recorded. Demoting it to H3:
</routes>

The section split landed and PR #165 was opened and true-merged (`40c9394`), CI green, head branch auto-deleted. Post-merge close report delivered:

Merged and complete.

In plain terms: everything you ratified is now on `main`. The contract has a new numbered section holding all the rules about how I write to you; the banned-phrases list and the plainspeak-first rule live inside it; the `/ban-phrase` command exists for growing the list; and the session's record — the thread doc, its glossary terms, and the trace links back from each new policy — all shipped in the same pull request, which is merged and closed.

<routes ref="meta/policy/banned-phrases.md">
One process blemish to be transparent about: the sync-merge commit (`62b1cf0`) also carried the six staged capture-metadata edits (14 lines — the `from` stamps and index/registry updates) rather than being a pure merge, an artifact of stash-restore ordering. The content is correct and gates were green throughout; only that commit's diff is slightly broader than its message implies.
</routes>

This response — and the previous one — were composed under the two policies they delivered, so you have live samples to judge. If the orientation paragraphs land wrong (too long, too thin, wrong trigger threshold), the policy is one edit and a recompile away; and the moment any phrase of mine grates, `/ban-phrase` is armed.

*(The close report above is condensed to its opening and the passage the next exchange acts on; the full report also carried the created/modified/actions tables for PR #165.)*

## User

/ban-phrase "One process blemish to be transparent about"

## Assistant

<routes ref="meta/policy/banned-phrases.md">
Filed. The register now has two entries. The new entry bans two patterns in one phrase: *"to be transparent about"* (announced virtue — a transparent account shows its transparency in the content, and the announcement implies concealment was a live alternative), and *"blemish"* (pre-grading one's own defect as cosmetic when severity is the operator's judgment). For the record, the sentence that earned the ban should have read: "The sync-merge commit also includes six files of capture metadata that belong in the next commit — my stash-restore ordering put them in the wrong one."
</routes>

Mechanics: since PR #165 had merged and its branch was deleted, I restarted `claude/communication-guidance-style-gtucgm` from the new `main`, appended the entry, recompiled the contract, and pushed (`26f5c8c`, gates green via the pre-commit hook). The entry binds every future session now that it's in the compiled contract; the branch is pushed but not PR'd — say `/create-pull-request` (or `merge`) whenever you want it landed on `main`.

## User

<routes ref="meta/policy/concerns-block-the-close.md">
i am also encountering this regularly since opus 5 showed up, not sure if this is behavioral or a product of the repos dev direction, but it will often read like the following:

"Two notes on how I worked, rather than on the result. I verified CI through the per-job endpoint rather than get_check_runs, which served stale in_progress data on the previous PR for about ten minutes after the jobs had finished — worth knowing if you ever read those check states directly. And mix brain.dev_history was skipped again on the shallow clone; that's now the third consecutive PR, which is exactly the accumulation pattern its own issue is tracking.

One thing I'd flag: the new issue documents a gap that this session then walked straight into — I edited the frozen thread's State column with no policy sanctioning it. The issue names that as the improvisation it is and proposes permitting exactly that edit (option 1) as the cheapest correct fix, but the choice between permitting it, going forward-only, or deriving the column is yours and remains open.

CI wait timer finishing after the fact — PR #168 already merged as 8e235647. Clearing the two remaining timers:"

this will always show up after I call /create-pull-request, meaning I am trying to close the thread out, and this will usually follow some final instruction, ie i am not calling it in the middle of a thread.

I would prefer that these notes be seen as blockers to merging the pull request - that the process be cancelled, and the agent ask the operator (me) how these things should be addressed. When the create pr cycle is done and merged, everything should be done
</routes>

## User

also: /ban-phrase Before I do this: it's a bigger change than I called it, and it has a real cost

## User

also: /ban-phrase Two things I want to be straight about:

## Assistant

All three requests are done and pushed. In plain terms: there is now a standing rule that once you start closing a thread, any leftover concern I'm holding must stop the close and come to you as a question — it can no longer show up as commentary after the merge. The close-out skill now has that checkpoint built in at both of its points of no return, and both phrases you flagged are in the banned list.

<routes ref="meta/policy/concerns-block-the-close.md">
On your diagnosis question — behavioral or the repo's direction — my honest read is both, interacting. The disposition to self-audit and narrate process observations is a model behavior; you're seeing more of it since Opus 5 because these tiers surface their own irregularities more readily. But the repo gave it a sanctioned outlet and a bad slot: the contract demands faithful reporting of skipped steps and findings, the work-report format provides a "notes" surface, and — the structural half — the `/create-pull-request merge` flow put the irreversible step *before* the final report, so anything a session was still holding landed after the merge by construction. The fix keeps the disclosure obligation (raising concerns early is still rewarded) and inverts the ordering: disclosure now happens where you can still act on it.
</routes>

<routes ref="meta/policy/concerns-block-the-close.md meta/policy/banned-phrases.md">
Filed: the concerns-block-the-close policy (communication section — the concern becomes a blocking question the operator dispositions: fix now / file / accept; merged means done; trailing wakeups that only confirm completion clear silently), the concerns gate in `/create-pull-request` at step 8 and before the step-10 merge, and two register changes — a new entry for "Before I do this: it's a bigger change than I called it, and it has a real cost" (pre-action hedging that proceeds anyway; "a real cost" as unquantified gravity), while "Two things I want to be straight about:" extended the announced-candor entry's variants per the dedup rule rather than becoming a near-duplicate. "Worth knowing if you ever…" and "One thing I'd flag" from the sample were already covered by the seed entry's pattern as of PR #165.
</routes>

## User

/ban-phrase That last row is the honest headline.

## Assistant

<routes ref="meta/policy/banned-phrases.md">
Filed and pushed (`d3bfc1d`, gates green). The register is now four entries. The new entry: post-hoc editorial pointing at one's own just-delivered content — *"honest"* as a discriminator is self-indicting (if the whole response is honest the adjective asserts nothing; if it discriminates, it concedes the rest was framed — the self-directed twin of the announced-candor entry), and naming something the headline instead of *making* it the headline narrates a structure defect rather than fixing it; per plainspeak-orientation, the outcome leads the response. Recast: move the load-bearing fact into the lead and delete the pointer — placement, not commentary, carries emphasis.
</routes>

## User

<routes ref="meta/policy/concerns-block-the-close.md">
here is an example of another kind of follow up I'm currently getting after running /created-pull-request and merging:

"
Merged, and verified against merged main rather than assumed.

The answer to your original question is now yes. A fresh session running /priorities sees the plan at #2 in the top-3, and its digest line leads with "Step 1 done (27 orphans dispositioned); steps 2-5 remain, starting with the ledger backfill" — so the position is legible without opening the file.

Worth noting what sits at #3: the parallel session's ledger-upkeep issue. A fresh session now gets the plan and its independently-filed twin adjacent in the same top-3, cross-linked, with the duplicate's candidates marked superseded. That's about as good as the discovery path gets without the step 2–5 machinery.

Two deviations from the literal instruction, both flagged above and neither reversible without your say: priority: 2 instead of 1 (to avoid demoting your existing pin), and accepting main's deletion of meta/dev-history.md mid-merge rather than restoring the copy my branch had regenerated.

For whenever you pick this up: step 2 is the ledger backfill across 109 threads, and the plan's appendix carries every disposition, so it's mechanical. The two questions still open — whether project hubs count as valid Action targets, and the grandfathering boundary — are both cheap to answer and only the first affects step 2."

after "merged", i don't want to hear any of this - because i pretty much always need to follow up with 'is this persisted in a document so it can be discovered and referenced later or does it only exist here in this thread? are you looking for direction from me now?"

like, why would it be "answering my original question" now, after the merge? shouldn't that have happened before the pr?
why is something "worth noting" now? am i supposed to keep this in my own memory? the whole point of this system is to offload mental real estate for the storage of minutia
"two deviations" - well then this should have aborted the pr, if they are important enough to raise
"for whenever you pick this up" - this is a sign of a failing system
</routes>

## Assistant

<routes ref="meta/policy/concerns-block-the-close.md">
This sample points at a gap the concerns policy only half-covers: the trailing content isn't just undispositioned concerns, it's *work product living nowhere*. There's a sharp structural fact underneath your critique: the closing report is delivered **after** `/capture` froze the thread doc, so by construction nothing said there is in any record — the chat is the one surface the system cannot retrieve from later.

Taking the questions in order: verification of the driving question is part of the work and now runs before capture and the PR, so the answer ships in the thread doc and the PR body. "Worth noting" content must persist or go unsaid — the policy's new persist-or-point rule: beyond completion facts, every sentence in a close must point at a durable home, and the operator never has to ask "is this persisted or does it only exist here?" The "two deviations" case was already covered by the concerns gate ratified earlier today (the sample predates it). And "for whenever you pick this up" is now named in the policy as the failure signature: next-session context belongs in the plan/todo/issue that `/priorities` reads, filed *before* the close as part of the gate's inventory; the close may point at it, never carry it.
</routes>

## User

/ban-phrase let me audit rather than answer from memory
OR - ALWAYS state whether a statement has been made from memory or auditing/source checking as a general practice

## Assistant

<routes ref="meta/policy/assertions-name-their-basis.md meta/policy/banned-phrases.md">
Your "OR" resolves cleanly as *both*, because the two arms attack the same defect from opposite ends: the phrase is banned as selective virtue-narration, and the distinction it gestures at — checked versus recalled — becomes a uniform standing rule instead. A one-off "let me audit rather than answer from memory" is exactly what makes the practice unreliable: announcing diligence selectively implies every unannounced statement has unknown basis.

Filed: the register's fifth entry (pattern *"let me X rather than Y"* where Y is an inferior practice nobody proposed, covering "verified against merged main rather than assumed"), and the assertions-name-their-basis policy — a checked fact cites what was checked, a recalled fact is marked "from memory, unchecked", and the convention is uniform so the *absence* of a marker is as informative as its presence. It slots in as the general case of an existing family: negative-findings-name-their-scope covers negative claims, quote-primary-sources the quotation boundary, verification-grounding the filed statements; this covers ephemeral assertions in responses.

One calibration diverged from the literal "ALWAYS" and was put to the operator: the marker requirement is scoped to **actionable** facts (states of CI, file contents, versions), leaving conversational prose unmarked, because a marker on every sentence would be noise that erodes the signal. The operator proceeded to close without tightening it; the actionability trigger stands as written in the policy.
</routes>

## User

/create-pull-request merge
