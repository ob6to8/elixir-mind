---
id: em:189d88
type: concept
title: freshness gate
description: A blocking check that re-derives a generated-but-committed artifact and fails when the committed copy diverges, converting a doc's currency from a procedural obligation into a structural guarantee.
provenance: "Agent-distilled glossary definition"
verified: false
sense: repo
tags: [glossary, gates, generated-artifacts, staleness, ci]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "the term is load-bearing in the policy-index-gloss issue and recurs across the repo without a definition"
---

# freshness gate

The `--check` half of a `--materialize`/`--check` pair — `mix brain.contract`,
`brain.registry`, `brain.codemap`, `brain.lineage`, `brain.dev_history`, and the
log-fidelity arm of `brain.route_tags`. Each recomputes its artifact from the
sources and compares, so a stale committed copy fails the build rather than
sitting unnoticed. A subclass of the [gate suite](/beliefs/glossary/gate-suite.md),
which also holds gates that check properties rather than currency.

The category boundary is the point: a freshness gate can only cover an artifact
that is **derivable**. Hand-kept prose — an `index.md` gloss, a body paragraph —
has no re-derivation to compare against, so it falls outside every such gate no
matter how load-bearing it is. That is why this bundle's answer to a recurring
staleness problem has been to make the surface generated rather than to add a
rule asking people to remember, and why a surface that resists generation stays
an editorial risk.

*Seen in:* [the gate-suite tutorial](/meta/tutorials/the-gate-suite-and-where-it-runs.md), [policy index glosses drift](/meta/issues/policy-index-glosses-drift-on-policy-edits.md)
