---
type: plan
title: "Replace the frontmatter parser: a strict OKF-profile parser with an order-preserving serializer"
description: Rewrite ElixirMind.Frontmatter as an explicit recursive-descent parser for a defined frontmatter profile (nested block maps, block lists, quote-aware inline lists, loud errors) plus a Frontmatter.dump/1 serializer, so frontmatter writes become structural instead of regex surgery — validated by a differential harness over the full bundle and a byte-for-byte round-trip check.
status: proposed
provenance: "Claude Code session (claude-fable-5), 2026-07-20 — grew out of the operator's storage-format question (is markdown still right vs JSON/database); the format verdict was keep markdown, harden the structured layer, and this plan is hardening move 1"
tags: [meta, plan, tooling, frontmatter, parser, serializer, yaml]
timestamp: 2026-07-26
attribution:
  when: 2026-07-20T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive session on the data-format question"
  why: "operator commissioned the plan after the assessment identified the hand-rolled frontmatter parser as the bundle's most likely first casualty of growth"
  from: [/meta/threads/2026-07-20-storage-format-verdict-and-frontmatter-parser-plan.md, /meta/threads/2026-07-26-structured-plan-bodies-and-belief-layer.md]
---

# Replace the frontmatter parser: strict profile parser + serializer

## Problem

[`ElixirMind.Frontmatter`](/lib/elixir_mind/frontmatter.ex) is a deliberately
minimal, dependency-free parser for the YAML subset the bundle's frontmatter
uses. It served its purpose, but the structured layer (attribution maps, typed
edges, growing governance frontmatter) has reached the edge of what it can
carry, and its failure mode is the wrong one for a verified bundle — **silent
tolerance** instead of loud rejection:

- **One level of nesting, hardcoded.** Block maps parse only one level deep
  (the shape of `attribution:`). Anything deeper is silently mangled.
- **No block lists.** Only inline `[a, b]` lists parse, which is why
  `attribution.from` must stay inline even as thread paths make those lines
  unwieldy.
- **Quote-blind inline lists.** `["a, b"]` splits on the interior comma and
  yields two corrupted items.
- **Over-eager coercion.** Any value starting with `[` is treated as a list, so
  `title: [Draft] some idea` parses as a list, not a string.
- **Silent data loss.** An unparseable line inside a nested block is dropped
  with no error (`frontmatter.ex` `put_nested/3`, the `[_no_pair]` clause) — in
  a bundle whose verifier exists to catch exactly this kind of drift.
- **Writes bypass the parser entirely.** The only code that mutates
  frontmatter — `attribution/backfill.ex` `append_from/3` and
  `insert_attribution` — does regex surgery on raw text, assuming the
  attribution block is exactly "lines indented by two spaces". It breaks the
  moment the block nests deeper, and the `/create-pull-request` from-stamping
  motion has the same shape.

## Decision: rewrite the subset, don't adopt full YAML

Two options were weighed:

**A — adopt a YAML library** (`yaml_elixir`/`yamerl`, pure Erlang, no NIFs).
Rejected. It breaks the zero-dependency property that lets every `mix brain.*`
task compile offline in any fresh sandbox (`deps: []` is a documented design
goal of the tooling). And full YAML is a liability, not a feature, for this
bundle: YAML 1.1 coercions (`no` → false, date tuples, octals) silently change
parsed values, and full-YAML permissiveness (anchors, flow maps, folded
scalars) lets agents write frontmatter that parses but wrecks the bundle's
uniformity. The contract's philosophy is controlled vocabulary with
machine-enforced shape; a parser that accepts everything works against it.

**B — rewrite in place as an explicit "OKF frontmatter profile" parser**
(chosen). Same module, same `parse/1` / `parse!/1` API — all 16 call sites
across the 10 consuming modules are untouched — but internally a small
indentation-based recursive-descent parser with a defined grammar. Strictness
at the parser is what makes `mix brain.verify`'s guarantees real: the profile
becomes a spec the verifier can enforce, not an accident of implementation.

## The profile grammar

- Scalars: string, integer, boolean; single- and double-quoted strings.
- Inline lists, quote-aware (commas inside quoted items do not split).
- Block maps, arbitrarily nested by indentation.
- Block lists (`- item` lines), including as values inside block maps —
  unlocking a block-list form for `attribution.from`.
- List coercion only on a well-formed `[…]` value; `[Draft] some idea` stays a
  string.
- Everything else — tabs in indentation, anchors, flow maps, folded/multi-line
  scalars, inconsistent indent — is a **loud `{:error, {line, reason}}`**,
  never a silent drop.

No date coercion: ISO timestamps stay strings, matching current behavior and
avoiding the YAML-1.1 trap.

## The shape, structured

*Retrofitted 2026-07-26 as the pilot of the
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md) format; the
prose sections above are unchanged — these artifacts encode the same change as
reviewable structure. Per that policy's refresh rule, execution starts by
re-deriving these against `HEAD`.*

**File-tree diff:**

```diff
 lib/elixir_mind
 ├── frontmatter.ex                 # REWRITTEN in place — same parse/1 / parse!/1
~│                                  #   surface; recursive-descent profile parser
+│                                  #   + ordered representation + dump/update
 └── attribution
~    └── backfill.ex                # MODIFIED — append_from/3 regex surgery
+                                   #   becomes Frontmatter.update/2
 test/elixir_mind
~├── frontmatter_test.exs           # EXTENDED — golden profile tests, incl. the
+│                                  #   rejection set (inputs that must fail)
+├── frontmatter_differential_test.exs  # NEW, transient — old vs. new parser over
+│                                  #   every bundle doc, asserting identical maps
+└── frontmatter_roundtrip_test.exs # NEW — parse_pairs |> dump == original bytes
+                                   #   across the bundle
```

**Signatures** (the read surface is frozen; the write surface is new):

```elixir
# read surface — unchanged for the 10 consuming modules / 16 call sites
@spec parse(content :: binary()) ::
        {:ok, %{frontmatter: map(), body: binary()}}
        | {:error, {line :: pos_integer(), reason :: term()}}
@spec parse!(content :: binary()) :: %{frontmatter: map(), body: binary()}

# ordered representation — order lives here, not in the map
@typep value :: binary() | integer() | boolean() | [value()] | pairs()
@typep pairs :: [{key :: binary(), value()}]

# write surface — new; the only order-sensitive path
@spec parse_pairs(content :: binary()) ::
        {:ok, %{frontmatter: pairs(), body: binary()}}
        | {:error, {line :: pos_integer(), reason :: term()}}
@spec dump(pairs()) :: binary()
@spec update(
        content :: binary(),
        transform :: (pairs() -> pairs())
      ) :: {:ok, binary()} | {:error, term()}
```

**Call trees** — the write path is what changes; shown production then test:

```diff
 # production: attribution stamping (/create-pull-request from-stamp, backfill)
 Backfill.append_from
-  Regex surgery on raw text          # assumes two-space-indented block
+  Frontmatter.update(content, transform)
+    parse_pairs                      # ordered recursive-descent
+    transform.(pairs)                # append thread ref to attribution.from
+    dump(pairs)                      # order-preserving serialize
```

```
# test topology: three suites, three seams
frontmatter_test.exs            → grammar directly (golden + rejection set)
frontmatter_differential_test   → corpus → old parse/1 vs new parse/1 (equal maps)
frontmatter_roundtrip_test      → corpus → parse_pairs |> dump (byte equality)
```

**Boundary decisions:**

- **Order lives in the internal `pairs` representation only.** `parse/1` keeps
  returning a plain map so all 16 existing call sites stay untouched; anything
  that *writes* goes through `parse_pairs`/`update`, the one order-sensitive
  path.
- **Strictness lives in the parser, not the verifier.** The verifier gains the
  round-trip check for free but the grammar rejections fire at parse time, as
  loud `{:error, {line, reason}}`.
- **The differential harness is transient.** It exists to pin the migration
  and is deleted with the old parser (build-order step 5).

**Anchors** (attached last, per the policy): `lib/elixir_mind/frontmatter.ex`
(rewrite), `lib/elixir_mind/attribution/backfill.ex` `append_from/3` +
`insert_attribution` (refactor onto `update/2`),
`test/elixir_mind/frontmatter_test.exs` (extend); reuse
`ElixirMind.Registry.scan/1`'s bundle walk for the corpus-wide tests; the
[frontmatter-schema policy](/meta/policy/frontmatter-schema.md) is the doc-side
anchor build-order step 6 amends.

## The serializer — the half that fixes the writes

`Frontmatter.dump/1` (and an `update/2` convenience: parse → transform map →
dump) with an **order-preserving round-trip** as the design constraint: the
parser keeps key order (ordered internal representation), so `parse |> dump` on
an unmodified document reproduces the file byte-for-byte. That yields:

- **Structural writes.** `backfill.ex`'s regex surgery and the
  `/create-pull-request` from-stamping become parse-modify-dump.
- **A free canonical-form check.** `mix brain.verify` can assert every doc's
  frontmatter round-trips cleanly, converting formatting drift from editorial
  to structural.
- **Minimal diffs** when tooling rewrites a doc, and one canonical formatting
  that agents and the serializer converge on.

## Build order

1. New parser built alongside the old (internal `Frontmatter.V2`), identical
   return shape.
2. **Differential harness**: a test parsing every document in the bundle with
   both parsers, asserting identical maps. Divergences are triaged — each is
   either a new-parser bug or a latent old-parser bug surfacing.
3. Golden profile tests in `test/elixir_mind/frontmatter_test.exs`, including
   inputs that must **fail** (the rejection set is part of the spec).
4. Round-trip test: `parse |> dump == original` across the bundle; docs that
   don't round-trip get normalized once, in the same PR, so the canonical form
   starts true.
5. Swap the implementation, delete the old code paths; refactor
   `attribution/backfill.ex` regex writes onto `dump`.
6. Amend the [frontmatter-schema policy](/meta/policy/frontmatter-schema.md) to
   name the profile as the enforced grammar (what YAML subset is legal
   graduates from implementation detail to contract), and re-render the
   contract.

Estimated size: parser + serializer ~300–400 lines replacing the current ~130,
plus tests. Low risk: the API boundary means nothing else in `lib/` changes,
and the differential harness pins behavior over the live corpus.

## Open questions

- Does the round-trip verifier rule land as a hard failure or a warning first?
  (Backfilled-era docs may need a one-time normalization pass; step 4 should
  reveal the count.)
- Should `attribution.from` migrate to block-list form once supported, or stay
  inline? (Cosmetic; can be deferred or decided at execution.)
