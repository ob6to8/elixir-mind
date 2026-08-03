---
id: em:6733b4
type: project
title: "Elixir agent memory"
description: A BEAM-native recall-and-dedup sidecar for file-canonical knowledge bundles and agent fleets — derived, disposable indexes (SQLite FTS5 BM25 + local embeddings) over canonical markdown, served through an Elixir API, a CLI, and MCP, benchmarked on recall gold sets rather than conversational-memory benchmarks.
status: incubating
tags: [projects, agent-memory, retrieval, elixir, beam, embeddings, fts5, mcp, dedup, file-canonical]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T21:28:00Z
  channel: agent-authored
  agent: "Claude Code agent, memory-system research spike session"
  why: "operator asked to consider an Elixir-native port of the memory-spike concepts and to open a plan if the idea proved advised, viable, and a real gap"
---

# Elixir agent memory

A memory engine with the polarity most 2026 memory products invert: **files
stay canonical, the engine owns only derived state**. It scans a markdown
bundle (OKF or plain), maintains rebuildable indexes — SQLite FTS5 for BM25
lexical recall, locally-computed embeddings for semantic recall, content-hash
keyed so staleness is structural — and serves three verbs over an Elixir API,
a JSON CLI, and an MCP server: `recall` (hybrid top-k with scores and paths),
`dedup_candidates` (nearest existing documents for a proposed new one), and
`reindex`. Deleting its store loses nothing; that disposability is the design
center, taken from the
[markdown-folder-over-vector-DB migration report](/knowledge/SWE/agentic/context-engineering/markdown-folder-beat-a-vector-db-as-agent-knowledge-base.md)'s
hybrid ("files as source of truth, index derived") and from
[mex](/knowledge/SWE/agentic/code-context/mex.md)'s markdown-canonical,
database-derived split.

## The three consumers that shape it

1. **This brain's tier-2 dedup.** The
   [vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
   already specifies tier-2 exactly: embed title+description at intake,
   brute-force cosine against a content-hash-keyed cache, surface top-5
   "possible duplicates". The engine is that specification built as a
   sidecar, so this repo's `deps: []` invariant survives — the intake agent
   shells out to the engine when present, and the
   [dedup probe](/meta/evals/dedup-probe.md) gold set doubles as the engine's
   benchmark fixture.
2. **The shared canonical mind of a future BEAM fleet.** The
   [two-tier memory](/beliefs/glossary/two-tier-memory.md) model and the
   [GenServer-agents analysis](/meta/analysis/agents-as-genservers-with-per-agent-okf-mind.md)
   keep converging on one shape: agents read a shared corpus freely, writes
   serialize through a
   [librarian-write-broker](/beliefs/glossary/librarian-write-broker.md)
   whose intake dedup must be fast and in-process. This engine is that
   broker's read side, built first.
3. **The open slot in the Elixir ecosystem.** The 2026 crop of Elixir memory
   experiments is store-canonical in the Mem0 mold; the file-canonical,
   eval-first sidecar position is uncontested (scoped findings in the
   [strategy analysis](/meta/analysis/agent-memory-strategy-for-elixir-mind.md)).

## What it deliberately is not

No LLM extraction pipeline deciding what to remember (curation stays with the
operator and the consuming agent's governance); no store-of-record (the bundle
is the record); no conversational-memory benchmark theater — its published
number is recall@k on versioned gold sets of natural-phrasing queries, the
[dedup-probe](/meta/evals/dedup-probe.md) instrument generalized.

## Design records

- [Design and build order](/projects/elixir-agent-memory/design-and-build-order.md) —
  architecture, index layout, surfaces, eval harness, incumbent
  differentiation, build sequence, and open questions (including the working
  name).

## Knowledge this project rests on

- [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md) — the field this positions against
- [A folder of cross-linked markdown beat a vector DB](/knowledge/SWE/agentic/context-engineering/markdown-folder-beat-a-vector-db-as-agent-knowledge-base.md) — the files-canonical hybrid, reported from outside
- [AI agent memory management — when markdown files are all you need](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md) — the search progression (grep → BM25 → hybrid) this engine's tiers mirror
- [Would a vector DB improve recall as this bundle scales?](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md) — the tier-2 contract and the no-ANN arithmetic
- [SuperLocalMemory](/knowledge/SWE/agentic/agent-memory/superlocalmemory.md) — the maximalist counter-example: five channels, store-canonical, vendor-run benchmarks

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:6733b4">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-01-memory-system-research-spike (2026-08-01)

4 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:6733b4`]**  (co-feeds: `em:a0fbd5 em:fe3522 em:dd64c2`)

https://github.com/mex-memory/mex
https://github.com/qualixar/superlocalmemory
then

* do a research spike into alternatives, the landscape, learnings, what is hype what is proven etc
* do an analysis of this repo with respects to this strategy - what could be gained, and what might be tradeoffs, if there are any
* consider porting these concepts to an elixir native solution (if one does not already exist)
* if that idea is advised, viable, and its a gap in the market, create a plan

---

**[`em:6733b4`]**  (co-feeds: `em:50bbc3`)

The Elixir gap check is back, and it sharpens the thesis: the niche is not empty — ~15 single-author experiments appeared in the last six months (jido_memory, mnemosyne, jiyi, recollect, graphonomous, plus Arcana as a mature RAG substrate) — but every entrant is a store-canonical memory database in the Mem0 mold, none has credible evaluation, and none is file-canonical. The differentiated open slot is exactly what this brain would want: a derived-index recall sidecar where markdown stays the source of truth. All building blocks confirmed active (anubis_mcp as de-facto MCP standard, Bumblebee text embeddings, exqlite with FTS5 compiled in, pgvector/sqlite-vec/hnswlib). mex turns out to be TypeScript at ~1.2k stars; SuperLocalMemory is Python at ~201 stars.

---

**[`em:6733b4`]**  (co-feeds: `em:dd64c2`)

**In plain terms:** I read and filed both repos you pointed at, then ran two background research sweeps — one across the whole memory-tools field, one across the Elixir ecosystem. The headline from the field sweep is good news for this repo: during 2026 the leading memory vendors moved *toward* what this brain already is — Letta rebuilt its coding-agent memory on git-versioned markdown files, LangChain shipped a markdown-wiki memory, and every first-party memory feature (Claude Code, the Anthropic API memory tool) is a file directory. The one place the field is genuinely ahead of this repo is search quality over what's stored — a weakness this brain had already graded (C−) and designed a fix for (the "tier-2" embedding dedup) without ever building it. So the Elixir idea landed in a reshaped form: not a port of either repo, but a small standalone Elixir engine that builds disposable search indexes over a markdown bundle while the files stay the source of truth — with this brain as its first customer. I opened that as a project with a full build plan.

---

**[`em:6733b4`]**  (co-feeds: `em:50bbc3`)

- **The Elixir verdict.** Gap: real but not empty — the sweep enumerated ~35 hex.pm searches, GitHub, Elixir Forum, and both awesome-lists, finding ~15 single-author 2026 experiments, all store-canonical, none above 30 stars, no Mem0 port, no official MCP-org Elixir SDK, and no file-canonical eval-first entrant. Viable: anubis_mcp 1.14.0, Bumblebee 0.7.1, exqlite with FTS5 compiled in, pgvector at ~1M downloads. Advised: yes, as the [elixir-agent-memory project](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/projects/elixir-agent-memory.md) with a [structured plan](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/projects/elixir-agent-memory/design-and-build-order.md) — FTS5 tier and eval harness first, adoption into `/intake` gated on a side-by-side gold-set measurement, with the crowding risk stated (fifteen entrants in six months; the plan's refresh rule re-checks the incumbent map before build).
