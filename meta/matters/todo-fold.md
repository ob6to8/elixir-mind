---
type: matter
title: "Todo fold"
description: Matter-docs build 3 — migrate meta/todos/ into meta/matters/, retire type todo from the vocabulary with a contract recompile, and repoint the reading surfaces.
status: done
pr: 232
plan: /meta/plans/matter-docs-architecture.md
order: 3
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, todos, migration]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "migrated from the matters register's row packet when the register thinned to the order-only pointer view"
  from: [/meta/matters.md, /meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md, /meta/threads/2026-08-02-todo-fold-into-matters.md]
---

# Todo fold

Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 3:
migrate `meta/todos/` to `meta/matters/` (open todos become backlog matters —
open, outside [the register](/meta/matters.md); done/cancelled keep status),
retire `type: todo` from the vocabulary + contract recompile, repoint the
reading surfaces (`mix brain.session_init`, `/priorities`, `/todo` skill
retired or aliased), indexes.
