---
id: em:ce4695
type: concept
title: tokenizer
description: The component that splits text into the discrete units a language model consumes, fixing both what the model sees and what a request is billed and length-limited by; different models use different vocabularies, so a token count is meaningful only against a named one.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-engineering, tokens, context-window, cost-optimization]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the measurement instrument behind the serialization benchmark's token counts"
---

# tokenizer

Modern vocabularies are learned by subword merging (BPE and its relatives), so
the mapping from characters to units is empirical rather than principled:
common words are one unit, rare ones several, and punctuation-dense or
whitespace-heavy text fragments badly. That is the mechanism behind format
comparisons — a syntax that repeats keys, brackets, and indentation spends units
on characters carrying no information, and the penalty is a property of the
vocabulary, not of the format in the abstract.

The practical consequence is that token counts do not transfer. A saving
measured under one vocabulary (OpenAI's `o200k_base`, say) will differ under
another, so a comparison is reproducible only when the vocabulary is named —
which, unlike a model's accuracy, it then is exactly, since tokenization is
deterministic.

*Seen in:* [Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
