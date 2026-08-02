---
type: matter
title: "mix brain.matters verifier"
description: Matter-docs build 5 — a mix brain.matters verifier for pointer-ref resolution, order-inversion, and row↔doc agreement, after which the register's Consumed section retires.
status: open
plan: /meta/plans/matter-docs-architecture.md
order: 5
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, verifier, tooling]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "migrated from the matters register's row packet when the register thinned to the order-only pointer view"
  from: [/meta/matters.md]
---

# mix brain.matters verifier

Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 5:
pointer refs resolve, the global order never inverts a plan's internal order,
row↔doc agreement; then retire [the register](/meta/matters.md)'s Consumed
section in favor of landing metadata on done docs. Gate admission per the
[coding-standards](/meta/policy/elixir-coding-standards.md) rule.
