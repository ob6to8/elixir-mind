---
id: em:fb2eaa
type: source
title: "LiveBench: A Challenging, Contamination-Limited LLM Benchmark (paper)"
description: The paper behind the LiveBench leaderboard — monthly-refreshed questions from recent sources, scored against objective ground truth instead of an LLM judge, across math, coding, reasoning, language, data analysis, and instruction following.
resource: https://arxiv.org/abs/2406.19314
provenance: "arXiv abstract (2406.19314), fetched 2026-08-21"
tags: [evals, benchmarking, contamination, llm-evaluation, arxiv]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# LiveBench: A Challenging, Contamination-Limited LLM Benchmark

Authors: Colin White, Samuel Dooley, Manley Roberts, Arka Pal, Ben Feuer,
Siddhartha Jain, Ravid Shwartz-Ziv, Neel Jain, Khalid Saifullah, Sreemanti
Dey, Shubh Agrawal, Sandeep Singh Sandha, Siddartha Naidu, Chinmay Hegde,
Yann LeCun, Tom Goldstein, Willie Neiswanger, Micah Goldblum.

This is the paper behind [LiveBench](/knowledge/SWE/evals/livebench.md). It
argues most LLM benchmarks suffer from contamination (test data leaking into
training) and from relying on human or LLM judges that introduce bias, and
proposes a benchmark designed against both: monthly-refreshed questions
sourced from recent math competitions, arXiv papers, news articles, and
datasets, harder variants of Big-Bench Hard / AMPS / IFEval tasks, and
purely objective, automatic scoring against ground-truth answers — "without
the use of an LLM judge." Evaluating models from 0.5B to 405B parameters,
closed and open, the paper reports that "top models achieving below 70%
accuracy" demonstrates the benchmark's difficulty. Questions, code, and model
responses are released, with the benchmark intended for ongoing monthly
expansion.

# Citations

- <https://arxiv.org/abs/2406.19314> — abstract
