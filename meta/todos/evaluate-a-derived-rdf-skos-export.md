---
type: todo
title: "Evaluate a derived RDF/SKOS export of the bundle (mix brain.rdf)"
description: The bundle's frontmatter is already triple-shaped and its taxonomy/glossary are already a SKOS-shaped concept scheme, so a derived RDF/JSON-LD export would make the corpus SPARQL-queryable and interoperable at no cost to the authored substrate; decide whether the interoperability is wanted before building the task.
status: open
provenance: "Claude Code session, 2026-07-28 — the one open strand left by the OWL/RDF/SKOS comparison"
tags: [meta, todo, rdf, skos, semantic-web, derived-views, tooling, interoperability]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T10:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, OWL/belief-layer session"
  why: "the comparison's only unresolved strand; filed as tracked work rather than left as one dangling row among 97"
  from: [/meta/threads/2026-07-28-owl-rdf-skos-and-the-belief-layer.md]
---

# Evaluate a derived RDF/SKOS export of the bundle

The [OWL/belief-layer analysis](/meta/analysis/owl-and-the-belief-layer.md)
found that this bundle independently converges on
[RDF](/beliefs/glossary/rdf.md)'s identity-and-assertion layer: `em:` ids play
the IRI role, every frontmatter key is a subject–predicate–object assertion, and
the taxonomy plus glossary are very nearly a [SKOS](/beliefs/glossary/skos.md)
concept scheme already. The translation is therefore near-mechanical rather than
a re-modeling exercise.

**Task.** Decide whether to build `mix brain.rdf`, emitting the bundle as
Turtle and/or JSON-LD. The shape the analysis recommends:

| Bundle | Export |
|---|---|
| `em:` id | IRI under the Pages base URL (`ElixirMind.SiteConfig.base_url/0`) |
| `type` | `rdf:type` |
| `title` / `description` | `skos:prefLabel` / `skos:definition` |
| directory tree, index nesting | `skos:broader` / `skos:narrower` |
| `verified_by` | a typed predicate |
| `provenance`, `attribution` | [PROV-O](/beliefs/glossary/prov-o.md) terms |

Deliberately **out of scope**: any OWL axioms or reasoning. The analysis
declines OWL-as-reasoner, and the same reasoning that keeps
[SHACL](/beliefs/glossary/shacl.md) out of the verifier
([ontology guardrails](/meta/analysis/ontology-guardrails-vs-schema-validation.md))
applies here — this is a serialization, not a semantics layer.

**The real question is demand, not feasibility.** The export buys
interoperability with standard tooling (SPARQL, vocabulary alignment, embedding
JSON-LD in the Pages site) and costs a generated artifact to keep fresh. Nothing
currently consumes it. Weigh it against the
[derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md)
doctrine, which permits the artifact cheaply, and the
[admission rule](/beliefs/glossary/admission-rule.md), which asks whether the
signal beats the upkeep — noting a generated view that no gate checks is not
subject to the admission rule at all, since it is not a gate.

**Done when.** Either `mix brain.rdf` exists with its freshness handling
decided, or this todo is closed `cancelled` with the reason recorded — that no
consumer justifies the artifact yet, and what would change that.
