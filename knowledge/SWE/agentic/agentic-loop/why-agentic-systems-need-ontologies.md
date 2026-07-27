---
id: em:1df031
type: reference
title: "Why agentic systems need ontologies (Frank Coyle)"
description: AI Engineer talk arguing that agent failures are symptoms of one missing layer — a formal ontology outside the model, applied as a neurosymbolic validator on the tool-use loop ("Pydantic at the door, ontology at the ledger").
resource: https://www.youtube.com/watch?v=Sir59K8ZDPU
provenance: "Frank Coyle (UC Berkeley), 'Why Agentic Systems Need Ontologies', AI Engineer conference talk, 21 min, uploaded 2026-07-23; distilled from the video's transcript and description"
tags: [agents, agentic-loop, ontology, neurosymbolic-ai, guardrails, tool-use, rdfs, owl, knowledge-graph, validation]
timestamp: 2026-07-27T07:10:00Z
attribution:
  when: 2026-07-27T07:10:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator passed the talk's YouTube URL to /intake for capture into the brain"
---

# Why agentic systems need ontologies (Frank Coyle)

## Summary

Coyle's claim is that most agent failures — a second refund on the same order,
a payout sent to the support desk instead of the buyer, an order status of
"probably shipped" — are symptoms of one missing layer. LLMs reason
probabilistically over domains they only half understand, and no paragraph of
prompt instructions reliably stops these mistakes; hallucination "is a feature"
of the probabilistic machinery, not a bug to be prompted away. His fix is
neurosymbolic: keep the probabilistic reasoning inside the model and put logic
outside it, as a formal ontology sitting beside the agent loop and checking
what the model proposes before anything acts.

An ontology here is nothing exotic — typed entities, relationships, and
constraints, quoting Gruber (1993): "a formal specification of a shared
conceptualization". Expressed in the old, boring W3C standards (RDFS and OWL),
it lets you say that a payment status must be one of three values, that a
customer and a support rep are disjoint kinds of thing, that an order can be
refunded only once. The operational pattern: wrap a Claude tool-use loop with a
validator — when the model proposes a tool call, check the parameter types with
Pydantic and the results against the ontology, and only then let the action
through. Catches that are painful to write in English become a few lines of
logic. His slogan for the architecture: "Pydantic at the door, ontology at the
ledger" — and keep the tools side-effect-free until the validator has passed
them.

## Key terms

- **Ontology** — a formal representation of a domain's entities, their
  properties, and their relationships; operationally, a
  [knowledge graph](/beliefs/glossary/knowledge-graph.md) plus constraint and
  inference machinery sitting beside it. See the glossary entry
  [ontology](/beliefs/glossary/ontology.md).
- **Neurosymbolic AI** — the convergence of neural (probabilistic, LLM) and
  symbolic (rule-based, logic) systems; in this talk's usage, symbolic
  guardrails around a probabilistic core.
- **RDFS domain and range** — inference vocabulary: declaring `teaches` to have
  domain `Teacher` and range `Student` lets "Bob teaches Scooter" *derive* that
  Bob is a teacher (hence a person) and Scooter is a student, without those
  facts being asserted.
- **OWL property axioms** — [OWL](/beliefs/glossary/owl.md) constructs the
  validator leans on: *transitive* properties (ancestor-of chains compose),
  *functional* properties (at most one value — two asserted fathers means two
  names for one individual, or an error), and *disjoint* classes (a customer is
  never a support rep).
- **Tool-use loop** — the classic `while True` agent loop: the LLM cannot
  execute anything itself; it proposes a tool call (surfaced via a `tool_use`
  stop reason), the harness executes it, and results are fed back. See
  [the agent loop as a while-loop](/knowledge/SWE/agentic/agentic-loop/agent-loop-as-a-while-loop.md).
- **Validator** — the code between the model's proposal and the action: Pydantic
  for parameter *types* at the boundary, the ontology reasoner for *semantic*
  invariants over the results; failures route back to the LLM or to a human in
  the loop.
- **Böhm–Jacopini result (1966)** — sequence + conditionals + iteration make a
  language Turing-complete; Coyle's framing is that loops give agentic AI that
  last piece — and with it the classic loop failure modes (infinite loops,
  drift, runaway token cost).
- **Existing taxonomies** — schema.org, FOAF, Dublin Core, DBpedia: published
  vocabularies to reuse rather than reinventing a domain model from scratch.

## Technical summary

The talk traces two lineages — agents (McCarthy, Selfridge, Minsky; perceive →
decide → act) and ontologies (Aristotle's categories through Quine to Gruber's
1993 definition) — and argues their convergence is what "neurosymbolic AI"
names. The expert-systems era of the 1980s is the cautionary precedent:
symbolic AI alone couldn't scale and produced an AI winter, just as neural
networks alone couldn't scale until GPU compute arrived. Ontologies are built
top-down (domain experts enumerate entities/relations, the expert-systems
workflow) or bottom-up (mined from interactions), and preferably seeded from
existing taxonomies.

Mechanically, the graph holds entities, properties, and relationships; RDFS and
OWL sit "on the side" of the graph supplying derivations (domain/range typing,
transitive closure) and constraints (functional properties, disjointness,
enumerated value sets). The agent-side integration is a standard Claude
tool-use loop with an interposed validation stage: on `stop_reason ==
"tool_use"`, extract the proposed call, execute the tool, normalize the result
into the validator's form, and check it against the ontology before committing
anything — "surround the input with checks", keep agents free of side effects
until validation passes, and on failure loop back to the model or escalate to a
human. The closing catalogue of errors an ontology catches that English
cannot: double refunds (a once-only relationship), misdirected payouts
(disjoint classes), and invented enum values like "probably shipped" (a closed
value set — paid, shipped, or refunded, nothing else).

The formal underpinnings of RDFS/OWL — decidability trade-offs, description
logics, and what the authoring cost buys — are captured separately in
[FOL and OWL: fully formal knowledge representation](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md);
this talk is the agent-side argument for putting that machinery to work as
loop guardrails.

# Citations

- Talk: Frank Coyle, "Why Agentic Systems Need Ontologies", AI Engineer
  (YouTube, 21:18, uploaded 2026-07-23):
  <https://www.youtube.com/watch?v=Sir59K8ZDPU>
- Speaker: <https://www.frank-coyle.ai/>
