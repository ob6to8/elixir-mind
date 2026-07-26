---
type: policy
title: Prefer established terminology
description: Name genres, types, artifacts, and concepts with standard terms of art; coin a bespoke term only when nothing established fits, define it in the glossary at first use, and never churn existing names retroactively without ratification.
section: filing
order: 17
status: active
tags: [meta, governance, terminology, naming, vocabulary]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session"
  why: "operator directed encoding the avoid-bespoke-terminology preference as policy while deciding the flow-genre naming question"
  from: [/meta/threads/2026-07-26-structured-plan-bodies-and-belief-layer.md]
---
**Prefer established terminology; coin bespoke terms only when nothing
established fits.** When naming a genre, a `type`, an artifact, a mix task, or
a concept, reach for the standard term of art (*flow*, *plan*, *glossary*,
*digest*) before inventing repo-specific vocabulary. Every bespoke term is a
tax on future readers and agents: it must be learned, glossaried, and
disambiguated against the standard term it displaced — and an agent
encountering it cold will guess its meaning from the nearest established sense
anyway.

- **The test.** Before coining, ask: does an established term denote this
  thing, even approximately? An approximate standard term with a one-line
  qualification beats an exact bespoke one (*"flow doc — the touch-sequence of
  a canonical run"* over a novel coinage).
- **When bespoke is warranted** — the concept is genuinely novel to this
  bundle (e.g. *route tag*) — define it in the
  [glossary](/beliefs/glossary/index.md) at first use, with `sense: repo`.
- **No retroactive churn.** An existing name is not renamed to a "better" term
  without operator ratification: renames are shape changes
  ([taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)),
  and a rename's cost (links, skills, muscle memory) usually exceeds a
  marginal terminology gain.
