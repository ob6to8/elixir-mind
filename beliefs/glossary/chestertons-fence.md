---
id: em:869ba1
type: concept
title: Chesterton's fence
description: The principle that you should not remove something whose purpose you do not yet understand — the reformer must first learn why the fence was put there before being entitled to take it down.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, software-design, maintenance, heuristics]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T22:02:20Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-26 living-text-present-tense-policy thread"
---

# Chesterton's fence

From G. K. Chesterton's 1929 illustration of a gate across a road, the maxim
argues that apparent uselessness is usually a gap in the observer's knowledge
rather than in the thing observed, so the burden of proof falls on whoever wants
to remove it. In software it is the standard caution against deleting code,
configuration, or comments that look vestigial.

**In this brain:** it names one of the carve-outs of the
[living-text-is-present-tense policy](/meta/policy/living-text-is-present-tense.md).
A comment explaining why live code still exists — "kept only as the migration
reader for X" — reads as a justification for something present rather than as
[retrospective narration](/beliefs/glossary/retrospective-narration.md), and
deleting it would leave the code looking dead and invite exactly the uninformed
removal Chesterton warns against. The relevant test is whether the sentence
supports code that is still there.

*Seen in:* [2026-07-26 living-text present-tense policy thread](/meta/threads/2026-07-26-living-text-present-tense-policy.md), [lib/elixir_mind/lineage.ex](/lib/elixir_mind/lineage.ex)
