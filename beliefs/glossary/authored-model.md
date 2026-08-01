---
id: em:f064b8
type: concept
title: authored model
description: A model written to express intent independently of what the implementation currently does — a "spec" that can catch an implementation error precisely because it doesn't move when the code moves, unlike a model merely derived from the code.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, agent-governance, models, spec-vs-implementation]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 MAGE semantic-gap intake thread"
---

# authored model

James C. Davis's *Model-Based Agentic Software Engineering* (MAGE) frames
this as the whole point of model-based governance: "the power was never in
modeling as such. It was in the model being **authored independently of the
code**." Independence is what lets a model catch a real implementation
error rather than just restate one — a model that instead reflects the code
it's compared against (a [derived model](/beliefs/glossary/derived-model.md),
or "mirror") makes any drift check between the two circular.

*Seen in:* [2026-07-31 Neovim PR tree view and MAGE semantic-gap intake](/meta/threads/2026-07-31-neovim-pr-tree-view-and-mage-semantic-gap-intake.md), [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md)

*See also:* [derived model](/beliefs/glossary/derived-model.md), [three-island problem](/beliefs/glossary/three-island-problem.md)
