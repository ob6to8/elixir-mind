---
type: plan
title: "mix brain.query: a general filter surface over frontmatter facets, generalizing the one-off brain.* slices"
description: Build a general WHERE-style query over the registry's frontmatter fields (type, verified, tags, attribution.channel, presence/absence of a field), generalizing the ad-hoc one-off logic already duplicated across brain.evidence/brain.orphans/brain.lineage — the structured half of the query win terse-brain's TERSE syntax demonstrated, taken without the format, and deliberately scoped apart from the still-deferred BM25/embedding retrieval decision it does not replace.
status: proposed
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-01 — designed from the terse-brain evaluation's query-shape finding; persisted because the field-selector grammar and its relationship to the deferred retrieval trigger need ratification before code lands"
tags: [meta, plan, retrieval, tooling, elixir, query, terse, registry]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, terse-brain-evaluation session"
  why: "operator selected this action from the terse-brain evaluation, which named the query shape a real win worth taking without the format"
  from: [/meta/threads/2026-08-01-terse-brain-evaluation-and-index-coverage-gate.md]
---

# mix brain.query: a general frontmatter facet filter

Grounded in one finding from the
[terse-brain evaluation](/meta/analysis/terse-lang-terse-brain-evaluation.md):
TERSE's `? Wiki.Claims.* [WHERE Its HAS disputed]` answers *structured*
questions — every unverified claim, every doc from a given channel, every
belief with no inbound link — that this bundle can currently only answer by
writing a one-off script or grepping frontmatter by hand. The
[615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)
graded retrieval C− on 32% plain-text recall; this plan does **not** move
that number — `CONTAINS`-style substring matching is no better than grep at
"what do I know about attention?" — it targets the different, currently
unserved shape: filtering on the typed fields the frontmatter already
carries.

## The problem

This bundle's registry (`ElixirMind.Registry.scan/1`) already parses every
document's frontmatter into a struct — `id`, `type`, `title`, `verified`,
`resource`, `sense`, `attribution`, `verified_by`. Three existing tasks each
independently query a narrow slice of it: `mix brain.evidence <id>` (what
backs a claim), `mix brain.orphans` (docs with no inbound link),
`mix brain.lineage` (typed edges by id). Each is a bespoke filter over the
same `Registry.scan/1` output; there is no general "give me every doc where
`<field>` `<op>` `<value>`" surface, so a new question of that shape means
writing a new one-off task.

## Current-state tree

```
ElixirMind.Registry.scan/1                 # the one shared crawler (see
                                             # the three-bundle-scanners tutorial)
  ├── Mix.Tasks.Brain.Evidence              # bespoke filter: verified_by closure for one id
  ├── Mix.Tasks.Brain.Orphans               # bespoke filter: no inbound link
  └── Mix.Tasks.Brain.Lineage               # bespoke filter: typed edges, one namespace
```

## Desired-state tree

```
ElixirMind.Registry.scan/1                  (unchanged — still the shared crawler)
  └── ElixirMind.Query                      # NEW — general facet filter over Entry structs
        ├── parse/1     :: String.t() -> {:ok, Query.t()} | {:error, reason}
        ├── run/2        :: Query.t(), [Entry.t()] -> [Entry.t()]
        └── mix brain.query "type=claim verified=false"     # NEW task, thin CLI wrapper
              mix brain.query "attribution.channel=auto-intake"
              mix brain.query "tags~terse"                  # substring, not full CONTAINS-graph
              mix brain.query "resource=*"                  # presence test

Existing tasks unchanged — brain.evidence/orphans/lineage keep their own
logic (each does real graph work beyond a flat filter); brain.query is a
new, general complement, not a replacement.
```

## File-tree diff

```
lib/elixir_mind/
  query.ex             # NEW — parse a small selector grammar, run it over [Entry.t()]
lib/mix/tasks/
  brain.query.ex        # NEW — CLI wrapper: parse argv, call Query.run/2, print rows
test/elixir_mind/
  query_test.exs         # NEW — grammar parsing + filter semantics, no I/O
```

## Selector grammar (sketch, not final)

A minimal `field<op>value` grammar over `Entry` fields already on the struct,
space-separated as an implicit AND (no OR/nesting in v1 — see open question
2):

| Op | Meaning | Example |
|---|---|---|
| `=` | exact match | `type=claim` |
| `!=` | exact non-match | `verified!=true` |
| `~` | substring | `tags~terse` |
| `=*` | field present (non-nil/non-empty) | `resource=*` |
| `!=*` | field absent | `verified_by!=*` |

Dotted paths reach into nested maps already on the struct
(`attribution.channel=auto-intake`). No new fields are added to `Entry` —
this plan queries what `Registry.scan/1` already extracts; a facet not on
the struct today (e.g. `status`, which only some types carry) is out of
scope for v1 and named in the open questions.

## Boundary decisions

- **Reuses `Registry.scan/1` as-is** — no new crawler, no new exclusion
  list, so `brain.query` inherits exactly the same corpus and blind spots
  the registry already has (governance docs, threads, and `evals/` stay
  invisible, same as `brain.evidence`/`brain.orphans` today).
- **Read-only, offline, dependency-free** — clears the
  [admission rule for new guardrails](/meta/policy/elixir-coding-standards.md)
  outright; this is a report task like `brain.orphans`, not a gate.
- **Explicitly not retrieval.** No ranking, no stemming, no synonym
  expansion, no full-text search — those are the deferred tier-2 decision
  the 615-document analysis already named
  ([vector-db-recall-for-the-scaling-bundle](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)).
  `brain.query` answers "which docs have property X," never "which docs are
  about X" — the two must not be conflated in the tool's own framing, or its
  shipping reads as having closed the C− finding when it hasn't touched it.

## Anchors

- `ElixirMind.Registry.Entry` — the struct `Query.run/2` filters; any facet
  not already a field on it is out of scope until `Entry` grows that field
  for an unrelated reason.
- `ElixirMind.Registry.scan/1` — the sole input; `Query` never reads the
  filesystem itself.
- `mix brain.evidence`/`brain.orphans`/`brain.lineage` — precedent for CLI
  shape (plain-text rows, `Mix.shell().info`); `brain.query` follows the same
  output convention, not a new one.

## Decisions and open questions

**Recommended shape:** as above — a small selector grammar over the existing
`Entry` struct, additive to (not replacing) the three bespoke tasks.

**Alternatives rejected:**

- Porting TERSE's bracketed-tail syntax verbatim — rejected; it is designed
  to compose with TERSE's tree-shaped queries and mutations, neither of
  which this bundle has or needs. A selector grammar scoped to flat
  frontmatter filtering is the actual shape borrowed, not the syntax.
- Building this as full-text/vector retrieval — rejected; conflates two
  different gaps (see boundary decisions).

**Open questions for ratification:**

1. **Output format.** Plain rows (path + matched fields) like the existing
   tasks, or a `--format terse`/`--format json` option for piping into
   another tool? terse-brain's lint output being itself re-ingestable TERSE
   is the closest precedent, but this bundle has no analogous re-ingestion
   consumer today.
2. **AND-only v1, or does OR/nesting get requested before it's built?**
   Building composability nobody has asked for yet is the over-specification
   the [structured-plan-bodies granularity bound](/meta/policy/structured-plan-bodies.md)
   warns against — default to AND-only and revisit only if a real query
   needs OR.
3. **`status` and other type-specific fields.** `Entry` doesn't carry
   `status` (only some types — `plan`/`todo`/`issue`/`project` — have one).
   Extending `Registry.scan/1` to capture it generically vs. leaving
   status-filtering to the existing `/plan`, `/todo`, `/issue` skills is an
   open call; the existing skills already do this well for their own type,
   so the case for duplicating it here is weaker than for the
   cross-type facets (`type`, `verified`, `attribution.channel`, `tags`).
