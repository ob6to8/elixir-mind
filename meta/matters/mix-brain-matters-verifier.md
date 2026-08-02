---
type: matter
title: "mix brain.matters verifier"
description: Matter-docs build 5 — a mix brain.matters verifier for pointer-ref resolution, order-inversion, and row↔doc agreement, after which the register's Consumed section retires.
status: done
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
  from: [/meta/matters.md, /meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md]
---

# mix brain.matters verifier

Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 5:
pointer refs resolve, the global order never inverts a plan's internal order,
row↔doc agreement; then retire [the register](/meta/matters.md)'s Consumed
section in favor of landing metadata on done docs. Gate admission per the
[coding-standards](/meta/policy/elixir-coding-standards.md) rule.

Delivered 2026-08-02: `ElixirMind.Matters` (`lib/elixir_mind/matters.ex`) with
`mix brain.matters` — five named checks (register shape; ref resolution + doc
shape; row↔doc agreement; plan-order inversion; landing metadata, the last
warn-only since a done doc legitimately awaits its `pr:` stamp until
`/create-pull-request` opens the PR) — wired into CI and the pre-commit hook
beside the other verifiers, with `ElixirMind.SessionInit` repointed onto the
module's `queue_positions/1` as the one register parser. The register's
Consumed section retired in the same motion: its landing PRs live on the done
docs (the two pre-stamp docs backfilled from merge-graph evidence, PR #164
and PR #216), and the four pre-migration rows' packets stay in git history
per the plan.
