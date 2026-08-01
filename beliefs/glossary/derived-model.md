---
id: em:cdc9f5
type: concept
title: derived model
description: A model generated from, or automatically reflecting, an existing implementation rather than authored independently of it — a "mirror" that can't catch an implementation error because it moves whenever the implementation does.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, agent-governance, models, spec-vs-implementation]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 MAGE semantic-gap intake thread"
---

# derived model

The trap James C. Davis's *Model-Based Agentic Software Engineering* (MAGE)
names as the "mirror": comparing a derived model against the code it was
derived from for "drift" is circular, since both can wander off together in
the same wrong direction and the diff between them stays green. Contrasted
with an [authored model](/beliefs/glossary/authored-model.md) ("spec"), which
expresses intent independent of the current implementation and so can
actually catch the implementation being wrong.

*Seen in:* [2026-07-31 Neovim PR tree view and MAGE semantic-gap intake](/meta/threads/2026-07-31-neovim-pr-tree-view-and-mage-semantic-gap-intake.md), [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md), [2026-08-01 MAGE governance comparison and update](/meta/threads/2026-08-01-mage-governance-comparison-update.md)

*See also:* [authored model](/beliefs/glossary/authored-model.md), [three-island problem](/beliefs/glossary/three-island-problem.md)
