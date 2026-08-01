---
type: plan
title: "Per-key schema formalization and the advisory evaluator lane"
description: Give every frontmatter key a formal, machine-readable definition co-located with its policy, check values against those definitions in three tiers — deterministic shape (existing gates), deterministic structure over prose (new gate-eligible checks, generalizing the glossary containment check bundle-wide), and semantic fit (an LLM evaluator) — and admit the evaluator through a new advisory CI lane that reports but can never fail the build, keeping the offline zero-dependency gate doctrine intact.
status: accepted
provenance: "Agent-distilled from an operator-directed design dialogue examining em:712e01 against the attribution machinery, 2026-08-01; model undisclosed"
tags: [meta, plan, schema, verification, evaluator, ci, description, iso-704, definitions, gates]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T07:31:45Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on schema formalization and attribution"
  why: "the frontmatter schema's semantic obligations (a description that summarizes, a type that fits, a provenance that resolves) are enforced by nothing — the operator ratified formalizing each key's definition and checking values against it, with the fuzzy residue judged by an evaluator that reports without gating"
---

# Per-key schema formalization and the advisory evaluator lane

## Problem

The frontmatter schema's *shape* is machine-enforced — `mix brain.verify`
checks attribution wellformedness, `verified`/`verified_by` coherence,
`launch`, ref resolution — but its *semantics* are enforced by nothing. A
`description` that near-copies the body's first paragraph, a `type` whose
definition the content contradicts, a title term-pair the description silently
swaps ("normative records" / "decision records" on `em:712e01`): all pass every
gate. The definitions the checks would need are prose scattered through the
policy set, written for humans, resolvable by no tool.

One existing check proves the middle ground exists:
[`ElixirMind.Glossary`](/lib/elixir_mind/glossary.ex)'s repetition check
computes content-word containment between each body sentence and the
`description` — deterministic, offline, CI-failing — but only over
`beliefs/glossary/`. The rest of the bundle has no description discipline at
all.

## Decisions — ratified 2026-08-01

**D1 — Three tiers per key.**

| Tier | Predicate kind | Checker | Disposition |
|---|---|---|---|
| 1 shape | parseable, present, controlled values, refs resolve | `mix brain.verify` (existing) | gate — fails |
| 2 structure | deterministic reductions over prose: containment, grammar templates, path/tag disjointness | new `mix` checks, zero-dep | gate — warn first, fail once corpus is clean |
| 3 semantic fit | does the value satisfy the key's *definition*: summary quality, type fit, genus adequacy | LLM evaluator | advisory lane — reports, never fails |

**D2 — Formal definitions live where the schema lives.** Each key's
machine-readable definition is a fenced block inside the policy doc that
already governs it ([frontmatter-schema](/meta/policy/frontmatter-schema.md)
and siblings): the key, its tier-1 shape, its tier-2 reductions, and the
tier-3 predicate stated as the question the evaluator answers. One artifact,
so the human rule and the checked rule cannot drift apart; the evaluator
resolves definitions from the policy source, not from a copy.

**D3 — The description regime generalizes from the glossary, unchanged.**
`description` is the canonical compressed statement; the body is
expansion-only; containment-checked bundle-wide with the glossary's
thresholds as the starting calibration. Warn-only first to measure the
existing violation rate, then fail. For `type: concept`, tier 2 additionally
parses the description against an intensional-definition template
(superordinate + delimiting characteristics — ISO 704's form), and tier 3
judges whether the differentia actually delimits.

**D4 — ISO 704 is adopted as distilled knowledge, never as a committed PDF.**
The standard (ISO 704:2022, ed. 4, CHF 204) enters the bundle as a
`reference`/`source` capture — principles distilled, phrase-scale verbatim
quotes, `resource:` the ISO catalog URL — per
[capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md).
Committing the PDF is ruled out: the bundle publishes to public GitHub Pages,
repo history is unrewritable by policy, and the single-user license does not
extend to redistribution. Free proxies for the same craft (the Pavel
terminology tutorial; OMG SBVR) are acceptable capture sources if the standard
is not purchased.

**D5 — The vocabulary becomes pure content-kinds.** Ratified here, recorded
and executed under the
[concept-terminology plan](/meta/plans/concept-terminology-and-type-redefinition.md)
(the standing artifact for that matter): `claim` = truth-apt proposition;
`concept` = definition or mental model, judged by adequacy; `belief` =
holder-indexed assertion; claim→concept graduation dropped;
"(established/accepted)" dropped; `verified` becomes the sole status carrier.

**D6 — No adopted standard defines `belief`; the axis is bundle-native.**
Scoped negative finding, recorded so it is not silently re-derived: ISO 704,
SKOS, PROV-DM, and SBVR were each read against the type vocabulary (from
training knowledge, at ratification time). ISO 704 and SKOS carry no
truth-status axis; PROV-DM models origin, never warrant; SBVR has alethic and
deontic modality (mapping to `policy`/`doctrine`) but no doxastic modality.
The `claim`/`belief` split is this bundle's own contribution, anchored in
doxastic logic (`B_holder φ`: an assertion whose warrant is that a specified
holder holds it) — the sanctioned bespoke case under
[prefer-established-terminology](/meta/policy/prefer-established-terminology.md).

**D7 — The evaluator enters through a new advisory lane, not a weakened gate.**
The [coding-standards](/meta/policy/elixir-coding-standards.md) admission rule
(offline, zero-dependency, signal beats upkeep) stands unmodified for gates.
The doctrine gains a second lane on the actionlint precedent (checks whose
subject exists only in CI run CI-only): **advisory checks run CI-only, report
into the PR, and can never fail the build** — which is where nondeterminism,
API cost, and network belong. Policy amendment + contract recompile.

**D8 — The evaluator is a plain mix task; Jido stays deferred.** One API call
per key per changed doc, schema-constrained response, rendered as a PR
report. On a current toolchain this is zero-dependency (`:httpc` + the
stdlib JSON that arrives with the raised floor), so the
[toolchain-floor plan](/meta/plans/raise-elixir-otp-toolchain-floor.md) — in
its own order, environment first, pins second — is a prerequisite for the
lane. Agent-framework machinery (supervised loops, scheduling) is the
[thin-Jido-host plan](/meta/plans/thin-jido-brain-host.md)'s territory and is
not needed to judge one value against one definition.

**D9 — Two invocations, two scopes.** The CI lane evaluates the PR's changed
documents (signal attached to the change that introduced it); a scheduled
full-corpus audit runs the same task over everything and files its report as
a governance doc (catches drift predating the checks). Same code, different
scope flag.

**D10 — Tags are facets; the flat index is derived.** Ratified here, recorded
under the [tag-governance plan](/meta/plans/tag-governance.md) (the standing
artifact for that matter): stored tags never duplicate the doc's own path
segments (tier-2 lint), and tag queries union stored tags with path segments
at query time, labeling each hit `[path]` (canonically filed here) or `[tag]`
(cross-cutting facet).

## Desired shape

File-tree diff:

```
meta/policy/
  frontmatter-schema.md       # MODIFIED — per-key definition blocks (D2)
  elixir-coding-standards.md  # MODIFIED — advisory-lane amendment (D7)
lib/elixir_mind/
  descriptions.ex             # NEW — bundle-wide containment + per-type grammar (tier 2)
  schema_defs.ex              # NEW — parse per-key definition blocks out of policy docs
lib/mix/tasks/
  brain.descriptions.ex       # NEW — tier-2 runner (gate-eligible)
  brain.evaluate.ex           # NEW — tier-3 runner (advisory lane only)
.github/workflows/
  ci.yml                      # MODIFIED — advisory job, non-blocking, changed-docs scope
```

Signatures:

```elixir
@spec check(entries :: [Registry.Entry.t()], opts :: keyword) :: [finding]        # Descriptions
@spec definitions(root :: String.t()) :: %{optional(String.t()) => KeyDef.t()}    # SchemaDefs
@spec evaluate(entry :: Registry.Entry.t(), defs :: map, opts :: keyword) :: [finding]  # brain.evaluate
```

Boundary decisions:

- **`SchemaDefs` is the only reader of definition blocks** — tier 2 and tier 3
  both consume its output; the policy text stays the single source.
- **Tier 2 never calls a model; tier 3 never gates** — the tier boundary is
  the doctrine boundary, kept structural.
- **The advisory job is a separate workflow job** with its own status check,
  never a step inside the gate job — a lane the branch protection does not
  require.

## Build order

1. **Pilot (deterministic only).** `Descriptions` containment bundle-wide,
   warn-only, with a measured violation census; the tag/path disjointness
   lint (after the tag-governance report exists to absorb its findings); and
   the `em:712e01` fixes — description rewritten to the intensional template
   without body overlap, provenance ref resolved, `supervision` tag
   dispositioned — as the pilot's worked test case.
2. **Definition blocks + doctrine amendment.** Per-key blocks into the policy
   docs (D2), the advisory-lane amendment (D7), contract recompile,
   `SchemaDefs` parsing them with a freshness-style check that every
   schema key has a block.
3. **Vocabulary execution** — runs under the concept-terminology plan (D5):
   policy edits, the one graduated doc retyped, code-side vocabulary sweep,
   contract recompile.
4. **Evaluator lane** — after the toolchain floor rises: `brain.evaluate`,
   the CI advisory job over changed docs, thresholds and prompt fixed by the
   definition blocks alone.
5. **Scheduled audit** — the full-corpus invocation as a Routine filing a
   dated report; cadence decided from the phase-4 signal.

## Open questions

1. **Definition-block format** — YAML-in-fence vs. a dedicated section
   grammar; decided at phase 2 by whichever `SchemaDefs` parses with the
   least ceremony under the existing frontmatter parser's limits.
2. **Evaluator model tier and cost ceiling** — per-run spend cap and which
   model the lane calls; decided at phase 4 with real per-doc token counts.
3. **Tier-3 finding lifecycle** — whether advisory findings accumulate into
   `meta/issues/` automatically or stay report-only until an operator
   promotes them. Report-only is the phase-4 default; automation is a
   separate decision.

## Decision list

- **Recommended shape:** D1–D10, built 1→5, with phases 1–3 fully inside the
  existing gate doctrine and only phase 4 touching the new lane.
- **Rejected:** SHACL/declarative constraint re-expression (stays declined
  per the [ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md);
  reopen only on its own named conditions, which large-scale definition churn
  could yet trigger — that reopening is sanctioned, not feared); an LLM judge
  inside a blocking gate (nondeterminism decides merges); a committed ISO 704
  PDF (D4); formalizing body-prose rhetorical structure beyond descriptions
  and spans (a controlled natural language whose authoring cost approaches
  its checking benefit — the [spec-length prior](/beliefs/spec-detail-approaches-code-length.md),
  `em:1eebdf`, applied to prose).
- **Assumption:** the glossary thresholds (fail ≥ 0.72, warn ≥ 0.55) transfer
  to non-glossary prose approximately; phase 1's census is the calibration
  data for revising them.
