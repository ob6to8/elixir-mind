---
id: em:57087f
type: concept
title: safetensors
description: A tensor-storage format — an 8-byte little-endian header length, a JSON header mapping tensor names to dtype, shape, and byte offsets, then the raw contiguous tensor bytes — designed to be memory-mappable and safe to load, executing no code on read (unlike pickle-based checkpoints).
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, ml-infrastructure, file-formats]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T00:50:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread and its vocabulary-mismatch analysis"
---

# safetensors

The Hugging Face ecosystem's default weights format. The three-part layout is
simple enough to parse without any ML library — this bundle's static-embedding
probe read a [model2vec](/beliefs/glossary/model2vec.md) tensor with the Elixir
standard library alone — and the flat offset table is what lets loaders map
tensors in place instead of deserializing them.

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md) · [solving vocabulary mismatch offline](/meta/analysis/solving-vocabulary-mismatch-offline.md)
