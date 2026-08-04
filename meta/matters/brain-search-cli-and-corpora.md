---
type: matter
title: "brain.search build 2: the CLI and corpora"
description: mix brain.search over the core — default corpus excluding meta/threads/ bodies with --all for the full sweep, --topk (default 10), --json one-object-per-line, and human output as breadcrumb (path > heading), score, and a ~200-byte highest-density snippet — with scenario tests through the task boundary.
status: open
model: Claude Sonnet 5
plan: /meta/plans/brain-search-ranked-retrieval.md
order: 2
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, retrieval, search, cli, elixir]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "emitted as order 2 of the brain-search plan's build sequence"
---

# brain.search build 2: the CLI and corpora

Deliver `lib/mix/tasks/brain.search.ex` on top of build 1: corpus selection
(default = bundle + governance docs minus `meta/threads/` bodies; `--all`
sweeps everything; `deprecated/` always excluded), `--topk` with default 10,
`--json` emitting one object per line for agent use, and the human format
`rank · score · breadcrumb` then the snippet (highest-density ~200-byte window
over the matched chunk, read from the source file). Scenario tests through the
task boundary per the
[testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md);
moduledoc written summary-first (the code map compiles from it).

## Model

Well-specified execution against the plan's decided flags and output shape,
suite-gated — the roster's Sonnet row.
