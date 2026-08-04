---
type: matter
title: "brain.search build 4: the static-embedding tier"
description: Tier 1.5 — fetch potion-base-8M once into a gitignored cache pinned by SHA-256, embed with stdlib-only safetensors parsing, WordPiece, and mean pooling, fuse with BM25 by reciprocal rank fusion (k=60), degrade to BM25-only when the model file is absent, and give the tier its own probe trend line.
status: open
model: Claude Opus 5
plan: /meta/plans/brain-search-ranked-retrieval.md
order: 4
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, retrieval, search, static-embeddings, hybrid-search, elixir]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "emitted as order 4 of the brain-search plan's build sequence"
---

# brain.search build 4: the static-embedding tier

Deliver `lib/elixir_mind/search/embed.ex` per the
[plan](/meta/plans/brain-search-ranked-retrieval.md): `ensure_model/1`
(fetch-once of [potion-base-8M](/beliefs/glossary/model2vec.md) —
`model.safetensors` + `tokenizer.json` — into a gitignored cache, SHA-256
pinned, `:absent` without network and no retry storm), stdlib parsing
([safetensors](/beliefs/glossary/safetensors.md) header + raw F32
`[29528×256]`; [WordPiece](/beliefs/glossary/wordpiece.md) greedy
longest-prefix with BERT normalization), mean pooling, cosine ranking over
doc `title+description+tags` (the measured configuration), and
[RRF](/beliefs/glossary/reciprocal-rank-fusion.md) fusion (k = 60) with the
BM25 list in `query/3`. Every semantic path degrades to BM25-only when the
model is absent. The probe gains the tier-1.5 trend line on the seam build 3
established. Recall floors to hold: the
[companion analysis](/meta/analysis/solving-vocabulary-mismatch-offline.md)'s
measured 25/30 @10 and 29/30 union. The working probe scripts from the spike
session are described in that analysis; the implementation is fresh code under
the repo's standards, not a paste-in.

## Model

The build's widest un-oracled surface: tokenizer parity with BERT
normalization, fetch/degradation behavior, and fusion quality are judged
rather than gate-checked, and a wrong shape in `lib/` propagates — the
roster's Opus row.
