---
id: em:2511d9
type: concept
title: Hybrid inference with pseudonymized egress
description: A disclosure-control pattern for LLM systems over sensitive corpora — a local plane holds all raw data and identifiers and runs modest models, while a single gateway pseudonymizes, deterministically gates, logs, and rehydrates the narrow payloads sent to rented frontier models, trading bounded structural leakage for frontier reasoning quality.
verified: false
provenance: model undisclosed
tags: [security, privacy, llm, inference, architecture, pseudonymization, egress]
timestamp: 2026-08-11
attribution:
  when: 2026-08-11T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed estate-agent speccing session"
  why: "the estate-management-agent privacy architecture instantiates this pattern; the pattern itself is system-independent and belongs to the taxonomy"
---

# Hybrid inference with pseudonymized egress

A deployment pattern for agentic systems over sensitive corpora — financial,
legal, medical — that want frontier-model reasoning without granting a
frontier provider the corpus. It sits between two established postures:
zero-egress local inference (full confidentiality, capped reasoning quality)
and cloud inference under contractual or attested protections (full quality,
trust concentrated in the provider — see
[confidential computing](/knowledge/SWE/security/confidential-computing-for-llm-inference.md)).

## The pattern

- **Two planes.** A local plane owns everything raw — documents,
  identifiers, the canonical store — and runs modest models for extraction,
  classification, retrieval, and routine chat. A frontier plane, rented,
  receives only derived task payloads for synthesis-heavy work.
- **Sensitivity tiers** partition content: identity-bearing data never
  egresses in any form; structural and quantitative content egresses only
  transformed; content with no referent to the corpus egresses freely.
  Unclassified content takes the stricter treatment.
- **One gateway.** All egress passes a single service that (1) swaps
  referents for pseudonyms from a locally-held alias map, generalizes free
  text, and buckets quantities; (2) applies a deterministic gate —
  identifier-format scanners, a corpus-derived denylist, allowlists for
  structured fields — that fails closed and is code rather than model
  judgment, since a model-judged gate can be argued past by the very inputs
  it screens; (3) logs payload and response verbatim, append-only, so "what
  has ever left" is inspectable; (4) rehydrates pseudonyms on return, treats
  unresolvable pseudonym-shaped tokens as fabrication tripwires, and lands
  frontier output as draft, never directly as trusted record.
- **Canaries close the loop.** Synthetic identifiers seeded in the corpus,
  plus end-to-end tests asserting no canary ever reaches an egress fixture —
  the gate is tested against the system's behavior, not only against a
  specification of it.
- **Arithmetic stays out of models.** Load-bearing computation runs as
  ordinary code on the local plane; models extract, classify, and draft. A
  correctness discipline that doubles as disclosure minimization: synthesis
  payloads rarely need exact figures.

## The residual, named

Pseudonymization removes identity, never shape. Stable aliases make the
egressed payload stream coherent, and a provider that retained it could
reconstruct a pseudonymized shadow of the corpus's structure, magnitudes,
and timing. Mitigations — alias rotation or per-matter scopes, bucketed
quantities, zero-retention terms, a per-task-class egress policy — bound the
leak; they cannot zero it while the lane exists. A system for which shape
itself is the secret should stay zero-egress.

## When it fits

The workload includes tasks where frontier quality genuinely matters —
long-horizon synthesis, high-stakes drafting — *and* those tasks survive
pseudonymization. Pure extraction and classification workloads fit
local-only postures instead. Indirect prompt injection is orthogonal to all
of this and is answered at ingestion, before any model reads a document
([document-pipeline injection](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md)).

Instantiated by the
[estate-management-agent privacy architecture](/projects/estate-management-agent/privacy.md);
the zero-egress end of the spectrum is
[secure-financial-agent](/projects/secure-financial-agent.md), and the
isolation postures behind it are surveyed in
[air-gapped operations](/knowledge/SWE/security/air-gapped-operations.md).
