---
type: plan
title: "mix brain.search: ranked lexical retrieval with a static-embedding tier"
description: Build the retrieval layer the two 2026-08 spike analyses recommend — a zero-dependency BM25 over heading-level chunks with stemming and corpus scoping, wired into intake dedup and the recall probe, then a fetch-once static-embedding tier fused by reciprocal rank fusion — emitted as four sequenced matters.
status: proposed
provenance: "Claude Code session (Claude Fable 5), 2026-08-04 — scoped from the beyond-grep and vocabulary-mismatch analyses at operator direction"
tags: [meta, plan, retrieval, search, bm25, static-embeddings, tooling, elixir]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "the operator directed the session's open retrieval recommendation be turned into matters, with an encompassing plan where sequencing is real"
  from: [/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md]
---

# mix brain.search: ranked lexical retrieval with a static-embedding tier

## Problem

Retrieval is the bundle's weakest measured dimension (C− in the
[615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)).
The [beyond-grep analysis](/meta/analysis/beyond-grep-ranked-retrieval-options.md)
decomposed the gap — vocabulary mismatch, no ranking, all-or-nothing matching —
and recommended an in-house BM25 layer (doma's design, no binary dependency);
the [vocabulary-mismatch companion](/meta/analysis/solving-vocabulary-mismatch-offline.md)
measured a static-embedding tier against the live gold set (recall@10 8/30 →
25/30 at 0.8 ms/query; union with tier-1 expansion 29/30). Both feasibility
premises were measured in-session, and both analyses close by pointing here:
the build decisions land as this plan before code.

## Current-state tree

```
retrieval today
├── grep/rg over the tree            # unranked, exact-substring, saturating
├── /intake dedup, tier 1            # agent generates 3–5 phrasings → N greps
├── LLM-in-context                   # the de-facto semantic layer, costs turns
└── mix brain.dedup_probe            # substring backend; plain + expanded lines
```

## Desired-state tree

```
retrieval after this plan
├── ElixirMind.Search                        # zero-dep core
│   ├── chunk: heading-level, fence-aware    # doma's unit, OKF-shaped
│   ├── tokenize: lowercase + camelCase/_ splits + Porter stemming
│   ├── bm25: k1=1.2 b=0.75, field boosts (title/description/tags)
│   └── tier 1.5: potion vectors (fetch-once cache) + cosine + RRF fusion
├── mix brain.search                         # CLI: corpora, top-k, --json,
│                                            # breadcrumb + snippet output
├── /intake dedup, tier 1'                   # expanded phrasings → ONE ranked query
└── mix brain.dedup_probe                    # plain · expanded · ranked · tier-1.5
                                             # trend lines, separately readable
```

## File-tree diff

```
lib/elixir_mind/search.ex            # NEW — chunker, tokenizer, BM25, index, query
lib/elixir_mind/search/embed.ex      # NEW (order 4) — model cache, WordPiece, pooling, RRF
lib/mix/tasks/brain.search.ex        # NEW — the CLI surface
test/elixir_mind/search_test.exs     # NEW — unit + scenario coverage
lib/elixir_mind/dedup_probe.ex       # MODIFIED — ranked (and later tier-1.5) backend + trend lines
.claude/skills/intake/SKILL.md       # MODIFIED — dedup step queries the ranked backend
.gitignore                           # MODIFIED — the model cache path
```

## Signatures

```elixir
@spec chunk(path :: String.t(), body :: String.t()) :: [Chunk.t()]
@spec tokenize(text :: String.t()) :: [String.t()]        # stems applied
@spec build_index(paths :: [String.t()]) :: Index.t()      # in-memory, per invocation
@spec query(Index.t(), query :: String.t(), opts :: keyword()) :: [Hit.t()]
# Hit: %{path, heading, score, snippet}                    # breadcrumb + ~200-byte window

# order 4
@spec ensure_model(cache_dir :: String.t()) :: {:ok, Model.t()} | :absent  # sha256-pinned fetch-once
@spec embed(Model.t(), text :: String.t()) :: [float()]
@spec fuse(bm25 :: [Hit.t()], semantic :: [Hit.t()]) :: [Hit.t()]          # RRF, k = 60
```

## Boundary decisions

- **`ElixirMind.Search` owns chunking, tokenization, and scoring**; the mix
  task owns corpus selection, flags, and rendering. The probe calls the core,
  never the task.
- **Index is in-memory, rebuilt per invocation** (measured: ~7 s naive over the
  full tree, less over the default corpus). A persisted cache is a deferred
  decision with a measurement trigger, not part of this build.
- **Default corpus excludes `meta/threads/` bodies** (46% of corpus words,
  record layer); `--all` sweeps everything.
- **The model file is a disposable cached asset, never committed**: fetch-once
  into a gitignored path, pinned by SHA-256; every semantic call degrades to
  BM25-only when the file is absent
  ([derived-views](/meta/doctrine/derived-views-stay-disposable.md) intact).

## Anchors

- Frontmatter parsing and doc enumeration: reuse the registry scanner's
  approach (`ElixirMind.Registry.scan/1`) rather than a second parser.
- Probe integration: `ElixirMind.DedupProbe`'s backend seam and the generated
  `## Baseline` table in [the gold doc](/meta/evals/dedup-probe.md).
- Intake wiring: the dedup step of
  [`/intake`](/.claude/skills/intake/SKILL.md) (tier-1 synonym expansion stays;
  its phrasings become one ranked query).
- Measured feasibility baselines to hold: BM25 build ≲ 7 s full-tree / queries
  ≲ 0.2 s; tier-1.5 embed-all ≈ 3.3 s / 0.8 ms per query; recall floors from
  the [companion analysis](/meta/analysis/solving-vocabulary-mismatch-offline.md).

## Sequence

| Order | Matter | Intent |
|---|---|---|
| 1 | [brain-search-bm25-core](/meta/matters/brain-search-bm25-core.md) | the pure core: chunker, tokenizer + stemming, BM25, in-memory index, tests |
| 2 | [brain-search-cli-and-corpora](/meta/matters/brain-search-cli-and-corpora.md) | `mix brain.search`: corpora, top-k, `--json`, breadcrumb + snippet |
| 3 | [brain-search-probe-and-intake-wiring](/meta/matters/brain-search-probe-and-intake-wiring.md) | ranked trend line in the probe; `/intake` dedup queries it |
| 4 | [brain-search-static-embedding-tier](/meta/matters/brain-search-static-embedding-tier.md) | tier 1.5: model cache, embedding, RRF fusion, its own trend line |

Each order lands green alone (core with tests before any CLI; wiring after the
surface it wires; the semantic tier last, purely additive). 1→2→3 are strict
prerequisites in that order; 4 needs 1–2 and is sequenced after 3 so its trend
line lands on the probe seam 3 builds.

## Decisions

- **Recommended shape:** as above — in-house zero-dep BM25 first, static
  embeddings as a data-file tier, fusion by
  [RRF](/beliefs/glossary/reciprocal-rank-fusion.md).
- **Rejected** (adjudicated in the analyses, carried here as settled): the doma
  binary as a dependency; SQLite FTS5; external engines/services; committing
  index artifacts; a standalone vector DB.
- **Open questions:** (a) tier 1.5 embeds `title+description+tags` (the
  measured configuration) — body-chunk embeddings are a follow-on measurement,
  not assumed; (b) the persisted-index trigger (adopt only if the default
  corpus's build time is measured to matter in practice); (c) potion-base-2M
  (~8 MB) as fallback if the 30 MB cache is unwanted.
