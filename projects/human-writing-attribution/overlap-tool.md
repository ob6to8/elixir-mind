---
id: em:fe5ca6
type: plan
title: "Human writing attribution — the overlap tool"
description: Design for the quotation-vs-synthesis report generator — a pure-Elixir literal-span matcher that takes a finished piece plus its declared inputs and emits a report classifying each overlap as marked quotation or unmarked overlap, prototyped as a mix task in this repo and porting with the project on break-out.
status: proposed
tags: [projects, writing, attribution, overlap, tooling, elixir, planning]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed filing session"
  why: "operator directed persisting the overlap-tool design before the session closes; the build is deferred, so the decisions need a durable record a cold session can execute from"
---

# Human writing attribution — the overlap tool

The [project hub](/projects/human-writing-attribution.md) commits to a
mechanical overlap report: the finished piece is analyzed against its declared
inputs, and literal overlap is surfaced so the reader can check the
quotation/synthesis boundary rather than take it on trust. This plan fixes the
shape of that tool. The bounding decision is inherited from the hub and
repeated here because it constrains everything below: **the report discloses
literal quotation only** — it never certifies the residue as human-authored,
because paraphrase detection overclaims and sentence-level originality is not
the attested unit.

## Current state

```
projects/human-writing-attribution.md        # hub: premise, trust model, decisions
projects/human-writing-attribution/          # this plan only; no code exists
beliefs/value-of-writing-is-human-synthesis.md   # the prior; quotes operator verbatim
lib/mix/tasks/brain.*.ex                     # existing task conventions: offline, zero-dep
```

## Desired state

```
mix brain.overlap <piece.md> --manifest <manifest>
  read piece + manifest                      # task layer: all file IO here
    ├─ prepare inputs: {label, text} pairs   # thread docs: body only, frontmatter
    │                                        #   and routing ledger stripped
    ↓
  ElixirMind.Overlap.report/2                # pure core: text in, struct out
    ├─ tokenize piece and each input         # tokens keep original byte offsets
    ├─ match maximal literal spans           # n-gram seed + greedy extension,
    │                                        #   minimum span threshold (default 8 tokens)
    ├─ classify each span                    # :marked_quotation (inside blockquote /
    │                                        #   quotation marks) | :unmarked_overlap
    └─ summarize                             # per-input and total token coverage;
                                             #   no "human-authored %" — out of scope
    ↓
  render markdown report → stdout or --out   # spans with piece location, matched
                                             #   input, verbatim text, classification
```

## File-tree diff

```
lib/elixir_mind/overlap.ex          # NEW — pure core: tokenize, match, classify, summarize
lib/elixir_mind/overlap/report.ex   # NEW — Report and Span structs + markdown renderer
lib/mix/tasks/brain.overlap.ex      # NEW — CLI boundary: manifest parsing, file IO, output
test/elixir_mind/overlap_test.exs   # NEW — core scenarios against fixtures
test/mix/tasks/brain_overlap_test.exs  # NEW — task-boundary scenario test
test/fixtures/overlap/              # NEW — piece + two inputs with known overlaps
```

## Call/flow trees

Production:

```
Mix.Tasks.Brain.Overlap.run/1
├─ parse_args (piece path, manifest path, --out, --min-span)
├─ load_inputs/1                    # reads files; strips thread-doc scaffolding
├─ ElixirMind.Overlap.report/2     # pure
└─ ElixirMind.Overlap.Report.render/1 → IO.write or File.write
```

Test (the seam under substitution is the filesystem — the core never sees it):

```
overlap_test.exs
└─ ElixirMind.Overlap.report/2 called with in-memory strings from fixtures
brain_overlap_test.exs
└─ Mix task run against test/fixtures/overlap/ paths, output captured
```

## Signatures

```elixir
@type input :: {label :: String.t(), text :: String.t()}

@spec report(piece :: String.t(), inputs :: [input()], opts :: keyword()) ::
        Report.t()

@spec tokenize(text :: String.t()) :: [Token.t()]

@spec match_spans(
        piece_tokens :: [Token.t()],
        input_tokens :: [Token.t()],
        min_span :: pos_integer()
      ) :: [Span.t()]

@spec classify(Span.t(), piece :: String.t()) ::
        :marked_quotation | :unmarked_overlap

@spec render(Report.t()) :: String.t()
```

## Boundary decisions

- **The core is pure.** `ElixirMind.Overlap` takes strings and returns a
  struct; the mix task owns every file read, manifest parse, and write —
  the toolchain's functional-core/imperative-shell shape.
- **Input preparation is the task layer's job.** Stripping a thread doc down
  to its rendered body (frontmatter, `## Routing`, and route-tag markup
  removed) happens before the core is called, so the core has no knowledge
  of doc genres.
- **Classification reads the piece, not the input.** Whether an overlap is
  disclosed is a property of how the *piece* frames it (blockquote or
  quotation marks around the span), so the classifier consults piece-side
  context only.
- **The tool is a generator, never a gate.** It runs on demand and always
  exits 0; unmarked overlap is information for the author, and whether it is
  acceptable is an editorial judgment. It therefore joins the toolchain
  without an admission-rule claim — though it meets the offline,
  zero-dependency bar regardless.

## Anchors

- Task conventions: any existing `lib/mix/tasks/brain.*.ex` (e.g.
  `brain.verify`) — `@impl Mix.Task`, moduledoc written summary-first for the
  code map, specs per the coding standards.
- Normalization for matching: lowercase, Unicode NFC, collapse whitespace,
  strip edge punctuation — tokens retain original offsets so the report can
  quote the piece verbatim.
- Tests per the
  [testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md):
  scenario tests through the public surface; fixture piece carries one
  blockquoted lift (expect `:marked_quotation`), one unmarked lift (expect
  `:unmarked_overlap`), and clean prose (expect no span).
- First real run — the dogfood case: this project's own
  [belief doc](/beliefs/value-of-writing-is-human-synthesis.md) against the
  captured thread doc of the session that produced it; the operator
  quotations in the belief body should surface as marked quotation.

## Build order

1. Tokenizer with offset preservation.
2. Span matcher (n-gram seed, greedy extension to maximal spans, threshold).
3. Classifier against quotation markers.
4. `Report`/`Span` structs and the markdown renderer.
5. Mix task: args, manifest, input preparation, output.
6. Fixtures and the two scenario tests.
7. Dogfood run; tune the default threshold against its output.

## Decision list

**Recommended shape.** Token-level maximal-span literal matching with a
configurable minimum span (default 8 tokens); two-way classification
(marked quotation vs unmarked overlap); local-file inputs only; markdown
report.

**Rejected alternatives.**

- *Embedding or paraphrase similarity* — crosses the hub's
  literal-quotation-only decision; any similarity score smuggles back the
  "purely human residue" claim the project declines to make.
- *External plagiarism-detection services* — network egress of unpublished
  drafts, a dependency, and offline operation all rule it out (per
  [why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md)).
- *Character-level suffix-automaton matching* — more precise on reworded
  boundaries, but heavier to build and tune; token-level matching suffices at
  prototype scale and the seam (the matcher behind `match_spans/3`) allows a
  later swap without changing the report contract.

**Open questions and assumptions.**

- The 8-token default is a guess; step 7 tunes it against real output.
  Related: whether spans consisting mostly of stopwords need suppression
  beyond the length threshold, or the threshold alone is enough.
- A JSON export for the eventual publication frame is deferred until the
  hub's publication-format question is answered.
- Assumes declared inputs are local files (source captures, thread docs);
  fetching remote URLs at run time stays out — an input must first be
  captured into the bundle, which the link-processing policy requires anyway.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:fe5ca6">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-30-human-writing-attribution (2026-07-30)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:fe5ca6`]**  (co-feeds: `em:763ec8`)

The delta to actually prototype it here is small: a document layer for operator-authored synthesis that declares its inputs (thread docs + `source` captures), plus a `mix brain.*`-style task that computes literal-overlap spans between the piece and its declared inputs and emits the quotation/synthesis report. The thread docs you're already capturing are the expensive-to-fabricate part of the disclosure, and you already have them.
