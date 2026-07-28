---
id: em:8995e9
type: concept
title: SKOS (Simple Knowledge Organization System)
description: The W3C standard for publishing knowledge-organization schemes — thesauri, taxonomies, glossaries — as RDF, whose hierarchy relations deliberately carry no subsumption semantics, so meaning stays in the natural-language labels rather than in logic.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, semantic-web, rdf, taxonomy, vocabulary]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T07:12:25Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "operator asked what SKOS is during the OWL/RDF comparison; the term is load-bearing in the resulting analysis"
---

# SKOS (Simple Knowledge Organization System)

A W3C Recommendation (2009) for publishing controlled vocabularies as
[RDF](/beliefs/glossary/rdf.md): `skos:Concept` as the unit, `skos:ConceptScheme`
as the collection, `prefLabel`/`altLabel` for names, `definition`/`scopeNote`
for documentation, `broader`/`narrower` for hierarchy, `related` for
see-also links, and `exactMatch`/`closeMatch` for aligning concepts across
schemes. Though itself written as an [OWL](/beliefs/glossary/owl.md) ontology, its
load-bearing design decision is a refusal: `skos:broader` is deliberately *not*
`rdfs:subClassOf` — it licenses no subsumption inference and is not even
transitive by default — so a concept's meaning lives in its labels and
definitions while the RDF carries only identity, hierarchy, and linkage. That
makes it the fitting target vocabulary for a prose-first scheme like this
bundle's taxonomy and glossary, where [OWL](/beliefs/glossary/owl.md)'s
reasoning semantics would be unused weight.

*Seen in:* [OWL and the belief layer](/meta/analysis/owl-and-the-belief-layer.md), [2026-07-28 OWL/RDF/SKOS thread](/meta/threads/2026-07-28-owl-rdf-skos-and-the-belief-layer.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:8995e9">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-owl-rdf-skos-and-the-belief-layer (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:8995e9`]**

SKOS — the **Simple Knowledge Organization System** — is a W3C standard (Recommendation, 2009) that sits in the same semantic-web family as the lecture's RDF/RDFS/OWL, but targets a humbler and very common need: publishing *knowledge-organization schemes* — thesauri, taxonomies, subject-heading lists, glossaries, folksonomies — as machine-readable data. It came out of the library and information-science world (think Library of Congress Subject Headings, UNESCO and AGROVOC thesauri, Wikidata's concept links), where people had been building controlled vocabularies for a century without needing formal logic.

Technically, SKOS is itself an OWL ontology, and its data is plain RDF triples. Its core vocabulary:

- **`skos:Concept`** — the unit: a "concept" is an idea identified by an IRI, not a formal class with membership semantics.
- **`skos:ConceptScheme`** — the bundle of concepts that belong together (a particular thesaurus or glossary), with `skos:inScheme` linking each concept to it.
- **Labels** — `skos:prefLabel` (the one preferred display name per language), `skos:altLabel` (synonyms, abbreviations), `skos:hiddenLabel` (misspellings for search).
- **Documentation** — `skos:definition`, `skos:scopeNote` (how/when to use the term), `skos:example`, `skos:note`.
- **Hierarchy and association** — `skos:broader` / `skos:narrower` for the tree ("git" narrower than "version control"), and `skos:related` for non-hierarchical see-also links.
- **Mappings** — `skos:exactMatch`, `skos:closeMatch`, `skos:broadMatch` etc., for aligning concepts *across* different schemes ("my 'agents' concept ≈ your 'autonomous systems' concept").

The crucial design decision — and why I called it a better fit for this repo than OWL — is what SKOS *doesn't* claim. `skos:broader` is deliberately **not** `rdfs:subClassOf`: it carries no subsumption semantics, no reasoner will infer that instances of the narrower concept are instances of the broader one, and it isn't even transitive by default. The meaning of a SKOS concept lives in its natural-language labels and definitions; the RDF structure only carries identity, hierarchy, and linkage. That's the same trade this brain makes — "links are untyped edges; the prose carries the meaning" — which is why the mapping is so clean:

| elixir-mind | SKOS |
|---|---|
| a glossary entry / bundle document | `skos:Concept` |
| `em:` id | the concept's IRI |
| the bundle | `skos:ConceptScheme` |
| `title` | `skos:prefLabel` |
| `description` | `skos:definition` |
| directory tree / index nesting | `skos:broader` / `skos:narrower` |
| cross-links in prose | `skos:related` |
| `tags` | additional `skos:related` or scheme-internal grouping |

In short: OWL is for when you want a machine to *reason* about your categories; SKOS is for when you want to *publish and interlink* a human-curated vocabulary in a standard, queryable form. The brain is structurally the latter, which is why a derived SKOS/JSON-LD export would be a near-mechanical translation rather than a re-modeling exercise.
