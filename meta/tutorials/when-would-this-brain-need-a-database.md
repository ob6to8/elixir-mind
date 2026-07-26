---
type: tutorial
title: "When would this brain need a database? The query architecture and the crossing signals"
description: A walkthrough of how the brain answers queries today (lexical search plus committed generated indexes), what it means for a question to be inexpressible in that architecture, the three crossing signals that would justify a database layer, and the decision path from signal to analysis to operator ratification.
provenance: "Agent-authored tutorial, 2026-07-25 session"
tags: [meta, tutorial, storage, search, derived-views, agent-memory, architecture]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T23:15:00Z
  channel: agent-authored
  agent: "Claude Code agent, journal-skill session"
  why: "the operator asked for a tutorial built around the crossing-signal unpacking"
  from: [/meta/threads/2026-07-25-journal-skill-and-first-entry.md]
---

# When would this brain need a database? The query architecture and the crossing signals

The standing direction is set by
[derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md):
the markdown files are the single source of truth, and the brain adopts a
database only when a **crossing signal** appears. This tutorial walks the
mechanics behind that direction — what the brain's query architecture actually
is, what a signal would look like in practice, and how the decision would be
made. (The phrase-scale unpacking of the doctrine's crossing-signal sentence is
the [crossing-signal elaboration](/meta/elaborations/crossing-signal-learned-from-real-demand.md);
this is the subject explained end to end.)

## The two-tool query architecture

Every question asked of the brain today is answered by some combination of two
tools:

1. **Lexical search over the files.** `grep`/`rg` across the bundle —
   [lexical search](/beliefs/glossary/lexical-search.md) matches the literal
   words in documents. It is fast, dependency-free (a design constraint, per
   [why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md)),
   and blind to meaning: it finds *recitation* wherever that string occurs, and
   misses a document that says *restating objectives* instead.

2. **Committed generated indexes.** Structures the `mix brain.*` tooling
   derives from the files and commits beside them:
   [`meta/registry.md`](/meta/registry.md) (id → path), the glossary's
   `## Terms` listing, the route-tag excerpt logs, the site's search index.
   Each is [materialized](/beliefs/glossary/materialize.md) — computed, written
   to disk, freshness-gated in CI — and each is **disposable**: delete any of
   them and one `mix` task rebuilds it, because the files hold all the truth.

This *is* the hybrid people reach for when they layer SQLite over a markdown
store — the brain simply materializes to markdown instead of to a database
file. The essential property is not the storage format but the direction of
truth: every index is a **derived view** that may cache, index, and accelerate,
but never *knows* anything the files don't.

## What "inexpressible" means

A query is *expressible* in this architecture when lexical search plus some
committed index can compute its answer.

- "Every doc tagged `agent-memory`" — expressible (grep the frontmatter).
- "Which doc has id `em:41a1e3`" — expressible (registry lookup).
- "Every doc that cites this one" — expressible (grep for the path; the site's
  backlinks view materializes exactly this).
- "Every doc that *means roughly the same* as this new note" — **not**
  expressible: no combination of literal word-matching reliably computes
  semantic similarity. Today the brain approximates it with synonym-expanded
  lexical queries, and measures how well that approximation holds with a
  committed gold set (the [dedup recall probe](/meta/evals/dedup-probe.md),
  built after the
  [vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
  found grep already missing semantically-similar concepts — and still judged
  the file layer sufficient, with better intake dedup as the fix).

Expressibility erodes with scale rather than failing at a boundary — which is
why the doctrine watches for a *concrete failed query* instead of a document
count.

## The three crossing signals

1. **Concurrent writers.** Multiple agents mutating shared state
   simultaneously, beyond what branch-per-session and merge review can
   coordinate. Git is a fine concurrency model for a handful of sessions; it is
   not a transaction manager.
2. **Cross-document transactional invariants.** A consistency rule that must
   hold *atomically* across several files. The gate suite verifies such rules
   *after the fact* (CI fails on drift); it cannot make a multi-file update
   all-or-nothing the way a database transaction can. Today no invariant in the
   brain needs atomicity — the freshness gates plus true-merge history make
   drift visible and recoverable, which is enough.
3. **An inexpressible query under real load.** The semantic-similarity case
   above is the likely first candidate: if the corpus outgrows what
   synonym-expanded lexical dedup can hold (the dedup probe's recall trend is
   the early-warning instrument), similarity search would need vectors — a
   query no grep can express.

## The decision path

The doctrine's discipline, end to end:

1. **A signal arrives in real work** — a filing, search, or automation motion
   actually fails. The failed query is recorded (an `issue`, or directly the
   analysis below). Constructed rehearsals don't qualify: a scenario built to
   exercise a database teaches what the scenario assumed, not what the work
   needs.
2. **The investigation becomes an `analysis`** — the point-in-time judgment the
   doctrine anticipates: what exactly failed, what the smallest sufficient
   layer is (often: a better index or a synonym pass, not a database), and what
   a database would cost. The precedent is the vector-DB recall analysis: a
   probe over the live corpus, a "not yet" verdict, and an instrument (the
   dedup probe) left behind to watch the trend.
3. **The operator ratifies the crossing** — because what is being traded is
   structural: a second layer of truth with its own history mechanism, outside
   the git history that the provenance stack (session trailers, SHA citations,
   true merges) is built on. Even then, the doctrine's discipline survives the
   crossing: whatever database arrives should stay a derived view as long as
   possible — regenerable from the files, disposable, honest.

## Why not preemptively?

Adding a database before a signal buys generality the work hasn't asked for,
and its price is the one thing the brain cannot regenerate: a fork in truth.
The moment a fact lives only in the database, every consumer must ask *which
layer is right* — and the immutable, attributable git history stops being the
whole story. The operator's framing in the
[first journal entry](/journal/2026-07-25.md) stands as the design brief: learn
the tradeoffs by genuinely hitting them, and know where the line is *before*
needing to cross it.
