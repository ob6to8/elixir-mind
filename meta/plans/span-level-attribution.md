---
type: plan
title: "Span-level attribution: PROV-aligned provenance for document text"
description: Move attribution from one record per document to a layered model — structured provenance, a derived doc-side thread edge, deterministic verification of local quotes, and exception-marked text spans over a declared synthesis default — adopting the W3C PROV-DM vocabulary conceptually (agent, activity, quotation, derivation) while keeping YAML frontmatter and inline markup as the serialization and the hand-written Elixir verifier as the checker.
status: accepted
provenance: "Agent-distilled from an operator-directed design dialogue examining em:712e01 against the attribution machinery, 2026-08-01; drafted by Claude Opus 5, revised at the same day's review pass by Claude Fable 5"
tags: [meta, plan, attribution, provenance, prov-dm, verification, spans, frontmatter, schema]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T07:31:45Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on schema formalization and attribution"
  why: "doc-granular attribution forces one record onto documents whose text mixes operator voice, verbatim quotes, thread lifts, and synthesis — and the operator ratified a span-capable redesign before any evaluator work builds on the schema"
  from: [/meta/threads/2026-08-01-schema-formalization-and-span-attribution-plans.md]
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
its default basis in structured `provenance` (D5); spans are marked only where
they depart from it. Unmarked text is governed by the default, so annotation
mass lands on the exceptions (quotes, operator voice, thread lifts) instead of
on the dominant synthesis class — while the default itself stays explicit and
source-bearing rather than implicit.

**D3 — Synthesis basis is part of provenance, sub-attributed, and read as
attestation.** The default basis distinguishes synthesis **from memory** vs.
**from search/retrieval** (`provenance.mode`), with `provenance.sources` when
retrieval fed it; the instant is already `attribution.created` (a later
re-synthesis bumps `modified`), so no separate timestamp exists to drift.
Presence and form are checkable; truthfulness is not — the same epistemics
[model-attribution](/meta/policy/model-attribution.md) already assigns to the
model field ("evidence about authorship rather than proof of it").
*(Revised at the 2026-08-01 review pass: an earlier draft made synthesis a
fourth frontmatter block beside provenance/attribution/derived_from —
reproducing the origin-metadata sprawl this plan exists to cure. One default
basis, one home.)*

**D4 — The doc-side thread edge is derived, never hand-kept.** Bundle
documents gain a `derived_from` frontmatter list **materialized from the
existing route tags** by the same motion that writes excerpt logs, and
CI-checked for divergence exactly as the logs are. No second hand-maintained
copy of an edge the tags already carry; origins with no route tag (a
pre-capture conversation) belong in structured provenance instead.

**D5 — `provenance` becomes the structured default basis.** Sub-keys: `mode`
(`memory` · `search` · `operator` · `external` — how the content came to be),
`ref` (a resolvable `em:` id or bundle-absolute path, **required whenever the
origin has an in-repo address**), `sources` (URLs/ids when `mode: search`),
`note` (free-text residue for origins with no address). Ref resolution is
machine-checked. The **model has exactly one home — `attribution.agent`**
(D6): the filing model is the actor of the ingestion event, and a
`provenance.model` beside it would put one fact in two fields — the
"reads three ways" defect [model-attribution](/meta/policy/model-attribution.md)
itself warns against. That policy is amended in phase 1 to point at
`attribution.agent`; an origin model *distinct from the filer* (content
distilled from another model's output) goes in `provenance.note`.
*(Revised at the 2026-08-01 review pass: the ratified draft had
`provenance.model` and a model-bearing `agent` side by side.)*

**D6 — The attribution map realigns to PROV agent/activity; `channel` stays a
controlled key.** `agent` narrows to the actor (model in trailer display form,
plus harness); a new `activity` carries the context the current field actually
holds (session, skill, Routine); `when` renames to `created` and top-level
`timestamp` to `modified` (the Dublin Core `dcterms:created`/`dcterms:modified`
pair). `channel` is **kept as its own machine-enforced controlled field** —
the [escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md) keys
its ground-truth oracle on `channel: auto-intake`, and the attribution
backfill and `mix brain.attribution` queries filter on it; folding it into a
free-text `activity` string (an earlier draft's shape, reversed at the
2026-08-01 review pass) would demote a queryable controlled value to prose.
`why` is unchanged, and stays doc-granular under span attribution — a document
has one filing rationale even when its text has many origins.

**D7 — Local quotes verify deterministically.** A marked quote span whose
source is a local capture (e.g. the
[agent-says-done thread capture](/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md),
`em:b01e03`, quoted by the beliefs extracted from it) is checked by string
containment against the source body — no model, no network. The containment is
**whitespace-normalized and elision-aware**: markdown re-wrapping and
blockquote markers are collapsed before comparison, and a quote carrying a
marked elision (`…`) checks per fragment, since
[quote-primary-sources](/meta/policy/quote-primary-sources.md) explicitly
sanctions marked elisions and bracketed insertions — a naive exact-substring
check would fail every legitimate use of them. External-URL quotes stay
editorial.

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
+  mode: memory             # memory | search | operator | external
+  ref: /meta/threads/2026-07-30-neovim-adoption-and-the-agent-pairing-project.md
+derived_from: [/meta/threads/2026-07-30-neovim-adoption-and-the-agent-pairing-project.md]  # materialized, never hand-edited
-timestamp: 2026-07-30
+modified: 2026-07-30
 attribution:
-  when: 2026-07-30T07:05:00Z
+  created: 2026-07-30T07:05:00Z
   channel: agent-authored
-  agent: "Claude Code agent, operator-directed session on agent supervision and governance"
+  agent: "Claude Fable 5, Claude Code web session"
+  activity: "operator-directed session on agent supervision and governance"
   why: "the distinction generalizes past the project that surfaced it — …"
```

The `agent` value above is **recovered, not invented**: this doc's filing
commit (`818a885`) carries `Co-Authored-By: Claude Fable 5` in its trailer.
The migration recovers the model from each doc's filing-commit trailer — the
same derivation the attribution backfill used — and writes
`model undisclosed` **only** where no trailer exists (pre-2026-07-07 commits,
merge commits, local-terminal sessions, per
[merge-strategy](/meta/policy/merge-strategy.md)'s coverage-gap list).
Stamping `model undisclosed` onto a doc whose model *is* recorded discards
evidence; an earlier draft's example did exactly that and was corrected at
the 2026-08-01 review pass.

**Known error mode — the trailer names the harness's configured display
string, not necessarily the model that authored the turn.** Observed
directly in the 2026-08-01 session that wrote this plan: the operator
switched models mid-session (`/model`), and commit `db44f6a` — authored
while the session ran one model — carries a trailer naming the *other*.
The trailer is therefore strong evidence about a commit whose session never
switched models, and unreliable for one that did; a mixed-model session
attributes every doc in a commit to one string regardless. Two consequences
for phase 1: the recovery pass writes the trailer value as the **best
available attestation** (never a measurement — the posture
[model-attribution](/meta/policy/model-attribution.md) already fixes), and
it must not be presented to the operator as a verified model census. Where
a session knows it switched, the authoring model belongs in
`provenance.note` at filing time, since no post-hoc derivation can recover
it.

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
  model-attribution.md      # MODIFIED — model's home moves to attribution.agent (D5)
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
   edits (resource-attribution, model-attribution), `Attribution` checks,
   corpus migration sweep, contract recompile. **Scope honesty: this is the
   widest sweep since the `sb:` → `em:` id migration** — `timestamp` →
   `modified` touches every document in the bundle, and the attribution key
   renames touch every attribution block, plus every tool and policy that
   reads `timestamp` (registry, collection ordering, index conventions).
   Execute verifier-atomically on the id-migration pattern: one deterministic
   pass, gates green before and after, no partially-renamed state. Model
   values are recovered from filing-commit trailers (see the worked example);
   the migration's write path wants `Frontmatter.dump/1` from the
   [parser-rewrite plan](/meta/plans/frontmatter-parser-profile-rewrite.md) —
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

**Cross-plan ordering:** phase 1 here lands **before** phase 2 of the
[schema-formalization plan](/meta/plans/schema-formalization-and-evaluator-lane.md),
so its per-key definition blocks are written once, against the final key set,
rather than formalizing a schema this plan immediately rewrites.

## Span survival across edits — ruled 2026-08-01

Route tags only annotate frozen thread bodies; knowledge documents are living,
and a span boundary must survive prose re-flows. **Ruling: spans re-anchor by
normalized content hash, and the verifier fails on drift** — an edit that
changes text inside a span must update or re-confirm the span in the same
commit, converting span freshness from a remembered obligation into a gate.
The alternative (manual re-marking as editorial discipline) is rejected on the
bundle's own prior:
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md).
Residual detail for execution: hash granularity (per-span, over
whitespace-collapsed content) and the re-confirmation syntax — mechanics, not
open design.

## Open questions

1. **Truth-apt span segmentation.** Deciding which sentences are claims vs.
   framing has no mechanical oracle; it lands in the evaluator lane of the
   [schema-formalization plan](/meta/plans/schema-formalization-and-evaluator-lane.md)
   rather than in a gate.
2. **Adjacent-layer reconciliation.** The
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
  guessed); a separate `synthesis` frontmatter block (fourth origin structure
  — folded into `provenance`, review pass); folding `channel` into free-text
  `activity` (demotes a machine-queried controlled value to prose);
  `provenance.model` beside a model-bearing `agent` (one fact, two fields);
  manual span re-marking as discipline (remembered surface — see the ruling
  above).
- **Assumption:** the four classes are exhaustive for this bundle's text. A
  fifth (e.g. tool-generated tables) would extend the class enum, not the
  architecture.
