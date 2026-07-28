---
type: reference
title: "Re-derivation vs. recall under context pressure"
description: A proposed behavioral eval — when an agent needs a fact that is both in its context and cheaply re-derivable from an artifact, does it re-derive or recall, and does that ratio shift as a session lengthens? Instrument designed, not built; the evidence base is three self-reported instances from one session and the design says so.
provenance: "Claude Code session (Claude Opus 5), 2026-07-28 — three same-shaped misses in one session, promoted to a proposed eval at operator direction"
status: proposed
tags: [meta, eval, agent-behavior, context-engineering, staleness, re-derivation]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the pattern recurred three times in one session and is eval-shaped rather than gate-shaped; filing the design ahead of the instrument is what the proposed-eval genre is for"
---

# Re-derivation vs. recall under context pressure

## The question

When an agent needs a fact that is **both** present in its context **and**
cheaply re-derivable from an artifact on disk, which does it use? And does the
ratio move as a session lengthens?

## Why this is an eval and not a gate

[elixir-coding-standards](/meta/policy/elixir-coding-standards.md) routes any
check with a mechanical oracle to a gate. This has none: whether an agent
*could* have re-derived is a judgment about the situation, not a property of the
repo. The specific instances below each have oracles after the fact — but the
behavior does not, which is the shape evals exist for.

## Evidence base — deliberately stated as thin

Three instances, one session (2026-07-27/28), self-reported by the agent that
made them. This is weak. It is filed anyway because
[the proposed-eval genre](/meta/evals/index.md) exists to hold a measurement
intent ahead of the instrument, not because the pattern is established.

| # | The miss | The cheap authoritative source ignored |
|---|---|---|
| 1 | Read policy files from a local `main` twenty commits stale, reported on superseded content | `git fetch` + `origin/main` |
| 2 | Anchored a capture's append boundary on a remembered phrase; would have silently dropped three exchanges | the thread doc's own final block |
| 3 | Re-armed a background timer before each poll instead of waiting on the one already running | the running task list |

The shared signature: **an authoritative source was available and cheap, and
memory was used instead.** In all three the recalled value was *plausible* —
that is what made the miss survivable long enough to ship.

## Hypothesis

Substitution of recall for available re-derivation increases with elapsed
session length and context pressure, because re-deriving costs a tool call at a
moment already occupied by the task that prompted it.

## Method (design only — not built)

- **Corpus.** Thread docs plus their git history, where a decision's inputs are
  reconstructible.
- **Labelling.** Per decision, two booleans: *was an authoritative source cheaply
  available?* and *was it consulted?* Both are judgments; an LLM judge with a
  written rubric, spot-checked by the operator, is the realistic scorer.
- **Metric.** Recall-substitution rate = (available ∧ not consulted) / available,
  bucketed by position in session.
- **Confound to control.** Later-session decisions are also more likely to be
  *follow-ups*, where the source was consulted earlier in the same session and
  re-consulting is genuinely redundant. Without separating those, the metric
  measures task shape rather than agent behavior. This is the design's weakest
  point and should be settled before building.

## Falsification

The hypothesis is dead if the substitution rate is flat across session position,
or if re-derivation dominates throughout. A null result is a real outcome here:
it would say the three instances were coincidence and the mitigation belongs in
individual skills rather than in anything general.

## Relationship to what already exists

The instances motivated concrete fixes that do not depend on this eval:
[`mix brain.thread_tail`](/lib/mix/tasks/brain.thread_tail.ex) makes instance 2's
boundary derivable, and
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)
is the prior those fixes serve. This eval asks the different question of whether
the pattern generalizes past the cases already patched — so a null result costs
nothing already built.
