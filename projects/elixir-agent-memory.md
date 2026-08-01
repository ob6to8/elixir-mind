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
