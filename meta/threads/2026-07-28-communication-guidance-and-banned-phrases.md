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

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Banned words/phrases register + organic growth skill | closed | [banned-phrases](/meta/policy/banned-phrases.md) | - |
| Plainspeak/technical balance in responses | closed | [plainspeak-orientation](/meta/policy/plainspeak-orientation.md) | - |
| Dedicated `communication` contract section | closed | [policy index](/meta/policy/index.md) | - |

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
