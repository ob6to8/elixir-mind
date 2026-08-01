---
id: em:fc19fe
type: concept
title: semantic gap
description: The mismatch between the abstraction level a check or process operates at and the level where the property it's meant to catch actually becomes legible — enforcing something at too fine a grain (a single commit, a single file) where the property is simply not yet visible.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, agent-governance, verification, abstraction, definition-of-done]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 MAGE semantic-gap intake thread"
---

# semantic gap

Named for the general phenomenon in information systems where low-level
representations (pixels, tokens, individual commits) fail to carry the
higher-level meaning a reader or a check actually cares about. James C.
Davis's *Model-Based Agentic Software Engineering* (MAGE) applies it as a
diagnosis for a recurring governance-tooling mistake: a property that needs
"an entire feature and its plan" to be legible — e.g. whether a model stays
in sync with the code it describes — will look fine, or won't even be
checkable, at the level of one commit inside that feature. The fix is to
move the check to where the property becomes legible (the end of the
[epic](/beliefs/glossary/epic.md), not every intermediate commit), which is
also offered as the reason pre-commit hooks fail for many governance
properties: they sit structurally below the level where the property has
meaning.

*Seen in:* [2026-07-31 Neovim PR tree view and MAGE semantic-gap intake](/meta/threads/2026-07-31-neovim-pr-tree-view-and-mage-semantic-gap-intake.md), [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md), [2026-08-01 MAGE governance comparison and update](/meta/threads/2026-08-01-mage-governance-comparison-update.md)

*See also:* [definition of done](/beliefs/glossary/definition-of-done.md), [epic](/beliefs/glossary/epic.md)
