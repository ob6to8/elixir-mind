---
type: reference
title: 2026-08-02-methodology-finalization
description: Consumed the register's top matter — the methodology A-package remnant — adding the four-rung Protecting-the-contract ladder to §2 of em:cab2c5 plus one vendorable-block line, dropping the is-exempt framing from the block, the policy-index gloss, and the atomic-PR policy description, finalizing block v1 under the operator's conditional ratification, and removing the consumed register row.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, methodology, tdd, test-protection, matters, atomic-prs]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01T1qaAPJR186EfqnoSu1pZY
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
