---
type: doctrine
title: "Derived views stay disposable: the markdown→database line"
description: The brain's standing direction for its storage layer — the files are the single source of truth, and any database-shaped layer (index, registry, search index, a future SQLite cache) may cache, index, and accelerate but never know anything the files don't. The line to a database-driven solution is crossed the day a fact lives only in the database — equivalently, the day a derived view stops being regenerable from the files.
provenance: "Claude Code session (Claude Fable 5), 2026-07-25 — distilled from the first journal entry's markdown→database question and the agent's response to it; operator directed its persistence"
tags: [meta, doctrine, direction, storage, agent-memory, derived-views, provenance]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T21:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, journal-skill session"
  why: "the operator asked to persist the response's markdown→database guideline as a standing direction for future dev"
  from: [/meta/threads/2026-07-25-journal-skill-and-first-entry.md]
---

# Derived views stay disposable: the markdown→database line

This is a **standing direction** for one recurring storage decision: *when does
this brain graduate from markdown files to a database-driven memory layer?* The
answer is not a size threshold ("at N documents, add SQLite"). It is a
**provenance threshold**, and the brain already demonstrates the hybrid it
governs.

## The direction

**The files are the single source of truth; every database-shaped layer is a
derived, disposable view.** `meta/registry.md`, the route-tag materialized
logs, the site's search index — these are indexes and joins that stay honest
because they are *regenerable from markdown and checked for freshness in CI*,
never a second source of truth. A SQLite layer over the markdown store buys
time indefinitely under exactly one discipline: it may cache, index, and
accelerate, but never *know* anything the files don't.

**The line is crossed the day a derived view stops being regenerable** — when a
fact lives only in the database. At that moment the brain has acquired a second
layer of truth with its own history mechanism, separate from the repo, and has
traded away the persistent immutable git history that the whole provenance
stack (commit graph, session trailers, SHA citations) is built on. That trade
is not forbidden forever; it is forbidden *by default*, until a crossing signal
makes it an explicit, operator-ratified decision.

## Crossing signals to watch

No contrived experiments: the tradeoff is learned by watching for the first
real query the grep-plus-generated-index pattern cannot express, not by
building a database to have built one. The signals:

- **Concurrent writers** — multiple agents mutating shared state where
  file-level git merge stops being a sufficient concurrency model.
- **Cross-document transactional invariants** — a consistency rule that must
  hold *atomically* across documents, which CI-checked regeneration can only
  verify after the fact.
- **Queries inexpressible as grep + a generated index** — e.g. similarity
  search at a scale where a committed gold set and lexical layer (see the
  [vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md),
  this doctrine's precedent "not yet" case) demonstrably stop sufficing.

Until one appears, the answer to "SQLite over markdown?" is: the pattern is
already here — derived, regenerable, disposable — and a faster materialization
target would change performance, not architecture.

## Relations

The storage-layer application of
[intent is the source](/meta/doctrine/intent-is-the-source.md): derived views
are regenerable caches of the canonical file layer exactly as generated code is
a regenerable cache of intent, and like any such artifact they earn invisibility
only through the freshness gates that re-derive them. Sibling to
[regenerate the change, not the system](/meta/doctrine/regenerate-the-change-not-the-system.md)
in treating the durable layer as canonical and everything downstream as
disposable. The field consensus this direction rests on is captured in
[AI agent memory management — when markdown files are all you need](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md).
