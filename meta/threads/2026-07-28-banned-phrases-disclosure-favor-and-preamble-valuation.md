---
type: reference
title: 2026-07-28-banned-phrases-disclosure-favor-and-preamble-valuation
description: The operator flagged two more phrases for the banned-phrases register — disclosure framed as a courtesy, and a preambled self-graded importance claim — each filed with pattern, reasoning, and recast, landing as a bare-invocation PR handoff.
provenance: "Claude Code session (Claude Opus 5, Claude Sonnet 5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, communication, banned-phrases]
timestamp: 2026-07-28
session: https://claude.ai/code/session_014NJwuyVGKGypHxnmipK7Ue
---

# 2026-07-28-banned-phrases-disclosure-favor-and-preamble-valuation

## Where this landed

Two `/ban-phrase` invocations grew the register from five entries to seven.
The first, "I'd rather you hear it from me than find it," bans framing a
disclosure as a courtesy the agent elected to extend — the named alternative
(the operator discovering it unaided) implies withholding was available and
declined, pre-grading the disclosure as generous rather than a plain report.
The second, mid-invocation of `/create-pull-request merge` and interrupting
it, targeted "One thing that turned out to matter more than the mechanics:"
— a self-assigned importance ranking preambled before content instead of
left for the content and its placement to demonstrate. Both entries were
filed, committed, and pushed individually to `claude/ban-phrase-config-vg3k1e`
(`a63926c`, `1ca297a`) with the full gate suite green each time; the session
then closed via a bare `/create-pull-request`, handing the PR back unmerged
per the skill's default.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Register growth: two operator-flagged entries (disclosure-as-favor, preamble valuation) | closed | [banned-phrases](/meta/policy/banned-phrases.md) | - |

## User

/ban-phrase "I'd rather you hear it from me than find it"

## Assistant

<routes ref="meta/policy/banned-phrases.md">
The phrase is now the register's sixth entry, and the contract is recompiled so it binds every future session. The entry as filed:

> - **"I'd rather you hear it from me than find it"** — pattern: *"I'd rather you hear it from me than \<discover it yourself\>"* (also "better you hear this from me", "you'd have found this anyway, so") — framing a disclosure as a courtesy the agent elected to extend. The alternative it names is the operator finding out unaided, which asserts that withholding was available and declined: the disclosure arrives pre-graded as generous, and the operator is cast as receiving a favor rather than a fact. Reporting what happened is the baseline the ledger already requires ([response-work-report-format](/meta/policy/response-work-report-format.md)), and at close time a concern is owed as a blocking question ([concerns-block-the-close](/meta/policy/concerns-block-the-close.md)) — so the preamble claims credit for meeting an obligation. Structurally it is the *"let me X rather than Y"* entry above with the roles swapped: there the unraised alternative is the agent's laziness, here it is the operator's ignorance. Recast: state the thing and its consequence, with no preamble.

On dedup: two existing entries were close enough to consider extending instead of adding. The "to be transparent about" entry shares the announced-candor failure, and the "let me X rather than Y" entry shares the comparative construction. Neither pattern string catches this phrasing, and the distinctive failure — naming the *operator's* discovery as the declined alternative, which turns a report into a gift — is in neither reason, so it files as its own entry with cross-references to both.

The phrase came in as the invocation argument with no preceding exchange in this session, so the pattern, reason, and recast are derived from the phrase itself against the register's established lineage rather than from an operator criticism. If your objection to it was something other than the disclosure-as-favor framing, say so and I'll sharpen the reason.
</routes>

## What I modified

| File | Thrust of the change |
|---|---|
| `meta/policy/banned-phrases.md` | Appended the sixth register entry (phrase, pattern, reason, recast) |
| `CLAUDE.md` | Recompiled from the policies so the entry binds every session |

## Actions I have taken

| Action | Result |
|---|---|
| `mix brain.contract` | Recompiled `CLAUDE.md` |
| `mix brain.verify` | Ids, edges, and grounding all check out |
| `mix brain.contract --check` | `CLAUDE.md` is up to date |
| Commit `a63926c` (pre-commit gate suite) | All gates passed; 188 tests, 0 failures |
| `git push -u origin claude/ban-phrase-config-vg3k1e` | New branch pushed |

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | `/create-pull-request` | Captures the session, glossaries the thread, opens the PR |
| 2 | Ban another phrase | Another `/ban-phrase` invocation lands on the same branch |

## User

/model claude-sonnet-5

/create-pull-request merge

## Assistant

No response requested.

[Request interrupted by user]

## User

/ban-phrase "One thing that turned out to matter more than the mechanics:" - a valuation that is unecessary if it does not carry weight

## Assistant

<routes ref="meta/policy/banned-phrases.md">
Filed as the register's seventh entry:

> - **"One thing that turned out to matter more than the mechanics:"** — pattern: *"the thing that actually/really matters is X"* / *"what turned out to matter more than Y was X"* — a self-assigned importance ranking preambled before the content, instead of leaving the content and its placement to demonstrate the ranking. A valuation is unnecessary if it doesn't carry weight: if the point genuinely outweighs what preceded it, the reader sees that once it's stated; the preamble either asserts nothing (the weight was already going to land) or oversells a point that can't back it up alone. The preamble-side twin of the seed entry's "worth flagging" failure (self-graded worth asserted instead of shown) and the "honest headline" entry's post-hoc twin (pointing at significance instead of *making* something the headline via placement, per [plainspeak-orientation](/meta/policy/plainspeak-orientation.md)). Recast: state the point directly; if it needs prominence, lead with it or give it a heading — structure carries the emphasis, not a verdict phrase.

Dedup check: closest candidates were the seed "worth flagging" entry and the "honest headline" entry — both share the self-graded-significance failure, but neither's pattern string catches this preamble-comparative form ("X mattered more than Y:"), so it's filed as its own entry cross-referencing both rather than folded in.

`CLAUDE.md` is recompiled and `mix brain.verify` is clean. This landed mid-flow — you interrupted the `/create-pull-request merge` I'd started (thread capture, glossary, commit/push/PR/merge). Say the word and I'll pick that back up, now covering both this entry and the "I'd rather you hear it from me" one from before.
</routes>

## User

Stop hook feedback:
[~/.claude/stop-hook-git-check.sh]: There are uncommitted changes in the repository. Please commit and push these changes to the remote branch.

## Assistant

Committed (`1ca297a`) and pushed to `claude/ban-phrase-config-vg3k1e`, gate suite green. The branch now holds both new entries, still waiting on `/create-pull-request` to run capture, glossary, and open the PR whenever you're ready.

## User

/create-pull-request
