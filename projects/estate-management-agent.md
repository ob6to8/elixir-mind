---
id: em:567d37
type: project
title: Estate management agent
description: A personal agentic system that acts as a high-net-worth principal's single point of reference across their estate — the verified record of what exists, who owns it, who is responsible, and what happens next — aiding record keeping, portfolio balancing, budgeting, and trust administration directly, while routing every judgment that constitutes advice to the principal's licensed professionals.
status: incubating
tags: [projects, estate-management, finance, agents, elixir, privacy, local-inference, verification]
timestamp: 2026-08-11
attribution:
  when: 2026-08-11T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed estate-agent speccing session"
  why: "operator commissioned the system's founding spec — capabilities, expected behavior, interface, privacy — to incubate here before the system breaks out into its own repo"
---

# Estate management agent

A personal, self-hosted agentic system for a principal whose estate spans
brokerage and retirement accounts, real property, legal entities (trusts,
LLCs), insurance, and a bench of professionals — attorney, CPA, broker or
advisor. The system is the estate's **system of record and coordination
layer**: it keeps the canonical, evidence-backed picture of the estate,
watches its deadlines and drift, and prepares the work products the principal
hands to their professionals. It offers the continuity and memory a family
office provides, without staffing one, and it is used **alongside** the
professional bench rather than in place of it.

## The stance the design rests on

**The agent prepares; professionals opine; the principal decides.**

The boundary between aid and advice is structural rather than rhetorical: the
system's output genres are records, reconciliations, computations under
ratified mandates, monitors, briefs addressed to a professional, and drafts
for review. A recommendation is deliberately absent from that list — an
advice-shaped ask ("should I convert this IRA?") compiles into the fact
packet, the formed question, and an agenda item for the professional who owns
the answer. The
[product spec](/projects/estate-management-agent/product-spec.md) states the
boundary precisely, with its grounds — regulatory and epistemic — and marks
the regulatory reading as an assumption set for counsel review.

## The security premise

[secure-financial-agent](/projects/secure-financial-agent.md) established two
independent properties for systems touching financial documents. This system
inherits both and adds a third, because its workload includes synthesis and
its outputs reach professionals:

| Property | Failure looks like | Answered by |
|---|---|---|
| **Confidentiality** | estate data reaches a third party and is retained | the local plane holds everything raw; least-egress by default |
| **Integrity** | an ingested document's contents are read as instructions | the secure-financial-agent ingest zone: sandboxed model-free parse, typed capabilities, gated side effects |
| **Disclosure control** | more than the minimum leaves, or leaves unaudited | sensitivity tiers, a single pseudonymizing gateway, a verbatim egress log, principal-transmitted packets |

The [privacy architecture](/projects/estate-management-agent/privacy.md)
fixes the tiers, the gateway, the threat model, and the residual risks the
design accepts.

## Relationship to secure-financial-agent

Sibling, by design. secure-financial-agent is a zero-egress
document-processing pipeline; its architecture — the sandboxed parse worker,
the pure reducer whose side effects are data, the operator gate — is adopted
here wholesale as this system's ingest zone, cited rather than restated. The
posture difference is scoped and deliberate: this system's workload includes
synthesis tasks (briefs, scenario narratives) where frontier-model quality
matters and the content survives pseudonymization, so it opens **one audited,
pseudonymized egress lane** that secure-financial-agent's raw-document
workload has no need for. Whether the two projects eventually merge — the
estate agent absorbing the pipeline as its ingest subsystem — is an open
question the operator owns; the specs are written so either answer works.

## What it does

One line per capability; the
[product spec](/projects/estate-management-agent/product-spec.md) carries the
behavior contracts and scenario vignettes.

- **register** — the canonical record: people, entities, accounts, assets,
  instruments, titling, beneficiary designations, fiduciary roles — typed,
  stable-id'd, evidence-backed
- **ledger** — entity-aware double-entry books, reconciled monthly against
  statements; budgets and cash-flow projection under ratified budget mandates
- **portfolio** — positions, drift against the ratified investment policy,
  tax-lot-aware rebalancing worksheets addressed to the broker
- **legal** — instrument custody and term extraction, trust-funding
  tracking, the administration calendar, briefing memos for counsel
- **monitors** — deadlines, renewals, staleness sweeps, life-event protocols
- **readiness** — continuous gap analysis and the compiled incapacity/death
  runbook (the executor binder), rehearsed by drills
- **interface** — local chat and dashboard, the approval queue, compiled
  packets per professional

## Decisions so far

| Decision | Choice | Rationale |
|---|---|---|
| Hosting | a standalone local workstation the principal owns, plus rented frontier models behind an audited gateway | raw estate data never leaves hardware the principal possesses; frontier quality is bought only for pseudonymizable synthesis |
| Language / runtime | Elixir on the BEAM; the Jido-2 pattern secure-financial-agent selected | the same audit, gating, and supervision requirements — see [its rationale](/projects/secure-financial-agent/architecture.md) |
| Canonical store | a plain-text, git-versioned register bundle with derived database projections | reviewable diffs, mint-once identity, evidence edges — the [verification lending](/projects/estate-management-agent/verification.md) |
| Computation | deterministic code computes; models extract, classify, retrieve, and draft | arithmetic with an oracle stays out of model hands — and exact figures rarely need to egress |
| Egress | default-deny at the host; one pseudonymizing gateway; gate logic is code, never model judgment; verbatim egress log | the [privacy architecture](/projects/estate-management-agent/privacy.md) |
| Advice | not an output genre — briefs to the professional bench instead | the [product spec](/projects/estate-management-agent/product-spec.md) |

## Open questions

The per-document lists carry the detail; these are the ones the operator owns
outright:

- **Jurisdiction assumptions.** The spec is written against US law generally;
  state specifics (community property, situs, trust law) need counsel once
  the principal's facts are fixed.
- **Fold-in.** Does secure-financial-agent become this system's ingest
  subsystem, or stay a sibling that ships first?
- **Naming.** "Estate management agent" is a working slug ("estate agent"
  reads as a realtor in British English); the product name is unchosen.
- **Alias stability.** Stable pseudonyms across frontier calls buy coherence
  and cost linkage; rotation buys the reverse. The default posture is open.
- **Personal tool vs. product.** The spec holds the boundary at product-grade
  posture; if this stays a personal tool the regulatory pressure drops but
  the epistemic case for the boundary stands.

## Documents

- [Product spec](/projects/estate-management-agent/product-spec.md) —
  capabilities, expected behavior, mandates, interface, the autonomy split
- [Architecture](/projects/estate-management-agent/architecture.md) — the
  three-zone topology, subsystems, task routing, storage, build order
- [Privacy](/projects/estate-management-agent/privacy.md) — sensitivity
  tiers, the gateway, threat model, keys and continuity
- [Verification](/projects/estate-management-agent/verification.md) — the
  elixir-mind lending: ids, ontology, evidence, gates, audit trail
- [Project docs](/projects/estate-management-agent/index.md)

## Knowledge this project draws on

Filed to the taxonomy because each is true independent of this system — the
hub links out rather than restating:

- [Hybrid inference with pseudonymized egress](/knowledge/SWE/security/hybrid-inference-pseudonymized-egress.md)
  — the disclosure-control pattern the privacy architecture instantiates
- [Indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md)
  — the integrity threat the ingest zone answers
- [Confidential computing for LLM inference](/knowledge/SWE/security/confidential-computing-for-llm-inference.md)
  — the attestation alternative if a rented model must ever see more
- [Operating an air-gapped workstation](/knowledge/SWE/security/air-gapped-operations.md)
  — isolation postures and the encrypted-backup stance
- [Local inference serving stacks](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md)
  — the local serving layer and its constraints
- [Single-machine inference hardware, mid-2026](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md)
  — the hardware tiers the box decision picks from
- [Open-weight frontier models, mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md)
  — why frontier quality is rented rather than self-hosted
- [Elixir agent memory](/projects/elixir-agent-memory.md) — derived,
  disposable recall indexes over a file-canonical bundle: the register's
  query layer
- [Normative records vs. descriptive traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md)
  — why the audit layer rests on artifacts rather than the agent's own
  account
