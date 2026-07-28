---
type: todo
title: "Refresh the gate-suite tutorial's table to the current CI gate list"
description: The gate-suite tutorial's numbered table stops at ten gates and omits three that CI actually runs — brain.glossary, brain.lineage --check, and brain.dedup_probe — so a reader planning a local pass against it under-runs the suite.
status: open
provenance: "Claude Code session (2026-07-23) — residual drift noticed during the AI-drift intake; re-verified against .github/workflows/ci.yml on 2026-07-28"
tags: [meta, todo, gates, ci, tutorial, drift]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; the drift is verified against CI and the fix is a single table edit"
  from: [/meta/threads/2026-07-23-ai-drift-intake-and-coding-standards-ratification.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Refresh the gate-suite tutorial's gate table

[The gate suite and where it runs](/meta/tutorials/the-gate-suite-and-where-it-runs.md)
numbers its gates 1–10, ending at `mix brain.site`. Verified against
[`.github/workflows/ci.yml`](/.github/workflows/ci.yml) on 2026-07-28, CI also runs
four gates the table never mentions:

| Missing gate | Kind |
|---|---|
| `mix brain.glossary` | validation |
| `mix brain.lineage --check` | freshness |
| `mix brain.dedup_probe` | validation |

**Why it matters.** The tutorial's § on the quick manual pass tells a reader which
subset to run locally. Working from a table that is four gates short means running
an under-powered local pass and discovering the rest in CI — the exact failure the
tutorial exists to prevent.

**Task.** Renumber the table to cover all thirteen, place each in its existing
kind taxonomy (freshness / validation / build-artifact), and re-check the
quick-pass subset advice against the fuller list.

**Done when.** Every `mix brain.*` invocation in `ci.yml` appears in the tutorial's
table, and a fresh reader running the documented local subset hits no CI-only
surprise.

> **Amended 2026-07-28.** `mix brain.dev_history --check` was removed from CI and
> the pre-commit hook when the dev-history view stopped being committed (see
> [the issue](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md)),
> so the gap this todo describes is one gate smaller than when it was filed.
