---
id: em:069bf4
type: concept
title: ouroboros
description: The mythological image of a serpent eating its own tail, used technically for a degenerate system state in which cycles are spent reprocessing or summarizing the system's own prior output instead of making forward progress.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, agent-governance, failure-mode, agentic-loop]
sense: dual
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 MAGE semantic-gap intake thread"
---

# ouroboros

An ancient symbol (Greek *oura* "tail" + *bora* "food") found across
Egyptian, Greek, and Norse traditions, generally read as a figure of
self-consuming or self-referential cycles.

**In this brain:** James C. Davis's *Model-Based Agentic Software
Engineering* (MAGE) borrows the image for a specific agentic failure mode —
a session or pipeline that spends its iterations summarizing, compacting, or
re-deriving its own prior output rather than progressing the actual task,
consuming its own output as its input. Named in the chapter's discussion of
context compaction, where an over-eager or mistimed compaction step risks
tipping a session into exactly this loop.

*Seen in:* [2026-07-31 Neovim PR tree view and MAGE semantic-gap intake](/meta/threads/2026-07-31-neovim-pr-tree-view-and-mage-semantic-gap-intake.md), [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md)
