---
type: matter
title: "brain.search build 1: the BM25 core"
description: ElixirMind.Search's pure core — heading-level fence-aware chunker, tokenizer with camelCase/underscore splits and Porter stemming, BM25 scorer (k1=1.2, b=0.75, title/description/tags boosts), in-memory index build and query — with unit tests; no CLI surface yet.
status: open
model: Claude Sonnet 5
plan: /meta/plans/brain-search-ranked-retrieval.md
order: 1
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, retrieval, search, bm25, elixir]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "emitted as order 1 of the brain-search plan's build sequence"
---

# brain.search build 1: the BM25 core

Deliver `lib/elixir_mind/search.ex` per the
[plan](/meta/plans/brain-search-ranked-retrieval.md)'s signatures and boundary
decisions: `chunk/2` (ATX heading boundaries, fence-aware — a `#` inside a
fenced block never opens a chunk), `tokenize/1` (lowercase; split on
non-alphanumerics, camelCase boundaries, underscores; Porter stemming),
`build_index/1` and `query/3` (BM25, `k1 = 1.2`, `b = 0.75`, frontmatter
`title`/`description`/`tags` boosted over body; top-k via sort or bounded
heap). In-memory only — persistence is out of scope by plan decision. Reuse
the registry scanner's frontmatter approach rather than writing a second
parser. Unit tests over fixture trees; the feasibility baselines to stay under
are in the plan's anchors. Zero dependencies, offline, deterministic.

## Model

Well-specified execution against the plan's decided shape, gated by the test
suite and the compile/format gates — the roster's Sonnet row.
