---
type: analysis
title: "Beyond grep: which retrieval layer this bundle should adopt, measured against its own failure modes"
description: A research spike prompted by the C− retrieval grade — decomposes the measured gap into vocabulary mismatch, missing ranking, and all-or-nothing matching; reads doma (single-binary BM25) against the toolchain's zero-dependency doctrine; measures in-session that a stdlib Elixir BM25 over the live tree builds in ~7 s and answers in ≲0.2 s with visibly better recall than grep on two gold-set misses; and recommends an in-house mix brain.search ranked-lexical layer, with tier-2 embeddings unchanged as the semantic graduation and the doma binary declined.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02 — feasibility probe run against the live working tree; doma README, its release post, and field material fetched the same day"
tags: [meta, analysis, retrieval, search, bm25, lexical-search, dedup, recall, tooling, doma]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T09:30:00Z
  channel: agent-authored
  agent: "Claude Code agent, retrieval research-spike session"
  why: "the operator asked for a research spike on improving the repo's grep-primary search, with doma considered amongst the options"
---

# Beyond grep: which retrieval layer this bundle should adopt

**Question.** The
[615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)
graded retrieval C− — "grep + LLM-in-context; 32% plain recall; field has moved
past this" — and recommended firing the tier-2 trigger the
[vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
defined. The operator asked for a research spike on how retrieval could be
improved, with [doma](/knowledge/SWE/agentic/code-context/doma.md) — a
single-binary BM25 search released this week — considered amongst the options.

**Bottom line.** Ranked lexical retrieval is buildable *inside* the
toolchain's zero-dependency, offline constraints — a `mix brain.search` running
BM25 over heading-level chunks, doma's shape without doma's binary — and it
fixes the ranking, saturation, and partial-match components of the C−. It
cannot fix the *dominant* measured failure, vocabulary mismatch: no lexical
layer scores a term that isn't there, doma included (its own scope list says
so). So the recommendation is layered: build the lexical floor in-house now,
give it its own recall trend line, and leave the prior analysis's tier-2
graduation — cached brute-force embeddings, no vector DB — unchanged as the
semantic layer above it. The two compose rather than compete; the doma binary
itself is declined as a dependency while its design is adopted as the
template.

## What the C− is actually made of

The grade compresses several distinct failures. Separating them matters
because the candidate fixes split cleanly across the line:

1. **Vocabulary mismatch — the dominant, semantic failure.** "pollution" never
   finds the concept titled "poisoning"; "lost in the middle" shares zero
   tokens with "context rot". The [dedup probe](/meta/evals/dedup-probe.md)
   measures this directly: plain recall 8/29 against 24/29 once the agent
   generates synonym variants. Ranking cannot help here — a term absent from
   the document contributes zero score under any lexical weighting.
2. **No ranking, so clusters saturate.** grep returns an unranked, exhaustive
   hit set: the prior analysis measured `"agent loop"` → 8 undifferentiated
   files at 39 concepts, and the corpus is now 1,329 markdown files. The
   probe's match-set-size column exists precisely because surfacing the right
   document inside a saturated result set is itself a failure mode.
3. **All-or-nothing matching.** A natural multi-word query hits only where its
   exact substring lands. "stale branch not updating" found nothing in the
   original probe; a scored backend credits partial term overlap.
4. **The compensator is the agent's own loop.** "The LLM is currently the
   semantic-search layer" (vector-DB analysis) — synonym expansion works, but
   it costs N separate greps per phrasing plus the turns to reason over
   unranked unions. This is exactly the behavior doma's author built against:
   "I wanted Claude to stop grepping wildly all over the place"
   ([release post](/knowledge/SWE/agentic/code-context/sources/doma-release-post.md)).

The prior analysis saw failure 2 clearly — it credited lexical engines with
"relevance ranking and stemming/prefix — which fix the *other* failure mode
(cluster saturation)" — but priced ranked lexical search only as a service
(Meilisearch/Typesense) and rightly rejected the service. The in-house form
dissolves that objection; it simply wasn't on that analysis's table.

## doma, read closely

The [reference](/knowledge/SWE/agentic/code-context/doma.md) holds the full
capture. What matters for this decision:

**Three design decisions transfer directly.** (a) *Chunk at markdown heading
boundaries and return passage-level hits with a breadcrumb and snippet* — for
an OKF bundle whose documents are heading-structured prose, this is the right
retrieval unit, and breadcrumb-plus-snippet is the right agent-facing output
(top-k passages, `--json`, no server). (b) *The index is a disposable cache* —
gitignored, freshness-checked against disk ("a query … never trusts blindly"),
deterministic to the byte. That is this repo's
[derived-views doctrine](/meta/doctrine/derived-views-stay-disposable.md)
implemented independently. (c) *Named corpuses* — scoped views of the tree
queried by name, defined in one committed file.

**Two facts disqualify adopting the binary.** First, the
[coding standards](/meta/policy/elixir-coding-standards.md) admission rule:
toolchain checks run "offline as a plain `mix` task with no dependencies". A
per-platform prebuilt binary in another language, from a day-old bus-factor-one
project whose author states "I made doma for myself and don't plan to put much
ongoing work into it", is a dependency in exactly the sense the rule exists to
refuse — MIT license and sympathetic engineering notwithstanding (and the
release post itself campaigns against dependency bloat and supply-chain risk;
adopting a stranger's fresh binary would be the ironic reading of it). Second,
the ceiling: doma tokenizes "with no stemming and no stopwords" and scopes out
"embeddings or models of any kind", so it is purely lexical — the release
post's "semantically relevant results" is relevance *ranking*, not semantics,
and failure 1 survives it intact.

## Feasibility, measured rather than assumed

A stdlib-only Elixir BM25 (naive: regex tokenizer, single-threaded, no
caching) was run against the live working tree in-session: 1,329 files
(`deprecated/` excluded) → 9,280 heading-level chunks, 20,879 terms. Index
build: **7.2 s**; queries: **21–209 ms**. Result quality on gold-set misses,
checked by hand:

- "lost in the middle" — a **zero-hit grep miss** in the original probe — now
  ranks `beliefs/glossary/lost-in-the-middle.md` in the top 5 on partial term
  overlap alone, no synonym expansion involved.
- "codebase graph" — also a grep miss — ranks the `code-context/` documents
  top-3.
- "context pollution" still resolves to documents *about* the
  pollution/poisoning mismatch rather than the poisoning concept itself:
  failure 1 surviving a ranked lexical layer, exactly as predicted.

Two operational readings. A ~7 s build is fine for CI and probe use but not
for every agent query; the fixes are doma's own patterns — a gitignored,
content-hash-keyed index cache, and/or **corpus scoping**: `meta/threads/`
alone is 46% of corpus words and is record layer, not knowledge, so a default
corpus that excludes thread bodies (with a flag for the full sweep) is both
faster and less noisy. A tuned implementation also has real headroom over the
naive probe.

## The options, weighed

| Option | Fixes | Costs | Verdict |
|---|---|---|---|
| Status quo (grep + synonym expansion + LLM-in-context) | 1 (partially, at loop cost) | the C− stands | baseline |
| Adopt the doma binary | 2, 3 | external binary dependency; supply-chain trust in a day-old project; still lexical | decline as dependency; adopt as design template |
| **In-house `mix brain.search` (BM25, heading chunks)** | 2, 3, and collapses 4's N greps into one ranked query | a small pure-Elixir module to build and maintain; still lexical | **recommended now** |
| SQLite FTS5 via `exqlite` | 2, 3 | a NIF dependency for what ~200 lines of stdlib Elixir buys | decline |
| Meilisearch/Typesense/tantivy | 2, 3, typo-tolerance | services/deps; typo-tolerance bridges none of the measured misses | decline (standing verdict, unchanged) |
| Committed search index in CI (pkb/Wuphf field pattern) | — | commits a rebuildable binary artifact; the registry precedent commits human-readable views only | decline; gitignored cache instead |
| Tier-2 cached embeddings (prior analysis) | 1 | the embedding model is the real dependency (local model or network) | keep as the ratified graduation, unchanged |
| `mix brain.query` facet filter ([proposed plan](/meta/plans/frontmatter-facet-query.md)) | structured queries (different axis) | — | complementary; its plan already scopes itself apart from this decision |
| Graph-shaped context (GitNexus/Codebase-Memory class) | structure supply, not recall | heavy stack | out of scope — the tree, links, and route tags already carry structure |

The field corroboration for the hybrid end-state: the surveyed
[code-context](https://github.com/infino-ai/code-context) plugin (r/LLMDevs,
2026-07-16) ships BM25 fused with local-model embeddings as an MCP server —
lexical floor plus semantic layer, which is precisely the composition the
tiering here arrives at, minus the server and the protocol.

## Recommendation

1. **Build `mix brain.search`** — BM25 over heading-level chunks; frontmatter
   `title`/`description`/`tags` boosted over body; breadcrumb + snippet + score
   output, `--json` for agents, top-k default 10. Zero dependencies, offline,
   deterministic; default corpus excludes `meta/threads/` bodies, `--all`
   sweeps everything. Start with per-invocation indexing; add the gitignored
   hash-keyed cache only if measured use demands it.
2. **Wire it into `/intake` dedup**: the tier-1 synonym expansion stays, but
   its 3–5 phrasings become *one* ranked query over the union of terms instead
   of N separate greps over an unranked corpus.
3. **Give the ranked backend its own probe trend line** beside plain and
   expanded in the [dedup probe](/meta/evals/dedup-probe.md) — implementing the
   re-evaluation's "report plain and expanded recall as separate trend lines"
   so the tier-2 trigger stays readable off the ranked figure, not muddied by
   it.
4. **Leave tier-2 embeddings as specified** — cached vectors, brute-force
   cosine, no vector DB, adopted on the probe's signal as an operator-ratified
   crossing. Once both layers exist, hybrid fusion (BM25 + cosine) is a
   composition of parts already in hand, not a new system.
5. **Declines**, for the record: doma-as-dependency, FTS5, external engines,
   committed index artifacts.

Per [plan-vs-capture](/meta/policy/plan-vs-capture.md) this analysis is the
judgment, not the commitment: if the operator ratifies the direction, the
`brain.search` build decisions (chunker reuse against the existing scanners,
corpus definition, probe wiring, cache format) land as a `type: plan` with a
structured body before code.

## Relation to other documents

- [vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
  — the tier architecture this spike extends downward: its tier 1 (expansion)
  and tier 2 (cached embeddings) stand; the ranked lexical floor slots between
  them.
- [615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)
  — the C− grade and the field movement (Wuphf, pkb) this spike answers.
- [when would this brain need a database](/meta/tutorials/when-would-this-brain-need-a-database.md)
  / [derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md)
  — the recommended layer stays on the file side of the line: an in-memory or
  gitignored index is a disposable derived view, never a second truth.
- [doma reference](/knowledge/SWE/agentic/code-context/doma.md) and
  [release post](/knowledge/SWE/agentic/code-context/sources/doma-release-post.md)
  — the design template and its primary source.
- Glossary: [BM25](/beliefs/glossary/bm25.md) ·
  [lexical search](/beliefs/glossary/lexical-search.md) ·
  [hybrid search](/beliefs/glossary/hybrid-search.md) ·
  [synonym expansion](/beliefs/glossary/synonym-expansion.md) ·
  [recall probe](/beliefs/glossary/recall-probe.md).
