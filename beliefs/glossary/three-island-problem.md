---
id: em:8af8b6
type: concept
title: three-island problem
description: The default state of prose documentation, code, and tests as three artifacts with no structural link between them, so nothing forces any one to stay consistent as the others change — a change to the code doesn't touch the doc, and a stale test doesn't know the schema moved.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, agent-governance, models, documentation-drift]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 MAGE semantic-gap intake thread"
---

# three-island problem

Coined in James C. Davis's *Model-Based Agentic Software Engineering* (MAGE)
to name why documentation drift is the default rather than an anomaly: prose,
code, and tests evolve independently because nothing checks them against each
other. The chapter's proposed fix is a typed [model](/beliefs/glossary/authored-model.md)
sitting at the top of the documentation hierarchy, providing the checked
edges that bind the three islands together — but only when the model is
itself [authored independently](/beliefs/glossary/authored-model.md) of the
code, since a model merely [derived](/beliefs/glossary/derived-model.md) from
one of the islands can't bind it to the others.

*Seen in:* [2026-07-31 Neovim PR tree view and MAGE semantic-gap intake](/meta/threads/2026-07-31-neovim-pr-tree-view-and-mage-semantic-gap-intake.md), [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md)

*See also:* [authored model](/beliefs/glossary/authored-model.md), [derived model](/beliefs/glossary/derived-model.md)
