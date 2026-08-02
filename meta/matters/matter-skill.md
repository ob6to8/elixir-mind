---
type: matter
title: "The /matter skill"
description: Matter-docs build 4 — a subcommand-dispatched /matter skill whose bare invocation consumes the top queued matter under the approval-gated protocol, with list rendering the register and create filing a matter.
status: open
plan: /meta/plans/matter-docs-architecture.md
order: 4
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, skills]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "migrated from the matters register's row packet when the register thinned to the order-only pointer view"
  from: [/meta/matters.md]
---

# The /matter skill

Merged former register rows 2+3 (operator-approved 2026-08-02), per
[matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 4:
bare `/matter` consumes the top pointer under the approval-gated protocol
(print the matter as the record, state the approach, wait for approval,
deliver, flip the doc `done`, drop the pointer, log per
[the register](/meta/matters.md)'s protocol); `/matter list` renders the
register; `/matter create` files a matter (absorbing `/todo create`).
Skills-registry entry + contract recompile ride; retires the planned
`/present-matters`.
