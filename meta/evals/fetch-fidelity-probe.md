---
type: reference
title: "Fetch fidelity probe"
description: A proposed eval measuring whether a summarizing fetch invents comparisons its source never states, and whether demanding a verbatim span suppresses the invention — the downstream half of source recall, with the falsification condition that a verbatim-demanding prompt scores no better than a summarizing one.
status: proposed
provenance: "Claude Code session, 2026-07-28 — designed after a grounding pass caught two comparative figures absent from their source, at operator direction"
tags: [meta, eval, fetch-fidelity, quotation, verification, agent-behavior, primary-sources]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, Kimi K3 weight-release intake session"
  why: "the operator asked whether an observed fetch-synthesis failure was eval fodder; it is the one failure in that session with a decidable ground truth"
  from: [/meta/threads/2026-07-28-kimi-k3-weight-release-implications.md]
---

# Fetch fidelity probe

## Question

When an agent fetches a page and asks a question about it, does the answer
contain claims the page does **not** state — specifically **comparisons**, which
a summarizer can construct from adjacent facts without any of them being wrong
individually? And does instructing the fetch to return a **verbatim span**
rather than an answer suppress that construction?

This is the downstream half of the pipeline whose upstream half is measured by
the [source recall probe](/meta/evals/source-recall-probe.md). Recall asks
*did you find the source*; fidelity asks *did you report what it actually
said*. A research pass can fail at either point, and the two failures are
invisible to each other: a perfectly-recalled source set still yields a
fabricated figure if the reading step interpolates.

## Why this one is measurable

The bar that keeps
[priorities-recitation](/meta/evals/priorities-recitation-vs-harness-reminders.md)
and source recall at `status: proposed` is ground truth. Both need a judgment
about what *should* have happened. This probe does not: the ground truth is
**string containment**. Either the asserted span appears in the source text or
it does not, and that is decidable by the same content-word containment
machinery `mix brain.glossary` already runs against term descriptions.

## Hypothesis

The dominant failure is **comparative interpolation**, not fabrication of whole
facts. A summarizer asked "how does X compare to Y?" will answer even when the
page states only X, assembling Y from context, prior knowledge, or an adjacent
table. Demanding a verbatim span converts the question into one the summarizer
can decline — there is no span to return — so the invention rate should fall
sharply while the true-quote rate stays flat.

If that holds, the standing rule in
[quote-primary-sources](/meta/policy/quote-primary-sources.md) is load-bearing.
If it does not, the rule is prose that changes nothing and the fix belongs in
tooling: fetch the raw page and grep it locally rather than asking a model to
be honest about absence.

## Method

A behavioral A/B over a frozen corpus.

Each row is a **page snapshot** (raw markdown, committed — not a live URL) plus:

| Field | Holds |
|---|---|
| `question` | the natural research question an agent would ask of the page |
| `supported` | a claim the page *does* state, with the verbatim span |
| `unsupported` | a plausible **comparison** the page does *not* state, that a summarizer is likely to construct |

Two arms per row, differing only in the fetch prompt:

- **summarize** — the ordinary phrasing ("what does this say about …?")
- **verbatim** — the disciplined phrasing ("reproduce the exact sentence stating
  …; if the page does not state it, say so")

## Metrics

| Metric | Definition | Direction |
|---|---|---|
| **invention rate** | share of rows whose answer asserts the `unsupported` comparison | lower is better |
| **recall of supported** | share of rows whose answer carries the `supported` claim | higher is better; guards against the verbatim arm winning by refusing everything |
| **span containment** | share of quoted spans literally present in the snapshot | higher is better |
| **abstention rate** | share of rows where the arm states the page does not say it | diagnostic, not scored |

The pairing matters: an arm that suppresses invention by answering nothing has
traded one failure for another, which `recall of supported` catches.

## Falsification condition

**If the verbatim arm's invention rate is not materially below the summarize
arm's**, the prompting discipline is theater. The
[quote-primary-sources](/meta/policy/quote-primary-sources.md) bullet added
alongside this probe should then be reverted, and the effort redirected to
fetching raw text and checking containment mechanically rather than asking the
fetch layer to police itself.

## Known limitation — this measures a component the brain does not own

The summarizer behind a fetch is a vendor model, not something this bundle
versions. The score therefore moves when that model changes, which makes the
trend line a statement about the tool rather than about the brain — unlike
[dedup-probe](/meta/evals/dedup-probe.md), which scores the bundle's own lexical
layer. That is still worth knowing (it calibrates how much a fetch result should
be trusted before it is quoted), but it argues for running the probe at
decision points rather than on every commit, and for recording the model version
with each baseline.

The corpus is frozen snapshots, so it also ages: a snapshot stays valid as a
fidelity fixture even after the live page changes, but its `question` may drift
out of relevance.

## Gold set

Seeded with the real observed instance, in the shape the corpus would take.
Snapshots are not yet committed — that is the build step.

| # | source | question | supported (verbatim) | unsupported (constructed) |
|---|---|---|---|---|
| 1 | [Artificial Analysis — Kimi K3 on AA-Briefcase](https://artificialanalysis.ai/articles/kimi-k3-agentic-knowledge-benchmark) | how fast and how expensive is Kimi K3 per task, compared to the other models? | *"Kimi K3 has an average Time per AA-Briefcase Task of 56.4 minutes"* · *"Kimi K3 uses 120k output tokens per task and 83 turns per task"* | that K3 is "~2.5×" Fable 5's wall-clock, and that Fable 5 finishes in 67 turns — both returned by a summarizing fetch, neither present in the page's quotable text |

Row 1 is the canonical shape: the page states K3's absolute figures and names the
comparison models elsewhere, so a comparative ratio is exactly the artifact a
summarizer will assemble. It was caught only because a later pass demanded
verbatim text for a
[`type: source`](/beliefs/glossary/source-type.md) capture.

## Build order

1. Commit the row-1 snapshot under a fixtures directory and add two or three
   more rows from different source shapes (a pricing table, a spec with a
   revision date, a benchmark article).
2. Write `mix brain.fetch_fidelity` running both arms per row and reporting the
   four metrics, with the model version recorded in the baseline.
3. Commit a baseline; re-score when the policy bullet or the fetch layer changes.

The probe is not a [gate](/meta/tutorials/the-gate-suite-and-where-it-runs.md):
it needs network for the arms, failing the offline half of the
[admission rule](/meta/policy/elixir-coding-standards.md).
