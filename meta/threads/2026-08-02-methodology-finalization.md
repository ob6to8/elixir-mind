---
type: reference
title: 2026-08-02-methodology-finalization
description: Consumed the register's top matter — the methodology A-package remnant — adding the four-rung Protecting-the-contract ladder to §2 of em:cab2c5 plus one vendorable-block line, dropping the is-exempt framing from the block, the policy-index gloss, and the atomic-PR policy description, finalizing block v1 under the operator's conditional ratification, and removing the consumed register row.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, methodology, tdd, test-protection, matters, atomic-prs]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01T1qaAPJR186EfqnoSu1pZY
pr: 226
---

# 2026-08-02-methodology-finalization

## Where this landed

A fresh thread opened with the register's standing instruction — take the top
matter — and consumed row 1, the A-package remnant left when PR #224's
provenance table landed: the first fresh-thread consumption of
[the register](/meta/matters.md). The
[methodology doc](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
gained the four-rung "Protecting the contract" subsection under §2 (with the
two-set-split clarification for the held-out rung) and one protection line in
the vendorable block; the is-exempt framing came out of the block's Delivery
bullet, the [policy-index gloss](/meta/policy/index.md), and the
[atomic-PR policy](/meta/policy/git-atomic-pull-requests.md)'s description —
the third surface a session-time find, riding the same intent. The block was
finalized as v1 under the operator's conditional ratification, dials as
drafted. One verification finding shaped the text: Beck's immutable-annotation
span is not reproducible from the reachable pages, so the doc attributes the
wish as synthesis rather than quotation, with the failed reproduction recorded
in its claim-provenance row. The consumed row came off the register (removal
landing with this matter's merge), remaining rows renumbered.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Methodology finalization — protection ladder, de-exempt wording, block v1 final | closed | [agent-development-methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) | - |
| De-exempt wording in the atomic-PR policy's description (beyond the row's two named surfaces) | closed | [git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md) | - |
| Beck immutability-wish span verification — kept synthesis, not quote | closed | [agent-development-methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) | - |
| Register consumption — row 1 removed, rows renumbered | closed | [matters](/meta/matters.md) | - |

## User

take the top matter from meta/matters.md. ask questions if needed

## Assistant

<routes ref="em:cab2c5">
I now have the complete picture of the matter. Before executing, I need the supporting refs: the ranking analysis (which holds the protection-ladder evidence), the two-level guidance plan (which governs the block's versioning), and the matter-queue plan (which governs how a consumed row is closed out). Let me also map every "exempt" occurrence.
</routes>

<routes ref="em:cab2c5 meta/policy/git-atomic-pull-requests.md">
Branch is set up at `origin/main` (PR #225's merge), working tree clean. The policy body already carries the correct framing — only its `description` frontmatter, the index gloss, and the vendorable block have the "exempt" defect. Let me create the task list and verify the Beck "immutable annotation" quote from its primary source before I write it into the doc.
</routes>

<routes ref="em:cab2c5">
Verification outcome: the "immutable annotation" span is not reproducible from either reachable Beck source (the Substack post yields only "Any indication that the genie was cheating, for example by disabling or deleting tests"; the interview's free page only confirms the deleting-tests problem; the full transcript is podcast-gated). Per the quote-primary-sources policy, that phrase gets no quotation marks — I'll attribute it as synthesis and record exactly that in the provenance row.

Now applying the edits to the methodology doc — (b) the subsection under §2:
</routes>

All gates green — 201 tests pass, contract/registry/codemap current, bundle verifies, route tags and glossary check out, site builds (the warnings shown are pre-existing advisory ones). The contract check confirms the policy `description` edit needs no recompile.

Quick self-review of the changed doc before committing:

## Assistant

Matter delivered — **PR #226 is open and awaiting your merge: https://github.com/ob6to8/elixir-mind/pull/226**

In plain terms: I took the register's top row (the methodology finalization left over from the TDD spike) and executed it end to end. The methodology document now has its missing section on how tests are protected from the agent implementing against them; the leftover "is exempt" phrasing — which implied a size cap the policy doesn't have — is gone from every living surface; and the paste-into-other-repos block is now the finalized v1 you conditionally ratified, dials exactly as drafted. No blocking questions arose: the row's handoff packet was self-contained, as designed — this was also the register's first fresh-thread consumption, and the mechanism worked.

**What I created**

| type | doc | why this type |
|---|---|---|
| thread doc | [`meta/threads/2026-08-02-methodology-finalization.md`](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-bujixu/meta/threads/2026-08-02-methodology-finalization.md) | the session's frozen record (routing ledger, route tags, `pr: 226` stamped) |
| glossary `concept` | `protection-ladder` (`em:07519b`) | repo coinage now load-bearing in the methodology |

**What I modified**

| file | thrust of the change |
|---|---|
| [`agent-development-methodology.md`](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-bujixu/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) (`em:cab2c5`) | "Protecting the contract" subsection under §2 (four rungs + the two-set-split clarification); one protection line in the block; Delivery bullet de-exempted; version line dated to the finalized text; six new claim-provenance rows |
| `meta/policy/index.md` + `git-atomic-pull-requests.md` | gloss and `description` de-exempted (the description was a third surface with the identical defect, found in session — same intent, so it rode; the policy body was already correct); thread stamped into the policy's `attribution.from` |
| [`meta/matters.md`](https://github.com/ob6to8/elixir-mind/blob/claude/meta-matters-top-bujixu/meta/matters.md) | row 1 removed in this PR (so removal lands exactly at merge, per the register's rule); rows renumbered — `deferred-work-is-filed` policy is the new top |
| `held-out-set.md`, `matter.md` (glossary) | dev-loop application added; register sentence moved to present tense |

**Actions I have taken**

| action | result |
|---|---|
| Verified Beck's "immutable annotation" span against both reachable sources | not reproducible (Substack post + interview free page; transcript podcast-gated) → attributed as **synthesis, not quotation**, with the failed reproduction recorded in its provenance row |
| Full gate suite on all three commits | green — 201 tests; contract/registry/codemap current; bundle, route-tag, glossary, lineage checks pass |
| Pushed `a2e57d0` → `441236b` → `4d8f714`, opened PR #226 | open against `main` |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Review and merge #226 | use **"Create a merge commit"** — never squash/rebase; highest-leverage review targets: the §2 subsection and the finalized block |
| 2 | Have me watch the PR | I subscribe to its CI/review events and respond — say the word |

After #226 lands, the next fresh thread picks up the new row 1 (`deferred-work-is-filed` policy) with the same opener you used here.

## User

merge

## Assistant

Merging under the explicit opt-in — the step-9 concerns gate passes (nothing emerged since opening: no new commits, no surprises). Checking CI first, never merging red:
