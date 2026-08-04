---
id: em:8da2af
type: concept
title: feature triple
description: The unit of adoption in the library's deferred modular-features stage — one feature taken whole as its gate (checks and mix task), its policy text, and usually its skill, together with the frontmatter keys the feature claims.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, architecture, spin-out, modularity]
sense: repo
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:04:58Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term coined in the 2026-08-03 modular-features stage amendment to the spin-out plan"
---

# feature triple

The three members package differently: the gate and the skill travel as code,
while the policy member ships as a *template* the adopting bundle ratifies into
its own `meta/policy/` — ratification stays a per-bundle governance act, so an
adopter knowingly takes on a feature's law rather than silently inheriting
another bundle's. Formally defining a feature means declaring all three members
plus its dependency edges on other features (route-tagging, for example,
requires identity and session capture), which is what the metadata profile
spec's per-feature extensions record. Deliberately wider than an Elixir module:
one triple typically spans `lib/`, `meta/policy/`, and `.claude/skills/`.

*Seen in:* [2026-08-03 modular-features stage thread](/meta/threads/2026-08-03-modular-features-stage-in-the-spin-out-plan.md), [library spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md)
