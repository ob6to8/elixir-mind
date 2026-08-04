---
type: matter
title: "brain.search build 3: probe trend line and intake wiring"
description: Give the ranked backend its own recall trend line in mix brain.dedup_probe (beside plain and expanded, in the generated Baseline table and the report) and rewire /intake's dedup step so the tier-1 synonym phrasings become one ranked query against mix brain.search, with grep retained as the exact-match complement.
status: open
model: Claude Sonnet 5
plan: /meta/plans/brain-search-ranked-retrieval.md
order: 3
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, retrieval, dedup, recall, probe, intake]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "emitted as order 3 of the brain-search plan's build sequence"
---

# brain.search build 3: probe trend line and intake wiring

Two wirings of the surface builds 1–2 delivered, one intent: retrieval
improvements become measurable and used. (a) `ElixirMind.DedupProbe` gains a
ranked backend mode calling `ElixirMind.Search` — hit = any acceptable id in
the top-k (k = 10) — reported as a third line beside plain and expanded in the
generated `## Baseline` table of [the gold doc](/meta/evals/dedup-probe.md)
and in the CI report step, implementing the
[re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)'s
separate-trend-lines recommendation so the tier-2 trigger stays readable.
(b) [`/intake`](/.claude/skills/intake/SKILL.md)'s dedup step: the 3–5
synonym-expanded phrasings are issued as **one** ranked query (union of
terms) instead of N greps, with a plain grep retained for exact-phrase
confirmation.

## Model

Execution against a decided seam — the probe's backend boundary and a skill
prose edit — with the baseline table regenerated and the suite gating the
code half; the roster's Sonnet row.
