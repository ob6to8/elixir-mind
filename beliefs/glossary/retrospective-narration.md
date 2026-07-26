---
id: em:d95896
type: concept
title: retrospective narration
description: Prose embedded in a living artifact that recounts what the artifact or system used to be — "this used to X", "the old Y", "was removed in favor of Z" — duplicating a change record the commit graph already holds.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, governance, documentation, provenance, staleness]
sense: repo
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T22:02:20Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-26 living-text-present-tense-policy thread"
---

# retrospective narration

Its cost is the one that retired the hand-kept logs: such prose is greppable but
unmaintained, so it goes stale silently and is then retrieved and trusted as
current state. Because it duplicates on write and decays thereafter, the
[merge-strategy](/meta/policy/merge-strategy.md) designation of the commit graph
as the single change-narrative layer already answers it — the
[living-text-is-present-tense policy](/meta/policy/living-text-is-present-tense.md)
just extends that answer from dedicated `log.md` files down to comment scale.

The characteristic failure mode is *dispersion*: one refactor leaves residue in
every file it touched, each independently re-telling the same history, so the
count of stale sentences grows with the blast radius of the change rather than
with the number of changes. Two things resemble it and are exempt — a
present-tense pointer, which tells a reader where a capability lives *now*, and a
[Chesterton's-fence](/beliefs/glossary/chestertons-fence.md) comment, which
justifies why live code still exists.

*Seen in:* [2026-07-26 living-text present-tense policy thread](/meta/threads/2026-07-26-living-text-present-tense-policy.md), [living-text-is-present-tense policy](/meta/policy/living-text-is-present-tense.md), [future beliefs](/beliefs/future-beliefs.md)
