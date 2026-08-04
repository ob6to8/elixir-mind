---
id: em:16a947
type: concept
title: model2vec
description: MinishLab's technique and library that turns a sentence transformer into a static embedding model by forward-passing the tokenizer's whole vocabulary through the teacher once and keeping only the per-token output vectors — shrinking the model up to ~50× and speeding inference up to ~500×.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, embeddings, search, distillation, tooling]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T00:50:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread and its vocabulary-mismatch analysis"
---

# model2vec

The output is a [static embedding](/beliefs/glossary/static-embeddings.md)
model: one tensor of per-token vectors (stored as
[safetensors](/beliefs/glossary/safetensors.md)) plus the teacher's tokenizer
(for the potion models, BERT [WordPiece](/beliefs/glossary/wordpiece.md));
inference is token lookup and mean pooling. The MIT-licensed potion family
spans ~8 MB to ~30 MB on disk (potion-base-2M through 32M, plus a multilingual
128M).

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md) · [solving vocabulary mismatch offline](/meta/analysis/solving-vocabulary-mismatch-offline.md) · <https://github.com/MinishLab/model2vec>
