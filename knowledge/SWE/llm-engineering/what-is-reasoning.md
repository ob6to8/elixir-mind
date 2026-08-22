---
id: em:82af8d
type: reference
title: "What Is Reasoning (Armin Ronacher)"
description: "Ronacher's mechanical account of LLM reasoning traces: they are ordinary text routed into a separate channel by learned convention, reasoning effort is a system-prompt instruction rather than a sampling parameter, and 'not thinking' is itself a learned, sometimes mechanically-enforced behavior."
resource: https://lucumr.pocoo.org/2026/8/19/what-is-reasoning/
provenance: "Armin Ronacher, lucumr.pocoo.org essay, published 2026-08-19"
tags: [llm-reasoning, chain-of-thought, system-prompts, reasoning-tokens, inference-mechanics, gpt-oss]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# What Is Reasoning

Prompted by a paper on extracting reasoning traces from closed-weight models
and online discussion of "tricking models into leaking them," Armin Ronacher
lays out what a reasoning trace actually is, mechanically, against what he
calls industry mystique: "The industry has done a good job at making
reasoning traces sound special and exotic, but they really are just text: the
model is trained to emit its thinking into a scratchpad as part of its
response, before its final answer."

## Traces are a routed text stream

GPT-OSS's Harmony format makes the mechanism visible — an `analysis` channel
holding the scratch work, then an `assistant`/`final` channel holding the
answer:

```
<|channel|>analysis<|message|>
I need to work this out ...
<|end|><|start|>assistant<|channel|>final<|message|>
The answer is ...
<|return|>
```

"The markers are special tokens, but the reasoning between them uses 'the
same text' as the final answer." A parser routes text sampled after the
`analysis` marker into a separate stream exposed through the API, rather than
the reasoning being produced by some distinct architectural mechanism.

## Reasoning effort is a prompt, not a knob

"Earlier APIs exposed reasoning token budgets, making it seem like a property
of the sampling process. In reality, reasoning effort is baked into the
system prompt." GPT-OSS's entire mechanism for this is the literal line
`Reasoning: low` placed in the system prompt; "training produces the
resulting behavior, such as emitting the token sequence that switches to the
analysis channel." This also explains a practical annoyance: changing the
reasoning-effort setting invalidates the KV cache, because it changed the
system prompt.

## Not thinking is also learned

"The destination of reasoning tokens is therefore a learned convention: the
model is trained to keep scratch work out of the final channel. Trick it into
thinking it is in that channel and it may leak tokens" — Ronacher notes older
models, with thinking disabled, have been observed reasoning into a bash tool
and echoing their thoughts to `/dev/null`. His conclusion: "in some sense the
only 'special' behavior for some models is not to think," and that
suppression is sometimes done "mechanically" — DwarfStar prefills the
`</think>` token to force thinking off and `<think>` to force it on, while
GPT-OSS lets the model choose either way on its own. He speculates that some
inference APIs prefill the reasoning-opening token when reasoning is enabled
specifically so the model never has to sample it itself, which would explain
why a custom "think" tool can trick some models into reasoning where it
shouldn't — but only when native reasoning is disabled and there's no prefill
blocking the sampled token.

This is a mechanics-level companion to
[Defeating Nondeterminism in LLM Inference](/knowledge/SWE/llm-engineering/defeating-nondeterminism-in-llm-inference.md):
both pieces take a phenomenon presented to users as sampling magic
(nondeterministic output; a "reasoning" capability) and locate the actual
cause in an engineering decision (batch composition; a system-prompt
convention plus training) rather than in anything mysterious about how the
model "thinks."

# Citations

- Source: <https://lucumr.pocoo.org/2026/8/19/what-is-reasoning/>
