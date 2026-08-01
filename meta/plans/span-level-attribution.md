---
type: plan
title: "Span-level attribution: PROV-aligned provenance for document text"
description: Move attribution from one record per document to a layered model — structured provenance, a derived doc-side thread edge, deterministic verification of local quotes, and exception-marked text spans over a declared synthesis default — adopting the W3C PROV-DM vocabulary conceptually (agent, activity, quotation, derivation) while keeping YAML frontmatter and inline markup as the serialization and the hand-written Elixir verifier as the checker.
status: accepted
provenance: "Agent-distilled from an operator-directed design dialogue examining em:712e01 against the attribution machinery, 2026-08-01; model undisclosed"
tags: [meta, plan, attribution, provenance, prov-dm, verification, spans, frontmatter, schema]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T07:31:45Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on schema formalization and attribution"
  why: "doc-granular attribution forces one record onto documents whose text mixes operator voice, verbatim quotes, thread lifts, and synthesis — and the operator ratified a span-capable redesign before any evaluator work builds on the schema"
---

# Span-level attribution: PROV-aligned provenance for document text

## Problem

A document's text is a mixture — operator-authored passages, verbatim quotes
from external sources, regions lifted from captured threads, and
agent-synthesized prose — but every attribution mechanism the bundle has is
**doc-granular**: one `attribution` map (the ingestion event), one free-text
`provenance` string, one `verified` bit. Four concrete failures follow:

1. **One bit onto a mixture.** `verified` on
   [normative-records-vs-descriptive-traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md)
   (`em:712e01`) must speak for both an empirically checkable claim ("oversight
   obligations ask for this artifact") and a framing that is not truth-apt (the
   kind distinction itself). Either value misrepresents part of the text.
2. **Resolvable origins left as prose.** The same doc's `provenance` gestures
   at "an operator-directed design session" while the session's thread doc sits
   at a known path — an unresolvable pointer to a resolvable artifact, which no
   current rule catches.
3. **The doc→thread edge is one-sided.** Route tags machine-verify the
   thread→doc direction (excerpt logs re-derived, CI-gated), but a bundle
   document's frontmatter carries no edge back to the threads that fed it —
   [resource-attribution](/meta/policy/resource-attribution.md) restricts
   `from` to governance docs, whose lack of `em:` ids is exactly why they need
   it. The mechanism is right; the visibility is asymmetric.
4. **Quotes are asserted, never checked.**
   [quote-primary-sources](/meta/policy/quote-primary-sources.md) mandates
   verbatim spans with citations, and nothing verifies them — even when the
   cited source is a local capture and the check is a string containment.

[assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md)
names its own residual gap ("ephemeral assertions in delivered responses") for
the response surface; this plan closes the same gap on the document surface.

## Decisions — ratified 2026-08-01

**D1 — Adopt the W3C PROV-DM vocabulary conceptually; keep the serialization
native.** The four text-attribution classes map onto PROV relations:

| Class | Text is… | PROV relation |
|---|---|---|
| operator | authored by the operator | `wasAttributedTo` (Person) |
| quote | verbatim from an external source | `wasQuotedFrom` + `hadPrimarySource` |
| thread | lifted verbatim from a captured thread | `wasQuotedFrom` (thread entity) |
| synthesis | agent-generated | `wasGeneratedBy` (Activity, SoftwareAgent) |

Serialization is YAML frontmatter plus inline markup — the posture the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)
already set: take the standard's semantics, decline the RDF/triple-store
substrate, keep `mix brain.verify` as the checker.

**D2 — Exception marking over a declared default.** Every document declares
its default basis in frontmatter; spans are marked only where they depart from
it. Unmarked text is governed by the default, so annotation mass lands on the
exceptions (quotes, operator voice, thread lifts) instead of on the dominant
synthesis class — while the default itself stays explicit, timestamped, and
source-bearing rather than implicit.

**D3 — Synthesis basis is recorded, sub-attributed, and read as attestation.**
The doc-level default distinguishes synthesis **from memory** vs. **from
search/retrieval**, with sources and a timestamp. Presence and form are
checkable; truthfulness is not — the same epistemics
[model-attribution](/meta/policy/model-attribution.md) already assigns to the
model field ("evidence about authorship rather than proof of it").

**D4 — The doc-side thread edge is derived, never hand-kept.** Bundle
documents gain a `derived_from` frontmatter list **materialized from the
existing route tags** by the same motion that writes excerpt logs, and
CI-checked for divergence exactly as the logs are. No second hand-maintained
copy of an edge the tags already carry; origins with no route tag (a
pre-capture conversation) belong in structured provenance instead.

**D5 — `provenance` splits into structure.** `model` (trailer display form or
`model undisclosed`, per model-attribution), `ref` (a resolvable `em:` id or
bundle-absolute path, **required whenever the origin has an in-repo address**),
`note` (free-text residue for origins with no address). Ref resolution is
machine-checked.

**D6 — The attribution map realigns to PROV agent/activity.** `agent` narrows
to the actor (model + harness); a new `activity` carries the context the
current field actually holds (session, skill, Routine); `channel` folds into
`activity` as its leading token; `when` renames to `created` and top-level
`timestamp` to `modified` (the Dublin Core `dcterms:created`/`dcterms:modified`
pair). `why` is unchanged, and stays doc-granular under span attribution — a
document has one filing rationale even when its text has many origins.

**D7 — Local quotes verify deterministically.** A marked quote span whose
source is a local capture (e.g. the
[agent-says-done thread capture](/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md),
`em:b01e03`, quoted by the beliefs extracted from it) is checked by string
containment against the source body — no model, no network. External-URL
quotes stay editorial.

**D8 — Doc-level `verified` becomes derived.** Once spans exist: a document is
verified iff every truth-apt span carries a resolving support ref. The bit
stops being asserted and becomes computable, dissolving failure 1.

## Desired shape

Frontmatter delta on a bundle document (illustrative):

```diff
 id: em:712e01
 type: concept
-provenance: "Agent-distilled from an operator-directed design session, 2026-07-30"
+provenance:
+  model: model undisclosed
+  ref: /meta/threads/2026-07-30-neovim-adoption-and-the-agent-pairing-project.md
+derived_from: [/meta/threads/2026-07-30-neovim-adoption-and-the-agent-pairing-project.md]  # materialized, never hand-edited
+synthesis:
+  mode: memory            # memory | search
+  at: 2026-07-30T07:05:00Z
-timestamp: 2026-07-30
+modified: 2026-07-30
 attribution:
-  when: 2026-07-30T07:05:00Z
-  channel: agent-authored
-  agent: "Claude Code agent, operator-directed session on agent supervision and governance"
+  created: 2026-07-30T07:05:00Z
+  agent: "model undisclosed, Claude Code web session"
+  activity: "agent-authored: operator-directed session on agent supervision and governance"
   why: "the distinction generalizes past the project that surfaced it — …"
```

Span markup, following the `<routes>` precedent (region tags over prose, one
class plus a source ref, never nested):

```
<attr class="quote" src="em:b01e03">
> Treat the write and the verify as two separate steps, never trust
> completion claims from the same context that made the claim
</attr>
```

File-tree diff:

```
lib/elixir_mind/
  attribution.ex        # MODIFIED — created/agent/activity schema, provenance-map checks
  route_tags.ex         # MODIFIED — --materialize also writes derived_from
  spans.ex              # NEW — parse/validate <attr> regions; class + ref resolution
  quotes.ex             # NEW — containment check for quote/thread spans with local sources
lib/mix/tasks/
  brain.quotes.ex       # NEW — mix brain.quotes (gate-eligible: offline, deterministic)
meta/policy/
  resource-attribution.md   # MODIFIED — schema realignment (D5, D6)
  span-attribution.md       # NEW policy — classes, default rule, markup, derived verified
```

Signatures for the new seams:

```elixir
@spec parse(body :: String.t()) :: {:ok, [Span.t()]} | {:error, [String.t()]}   # ElixirMind.Spans
@spec verify_quotes(entries :: [Registry.Entry.t()], by_id :: map) :: [String.t()]  # ElixirMind.Quotes
@spec derived_from_errors(entry :: Registry.Entry.t(), root :: String.t()) :: [String.t()]  # RouteTags
```

Boundary decisions:

- **`RouteTags` owns `derived_from`** — it is a second projection of the same
  tag data the excerpt logs project; one module, one source of truth.
- **`Spans` parses; `Quotes` judges** — markup wellformedness and ref
  resolution are one concern, content verification another; only `Quotes`
  reads source bodies.
- **The verifier aggregates** — span errors, quote failures, and provenance-ref
  resolution surface through `mix brain.verify`'s existing error list; no
  second gate entry point except `brain.quotes` for focused runs.

## Build order

1. **Structured provenance + attribution realignment (D5, D6)** — policy
   edits, `Attribution` checks, corpus migration sweep, contract recompile.
   The migration's write path wants `Frontmatter.dump/1` from the
   [parser-rewrite plan](/meta/plans/frontmatter-parser-profile-rewrite.md);
   until that lands, the sweep uses the same regex surgery the attribution
   backfill used, accepted as a one-time cost.
2. **`derived_from` materialization (D4)** — extend `--materialize` and the
   divergence check; backfill the corpus in the same motion.
3. **Quote verification (D7)** — `Spans` + `Quotes` + `mix brain.quotes` over
   quote/thread spans with local sources; warn-only first, gate after the
   corpus is clean.
4. **Span markup + synthesis defaults + derived `verified` (D1–D3, D8)** —
   the span-attribution policy, markup adoption on new documents, and the
   derived-verified rule; retrofit of the existing corpus is a separate,
   operator-scoped decision (the model-attribution posture toward its own
   pre-policy corpus).

`em:712e01` is the pilot document for phases 1–2 (its provenance and thread
edge are the worked example above).

## Open questions

1. **Span survival across edits.** Route tags only annotate frozen thread
   bodies; knowledge documents are living, and a span boundary must survive
   prose re-flows. Options at execution: re-anchor by content hash and fail
   loudly on drift, or accept manual re-marking as part of any edit that
   crosses a span. This is the plan's highest-risk unknown and phase 4 does
   not start until it has an answer.
2. **Truth-apt span segmentation.** Deciding which sentences are claims vs.
   framing has no mechanical oracle; it lands in the evaluator lane of the
   [schema-formalization plan](/meta/plans/schema-formalization-and-evaluator-lane.md)
   rather than in a gate.
3. **Adjacent-layer reconciliation.** The
   [epistemic-overlay plan](/meta/plans/epistemic-overlay.md) types edges
   *between* documents; this plan attributes text *within* them. The boundary
   looks clean (overlay = inter-doc evidential structure; spans = intra-doc
   origin), and phase 4 should re-check it against whatever the overlay has
   become by then.

## Decision list

- **Recommended shape:** the eight decisions above, phased 1→4 with each
  phase independently shippable and gate-checked.
- **Rejected:** RDF/triple-store serialization (re-litigates the declined
  SHACL stack for no checking power the Elixir verifier lacks); marking every
  span including synthesis (annotation mass on the default class buys no
  audit value — the declared default carries it); hand-kept `derived_from`
  (shadow copy of the route-tag edge); sampling-parameter capture in
  provenance (unobservable from a session; a required field that can only be
  guessed).
- **Assumption:** the four classes are exhaustive for this bundle's text. A
  fifth (e.g. tool-generated tables) would extend the class enum, not the
  architecture.
