---
id: em:2fc516
type: reference
title: "LiveBench — a contamination-limited LLM benchmark"
description: A continuously-refreshed LLM benchmark that scores questions from recent, verifiable sources with objective ground truth, so no LLM judge or static test set is needed.
resource: https://livebench.ai/#/
provenance: "livebench.ai leaderboard and LiveBench/LiveBench GitHub repository, fetched 2026-08-21"
tags: [evals, benchmarking, contamination, llm-evaluation, leaderboard, open-source]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# LiveBench

LiveBench is a leaderboard and benchmark suite built to resist the two
standard failure modes of LLM evaluation: **test-set contamination** (a
model has seen the eval questions during training) and **judge bias** (an
LLM grading another LLM's free-form answer). It solves both by construction
rather than by better prompting a judge.

## How it avoids contamination

- **Monthly-refreshed questions**, drawn from sources too recent to be in any
  model's training data: new math competitions, arXiv papers, news articles,
  and datasets.
- **Objective, verifiable ground truth** for every question, so scoring is
  automatic and exact — no LLM-as-judge step, and no subjective grading.
- Harder variants of established tasks (Big-Bench Hard, AMPS, IFEval) are
  folded in alongside the fresh material.

## Coverage

18 tasks across 6 categories: math, coding, reasoning, language
understanding, instruction following, and data analysis. Models from 0.5B to
405B parameters, closed and open, are evaluated on the same suite.

## Findings

At the paper's original evaluation, **top models scored below 70% accuracy**
— the suite is deliberately hard enough to leave room for models to keep
improving against it, which is the point of refreshing it monthly rather than
publishing a fixed static set. Questions, code, and model responses are
released publicly.

## Source paper

The underlying methodology is described in the paper
[LiveBench: A Challenging, Contamination-Limited LLM Benchmark](/knowledge/SWE/evals/livebench-contamination-limited-benchmark-paper.md).

# Citations

- <https://livebench.ai/#/> — live leaderboard
- <https://github.com/LiveBench/LiveBench> — project repository
