---
type: policy
title: Atomic pull requests
description: One matter per pull request — a matter is one coherent, separately-reviewable intent; size is a signal and never the gate, mechanical bulk is exempt, generated artifacts ride their source change, splits stop at the green boundary, and a session delivers matters sequentially rather than batching them into one PR.
section: git-workflow
order: 2
status: active
tags: [meta, governance, git, pull-requests, review, atomicity]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T19:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "operator ratified adopting an atomic-PR rule for this repo, shaped so the matter is the unit and line counts never force artificial splits"
  from: [/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md]
---
**One matter per pull request.** A **matter** is one coherent intent a
reviewer can approve or reject as a whole: an intake batch on one subject, a
policy adoption, an analysis, a feature with its tests, a refactor. The test
is independence — *if the operator could plausibly want to merge one part
while rejecting another, those are two matters.* This implements the
delivery half of [verified increments](/meta/doctrine/verified-increments.md):
generation is cheap and review attention is the bottleneck, so work is shaped
to fit review, not batched to amortize it.

- **Size is a signal, never the gate.** There is no line cap: a large diff
  carrying one mechanical intent — a rename, a regeneration, a format sweep,
  a verbatim thread capture — is one reviewable decision, while a small diff
  carrying two separable decisions still splits. Treat unexplained bulk as a
  smell to justify, not a threshold to enforce.
- **Splits stop at the green boundary.** Never split where each half cannot
  compile and pass the suite alone, and never sever a change from its tests —
  atomicity in the one-matter sense outranks smallness.
- **Generated artifacts ride their source change.** A contract recompile
  travels with its policy edit, the registry with its minting, index updates
  with their filing — a regeneration is part of the matter that caused it.
- **Sessions deliver sequentially.** Finish a matter, open its PR
  (`/create-pull-request`, scoped to that matter), and start the next matter
  after it lands; a session holding several finished, unmerged matters says
  so and hands the remainder to the operator instead of silently widening the
  open PR. Follow-up PRs from one session are the expected shape — the thread
  doc's `pr:` stays the origin PR and later PRs land in narrative prose, per
  the session-capture policy.
- **The daily `/research` run is one matter by construction** (digest plus its
  auto-intakes), as is any operator-directed batch with a single stated
  purpose.
