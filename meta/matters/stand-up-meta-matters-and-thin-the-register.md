---
type: matter
title: "Stand up meta/matters/ and thin the register"
description: Matter-docs build 2 — migrate the queued register rows to matter docs under meta/matters/, thin meta/matters.md to the order-only pointer view, revise its protocol prose, and add the directory index.
status: done
plan: /meta/plans/matter-docs-architecture.md
order: 2
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, matters, migration]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "filed at delivery as the done record of the migration itself, per matter-docs build-order 2"
  from: [/meta/matters.md]
---

# Stand up meta/matters/ and thin the register

Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 2:
migrate the queued rows to matter docs, reduce
[the register](/meta/matters.md) to the order-only pointer view (the global
sequence over queued matters is the one datum stored there), revise its
protocol prose, add the directory index.

Delivered 2026-08-02: the ten matter docs under this directory (this one
`done`, nine `open`), the thinned register with its Consumed log and protocol
prose revised, [the directory index](/meta/matters/index.md), and the
[meta index](/meta/index.md) updates. The `fresh` context flag retired into
the register's protocol prose (every queued matter is a fresh-thread handoff
by construction), and blocked matters stay unmarked in the pointer view — the
blocker lives in the matter doc, and the protocol skips a blocked matter for
the next row.
