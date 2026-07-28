---
type: todo
title: "Build the two proposed eval instruments under meta/evals/"
description: Both source-recall-probe and priorities-recitation-vs-harness-reminders sit at status proposed with no instrument behind them, and meta/evals/ is scanned by nothing, so a proposed eval is invisible to /priorities and stays proposed indefinitely.
status: open
provenance: "Claude Code sessions (2026-07-25, 2026-07-27) — both evals were designed and filed as proposed; statuses re-verified 2026-07-28"
tags: [meta, todo, evals, instrumentation, measurement]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from two untracked routing-ledger strands; both eval docs carry committed designs that no surface tracks toward execution"
  from: [/meta/threads/2026-07-25-journal-skill-and-first-entry.md, /meta/threads/2026-07-27-cca-study-program-and-the-primary-source-miss.md]
---

# Build the two proposed eval instruments

Two evals are designed and filed but unbuilt, both `status: proposed` (verified
2026-07-28):

| Eval | Measures |
|---|---|
| [source-recall-probe](/meta/evals/source-recall-probe.md) | whether the primary-source map and its policy change what an agent actually cites |
| [priorities-recitation-vs-harness-reminders](/meta/evals/priorities-recitation-vs-harness-reminders.md) | whether brain-level recitation beats harness reminders at keeping open work in view |

**Why they stalled.** `meta/evals/` is read by no digest. `/priorities` sources
issues, todos, and plans — an eval at `status: proposed` is invisible to every
surface that would surface it, so it stays proposed by default rather than by
decision.

**Task.** Build the A/B harness each doc specifies and run a first pass, recording
results in the eval doc and moving it off `proposed`. The two share enough shape —
a gold set, a with/without condition, a scored comparison — that building one
should make the second cheap; do the source-recall probe first, since the CCA
study program depends on knowing whether the source map works.

**Done when.** Both evals carry a run result and a status that reflects it, and a
decision is recorded on whether `meta/evals/` should become a `/priorities` source
so this class stops going quiet.
