---
type: reference
title: "Priorities recitation vs harness task reminders"
description: A proposed behavioral A/B eval — does reciting the brain's own objectives (the active plan's goal, the /priorities top-3) into agent context change agent behavior beyond what the harness's built-in task-state reminders already achieve? Instrument designed, not yet built; the falsification condition is that no measurable difference appears.
provenance: "Claude Code session (Claude Fable 5), 2026-07-25 — the recitation question from the first journal entry, promoted to a proposed eval at operator direction"
status: proposed
tags: [meta, eval, recitation, priorities, agent-behavior, context-engineering]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T21:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, journal-skill session"
  why: "the operator directed the recitation experiment toward the evals genre — evals generally and whenever possible"
  from: [/meta/threads/2026-07-25-journal-skill-and-first-entry.md]
---

# Priorities recitation vs harness task reminders

**Status: proposed** — the instrument is designed below but not yet built. This
is the first eval filed ahead of its instrument; the
[dedup recall probe](/meta/evals/dedup-probe.md) is the genre's model for what
it graduates into (a fixture with a committed baseline, re-scored as the corpus
and tooling evolve).

## Question

[Recitation](/beliefs/glossary/recitation.md) is now standard at the harness
level: Claude Code tracks task state and injects recency-positioned reminders —
the Manus `todo.md` mechanism, built in. What the harness does **not** recite
is the brain's own intent: doctrine, the active plan's goal, the
[`/priorities`](/.claude/skills/priorities/SKILL.md) top-3. Does reciting
*brain-level* objectives change agent behavior beyond what the harness's
mechanical task reminders already achieve — or would building it be
re-engineering the standard?

## Hypothesis

Turn- or session-granularity recitation of brain-level objectives improves goal
alignment on long sessions — fewer dropped strands, more priority-aligned first
actions — because the harness recites *task state* (what I'm doing), not
*intent* (why, and what matters most next).

## Method (proposed instrument)

A/B across matched sessions working the same backlog:

- **Baseline arm** — standard harness behavior; no brain-level injection.
- **Recitation arm** — a hook (SessionStart, optionally PostToolUse) injects a
  compact recitation block: the active plan's goal line plus the `/priorities`
  top-3.

Sessions drawn from comparable work (intakes, maintenance rounds, follow-ups on
open strands), logged well enough to score the metrics below. Ground truth is
constructible because the operator owns the corpus and its open-work state —
the property the
[eval-suitability analysis](/meta/analysis/eval-suitability-of-the-corpus-maintenance-failure-space.md)
identified as what makes this repo eval-friendly.

## Candidate metrics

- **Open-strand pickup rate** — does a session act on dangling routing-ledger
  strands without being prompted?
- **First-action alignment** — is the session's first substantive action inside
  the `/priorities` top-3?
- **Operator redirections per session** — how often must the operator steer the
  agent back to what matters?
- **Drift incidents** — work landed outside any open plan, todo, or issue.

## Falsification

No measurable difference between arms → the harness's task reminders already
suffice, the re-engineering worry from the
[first journal entry](/journal/2026-07-25.md) is confirmed, and the brain skips
building a recitation layer. That negative result is a finding, not a failure —
it retires an open question cheaply.

## Prior art

The [harness-and-ledger analysis](/meta/analysis/harness-and-ledger-as-eval-infrastructure.md)
anticipated exactly this move: the routing ledger and priorities machinery
double as eval infrastructure, so evals emerge from the repo's normal
operations rather than being constructed beside them.
