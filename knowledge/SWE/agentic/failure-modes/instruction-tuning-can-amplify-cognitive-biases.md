---
id: em:43a737
type: claim
title: "Instruction tuning can amplify cognitive biases in LLMs"
description: "Decoy, certainty, and belief biases appear across model families but show a stronger presence in instruction-tuned variants — bias profiles change at the alignment stage, so preference optimization is a real channel through which human-shaped bias enters."
verified: true
verified_by: [em:cea89d]
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — distilled from Itzhak et al. (TACL 2024) and the follow-up origins literature"
tags: [agentic, failure-modes, cognitive-bias, instruction-tuning, rlhf, training-channels]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the preference-tuning channel is one of the three evidence legs the bias-mapping cluster stands on and needed to be filed at claim strength"
---

# Instruction tuning can amplify cognitive biases in LLMs

Itzhak, Stanovsky, Rosenfeld & Belinkov (TACL 2024) tested three biases from
the human judgment-and-decision-making literature — the decoy effect, the
certainty effect, and belief bias — across the GPT-3, Mistral, and T5
families, comparing pretrained-only models with their instruction-tuned and
RLHF-tuned counterparts. The biases appear broadly, and: "Notably, we find a
stronger presence of biases in models that have undergone instruction
tuning, such as Flan-T5, Mistral-Instruct, GPT3.5, and GPT4"
([captured abstract](/knowledge/SWE/agentic/failure-modes/sources/itzhak-2024-instructed-to-bias.md)).

## Why this claim matters

The comparison holds the pretraining corpus fixed and varies the tuning
stage, so the bias delta is attributable to the alignment step. That makes
this the clean demonstration that **bias profiles are not frozen at
pretraining** — optimizing against human preference judgments is a second,
distinct channel through which human-shaped dispositions enter a model.
Sycophancy is the channel's flagship case: Sharma et al. find "human
feedback may also encourage model responses that match user beliefs over
truthful ones, a behaviour known as sycophancy," with the behavior "likely
driven in part by human preference judgments favoring sycophantic responses"
(<https://arxiv.org/abs/2310.13548>). CogBench reaches the same shape from
the benchmarking side: across 35 models, RLHF is one of the main drivers of
behaving more like humans (<https://arxiv.org/abs/2402.18225>).

## The scope limit

Amplification at the tuning stage does not mean origination there. The
follow-up causal study by the same group — seed-replicated finetuning plus
*cross-tuning* (swapping instruction datasets between models) over 30+
biases — finds "biases are mainly shaped by pretraining: models with the
same pretrained backbone exhibit more similar bias patterns than those
sharing only finetuning data" (<https://arxiv.org/abs/2507.07186>, CoLM
2025). The defensible composite: **pretraining plants the bias repertoire;
tuning modulates how strongly it is expressed.** Channel attribution for any
single bias therefore needs stage-ablation evidence of exactly this kind —
the methodological point developed in
[mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md).

# Citations

- Itzhak et al. (2024), "Instructed to Bias" —
  [captured abstract](/knowledge/SWE/agentic/failure-modes/sources/itzhak-2024-instructed-to-bias.md),
  <https://arxiv.org/abs/2308.00225>
- Sharma et al. (2023), "Towards Understanding Sycophancy in Language
  Models": <https://arxiv.org/abs/2310.13548>
- Coda-Forno et al. (2024), "CogBench: a large language model walks into a
  psychology lab": <https://arxiv.org/abs/2402.18225>
- Itzhak, Belinkov & Stanovsky (2025), "Planted in Pretraining, Swayed by
  Finetuning": <https://arxiv.org/abs/2507.07186>
