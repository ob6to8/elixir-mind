---
id: em:8255b8
type: reference
title: "FOL and OWL: fully formal knowledge representation"
description: First-order logic and the W3C Web Ontology Language (OWL 2) — the fully formal end of the knowledge-representation spectrum, with provable semantics, decidability trade-offs, and the authoring cost that motivates semiformal middle layers.
resource: https://www.w3.org/TR/owl2-overview/
provenance: "Distilled from the Wikipedia article on first-order logic and the W3C OWL 2 overview, fetched 2026-07-11; layered breakdown via /summarize-technical"
tags: [knowledge-representation, logic, first-order-logic, owl, description-logic, ontology, semantic-web, formal-methods]
timestamp: 2026-07-11
attribution:
  when: 2026-07-11T09:07:29+00:00
  channel: intake
  agent: "Claude Code agent, /intake"
  why: "operator-directed prior-art capture for the belief-decomposition assessment; body later restructured via /summarize-technical"
---

# FOL and OWL: fully formal knowledge representation

## Summary

These are the two landmark systems for writing statements so precisely that a
machine can *prove* what follows from them — the fully formal end of the
knowledge-representation spectrum, against which any semiformal scheme
defines itself.

The first, developed in the 1880s and mature by 1929, is a general language
of objects, their properties, and the relations between them, with the two
quantities "for all" and "there exists." Its powers and limits are theorems.
Everything that genuinely follows from a set of statements can be found by
mechanical proof search (nothing valid is out of reach); but there is no
procedure that always *terminates* when asked whether something follows — if
the answer is no, the search may run forever. And no set of statements in the
language can pin down an infinite structure like the whole numbers uniquely;
unintended interpretations always sneak in.

The second (a web standard, 2009) is a deliberately weakened descendant built
for publishing machine-readable vocabularies — categories, relationships,
individuals — on the web. By restricting what can be said, it buys what the
general language cannot offer: reasoning that is guaranteed to terminate, and
in its most restricted variants, guaranteed to be *fast*. It comes in graded
strengths, each targeting a workload: huge medical-style vocabularies,
database-backed query answering, or rule engines.

Together they mark the trade the formal pole offers: provable consequence
and mechanical consistency checking, purchased with expressive restriction
and heavy authoring cost — real prose does not compile into either.

## Key terms

- **Term / formula / sentence** — the syntax hierarchy: terms name objects
  (variables, constants, function applications); formulas state propositions
  (predicates over terms, combined by connectives and quantifiers ∀/∃); a
  sentence is a formula with no free variables, so its truth needs no further
  context.
- **Signature** — the non-logical vocabulary a theory chooses: its predicate,
  function, and constant symbols. The formal analogue of "what this document
  is allowed to talk about."
- **Structure (interpretation)** — a domain of objects plus an assignment of
  the signature's symbols to actual relations and functions over it; the
  thing formulas are true *in*.
- **Satisfaction (Tarski truth)** — the inductive definition of "structure M
  makes formula φ true" (M ⊨ φ), the anchor for every other semantic notion.
- **Validity / logical consequence** — true in every structure / true in
  every structure satisfying the premises. Consequence is the formal
  counterpart of the entailment judgments a belief graph asks for per edge.
- **Soundness & completeness (Gödel 1929)** — proof systems for first-order
  logic derive exactly the valid formulas: syntactic derivability and
  semantic consequence coincide.
- **Semidecidability (Church–Turing)** — consequence can be *confirmed* by
  exhaustive proof search but not refuted in general: no algorithm decides
  arbitrary entailment. The fundamental ceiling on formal auditing.
- **Compactness / Löwenheim–Skolem** — a theory is satisfiable if every
  finite part is; and satisfiable theories have countable (hence unintended)
  models — no first-order theory uniquely characterizes an infinite
  structure.
- **Description logic** — decidable FOL fragments engineered for
  concept/role/individual reasoning; **SROIQ** is the one underlying OWL 2.
- **OWL 2 DL vs. OWL 2 Full** — the syntactically restricted species that
  translates into SROIQ (decidable, under *Direct Semantics*) versus the
  unrestricted reading over arbitrary RDF graphs (*RDF-Based Semantics*,
  expressive but undecidable); a correspondence theorem keeps the two
  readings consistent where they overlap.
- **Profiles (EL / QL / RL)** — OWL 2's graded sub-languages with
  computational guarantees: EL gives polynomial-time reasoning for very large
  ontologies; QL answers conjunctive queries inside relational-database
  complexity (AC⁰) over big instance sets; RL supports rule-engine
  implementation directly on RDF triples.
- **Reasoning tasks** — the standard machine services: consistency,
  class satisfiability, subsumption/classification, instance retrieval —
  i.e. mechanical detection of contradiction and hierarchy.

## Technical summary

First-order logic fixes a signature, builds terms and formulas over it, and
interprets them in structures via Tarskian satisfaction; validity and logical
consequence are quantification over all structures. Gödel completeness makes
consequence provable (sound + complete calculi: Hilbert systems, natural
deduction, sequent calculus, resolution), compactness and Löwenheim–Skolem
bound what theories can pin down, and Church–Turing semidecidability caps
mechanical audit: entailment is confirmable, non-entailment not generally so.
Categorical characterization of infinite structures requires second-order
quantification, which sacrifices the completeness theorem.

OWL 2 packages a description-logic fragment for the web: ontologies of
classes, object/data properties, individuals, and axioms, exchangeable as RDF
(RDF/XML mandatory; Functional, Manchester, Turtle, OWL/XML optional). OWL 2
DL's Direct Semantics is model-theoretically aligned with SROIQ, so
consistency, subsumption, classification, and instance retrieval are
decidable; OWL 2 Full's RDF-Based Semantics drops all syntactic restriction
and decidability, with a correspondence theorem linking the two. The EL/QL/RL
profiles trade expressiveness for complexity guarantees (PTIME / AC⁰ query
answering / PTIME rule-based, respectively).

For a semiformal belief layer the relevant readings are: (1) entailment,
consistency, and
[minimal inconsistent subsets](/beliefs/glossary/minimal-inconsistent-subset.md) are
crisply defined only at this pole — semiformal analogues inherit the *shape*
of these notions while replacing the oracle with LLM judgment; (2) even here,
full generality is undecidable — guaranteed audit always comes from
restriction; (3) the authoring cost of formal ontologies is the standing
argument for keeping belief content in natural language and formalizing only
the *structure* around it.

## Why it is in this brain

FOL/OWL mark the fully formal pole against which a semiformal epistemic
substrate defines itself — what full formalization buys, and the
brittleness/authoring costs that motivate keeping beliefs in natural language
with an LLM as the local entailment oracle. See the
[belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md).

# Citations

- First-order logic — Wikipedia: <https://en.wikipedia.org/wiki/First-order_logic>
- OWL 2 Web Ontology Language Document Overview (Second Edition) — W3C:
  <https://www.w3.org/TR/owl2-overview/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:8255b8">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-owl-rdf-skos-and-the-belief-layer (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:8255b8`]**  (co-feeds: `em:df9c77`)

**Structural similarities — the repo re-invents the RDF layer**

**Stable ids ≈ IRIs.** The stable-identity policy — an `em:` id is "minted once … never changed, and never reused, even if the file moves" ([stable-identity](https://ob6to8.github.io/elixir-mind/meta/policy/stable-identity.html)) — solves the same problem IRIs solve in RDF: identity decoupled from location. The rule that "typed edges reference ids, not paths" is exactly RDF's discipline of predicating over resources, not documents. Even the `sb:` → `em:` prefix migration is a namespace-prefix rebinding, the same move as swapping an `xmlns:` declaration in the lecture's slide-8 header.

**Frontmatter ≈ triples.** Every frontmatter key is a subject–predicate–object assertion: (`em:8255b8`, `type`, `reference`); (claim, `verified_by`, source). The bundle flattens into an RDF graph almost mechanically.

**`type` ≈ `rdf:type` over an RDFS-style schema.** The controlled type vocabulary is a small ontology of classes, and the arrangement where `meta/policy/` defines the vocabulary that bundle documents instantiate mirrors how RDFS is itself written in RDF — schema and instances in one graph. The ratification protocol for new types is ontology governance by another name.

**The verification rules ≈ domain/range constraints.** The lecture gives `domain(C)` as `∃R.⊤ ⊑ C` — "things bearing this property belong to this class." The brain's rule that `verified` may appear "**only for agent-authored statements** (`claim`/`note`/`concept`)" ([verification-grounding](https://ob6to8.github.io/elixir-mind/meta/policy/verification-grounding.html)) is literally a domain constraint on a property. `verified_by` is a typed edge with a range restriction (targets must exist, typically `source` captures). One semantic caveat: in OWL these axioms *infer* under an open-world assumption (an untyped object of `hasChild` gets classified, not rejected), whereas `mix brain.verify` *rejects* violations — closed-world validation. In semantic-web terms the gate suite is **SHACL-shaped, not OWL-shaped**.

**Tree ≈ taxonomy, but SKOS more than OWL.** "The tree *is* the taxonomy" is a subsumption-flavored hierarchy, but a directory is single-parent and holds documents, not logical class membership — closer to SKOS `broader`/`narrower` than to `rdfs:subClassOf` with its multiple inheritance and inferred transitivity. The glossary — one concept per term, cross-linked, with citations — is very nearly a SKOS concept scheme already.

**Tolerant consumption ≈ open-world ethos.** The conformance rule — never reject a bundle for unknown types, extra keys, or broken links; preserve arbitrary extra keys — is RDF's "anyone can say anything about anything" extensibility posture.

**The deliberate difference — declining the DL trade**

The lecture's real subject is the OWL↔description-logic correspondence: restrict expressivity (DL, then the EL/QL/RL profiles) to buy decidable, even tractable, reasoning. The brain sits consciously on the other side of that trade. Its links are "untyped edges; the prose carries the meaning" — the inverse of RDF, where the typed predicate *is* the meaning — and there is no reasoner: no subsumption, no classification, no consistency checking. The filed FOL/OWL reference states the position: "the authoring cost of formal ontologies is the standing argument for keeping belief content in natural language and formalizing only the *structure* around it" — an LLM serves as the local entailment oracle instead of a DL reasoner.

Notably, the brain has *tried* moving toward the formal pole twice — the deprecated assertion DAG and Composable Beliefs — and the [belief-decomposition analysis](https://ob6to8.github.io/elixir-mind/meta/analysis/belief-decomposition-derived-vs-authored.html) diagnoses both failures the same way: atomized, authored graph stores accrue unbounded maintenance debt. Its verdict — "derive the graph, never author it" — is essentially a policy on where OWL-style structure is allowed to live: only in regenerable overlays.

That said, one idea in the lecture rhymes with the brain's own doctrine rather than opposing it: the OWL 2 profiles exist because "expressive power can be traded for performance guarantees" — the same shape as the gate-suite admission rule (a check earns a gate only when its "signal beats its upkeep"). Both are disciplined restriction purchased for guarantees.
