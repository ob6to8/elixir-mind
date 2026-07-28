---
type: todo
title: "Broaden the invisible-degradation glossary entry for the model-output sense"
description: The glossary entry for invisible-degradation covers one sense, and a second reading — degradation in model output that a reader cannot detect from the output alone — was raised and left unresolved between adding a paragraph and minting a distinct term.
status: open
provenance: "Claude Code session (2026-07-27) — surfaced during the LLM-security intakes"
tags: [meta, todo, glossary, terminology, llm-security]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; a small terminology decision that stays unmade while unfiled"
  from: [/meta/threads/2026-07-27-llm-security-intakes-and-two-evaluation-beliefs.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Broaden `invisible-degradation` for the model-output sense

[`invisible-degradation`](/beliefs/glossary/invisible-degradation.md) is defined
for one sense. A second reading came up in the LLM-security intakes: degradation
*in model output* that a reader cannot detect from the output alone — the failure
is real, and the artifact looks fine.

**The decision.** Two options, unresolved:

1. **One entry, two paragraphs** — the senses share a mechanism (the failure is
   undetectable at the surface where it is consumed), so one term covers both.
2. **A distinct term** — the subjects differ enough (a pipeline degrading over
   time vs. a single generated artifact) that collapsing them muddies both.

[prefer-established-terminology](/meta/policy/prefer-established-terminology.md)
argues for option 1: an approximate standard term with a one-line qualification
beats an exact bespoke one, and a second coinage costs a reader another entry to
learn and disambiguate.

**Done when.** The entry covers both senses, or a second entry exists and both
cross-link, with the choice recorded rather than defaulted into.
