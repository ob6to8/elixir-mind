---
id: em:35a507
type: concept
title: WordPiece
description: The subword tokenization algorithm of BERT-family models — each word is split by greedy longest-prefix matching against a fixed vocabulary, non-initial pieces carry a "##" continuation prefix, and a word with no matching prefix falls back to the [UNK] token.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, tokenization, nlp]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T00:50:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread and its vocabulary-mismatch analysis"
---

# WordPiece

Subword splitting is what lets a bounded vocabulary (tens of thousands of
pieces) cover an open-ended lexicon, and greedy longest-match makes the
algorithm implementable in a few dozen lines — the property that let this
bundle's static-embedding probe run tokenization with the standard library
alone. Distinct from BPE, which builds its vocabulary by merge frequency;
WordPiece selects merges by likelihood gain, but at inference both reduce to
matching against a fixed piece vocabulary.

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md) · [solving vocabulary mismatch offline](/meta/analysis/solving-vocabulary-mismatch-offline.md)
