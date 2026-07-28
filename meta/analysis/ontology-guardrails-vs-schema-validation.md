---
type: analysis
title: "Ontology guardrails vs. schema validation for agent loops: what a reasoner buys, and what Coyle's examples actually need"
description: Evaluates Frank Coyle's "Pydantic at the door, ontology at the ledger" against Jido 2 and against a custom Elixir enforcement layer; finds Jido occupies the door and the effect boundary but not the ledger, that OWL's open-world and no-unique-name semantics actively fight the talk's flagship double-refund catch (SHACL is the formalism that encodes it), that the talk never implements the ledger at all, and that none of its three motivating examples need inference — so the recommendation is a split enforcement stack (schemas and Elixir's type system at level 2, a closed-world constraint layer at level 3) with OWL reserved for derived knowledge and vocabulary reuse.
provenance: "Claude Code session, 2026-07-28 — operator asked whether Jido 2's directives/actions implement the validator pattern from the Coyle talk, then whether Jido is better compared to Pydantic, what Coyle's ledger is written in, and what adopting OWL as the enforcement layer offers over a custom Elixir one. Talk claims verified against the video's own transcript; Jido mechanics against the agentjido docs (jido, jido_action) 2026-07-28; Elixir RDF ecosystem against rdf-elixir.dev, GitHub, and hex"
tags: [meta, analysis, ontology, owl, shacl, rdf, jido, elixir, agents, guardrails, validation, neurosymbolic-ai, knowledge-representation]
timestamp: 2026-07-28T08:05:00Z
attribution:
  when: 2026-07-28T08:05:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked whether Jido 2's directives/actions implement Coyle's ontology-validator pattern, and what adopting OWL as an enforcement layer would buy over a custom Elixir one"
  from: [/meta/threads/2026-07-28-ontology-guardrails-intake-and-jido-comparison.md]
---

# Ontology guardrails vs. schema validation for agent loops

**Question.** [Coyle's talk](/knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md)
prescribes wrapping a tool-use loop with an ontology validator — "Pydantic at the
door, ontology at the ledger." Does [Jido 2](/beliefs/glossary/jido.md)'s
Action/Directive machinery already implement this? If not, what would adopting
RDFS/OWL as the enforcement layer buy over writing one in Elixir?

**Thesis.** Jido occupies the **door** and the **effect boundary**, not the
ledger — and the ledger is not a framework's to supply, because it is a model of
the business, not of the loop. But the sharper finding is about the ledger
itself: **OWL does not encode the talk's flagship example**, the talk never
implements the ledger at all, and none of its three motivating catches require
inference. The enforcement stack should therefore split by *world assumption*,
not adopt one formalism for both levels.

## Finding 1 — Jido is a door-and-effects framework; Directives are not validation

The comparison the operator proposed is the right one: Jido's Action schema is
the Pydantic-equivalent, and the ledger floats above either. Jido spans more
positions than Pydantic does, just not that one.

| Coyle's layer | Jido 2 equivalent | Verdict |
|---|---|---|
| Pydantic at the door | `use Jido.Action, schema: [...]` — documented hook order runs params → `on_before_validate_params` → schema validation → `on_after_validate_params` → `run`, then output validation | **Present, and better designed** |
| Tools side-effect-free | Directives — `run/1` returns `%Directive.Emit{}`/`Spawn`/`Schedule` as *data*; the runtime interprets them | **Present, and structural rather than a discipline** |
| Ontology at the ledger | — | **Absent** |

The door improves on the talk's Python in one specific way: `to_tool/0` derives
the LLM's `parameters_schema` from the *same* declaration that validates at
execution, and `Jido.Action.Tool.execute_action/3` re-validates the model's
actual arguments. In Coyle's setup the tool schema sent to the model and the
Pydantic model guarding execution are two artifacts that can drift apart; in
Jido they cannot.

**Directives are the effect-deferral mechanism, not the checking mechanism.**
They implement Coyle's prescription that agents "should try to have no side
effects" — the
[functional core, imperative shell](/beliefs/glossary/functional-core-imperative-shell.md)
split that keeps `cmd/2` replayable. The runtime type-checks them structurally
(a malformed instruction yields `%Jido.Agent.Directive.Error{}`), but nothing
consults a domain model before interpreting one. Deferring an effect is not
adjudicating it.

The categorical difference underneath: **a schema decides membership; a logic
derives consequences.** Jido's NimbleOptions/Zoi schemas are runtime predicates
over values — no entailment relation, no semantics, no reasoner. They can reject
`"probably shipped"` but can never report something not asserted.

## Finding 2 — OWL does not encode the double refund; SHACL does

Run the talk's three closing catches against the formalisms:

| Catch | Formalism that encodes it | Note |
|---|---|---|
| `"probably shipped"` — invented enum value | Any schema; `owl:oneOf` | Trivial; Jido gets it free |
| Payout to support desk, not buyer | `owl:disjointWith(Customer, SupportRep)` → inconsistency | Works cleanly — **but only if the payee is a typed individual in the graph**, not a string in a JSON field |
| Second refund on the same order | **Not OWL.** SHACL `sh:maxCount 1` | See below |

The once-only constraint is where the talk's named tools fail it, for two
reasons rooted in OWL's semantics:

- **No unique name assumption.** Declaring `hasRefund` an
  `owl:FunctionalProperty` and asserting both `order123 hasRefund R1` and
  `order123 hasRefund R2` does not raise an error — the reasoner concludes
  `R1 owl:sameAs R2`, inferring the two refunds are *the same refund*. That is
  the inverse of the intended guardrail. An inconsistency requires additionally
  asserting `R1 owl:differentFrom R2` (or `owl:AllDifferent`), or conflicting
  values on some other functional property.
- **Open world assumption.** Absence of a refund triple never entails that no
  refund occurred. "Has this already been refunded?" is inherently a
  *closed-world* question, and OWL is built to decline it.

[SHACL](https://www.w3.org/TR/shacl/) (W3C Rec, 2017) is the closed-world
constraint language for RDF graphs, where `sh:maxCount 1` produces a violation
report rather than an identity inference. The talk names RDFS and OWL and never
mentions SHACL — so its flagship example is the one its named tools handle
worst.

The materialization precondition on the disjointness catch is the ledger's real
hidden cost: constraints over entity classes only fire if the domain data exists
as a typed graph. Getting tool output into that form is work the talk elides.

## Finding 3 — Coyle never implements the ledger

Verified against the video's own transcript: no reasoner, library, triplestore,
or serialization is named anywhere. What appears on the code slide is a red
annotation marking a position:

> "Now, I have this stuff in red here. This is where I think the … ontologies
> and stuff can come in. … The tool's going to give us information. We put the
> information in a form that our validator can use, and **think about the
> validator as operating with** these ontologies about our domain"

and at the close, "**you can have** a reasoner built on ontology to check keep
the LLM on track." Both subjunctive. The working code in the talk is an ordinary
Claude tool-use loop plus Pydantic. Anyone costing this out is **originating**
the design, not adopting it.

## Finding 4 — OWL is a formal logic; the question is whether these problems want one

OWL 2 DL is a syntactic variant of the description logic **SROIQ(D)** — a
decidable first-order fragment with model-theoretic semantics and sound,
complete reasoners. Its trade-offs are already captured in
[FOL and OWL](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md).

| | OWL/RDF ledger | Custom Elixir |
|---|---|---|
| Derived facts | Free — transitivity, domain/range typing, subclass closure | Each inference hand-coded and kept mutually consistent |
| Global consistency | Reasoner checks the whole graph, catching constraint interactions never explicitly tested | Checks exactly what was written |
| Model as data | Editable and auditable without redeploy; readable by a domain expert | Model is code |
| Vocabulary reuse | schema.org, FOAF, Dublin Core off the shelf | From scratch |
| "Already happened?" | Fights you (OWA/UNA); needs SHACL or closed-world additions | Native — a unique index |
| Runtime cost | **No mature OWL DL reasoner on the BEAM.** RDF.ex and SPARQL.ex cover representation and query well, and RDF.ex ships OWL only as a *vocabulary* (namespace terms), not inference — so a reasoner means HermiT/openllet (JVM), owlready2 (Python), or a reasoning triplestore, out of process | None |
| Authoring cost | High — [FOL and OWL](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md) already concludes "the authoring cost of formal ontologies is the standing argument for keeping belief content in natural language and formalizing only the *structure* around it" | Low |

The out-of-process reasoner is the decisive constraint for this repo
specifically: it is a second runtime with its own dependency surface — the same
blocker standing against
[Jido's `req_llm` cognition dependency](/meta/analysis/jido-distribution-gap-and-req-llm-cognition-dependency.md)
and the zero-dependency stance in the
[BEAM/Jido evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md).

## Recommendation — split the stack by world assumption

**Coyle's three examples are the weakest possible case for an ontology.** All
three are *rejected input*; inference is for *derived knowledge*. The enum is a
schema. Disjointness is a type — and Elixir expresses it *better* than OWL does,
at compile time with distinct structs, where OWL works at runtime over an open
world. Once-only is a unique index. The talk uses these to motivate a reasoner
none of them require.

- **Level 2 — per-entity shape, closed value sets, entity kinds.** Jido Action
  schemas plus Elixir's type system. Already available; no new machinery.
- **Level 3 — relational and temporal invariants (cardinality over history,
  cross-entity constraints).** A **closed-world** constraint layer. If it should
  be declarative, its shape is SHACL, not OWL —
  [SHACL over SPARQL.ex has been demonstrated in Elixir](https://medium.com/@tonyhammond/working-with-shacl-and-elixir-4719473d43c1).
  Often it is simply a database constraint.
- **Reserve OWL** for the cases that genuinely want entailment: deriving facts
  not asserted, or reusing published vocabularies. Both are real motivations —
  neither is the one the talk advertises.

For this bundle, nothing here changes the standing "not now" on a resident
runtime; it narrows what a future enforcement layer should be built from if one
is ever wanted.

# Citations

- Talk transcript and slides: Frank Coyle, "Why Agentic Systems Need
  Ontologies", AI Engineer: <https://www.youtube.com/watch?v=Sir59K8ZDPU>
- Jido mechanics: <https://github.com/agentjido/jido> and
  <https://github.com/agentjido/jido_action> (actions guide, schemas-validation
  guide, state-ops guide, errors guide)
- SHACL: <https://www.w3.org/TR/shacl/>
- Elixir RDF ecosystem: <https://rdf-elixir.dev/>,
  <https://github.com/rdf-elixir/rdf-ex>, <https://github.com/rdf-elixir/sparql-ex>
