---
id: em:aa3f68
type: reference
title: "LilyBench — a symbolic music generation and understanding benchmark for LLMs"
description: A benchmark evaluating whether LLMs can generate valid LilyPond music notation and understand its musical structure, finding executable generation is easy zero-shot while structural understanding stays hard.
resource: https://github.com/CSCPadova/lilybench
provenance: "CSCPadova, GitHub README and project site (cscpadova.github.io/lilybench), fetched 2026-08-21"
tags: [evals, benchmarking, symbolic-music, music-generation, llm-evaluation, open-source]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# LilyBench

LilyBench evaluates LLMs on [LilyPond](https://lilypond.org/), a text-based
musical score notation language, across two complementary axes: whether a
model can **generate** valid, stylistically plausible scores, and whether it
can **understand** one it's given. The project accompanies a paper accepted
at Ital-IA 2026.

## Generation benchmark

Models are prompted from a fixed bank of 200 metadata-conditioned prompts
(composer, period, form, ensemble, part) drawn from three datasets — BMdataset
(in-domain), the Mutopia Project (out-of-domain), and EMOPIA (emotion-specific)
— across three regimes: zero-shot, few-shot from the training distribution,
and a few-shot ablation. Output is scored on:

- **Compile rate** — whether the generated LilyPond actually compiles (validated
  against the LilyPond 2.24.4 binary).
- **Jensen-Shannon similarity** across three MusPy descriptors.
- **Fréchet Music Distance**, via LilyBERT embeddings.

## Understanding benchmark

Ten tasks adapted from ABC-Eval probe structural comprehension at varying
depth: bar counting, metadata Q&A, bar sequencing, next-bar prediction,
metadata prediction, music captioning, composer/genre/emotion recognition,
and error detection — scored by accuracy, exact match, penalized Kendall-τ,
or macro-F1 depending on task, using greedy decoding.

## Findings

Four open-weight backbones were evaluated (Phi-4, Qwen2.5-Coder-14B,
DeepSeek-Coder-V2-Lite, Codestral-22B). The headline result: **executable
LilyPond generation is achievable zero-shot, while structural understanding
tasks remain hard despite strong composer and genre recognition** — models
are good at recognizing *what* a piece is but weak at reasoning about *how it
is put together* (bar counting, error detection). The paper also reports that
its descriptor- and embedding-based generation metrics **systematically
disagree** with each other, arguing against relying on any single generation
metric.

## Architecture

The codebase is built for extension: new generation regimes subclass
`Regime`, new understanding tasks register via `@register_task`, and new
models plug in through `ModelSpec`.

# Citations

- <https://github.com/CSCPadova/lilybench> — project repository and README
- <https://cscpadova.github.io/lilybench/> — project site, same benchmark
