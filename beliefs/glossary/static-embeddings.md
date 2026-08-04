---
id: em:bb293e
type: concept
title: static embeddings
description: Embedding vectors precomputed per token and stored as a plain lookup table, so producing a text's vector at inference is only token lookup plus pooling — no transformer forward pass, no neural runtime.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, embeddings, search, retrieval]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T00:50:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread and its vocabulary-mismatch analysis"
---

# static embeddings

Modern static models ([model2vec](/beliefs/glossary/model2vec.md), WordLlama)
distill the table from a transformer teacher, which puts their quality well
above classic static vectors (GloVe, word2vec) while keeping the model an inert
data file of a few dozen megabytes. Because pooling averages context-free token
vectors, they bridge synonymy and terminological paraphrase that defeat
[lexical search](/beliefs/glossary/lexical-search.md), but miss meaning carried
by narrative or idiom — the gap contextual
[embeddings](/beliefs/glossary/embeddings.md) exist to close. In this bundle
they were measured against the dedup gold set as a candidate offline semantic
layer (recall@10 8/30 → 25/30).

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md) · [solving vocabulary mismatch offline](/meta/analysis/solving-vocabulary-mismatch-offline.md) · <https://github.com/MinishLab/model2vec> · <https://github.com/dleemiller/WordLlama>
