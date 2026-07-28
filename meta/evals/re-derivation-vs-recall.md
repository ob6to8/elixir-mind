---
type: reference
title: "Re-derivation vs. recall under context pressure"
description: A proposed behavioral eval — when an agent needs a fact that is both in its context and cheaply re-derivable from an artifact, does it re-derive or recall, and does that ratio shift as a session lengthens? Instrument designed, not built; four instances across two sessions, one recorded independently by an earlier session before this one existed.
provenance: "Claude Code session (Claude Opus 5), 2026-07-28 — three same-shaped misses in one session, promoted to a proposed eval at operator direction; a fourth instance from 2026-07-22 found in future-beliefs during a later persistence audit"
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

## Evidence base

Four instances across two sessions. Three are self-reported by the agent that
made them, which is weak; the fourth is **independent** — recorded by a
different session months earlier, before this eval's question was posed.

| # | Session | The miss | The cheap authoritative source bypassed |
|---|---|---|---|
| 1 | 2026-07-22 | A dead Pages URL shipped even though the contract already said to use `mix brain.url` | `mix brain.url` |
| 2 | 2026-07-27/28 | Read policy files from a local `main` twenty commits stale, reported on superseded content | `git fetch` + `origin/main` |
| 3 | 2026-07-27/28 | Anchored a capture's append boundary on a remembered phrase; would have silently dropped three exchanges | the thread doc's own final block |
| 4 | 2026-07-27/28 | Re-armed a background timer before each poll instead of waiting on the one already running | the running task list |

The shared signature: **an authoritative source was available and cheap, and
memory was used instead.** In every case the recalled value was *plausible* —
that is what made each miss survivable long enough to ship.

Instance 1 matters disproportionately, because the session that recorded it
reached this eval's conclusion independently, in
[`beliefs/future-beliefs.md`](/beliefs/future-beliefs.md):

> "the contract already said 'use `mix brain.url`', yet a dead Pages URL
> shipped, because the *tool* was wrong (not branch-aware) and the policy also
> taught a hand-mapping an agent could apply instead. The fix landed in the tool
> … never in a sterner sentence."

Two sessions converging on *the fix belongs in the tool, not in a stricter rule*
is a different quality of evidence than one session noticing itself three times.
It does not establish the hypothesis — the sample is still four — but it removes
the most obvious deflation, that the pattern is an artifact of one agent's
self-reporting.

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
it would say the four instances were coincidence and the mitigation belongs in
individual skills rather than in anything general.

## Relationship to what already exists

The instances motivated concrete fixes that do not depend on this eval:
[`mix brain.thread_tail`](/lib/mix/tasks/brain.thread_tail.ex) makes instance 3's
boundary derivable, and
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)
is the prior those fixes serve. This eval asks the different question of whether
the pattern generalizes past the cases already patched — so a null result costs
nothing already built.
