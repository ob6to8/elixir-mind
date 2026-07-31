---
id: em:619132
type: reference
title: "Thin agents on a smarter substrate: the ontology-based semantic layer (Emil Eifrem)"
description: An AI Engineer keynote proposing a three-pillar ontology-based semantic layer — a business ontology, a technical ontology, and execution traces — as a shared substrate so agents stay thin instead of each one re-discovering and re-wiring its own enterprise data sources.
resource: https://www.youtube.com/watch?v=VGN22pPpb-8
provenance: "Emil Eifrem (Neo4j), \"Thinner Agents on a Smarter Substrate: The Ontology-based Semantic Layer\", AI Engineer conference keynote, ~9 min; distilled from the video's transcript and description"
tags: [agents, agentic-loop, ontology, semantic-layer, knowledge-graph, neo4j, data-discovery, enterprise-ai]
timestamp: 2026-07-31T01:15:00Z
attribution:
  when: 2026-07-31T01:15:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator passed three AI Engineer conference talk URLs to /intake for capture into the brain"
---

# Thin agents on a smarter substrate: the ontology-based semantic layer (Emil Eifrem)

## Summary

Eifrem opens with a bank-account-opening agent that needs to verify identity,
so a team wires it to the DMV registry and a passport-verification service.
It works — but every other team in the org building an agent repeats the same
manual discovery-and-wiring work against the same enterprise data sprawl (not
one Postgres database but a hundred databases, plus Snowflake, Databricks, and
S3 buckets), can't easily tell which copy of a given piece of data is the
trustworthy, permitted one, has no single point of change when a source moves
(violating **DRY** — cascading updates become manual rewiring across every
agent), and gets no smarter over time because the wiring between business
intent and data sources is buried in a mix of code and prompts. Markdown-file
"skills" solve part of this but not the data-discovery part — quoting Swyx
from the Latent Space podcast: "you got to learn your databases, you cannot
vibe code with just markdown files." Drawn from deployments at a Fortune 20
bank, a large Bay Area tech platform, and a fintech company, Eifrem's fix is
to make agents **thin** and move the intelligence into a **smarter shared
substrate** underneath them.

## Key terms

- **Business ontology** — the first pillar: the organization's key concepts
  and how they relate, named the way the humans in the org actually say them
  (customer, account, first name — never `f_name`). See the glossary's
  [ontology](/beliefs/glossary/ontology.md) and
  [knowledge-graph](/beliefs/glossary/knowledge-graph.md) entries.
- **Technical ontology** — the second pillar: metadata for every data source
  and asset in the enterprise (which of the many Oracle/Neo4j/Snowflake/S3
  systems, their schemas, where they sit), plus a mapping from each business
  concept to its system of record (e.g. `customer.first_name` → an Oracle
  column `F_NAME`).
- **Execution traces** — the third pillar: as agents walk the ontology graph
  and act, they leave traces of what they tried, whether it succeeded, and
  under what context, rolling up into a score. This is *bottom-up* learning
  layered on top of the *top-down*, human-curated business/technical
  ontology — an agent that succeeded via the DMV lookup last time is more
  likely to reach for it again in a similar context.
- **Thin agent** — an agent whose own logic is reduced to intent
  interpretation plus a plan/act loop; all data-source knowledge lives in the
  shared substrate rather than being hardcoded or re-derived per agent.

## Technical summary

The talk names four recurring failures of the "thick agent, manually wired
data sources" pattern — discovery cost (re-deriving where data lives, from
scratch, per agent, per team), trust (which of several duplicate copies is
current/authoritative/permitted), DRY violation (a moved or renamed source
requires manually rewiring every agent that touches it), and no learning
(neither within one agent over time nor across agents) — and argues all four
collapse to one missing layer. The proposed architecture, "thin agents on a
smarter shared substrate," instantiates the ontology as an actual graph: in
the worked bank example, business-layer nodes (checks, accounts, credit
history, a modeled business *process* the agent is meant to follow) connect
to technical-layer nodes for a "check compliance" step needing a
government-issued ID, which resolves in this org to two viable data sources
(DMV records, passport verification). When the agent executes against this
graph, it records what it tried and whether it worked as the third pillar,
feeding future routing choices.

This pillar structure is a *substrate-and-discovery* argument, distinct from
[Frank Coyle's ontology talk](/knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md)
already in this bundle, which is a *validator* argument: Coyle wraps a
tool-use loop with an RDFS/OWL reasoner that checks a proposed action's
*result* against domain constraints (disjoint classes, cardinality, closed
value sets) before it is allowed through. Eifrem's ontology instead answers
*which data source to use and whether it can be trusted*, upstream of any
single tool call, and adds a third component — execution-trace-driven
learning — that Coyle's talk does not cover. The two are complementary layers
an agent system could combine: Eifrem's substrate for discovery and routing,
Coyle's validator for guarding what the agent then does with what it finds.

The talk does not name a specific technical construction for the technical
ontology beyond "three key ways" left for a follow-up conversation, and
gives no benchmark or quantified before/after — the claims here are the
speaker's account of deployed patterns at named-category customers
(a "Fortune 20 global bank," a large tech platform, a fintech company),
not independently verified figures.

# Citations

- Talk: Emil Eifrem, "Thinner Agents on a Smarter Substrate: The Ontology-based
  Semantic Layer", AI Engineer (YouTube):
  <https://www.youtube.com/watch?v=VGN22pPpb-8>
- Speaker: <https://x.com/emileifrem>, <https://www.linkedin.com/in/emileifrem/>
