---
type: elaboration
title: "The crossing signal: the first query real work produces that grep plus generated indexes cannot express"
description: Unpacks the derived-views doctrine's crossing-signal sentence — what it means for a query to be inexpressible in the file-plus-index architecture, and why the doctrine waits for a real one instead of constructing a test.
provenance: "Phrase from meta/doctrine/derived-views-stay-disposable.md (Crossing signals to watch); expansion agent-authored, 2026-07-25 session"
tags: [elaboration, storage, search, derived-views, agent-memory]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T22:45:00Z
  channel: agent-authored
  agent: "Claude Code agent, /elaborate"
  why: "the operator asked for a plain-language expansion of the doctrine's crossing-signal sentence"
---

# The crossing signal: the first query real work produces that grep plus generated indexes cannot express

> "The tradeoff is learned from real demand: the crossing signal is the first
> query, arising in actual work, that the grep-plus-generated-index pattern
> cannot express."
>
> — [derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md),
> "Crossing signals to watch"

## In plain terms

This knowledge base currently answers every question with two tools: plain
text search across its files, and a handful of pre-built lookup tables that
the tooling rebuilds from those files whenever they change. The sentence says:
don't decide to adopt a database on a schedule, a hunch, or a rehearsal. Keep
working normally, and wait for the day you ask the knowledge base a real
question — in the middle of real work — that those two tools genuinely cannot
answer. That first unanswerable question is the event that makes a database
worth considering, and it is also the best teacher about what the database
would need to do. A question invented just to justify the tool teaches
nothing, because it wasn't shaped by actual need.

## The terms

- **grep** — the classic Unix text-search tool; here shorthand for
  [lexical search](/beliefs/glossary/lexical-search.md): finding documents by
  matching the literal words in them, fast and dependency-free but blind to
  meaning.
- **generated index** — a lookup structure the repo's tooling builds from the
  markdown files and commits alongside them (the id registry, the glossary's
  term list, the site's search index) — content that is
  [materialized](/beliefs/glossary/materialize.md): computed, written to disk,
  and rebuildable at any time because the files hold all the truth.
- **express a query** — a question is *expressible* in a system when the
  system's operations can compute its answer. "Every doc containing the word
  *recitation*" is expressible with text search; "every doc that means roughly
  the same as this one" is not — no combination of literal word-matching
  reliably computes it.
- **crossing signal** — the doctrine's own term for an event that converts its
  default "no database yet" into a decision worth making explicitly: a
  concurrent-writing need, an atomic cross-document consistency rule, or an
  inexpressible query.
- **real demand** — need that arises from actual use, as opposed to a scenario
  constructed to exercise a technology.

## What's actually happening

Today, when an agent (or the operator) needs something from the brain, the
motion is: text-search the files, and consult the committed lookup tables. The
doctrine names three ways this could genuinely fail someday. First,
meaning-based search: you want concepts *similar* to a new one, and
word-matching misses them because the wording differs — the
[vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
has already probed this edge and judged the file-based layer still sufficient.
Second, simultaneous writers: multiple agents changing shared state at once,
beyond what reviewing and merging file changes can coordinate. Third, an
all-or-nothing rule spanning many files, which file-by-file checking can only
verify after the fact rather than guarantee.

The sentence instructs a future maintainer on *how the decision gets made*:
when one of these stops being hypothetical — you actually hit it while filing,
searching, or automating — that concrete failed query becomes the evidence. It
gets investigated (that investigation is the `analysis` the doctrine
anticipates), and the operator decides whether a database now earns a place.
Until then, adding one solves a problem the brain doesn't have, and the price
is steep: a second copy of the truth with its own history, outside the git
history everything else relies on. Roughly: wait for the shelf to actually
sag before buying the steel bookcase — and let the way it sags tell you which
bookcase to buy.
