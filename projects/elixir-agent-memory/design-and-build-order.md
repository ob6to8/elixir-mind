---
id: em:50bbc3
type: plan
title: "Elixir agent memory — design and build order"
description: Architecture and build sequence for the file-canonical recall sidecar — SQLite FTS5 + Bumblebee embeddings as disposable derived indexes over a markdown bundle, hybrid recall and dedup-candidate APIs over lib/CLI/MCP surfaces, an offline recall@k eval harness, and the incumbent differentiation that scopes v1.
status: proposed
tags: [projects, elixir-agent-memory, plan, architecture, retrieval, embeddings, fts5, bumblebee, mcp]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T21:28:00Z
  channel: agent-authored
  agent: "Claude Code agent, memory-system research spike session"
  why: "records the engine's design decisions and build sequence before implementation begins in its own repository"
---

# Elixir agent memory — design and build order

**The problem.** Three converging needs (the hub's
[three consumers](/projects/elixir-agent-memory.md)) want one artifact: recall
over a file-canonical markdown corpus that is better than grep, cheaper than a
vector-DB service, local, and honest about its own hit rate. The 2026 Elixir
memory crop answers a different question (store-canonical memory databases);
the tier-2 contract in the
[vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
answers this one but has no implementation.

## Current state (the ecosystem, 2026-08-01)

Enumerated in the gap sweep (scoped findings in the
[strategy analysis](/meta/analysis/agent-memory-strategy-for-elixir-mind.md)):
~15 single-author Elixir memory experiments, all Jan–Jun 2026, none over 30
stars or 2k downloads; `jido_memory` 1.0.0 is the Jido-official plugin
(ETS/Redis providers, signal auto-capture), `recollect` the closest technical
cousin (pgvector/sqlite-vec + Bumblebee MiniLM + LLM extraction),
`graphonomous` the deepest MCP server (SQLite+HNSW, belief revision,
self-reported LongMemEval), `jiyi` the closest service shape (pgvector +
anubis_mcp + optional Bumblebee), Arcana (320 stars) the mature document-RAG
substrate. All are store-canonical; none is eval-first; none treats an
existing curated bundle as the source of truth.

## Desired state

```
engine (its own repo; this brain stays deps: [])
├── ingest      bundle scan → doc records {id?, path, title, description, tags, body, content_hash}
│               frontmatter-aware (OKF em: ids first-class; plain markdown degrades gracefully)
├── indexes     all derived, all rebuildable, one SQLite file
│   ├── lexical    FTS5 table (BM25) over title/description/tags/body   [tier L]
│   └── semantic   embeddings BLOB keyed by content_hash                [tier S]
│                  brute-force Nx cosine at query time — no ANN below ~100k docs
├── recall      query → L ∪ S candidates → reciprocal-rank-fusion → top-k {path, id, score, channel}
├── dedup       title+description → S (falling back to L) → top-5 nearest existing docs
├── surfaces    Elixir API · CLI --json · MCP server (anubis_mcp, stdio)
└── eval        recall@k over gold-set tables (dedup-probe row format as the interchange)
                offline in CI via a recorded-embeddings fixture provider
```

## File-tree (new repo)

```
lib/engine.ex                    # NEW — public API: scan/reindex/recall/dedup_candidates
lib/engine/doc.ex                # NEW — the doc record + frontmatter parse (subset, tolerant)
lib/engine/store.ex              # NEW — SQLite lifecycle, FTS5 schema, vector table, content-hash bookkeeping
lib/engine/lexical.ex            # NEW — FTS5 query + BM25 scoring
lib/engine/semantic.ex           # NEW — embedding cache + Nx cosine top-k
lib/engine/embedder.ex           # NEW — behaviour: embed(texts) :: {:ok, [vec]} — the test seam
lib/engine/embedder/bumblebee.ex # NEW — Nx.Serving impl (all-MiniLM-L6-v2 default, 384-d)
lib/engine/embedder/recorded.ex  # NEW — fixture impl for deterministic CI
lib/engine/fuse.ex               # NEW — reciprocal-rank fusion of channel rankings
lib/engine/cli.ex                # NEW — escript: reindex/recall/dedup --json
lib/engine/mcp.ex                # NEW — anubis_mcp server exposing the three verbs
eval/gold/*.md                   # NEW — gold-set tables (seeded from elixir-mind's dedup probe)
eval/engine_eval.exs             # NEW — recall@k report, plain vs hybrid, per gold set
```

## Call topology

```
production:  CLI/MCP → Engine.recall → Store (FTS5) ─┐
                                     → Semantic ──────┼→ Fuse → hits
                                        └ Embedder.Bumblebee (Nx.Serving, lazy-started)
test:        ExUnit → Engine.recall → Store (tmp SQLite, fixture bundle)
                                     → Semantic
                                        └ Embedder.Recorded (vectors from committed fixture)
```

The embedder behaviour is the only substituted seam; FTS5 and fusion run real
in both topologies.

## Signatures (outline level)

```elixir
@spec scan(bundle_path :: String.t()) :: {:ok, [Doc.t()]} | {:error, term()}
@spec reindex(bundle_path :: String.t(), opts :: keyword()) :: {:ok, Stats.t()} | {:error, term()}
@spec recall(query :: String.t(), k :: pos_integer(), opts :: keyword()) :: {:ok, [Hit.t()]}
@spec dedup_candidates(title :: String.t(), description :: String.t(), k :: pos_integer()) :: {:ok, [Hit.t()]}
# Hit.t() :: %Hit{path: String.t(), id: String.t() | nil, score: float(), channels: [:lexical | :semantic]}
```

## Boundary decisions

- **The bundle detects nothing; the engine detects staleness.** Content hashes
  decide re-embedding lazily; a `reindex` is always safe and never required
  for correctness of the files themselves.
- **The engine owns no writes to the bundle.** It is read-only over canonical
  files; promotion, filing, and governance stay with the consuming agent
  (this brain's contract, or a fleet's librarian broker).
- **Recall returns pointers, never synthesized content** — paths, ids, scores.
  Provenance-preserving by construction; the consumer reads the file.
- **The LLM stays out of the engine's core.** Query expansion (tier-1) remains
  the calling agent's job; the engine is deterministic given its index.
- **elixir-mind integration is advisory and optional**: the intake agent calls
  the CLI when installed (tier-2 dedup candidates); nothing in this repo's
  gate suite ever depends on it (per the offline/zero-dependency
  [admission rule](/meta/policy/elixir-coding-standards.md)).

## Build order

1. **Tier L** — ingest + FTS5 + BM25 recall + CLI. Zero ML; already past grep
   (ranking, stemming/prefix — the cluster-saturation fix the recall analysis
   named). This is the search-progression step the corpus is actually at
   (grep → BM25 at ~1k docs, per the
   [markdown-memory capture](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md)).
2. **Eval harness** — gold-set parser + recall@k report, seeded with a
   snapshot of this brain's [dedup-probe](/meta/evals/dedup-probe.md) gold
   set; recorded-embeddings fixture provider so CI is offline and
   deterministic. Built second so every later tier lands with a measured
   delta, per
   [an instrument without a control measures itself](/beliefs/an-instrument-without-a-control-measures-itself.md).
3. **Tier S** — Bumblebee embedder (all-MiniLM-L6-v2, 384-d) + content-hash
   vector cache + brute-force Nx cosine; hybrid fusion; `dedup_candidates`.
4. **MCP surface** — anubis_mcp stdio server exposing the three verbs.
5. **elixir-mind side-by-side probe** — run the engine against the live gold
   set beside tier-1 synonym expansion; publish plain/expanded/engine@k in
   the eval doc. Adoption into `/intake` remains an operator decision gated
   on that measurement.
6. **Deferred** (each graduates to its own plan when built): frontmatter-link
   graph channel; session-start router (the
   [mex](/knowledge/SWE/agentic/code-context/mex.md) borrow); librarian write
   lane; temporal/supersession signals (blocked on the
   [epistemic overlay](/meta/plans/epistemic-overlay.md) modeling
   supersession first); `jido_memory` provider adapter.

## Decision list

- **Recommended shape:** the sidecar above — SQLite single-file derived store,
  FTS5 + Bumblebee, RRF hybrid, three verbs, eval-first.
- **Rejected: store-canonical memory database** (the jido_memory/recollect/
  Mem0 shape) — inverts the files-canonical doctrine this brain runs on and
  the field's proven end (curated files) sits on.
- **Rejected: ANN index (hnswlib/sqlite-vec) in v1** — the no-ANN arithmetic
  (≈1.5 MB per 1k docs at 384-d; brute-force cosine sub-millisecond) holds
  until ~100k docs; sqlite-vec additionally has a paused hex wrapper.
- **Rejected: LLM extraction in the engine** — what to remember is a
  governance decision, not an index property.
- **Embedder default Bumblebee+EXLA; ONNX (ortex/ex_embed) noted as the lean
  alternative** if EXLA compile weight proves hostile to small installs.
- **Open: the name.** `engram` returned zero hits on hex.pm in the 2026-08-01
  gap sweep and fits (an engram is the physical trace of a memory); operator
  ratifies before the repo is created.
- **Open: seed-corpus breadth.** v1 targets OKF bundles (frontmatter-aware);
  whether plain-markdown vaults (Obsidian-shaped) are in scope for v1 or
  deferred affects only `Doc` parsing tolerance.
- **Assumption to re-verify at build time (refresh rule):** anubis_mcp still
  the de-facto MCP SDK; Bumblebee still current; the incumbent map above
  unchanged enough that the differentiation holds.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:50bbc3">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-01-memory-system-research-spike (2026-08-01)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:50bbc3`]**  (co-feeds: `em:6733b4`)

The Elixir gap check is back, and it sharpens the thesis: the niche is not empty — ~15 single-author experiments appeared in the last six months (jido_memory, mnemosyne, jiyi, recollect, graphonomous, plus Arcana as a mature RAG substrate) — but every entrant is a store-canonical memory database in the Mem0 mold, none has credible evaluation, and none is file-canonical. The differentiated open slot is exactly what this brain would want: a derived-index recall sidecar where markdown stays the source of truth. All building blocks confirmed active (anubis_mcp as de-facto MCP standard, Bumblebee text embeddings, exqlite with FTS5 compiled in, pgvector/sqlite-vec/hnswlib). mex turns out to be TypeScript at ~1.2k stars; SuperLocalMemory is Python at ~201 stars.

---

**[`em:50bbc3`]**  (co-feeds: `em:6733b4`)

- **The Elixir verdict.** Gap: real but not empty — the sweep enumerated ~35 hex.pm searches, GitHub, Elixir Forum, and both awesome-lists, finding ~15 single-author 2026 experiments, all store-canonical, none above 30 stars, no Mem0 port, no official MCP-org Elixir SDK, and no file-canonical eval-first entrant. Viable: anubis_mcp 1.14.0, Bumblebee 0.7.1, exqlite with FTS5 compiled in, pgvector at ~1M downloads. Advised: yes, as the [elixir-agent-memory project](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/projects/elixir-agent-memory.md) with a [structured plan](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/projects/elixir-agent-memory/design-and-build-order.md) — FTS5 tier and eval harness first, adoption into `/intake` gated on a side-by-side gold-set measurement, with the crowding risk stated (fifteen entrants in six months; the plan's refresh rule re-checks the incumbent map before build).
