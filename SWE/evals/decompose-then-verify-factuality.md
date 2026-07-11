---
id: sb:d6cb97
type: reference
title: "Decompose-then-verify factuality evaluation (FActScore, SAFE)"
description: "The LLM-evals literature that atomizes long-form generations into individual facts, verifies each against a knowledge source, and aggregates mechanically — FActScore (EMNLP 2023) and SAFE/LongFact (NeurIPS 2024) validate the pattern at scale."
provenance: "Distilled from the FActScore and SAFE arXiv abstracts (2305.14251, 2403.18802), fetched 2026-07-11"
tags: [evals, llm, factuality, fact-checking, claim-decomposition, atomic-facts, benchmarks]
timestamp: 2026-07-11
---

# Decompose-then-verify factuality evaluation (FActScore, SAFE)

The dominant modern pattern for evaluating the factuality of long-form LLM
output: **decompose** the generation into atomic facts, **verify** each fact
independently against a knowledge source, then **aggregate** the local
verdicts into a score mechanically. Holistic judging can't localize error;
decomposition makes factuality *additive* and auditable per claim.

## FActScore (Min et al., EMNLP 2023)

Decomposes a generation into "a series of atomic facts and computes the
percentage of atomic facts supported by a reliable knowledge source"
(Wikipedia, for the biography task). Findings: substantial factuality gaps in
prominent models (ChatGPT ≈ 58% on biographies); an automated
retrieval-plus-LM estimator matches human judgment with **< 2% error**, making
it feasible to score 6,500 generations from 13 models (vs. ~$26k of human
evaluation). Released as `pip install factscore`.

## SAFE and LongFact (Wei et al., NeurIPS 2024)

**Search-Augmented Factuality Evaluator**: split a response into individual
facts, **revise each to be self-contained** (the decontextualization step —
atomic claims ripped from context change meaning), then rate each via
multi-step reasoning over Google Search results. Contributions: **LongFact**
(GPT-4-generated prompts across 38 topics), the **F1@K** metric balancing
precision (fraction of supported facts) against recall at a preferred response
length, and the headline agreement result: SAFE matches crowdworkers 72% of
the time and *wins 76% of disagreements*, at >20× lower cost. Larger models
were generally more factual.

## Why it is in this brain

This is the empirically validated core of the belief-decomposition idea: local
LLM judgments per atomic claim, global mechanical aggregation — the pattern
the [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
generalizes from factuality scoring to logical structure (support, conflict,
[consensus cores](/glossary/consensus-core.md)). SAFE's self-containment
revision is also the canonical answer to the decontextualization problem any
decomposer must solve.

# Citations

- Min et al., *FActScore: Fine-grained Atomic Evaluation of Factual Precision
  in Long Form Text Generation* (EMNLP 2023):
  <https://arxiv.org/abs/2305.14251>
- Wei et al., *Long-form factuality in large language models* (NeurIPS 2024):
  <https://arxiv.org/abs/2403.18802>
