---
id: em:df9c77
type: concept
title: RDF (Resource Description Framework)
description: The W3C graph data model in which every statement is a subject–predicate–object triple over IRI-identified resources, giving identity decoupled from location and an extensible "anyone can say anything about anything" posture.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, semantic-web, rdf, graph]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T07:12:25Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the data model the bundle-vs-semantic-web comparison turns on"
---

# RDF (Resource Description Framework)

The W3C data model underlying the semantic-web stack: knowledge is a set of
**triples** — subject, predicate, object — whose subjects and predicates are
**IRIs**, so identity is global and decoupled from any document's location.
Schema layers sit *in* the graph rather than above it: RDFS adds `rdfs:Class`,
`rdfs:subClassOf`, `domain`, and `range`, and [OWL](/beliefs/glossary/owl.md)
ontologies are themselves primarily exchanged as RDF documents. Its posture is
deliberately open — unknown vocabulary and extra statements are tolerated
rather than rejected — which is the interoperability half of the
[open-world assumption](/beliefs/glossary/open-world-assumption.md). This
bundle's frontmatter is triple-shaped by construction (an `em:` id plays the
IRI role, each key a predicate), which is what makes a derived RDF/JSON-LD
export a near-mechanical translation.

*Seen in:* [OWL and the belief layer](/meta/analysis/owl-and-the-belief-layer.md), [FOL and OWL reference](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md), [2026-07-28 OWL/RDF/SKOS thread](/meta/threads/2026-07-28-owl-rdf-skos-and-the-belief-layer.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:df9c77">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-owl-rdf-skos-and-the-belief-layer (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:df9c77`]**  (co-feeds: `em:8255b8`)

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
