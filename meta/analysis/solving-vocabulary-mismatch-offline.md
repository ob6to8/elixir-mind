---
type: analysis
title: "Solving vocabulary mismatch: the alternatives map, and a measured static-embedding answer"
description: The follow-up spike to beyond-grep — maps every alternative retrieval approach by which failure it addresses and what runtime it costs, then measures the promising middle against the live gold set — a 30 MB static embedding model (potion-base-8M) run with ~150 lines of stdlib Elixir lifts recall@10 from 8/30 to 25/30 at 0.8 ms per query, and its union with the existing synonym-expansion tier reaches 29/30, leaving only fully narrative phrasings to the LLM or a full transformer tier.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02 — static-embedding probe run against the live working tree and gold set; model2vec and WordLlama claims fetched from their repositories the same day"
tags: [meta, analysis, retrieval, search, embeddings, static-embeddings, vocabulary-mismatch, dedup, recall, tooling]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T10:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, retrieval research-spike session"
  why: "the operator accepted the beyond-grep recommendation and asked what other alternative approaches exist and whether vocabulary mismatch (its failure 1) can be solved"
---

# Solving vocabulary mismatch: the alternatives map, and a measured static-embedding answer

**Question.** The
[beyond-grep spike](/meta/analysis/beyond-grep-ranked-retrieval-options.md)
recommended an in-house BM25 layer and left its failure 1 — vocabulary
mismatch, the dominant recall failure — to a deferred embeddings tier. What
other approaches exist beyond that spike's table, and can failure 1 be solved
now, within the toolchain's offline, zero-dependency constraints?

**Bottom line.** Yes, substantially, and it was measured rather than argued:
a **static embedding model treated as a data file** — potion-base-8M, 30 MB,
MIT, no neural runtime — driven by ~150 lines of stdlib Elixir (WordPiece
tokenize → token-vector mean → cosine) lifts gold-set recall@10 from **8/30 to
25/30** at 0.8 ms per query, recovering every classic synonym-gap miss
("long context degradation" → rank 1, "codebase graph" → rank 2, "stale
branch" → rank 3). Its miss profile is *complementary* to the existing
synonym-expansion tier: the union of the two reaches **29/30**, and the single
joint miss is a fully narrative phrasing — the class only a contextual
(transformer) embedding or the in-loop LLM can bridge. The recommended ladder
becomes: stemming and BM25 now, a curated alias layer as filing convention,
the static-embedding layer as a cheap "tier 1.5", and the full tier-2 held for
the narrative residue if the trend ever demands it.

## The map of alternatives

Grouped by which failure they address; "runtime cost" is what the approach
adds to the query path.

| Approach | Bridges | Runtime cost | Verdict |
|---|---|---|---|
| Stemming (Porter-class) in the tokenizer | morphology only (update/updating) | none — ~200 lines, offline | fold into `mix brain.search` |
| Trigram/edit-distance fuzziness | typos only | none | already adjudicated: bridges none of the measured misses |
| Document-side **aliases** (frontmatter field; SKOS `altLabel` analog) | every *recorded* synonym, mechanically, no LLM in the query loop | none — index-time expansion | adopt as filing convention; the gold set's variants column is this registry in embryo |
| Glossary as thesaurus (two-hop: query → term doc → citing docs) | terms the glossary already holds — 473 concept docs with aliases in prose | none | already half-built; the "lost in the middle" case below is it working |
| Query-side LLM expansion (current tier 1) | anything the model can paraphrase, including narrative | agent turns per search | keep at intake; not available to mechanical callers |
| Pseudo-relevance feedback (RM3-class) | co-occurring terms of top-k hits | none, but drift-prone | note as option; measure only if aliases+embeddings leave a gap |
| HyDE (LLM writes a hypothetical doc, embed that) | narrative queries | LLM **and** embedding per query | out — online query path |
| Learned sparse (SPLADE-class) / late interaction (ColBERT-class) | synonymy via neural term weighting | a model at index and query time; ColBERT multiplies storage | out — the runtime the doctrine refuses |
| **Static embeddings (model2vec / WordLlama class)** | unknown synonymy, terminological paraphrase | a 8–30 MB data file; arithmetic only | **the measured middle — see below** |
| Full transformer embeddings (tier 2: Bumblebee/Nx local, or API) | everything above plus narrative/idiomatic queries | a real model runtime or a network call | unchanged: the ratified graduation, now needed only for the residue |
| GraphRAG-class entity graphs | multi-hop structure, not recall | LLM-built graph | out — the tree, links, and route tags are the hand-built equivalent |
| Whole-corpus-in-context | everything, in principle | ~1M+ tokens per query (the corpus is ~840k words) | out as a search substrate; it is a per-query context spend |
| Agentic iterative search (reformulate-and-retry loops) | anything, eventually | turns | it is the status quo being economized, not an alternative |

Field markers for the middle row, 2026: Qdrant publishes a
[static-embeddings tutorial](https://qdrant.tech/documentation/tutorials-search-engineering/static-embeddings/)
positioning them for offline use, and the arXiv niche is active
(Luxical, "high-speed lexical-dense text embeddings", 2025; MonaVec, a
"training-free embedded vector search kernel" for edge/offline, 2026).

## What a static embedding model is, and why it fits here

[model2vec](https://github.com/MinishLab/model2vec) is "a technique to turn
any sentence transformer into a small, fast static embedding model": it
forward-passes the tokenizer's whole vocabulary through a teacher transformer
once, at distillation time, and keeps only the resulting per-token vectors.
Inference is then what [WordLlama](https://github.com/dleemiller/WordLlama)
(the same idea) describes as "a simple token lookup with average pooling" — no
transformer forward pass, no attention, no runtime beyond arithmetic. The
quality claim: "Model2Vec models outperform any other static embeddings (such
as GLoVe and BPEmb) by a large margin"; the cost claim: "reduces model size by
a factor up to 50 and makes models up to 500 times faster" than the teacher.
Both projects are MIT.

Concretely, potion-base-8M is one F32 tensor of shape `[29528, 256]` (30.2 MB
safetensors) plus a BERT WordPiece tokenizer — both parseable with the
standard library (safetensors is an 8-byte length, a JSON header, and raw
little-endian floats; WordPiece is greedy longest-prefix matching). The
"model" is a data file in exactly the sense the
[derived-views doctrine](/meta/doctrine/derived-views-stay-disposable.md)
tolerates: inert bytes, deterministic output, no server, no code executed from
it.

## The measurement

Run in-session against the live tree (stdlib Elixir only, ~150 lines: BERT
normalization → WordPiece → mean pool → cosine; documents represented as
`title + description + tags`):

| figure | value |
|---|---|
| corpus embedded | 783 registry docs, 3.3 s total (one-time per index build) |
| query latency | 0.8 ms average, brute-force over all docs |
| recall@1 / @5 / @10 | 14/30 · 23/30 · **25/30** |
| plain substring baseline | 8/30 |
| synonym-expanded baseline (tier 1) | 25/30 |
| **union: expanded ∪ static@10** | **29/30** |

Every specimen the beyond-grep spike classed as pure vocabulary mismatch
recovered without any variant list: "context pollution" → rank 1, "long
context degradation" → rank 1, "inference margin" → rank 1, "codebase graph"
→ rank 2, "stale branch" and "branch not updating" → rank 3.

**The miss profiles are complementary, which is the finding that sets the
architecture.** The four expanded-mode misses that static embeddings recover
are exactly the rows whose recorded variants happen not to occur as contiguous
substrings ("a mind implies agency and awareness" → rank 3, "the gen~ book's
approach…" → rank 2, "the evolutionary algorithms paper" → rank 2, "the
circles-sines-signals interactive educational displays" → rank 1). The static
misses are the *narrative* phrasings — "1400 years ago scholars solved a
problem multi-agent ai reinvented" (rank 65), "a convincing influencer and an
ai engineer…" (rank 223) — where meaning lives in the story, not the terms; a
7.5M-parameter bag-of-token-vectors has nothing to anchor on. Those rows the
expansion tier catches (the variants were recorded), leaving one joint miss
out of 30.

Two honest footnotes. "lost in the middle" scores rank 305 against its
adjudicated target, but the plain backend's match-set of 1 for that query *is*
[the glossary term doc of that exact title](/beliefs/glossary/lost-in-the-middle.md)
(`em:1b3160`, filed 2026-07-25, after the row's 2026-07-12 adjudication) —
the row's acceptable-id set has lagged the corpus, and the two-hop
glossary route already serves that query; the row should be re-adjudicated
rather than the backend blamed. And the probe embedded only
title+description+tags — body-aware chunk embeddings would plausibly lift the
narrative class too, at more vectors per doc; that is a follow-on measurement,
not a claim.

## The dependency question, stated plainly

The model file is the one genuinely new artifact class: 30 MB of upstream
binary data, not derivable from the bundle. Committing it would put opaque
megabytes in a plain-markdown repo; requiring it would break offline-first.
The design that preserves both doctrines: **fetch-once into a gitignored
cache, pinned by SHA-256, with graceful degradation** — `mix brain.search`
runs BM25-only when the file is absent and adds the semantic layer when
present. The precedent already exists: the SessionStart hook installs Elixir
itself; the toolchain has always bootstrapped its runtime from the network
while *running* offline. An 8 MB `potion-base-2M` is the fallback if size
matters more than the margin.

## Recommendation

1. **Unchanged from beyond-grep:** build `mix brain.search` (BM25, heading
   chunks) — now with Porter-class stemming in the tokenizer.
2. **Add the static-embedding layer as tier 1.5** behind the same task:
   vendored-by-hash potion model in a gitignored cache, brute-force cosine,
   fused with BM25 by reciprocal rank fusion; absent the file, lexical-only.
3. **Adopt an `aliases:` filing convention** (frontmatter, indexed by the
   search layer; the glossary keeps carrying prose aliases) so recorded
   phrasings stop depending on any model at all.
4. **Re-adjudicate the "lost in the middle" gold row** (add `em:1b3160` or
   note the glossary route) and add a static-embedding trend line to the
   probe beside plain and expanded.
5. **Tier 2 (full transformer embeddings) stays deferred** — its remaining
   justification is the narrative-query class, now measurable as the gap
   between the tier-1.5 line and expanded recall.

Per [plan-vs-capture](/meta/policy/plan-vs-capture.md), ratifying this folds
into the same `type: plan` the beyond-grep analysis anticipates — one build,
two measured layers.

## Relation to other documents

- [beyond-grep-ranked-retrieval-options](/meta/analysis/beyond-grep-ranked-retrieval-options.md)
  — the first half of the spike; this analysis resolves its failure 1 and
  refines its recommendation 4.
- [vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
  — the tier architecture; tier 1.5 sits exactly where its tier-2 design
  pointed ("an embeddings file + a linear scan, not a database"), with the
  model dependency it flagged as "the real cost to weigh" shrunk from a
  runtime to a data file.
- [dedup recall probe](/meta/evals/dedup-probe.md) — the instrument all
  figures here are scored against.
- Glossary: [lexical search](/beliefs/glossary/lexical-search.md) ·
  [hybrid search](/beliefs/glossary/hybrid-search.md) ·
  [vector database](/beliefs/glossary/vector-database.md) ·
  [synonym expansion](/beliefs/glossary/synonym-expansion.md).

# Citations

- model2vec — <https://github.com/MinishLab/model2vec>; potion-base-8M —
  <https://huggingface.co/minishlab/potion-base-8M>
- WordLlama — <https://github.com/dleemiller/WordLlama>
- Qdrant, "Static Embeddings" —
  <https://qdrant.tech/documentation/tutorials-search-engineering/static-embeddings/>
